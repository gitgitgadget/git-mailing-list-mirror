X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Sun, 26 Nov 2006 17:53:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611261747380.30076@woody.osdl.org>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org> <7vejrpr7mw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 01:54:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vejrpr7mw.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32379>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoVhU-0005kf-JZ for gcvg-git@gmane.org; Mon, 27 Nov
 2006 02:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756011AbWK0ByS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 20:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbWK0ByS
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 20:54:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:63195 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1756011AbWK0ByS (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 20:54:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAR1rnix023698
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 26
 Nov 2006 17:53:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAR1rmeC016654; Sun, 26 Nov
 2006 17:53:49 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sun, 26 Nov 2006, Junio C Hamano wrote:
> 
>  - a two-commit series on MIPS via Ralf Baechle,
>  - a four-commit series on ARM via Russel King,
>  - a three-commit series on POWERPC via Paul Mackerras,
>  - a seventeen-commit series in net/ area via Dave Miller,
>  - a three-commit series on x86_64 via Andi Kleen.

You'll reasonably often see in the kernel:

 - a patch-series by Andrew (where nothing but filename clustering really 
   would help: the committer is me, and the thing is linear)

 - linearly on top of that, a git merge that was a fast-forward 
   (especially from the subset of people who actively rebase their trees: 
   that notably includes Dave Miller, but also for example the DVB people)

so purely a first-parent logic would not catch that case at all (but the 
committer would at least catch the "patch-series by Andrew" -> "Merge of 
network tree by Davem" break).

But especially with long patch-series through Andrew, it would be nice to 
have some other heuristics (although they _tend_ to be fairly random, 
especially at the end of the release cycle - at the beginning, I tend to 
have series of 100-200 patches that often _could_ be clearly clustered 
into a few clusters).

Anyway, the real win of clusterign would likely be for big releases, ie 
soemthing like "v2.6.18..v2.6.19-rc1", where there's definitely some 
clustering even apart from just merging (although the merge topology will 
definitely get some of it)

