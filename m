From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mozilla SHA1 implementation
Date: Fri, 22 Apr 2005 08:31:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504220824480.2344@ppc970.osdl.org>
References: <87hdi5oet6.dancerj@netfort.gr.jp> <Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org>
 <20050418055824.42d621b8.froese@gmx.de> <Pine.LNX.4.58.0504211238150.2344@ppc970.osdl.org>
 <17000.43340.760901.175004@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Edgar Toernig <froese@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 17:33:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP07p-0003II-OA
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 17:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVDVPfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 11:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVDVPfc
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 11:35:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:28600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262041AbVDVPa0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 11:30:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MFTxs4010552
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 08:30:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MFTtnH029148;
	Fri, 22 Apr 2005 08:29:56 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17000.43340.760901.175004@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Apr 2005, Paul Mackerras wrote:
> Linus Torvalds writes:
> 
> > Interestingly, the Mozilla SHA1 code is about twice as fast as the openssl
> > code on my G5, and judging by the disassembly, it's because it's much
> > simpler. I think the openssl people have unrolled all the loops totally,
> > which tends to be a disaster on any half-way modern CPU. But hey, it could
> > be something as simple as optimization flags too.
> 
> Which gcc version are you using?

gcc-3.3.3.

But it's more likely the precompiled libssl. I'm not compiling the openssl
thing myself, but just using the standard 0.9.7a version that comes with
YDL. Which, btw, causes all of 

	/lib/libcrypto.so.4
	/usr/lib/libgssapi_krb5.so.2
	/usr/lib/libkrb5.so.3
	/lib/libcom_err.so.2
	/usr/lib/libk5crypto.so.3
	/lib/libresolv.so.2
	/lib/libdl.so.2

to also be included. Oh, well.

> I get the opposite result on my 2GHz G5: the Mozilla version does
> 45MB/s, the openssl version does 135MB/s, and my version does 218MB/s.
> The time for a fsck-cache on a linux-2.6 tree (cache hot) is 8.0
> seconds for the Mozilla version, 5.2 seconds for the openssl version,
> and 4.4 seconds for my version.

I get 16 seconds for the openssl one, and 8 for the Mozilla one. I'll try 
your version.

		Linus
