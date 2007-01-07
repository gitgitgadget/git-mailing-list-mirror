From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: [PATCH] Replacing the system call pread() with real mmap().
Date: Sun, 7 Jan 2007 17:36:37 +0100
Organization: -no organization-
Message-ID: <20070107163637.GE9909@scotty.home>
References: <20070106170330.GA8041@scotty.home> <20070107060007.GA10351@spearce.org> <20070107111712.GB9909@scotty.home> <20070107112445.GE10351@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 17:37:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3b0p-0005fC-LV
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 17:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbXAGQgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 11:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbXAGQgo
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 11:36:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:55922 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610AbXAGQgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 11:36:43 -0500
Received: from [84.134.15.225] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis),
	id 0MKwtQ-1H3b0h3js2-0006pg; Sun, 07 Jan 2007 17:36:42 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l07GacZO027166;
	Sun, 7 Jan 2007 17:36:38 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l07GabDF027162;
	Sun, 7 Jan 2007 17:36:37 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20070107112445.GE10351@spearce.org>
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-0.0 required=5.0 tests=ALL_TRUSTED,
	UNWANTED_LANGUAGE_BODY autolearn=failed version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV 0.88.7/2418/Sun Jan  7 10:42:41 2007 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36176>

Also sprach Shawn O. Pearce am Sun, 07 Jan 2007 at 06:24:45 -0500:
> Better to emulate pread using lseek/xread/lseek:
> 
> 	off_t p = lseek(fd, offset, SEEK_SET);
> 	xread(fd, buf, count);
> 	lseek(fd, p, SEEK_SET);
> 
> If you look at the history for contrib/mmap.c you will see an
> implementation like that before it was called git_mmap().

This doesn't work;I tried it before.

Stefan
-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
