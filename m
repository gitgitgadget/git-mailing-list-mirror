From: Scott Lamb <slamb@slamb.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 14:23:32 -0700
Message-ID: <469BE1D4.1070408@slamb.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org> <20070716200024.GD16878@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161315120.20061@woody.linux-foundation.org> <20070716202550.GH16878@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161332280.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 23:24:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAY2z-0003f2-GC
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 23:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760600AbXGPVX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 17:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760216AbXGPVX7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 17:23:59 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:38900 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760297AbXGPVX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 17:23:58 -0400
Received: from spiff.local (ppp-71-139-183-188.dsl.snfc21.pacbell.net [71.139.183.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 9876898105;
	Mon, 16 Jul 2007 14:23:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <alpine.LFD.0.999.0707161332280.20061@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52725>

Linus Torvalds wrote:
> No, but we don't *want* the "rmdir for directories" part! 
> 
> That's the whole point.
> 
> Calling "remove()" would be *wrong*. We want the *sane* "unlink()" 
> behaviour, where it only removes files, and returns an error for 
> directories.

Of course, but when used immediately after stat() says the path does not
refer to a directory, I would prefer SUS remove() (rmdir() for
directories) to Solaris unlink() (break_filesystem() on directories).

But Solaris remove() is broken, too, so it's a moot point. The
post-patch behavior is good enough - as you said, it won't happen during
reasonable usage and the problem's not unique to git.

Best regards,
Scott

-- 
Scott Lamb <http://www.slamb.org/>
