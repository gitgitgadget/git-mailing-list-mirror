From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: duplicate htons() in check_file_directory_conflict()
Date: Mon, 6 Jun 2005 18:59:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506061858140.1876@ppc970.osdl.org>
References: <1118098966l.5384l.0l@garlic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 03:55:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfTJX-0001lG-To
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 03:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVFGB7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 21:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVFGB7I
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 21:59:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:55251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261228AbVFGB7C (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 21:59:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j571vFjA003983
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 6 Jun 2005 18:57:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j571vDhq030583;
	Mon, 6 Jun 2005 18:57:14 -0700
To: Timo Hirvonen <tihirvon@ee.oulu.fi>
In-Reply-To: <1118098966l.5384l.0l@garlic>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 6 Jun 2005, Timo Hirvonen wrote:
>
> create_ce_flags() macro calls htons() so the htons()s in  
> check_file_directory_conflict() should be removed or alternatively htons  
> should be removed from the create_ce_flags macro. I noticed the bug when  
> compiling cogito with -Wshadow.

No, but it probably should be a ntohs()..

cache_name_pos() takes a host-order thing, and create_ce_flags creates a 
network order thing. It so happens that on all sane setups, ntohs == 
htons, so..

		Linus
