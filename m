From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 17:18:58 +0200
Message-ID: <20050417151858.GA5745@elte.hu>
References: <20050417145232.GA5289@elte.hu> <Pine.LNX.4.44.0504170804130.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Simon Fowler <simon@himi.org>,
	David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:16:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBVF-0002ol-HY
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVDQPTy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVDQPTy
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:19:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43700 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261326AbVDQPTv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 11:19:51 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 4ED5931D8B0;
	Sun, 17 Apr 2005 17:18:22 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id D39DF1FC2; Sun, 17 Apr 2005 17:19:01 +0200 (CEST)
To: Brad Roberts <braddr@puremagic.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0504170804130.2625-100000@bellevue.puremagic.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Brad Roberts <braddr@puremagic.com> wrote:

> While I agree that a hash collision is bad and certainly worth 
> preventing during new object creation, for it to actually implant a 
> trojan in a build successfully it'd have to meet even more criteria 
> than you've layed out. It'd have to...

>   - provide all the public symbols the shadowed object provided so that it
>     would still build and link successfully

that's not a problem. Most modules dont provide public symbols.  
Especially not drivers. Generally it's the modules that _dont_ have any 
global impact that get reviewed less stringently - an attacker would 
thus choose them for psychological reasons anyway.

>   - be shadowing an object that's part of an active tree
>
> Shadowing an object that's not part of the working tree means 
> something on another branch or obsoleted some time in the past is 
> still db corruption, but not nearly as big an issue from a trojan 
> standpoint.

it's not DB corruption, it's a feature of GIT: it's a content _cache_, 
new and old alike. Nothing in GIT says that old objects in the 
repository (which are still very much part of history) cannot be revived 
in newer trees. (in fact it regularly happens - e.g. if a fix is undone 
manually.)

	Ingo
