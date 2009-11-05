Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 29481 invoked by uid 107); 5 Nov 2009 19:40:41 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 05 Nov 2009 14:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758742AbZKETgr (ORCPT <rfc822;peff@peff.net>);
	Thu, 5 Nov 2009 14:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758445AbZKETgq
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 14:36:46 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:32909 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757755AbZKETgq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 14:36:46 -0500
X-Greylist: delayed 1461 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2009 14:36:46 EST
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id C544F40026;
	Thu,  5 Nov 2009 20:11:33 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id B6A5E40036; Thu,  5 Nov 2009 20:11:33 +0100 (CET)
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 7274E40026;
	Thu,  5 Nov 2009 20:11:33 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id DEDC6617E7; Thu,  5 Nov 2009 20:12:29 +0100 (CET)
To:	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To:	bill lam <cbill.lam@gmail.com>
Subject: Re: how to rebase backwards
From:	=?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Date:	Thu, 05 Nov 2009 20:12:29 +0100
In-Reply-To: <20091103093716.GD7117@debian.b2j> (bill lam's message of "Tue, 3
	Nov 2009 17:37:16 +0800")
Message-ID: <877hu4zsyq.fsf@lysator.liu.se>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
References: <20091103054510.GB7117@debian.b2j>
	<7vocnkt5o4.fsf@alter.siamese.dyndns.org>
	<20091103093716.GD7117@debian.b2j>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Old-Spam-Status: No, score=-0.2 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3

bill lam <cbill.lam@gmail.com> writes:

> Thank you for detail explanation.  From what you described, I begin
> with master commit D, 
>  $ git checkout -b deploy
>  $ git commit --allow-empty -m deploy

But why on earth would you want to use --allow-empty? There is no reason
for that. Just let deploy be where it is when you created it (until you
actually add something to it).

>                       E
>                      /^ deploy
>      ---A---B---C---D
>                     ^ master
>  
>  $ git rebase -i A
>
>                       v deploy
>           B'--C'--D'--E'
>          /
>      ---A---B---C---D
>                     ^ master
>
> since E is an empty commit, I suppose content of D' E' and D are
> identical at this point.  Is that correct?

Assuming you didn't intentionally change it during rebase, yes.

> If several months later, I forget which is the common ancestor for
> master and deploy, how do I generate the above graph or identify
> commit A as the common ancestor for these two branches?

That is exactly what git does all the time. You can use many
command. For instance git log --graph master...deply whill show you both
branches, starting from their common ancestor. "git merge-base deploy
master" will tell you that the common ancestor is. Etc.

-- 
David Kågedal
