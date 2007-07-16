From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 14:44:59 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161442410.20061@woody.linux-foundation.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
 <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org>
 <20070716200024.GD16878@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.999.0707161315120.20061@woody.linux-foundation.org>
 <20070716202550.GH16878@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.999.0707161332280.20061@woody.linux-foundation.org>
 <469BE1D4.1070408@slamb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 23:46:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAYOT-0002ha-CL
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 23:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbXGPVqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 17:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755717AbXGPVqI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 17:46:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50722 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752333AbXGPVqG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 17:46:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GLj5GV020947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 14:45:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GLixCb005468;
	Mon, 16 Jul 2007 14:45:00 -0700
In-Reply-To: <469BE1D4.1070408@slamb.org>
X-Spam-Status: No, hits=-4.644 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52726>



On Mon, 16 Jul 2007, Scott Lamb wrote:
> 
> But Solaris remove() is broken, too, so it's a moot point.

In fact, with the Solaris behaviour for unlink(), you *cannot* have a 
non-broken "remove()".

So the right fix is always to fix "unlink()" instead.

There really aren't any downsides (since no program can rely on it 
_anyway_, unless we're talking about some magic "early bootup" time 
scripts that depend on only running as root, and only ever running on UFS 
- but those kinds of scripts could be trivially fixed and are obviously 
under Sun control anyway)

			Linus
