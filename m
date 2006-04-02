From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH 2/2] pack-objects: be incredibly anal about stdio semantics
Date: Sun, 02 Apr 2006 15:12:54 -0700
Message-ID: <15051.1144015974@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.64.0604021417301.23419@g5.osdl.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 00:13:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQAoc-0001Yx-Ch
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 00:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWDBWMz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 18:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWDBWMz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 18:12:55 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:10138 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932407AbWDBWMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 18:12:54 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k32MCsgH015053
	for <git@vger.kernel.org>; Sun, 2 Apr 2006 15:12:54 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k32MCsPX015052
	for <git@vger.kernel.org>; Sun, 2 Apr 2006 15:12:54 -0700 (PDT)
To: git@vger.kernel.org
In-reply-to: <Pine.LNX.4.64.0604021417301.23419@g5.osdl.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18290>

And Linus Torvalds writes:
 - 
 - I don't have any really strong opinions on it. I think that any libc that 
 - needs the "ferror()" test + EINTR loopback is totally broken. I would 
 - happily say that people should just not use a development platform that is 
 - that horrible.

If you consider stdio to be a low-level wrapper over syscalls
that only adds buffering and simple parsing, then passing EINTR
back to the application is a sensible choice.  I wouldn't be
too surprised if L4, VxWorks, etc. do something similar.

 - So I _think_ we're safe with just the "sigaction()" diff.  Neither of the 
 - patches _should_ make any difference at all on a sane platform. 

Anyone with an older HP/UX care to try these patches?  HP/UX 
may not be sane, but I think it may lack SA_RESTART.  I don't 
know if stdio calls need restarted, though.

Jason
