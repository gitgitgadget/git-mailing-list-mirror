From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix crash in t0020 (crlf conversion)
Date: Mon, 23 Apr 2007 00:52:47 +0200
Message-ID: <20070422225247.GA2409@steel.home>
References: <20070422141222.GC2431@steel.home> <20070422141154.GB2431@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Martin Waitz <tali@admingilde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 00:52:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfkvO-0001Z4-Fd
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 00:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030950AbXDVWwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 18:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030951AbXDVWwv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 18:52:51 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:52654 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030950AbXDVWwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 18:52:50 -0400
Received: from tigra.home (Fcb6c.f.strato-dslnet.de [195.4.203.108])
	by post.webmailer.de (fruni mo45) (RZmta 5.6)
	with ESMTP id F01618j3MGmH0e ; Mon, 23 Apr 2007 00:52:48 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3CE7A277BD;
	Mon, 23 Apr 2007 00:52:48 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 9E1B4BDDE; Mon, 23 Apr 2007 00:52:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070422141222.GC2431@steel.home> <20070422141154.GB2431@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsD+I4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45285>

Alex Riesen, Sun, Apr 22, 2007 16:11:54 +0200:
> Reallocated wrong size.
> Noticed on Ubuntu 7.04 probably because it has some malloc diagnostics in libc:
> "git-read-tree --reset -u HEAD" aborted in the test. Valgrind sped up the
> debugging greatly: took me 10 minutes.

Alex Riesen, Sun, Apr 22, 2007 16:12:22 +0200:
> Also, noticed by valgrind: the code caused a read out-of-bounds.
> Some comments updated as well (they still reflected old calling
> conventions).

Actually, it is all the other way around. The _second_ patch
(buffer->src in convert.c, the read out-of-bounds caused overwrite of
malloc control structures because of incorrect dst update condition)
is for the crash, the first is unrelated, but noticed by valgrind
in the same test.

I messed up the commit descriptions completely (Martins mail made
me look at the patches again). Sorry
