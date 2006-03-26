From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Why would merge fail on a one-line addition?
Date: Sat, 25 Mar 2006 16:31:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603251629330.15714@g5.osdl.org>
References: <20060325222601.GA1500@buici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 26 01:31:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNJAX-0005NP-C4
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 01:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbWCZAba (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 19:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWCZAba
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 19:31:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751982AbWCZAb3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 19:31:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2Q0VRDZ006979
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 16:31:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2Q0VQr7018300;
	Sat, 25 Mar 2006 16:31:26 -0800
To: Marc Singer <elf@buici.com>
In-Reply-To: <20060325222601.GA1500@buici.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18009>



On Sat, 25 Mar 2006, Marc Singer wrote:

> One of the unmerged files leaves this trail.
> 
>   elf@florence ~...git/linux-2.6 > git-ls-files --unmerged
>   100644 6262d449120cdcde5db1b079806dcc0d9b5e6b7c 1       arch/arm/mach-lh7a40x/irq-lpd7a40x.c
>   100644 dcb4e17b941990eabe8992680c9aa9b67afb6fd4 3       arch/arm/mach-lh7a40x/irq-lpd7a40x.c
> 
>   elf@florence ~...git/linux-2.6 > git-cat-file blob 6262d449120cdcde5db1b079806dcc0d9b5e6b7c > a
>   elf@florence ~...git/linux-2.6 > git-cat-file blob dcb4e17b941990eabe8992680c9aa9b67afb6fd4 > b
>   elf@florence ~...git/linux-2.6 > diff a b                                       21a22
>   > #include "common.h"
> 
> Why would git have a problem with this?

That whole file was apparently removed in the branch you are merging into 
(no stage 2). So what should the merge do? Throw away the one-liner 
addition (likely the correct thing) or maybe it should go somewhere else 
(ie maybe it wasn't removed outright, but the contents moved into another 
file, which would now need the one-line addition).

		Linus
