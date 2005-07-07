From: Wolfgang Denk <wd@denx.de>
Subject: Cogito-0.12: problem with local clone
Date: Fri, 08 Jul 2005 01:00:55 +0200
Message-ID: <20050707230055.25D3B353A8B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 01:10:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqfV4-0002hI-I7
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 01:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVGGXJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 19:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVGGXGN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 19:06:13 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:36568 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262235AbVGGXDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 19:03:54 -0400
Received: from fwd26.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1DqfPG-0008Jk-00; Fri, 08 Jul 2005 01:03:46 +0200
Received: from denx.de (SOkMx2Zawem9nDNLS-eSpEK7Pivo0tJtiMACohvJfa+iXpSm2eoxoE@[84.150.81.76]) by fwd26.sul.t-online.de
	with esmtp id 1DqfPF-199XcW0; Fri, 8 Jul 2005 01:03:45 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 8EA2F42B02; Fri,  8 Jul 2005 01:03:44 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 25D3B353A8B;
	Fri,  8 Jul 2005 01:00:55 +0200 (MEST)
To: Petr Baudis <pasky@suse.cz>
X-ID: SOkMx2Zawem9nDNLS-eSpEK7Pivo0tJtiMACohvJfa+iXpSm2eoxoE@t-dialin.net
X-TOI-MSGID: 2014848d-d8b4-4f49-8a63-a3ca14be287f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

I have problems with Cogito-0.12 when trying to clone a "local" tree:

My "original" tree is in /git/u-boot-denx (imported from CVS); "/git"
is a directory mounted over NFS; all this is under Fedora Core  4  in
case it matters:

	-> cd /git/u-boot-denx
	-> cg-tag-ls
	/git/u-boot-denx/.git/refs/tags
	LABEL_2002_11_05_0120   405f4884816e733f8ba3675d2ead1b44fd4a2ad2
	LABEL_2002_11_05_1735   a21c24faf81d6e2c2cf21bc856b97994a7fb0950
	LABEL_2002_11_10_2310   90e51a047bc112515e1257077b4c898bedf29e69
	...
	U-Boot-1_1_1    eaa609e49846203434aa3b20e7084c79e89ea952
	U-Boot-1_1_2    3621a36bfb037a47a59b0c02d3686522c8d895bf
	U_BOOT_0_1_0    dc9791586a71cb80c255a830a38d4a2b092398c3
	-> cg-tag-ls | wc -l
	131

When I try to create a local clone I get lots of error messages:

	-> mkdir git-local
	-> cd git-local
	-> cg-clone /git/u-boot-denx 
	/home/wd/git/u-boot-denx
	defaulting to local storage area
	`/git/u-boot-denx/.git/refs/heads/master' -> `.git/refs/heads/origin'
	copy 9f94f652ff7a5be5263ca0ef35a512ac7f29be98
	copy db88a44625a80f558bcde5aeda291c54c737b573
	copy 30a7a8a8d49f7069403895f326de4905f63d8855
	...
	copy 9c2deccb2acfb1d0d77b733a3f19d12ea9d58ca2
	copy f548442a0fe39729a11b1d384708c7cc3b6bed20
	copy 2183da96d548c02bd4f99b05e673395f81212878
	`/git/u-boot-denx/.git/refs/tags/U_BOOT_0_1_0' -> `.git/refs/tags/U_BOOT_0_1_0'
	cp: cannot create link `.git/refs/tags/U_BOOT_0_1_0': Invalid cross-device link
	`/git/u-boot-denx/.git/refs/tags/LABEL_2002_11_05_0120' -> `.git/refs/tags/LABEL_2002_11_05_0120'
	cp: cannot create link `.git/refs/tags/LABEL_2002_11_05_0120': Invalid cross-device link
	`/git/u-boot-denx/.git/refs/tags/LABEL_2002_11_05_1735' -> `.git/refs/tags/LABEL_2002_11_05_1735'
	cp: cannot create link `.git/refs/tags/LABEL_2002_11_05_1735': Invalid cross-device link
	...
	`/git/u-boot-denx/.git/refs/tags/LABEL_2005_06_20_2345' -> `.git/refs/tags/LABEL_2005_06_20_2345'
	cp: cannot create link `.git/refs/tags/LABEL_2005_06_20_2345': Invalid cross-device link
	`/git/u-boot-denx/.git/refs/tags/LABEL_2005_07_04_0202' -> `.git/refs/tags/LABEL_2005_07_04_0202'
	cp: cannot create link `.git/refs/tags/LABEL_2005_07_04_0202': Invalid cross-device link
	unable to get tags list (non-fatal)
	/home/wd/git/u-boot-denx/.git/refs/tags
	New branch: 9f94f652ff7a5be5263ca0ef35a512ac7f29be98
	Cloned (origin /git/u-boot-denx available as branch "origin")
	Cloned to u-boot-denx/ (origin /git/u-boot-denx available as branch "origin")

And the resulting tree is indeed missing lots of tags:

	-> cg-tag-ls
	/home/wd/git/u-boot-denx.OLD/.git/refs/tags
	LABEL_2003_06_28_0050-stable    f50d58228a5be736e6ed0f8dd3202b9ea26169bf
	LABEL_2003_06_28_0130-stable    d8a9a48da39a79497d752d34d30b5edf3e3162a8
	LABEL_2003_06_28_1800-stable    b82064a05f9c88a6144dc8f894f9e312e134b6b3
	U_BOOT_0_1_0    d4e4163d86db0238264b7d06d9f023c16f1e371a
	-> cg-tag-ls | wc -l
	5
	-> 


Am I doing something wrong?
	

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Include the success of others in your dreams for your own success.
