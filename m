From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 0/4] dietlibc compatibility
Date: Sat, 24 Dec 2005 04:10:07 -0800
Message-ID: <20051224121007.GA19136@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 24 13:10:16 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq8E3-0007gQ-UK
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 13:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVLXMKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 07:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVLXMKJ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 07:10:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:26755 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932517AbVLXMKI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 07:10:08 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 57B867DC005; Sat, 24 Dec 2005 04:10:07 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14018>

I've started statically-linking git binaries against dietlibc to avoid
having to recompile it for every machine/distro and chroot (lots!) I
would use it in.

For building git (on a Debian unstable system with dietlibc-dev),
I used the following make vars:

	CC=diet -v gcc
	NO_STRCASESTR=YesPlease
	NO_SETENV=YesPlease

The dietlibc setenv() doesn't seem very nice to **envp in git.c,
resulting in $PATH being clobbered when it runs execve().  This
caused tests to fail.  Fortunately, gitsetenv() saved the day.

The following patches fix other issues I had with dietlibc.

-- 
Eric Wong
