From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 13:34:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161332280.20061@woody.linux-foundation.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
 <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org>
 <20070716200024.GD16878@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.999.0707161315120.20061@woody.linux-foundation.org>
 <20070716202550.GH16878@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 22:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAXHa-0003Dk-64
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 22:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbXGPUe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757522AbXGPUe6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 16:34:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47751 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757104AbXGPUe5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 16:34:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GKYrLr016615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 13:34:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GKYm9Y032642;
	Mon, 16 Jul 2007 13:34:48 -0700
In-Reply-To: <20070716202550.GH16878@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=-4.637 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52718>



On Mon, 16 Jul 2007, Thomas Glanzmann wrote:
>
> Hello,
> 
> > > is there a reason why we call unlink and not remove?
> 
> > Exactly because we only want to remove _files_.
> 
> of course. That is the whole point. Call unlink for files, rmdir for
> directories.

No, but we don't *want* the "rmdir for directories" part! 

That's the whole point.

Calling "remove()" would be *wrong*. We want the *sane* "unlink()" 
behaviour, where it only removes files, and returns an error for 
directories.

		Linus
