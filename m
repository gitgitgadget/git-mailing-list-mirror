Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883D81F403
	for <e@80x24.org>; Sun,  3 Jun 2018 20:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeFCUks (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 16:40:48 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41100 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCUkr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 16:40:47 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w53Kej3r005287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Jun 2018 22:40:45 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w53KejM6005286;
        Sun, 3 Jun 2018 22:40:45 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w53KOd0x013267;
        Sun, 3 Jun 2018 22:24:39 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w53KOdRf013266;
        Sun, 3 Jun 2018 22:24:39 +0200
Date:   Sun, 3 Jun 2018 22:24:39 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603202438.GA13078@helen.PLASMA.Xg8.DE>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
 <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <87sh638xdr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sh638xdr.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 09:48:16PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Sure, but what I'm pointing out is a) you can't focus on git as the
> technology because it tells you nothing about what's being done with it
> (e.g. the log file case I mentioned b) nobody who came up with the GDPR
> was concerned with some free software projects or the SCM used by
> companies, so this is very unlikely to be enforced.

As I already said, the GDPR refers to the state of the art in 
technology, without defining it.

The GDPR provides a generic framework. It covers everyone. From a 
single person running a small blog to a S&P500 enterprise. It also 
covers non-profits and state authorities. Everyone is covered. 
Including SCM used.

The GDPR will be enforced against SCMs. The question is just who will 
be the first to be affected. I suspect it will be a mega-corporation 
who fired one of their developers who wants to fight back and exercise 
his right to be forgotten against the company's public git repos.

> So nobody can be GDPR compliant in the face of archive.org and the like?

The GDPR has special exceptions for archives and the like.

> It does if you've got the ref. Maybe I just don't get your proposal,
> quote:
> 
>     Do not hash anything directly to obtain the commit ID. Instead, hash a
>     list of hashes of [$random_number, $information] pairs. $information
>     could be an author id, a commit date, a comment, or anything else. Then
>     store the commit id, the list of hashes, and the list of pairs to form
>     the commit.
> 
> You're just proposing (if I've read this correctly) that the commit
> object should have some list of headers pointing to other SHA1s, and
> that fsck and the like be OK with these going away. Right?

Certainly not SHA1. SHA1 is completely broken. I know Linus has a bit 
of a different opinion. But there's really no defense for SHA1. It's an 
utterly broken algorithm and should not be used at all anymore.

> How is this intrinsically different from referring to something in the
> ref namespace that may be deleted in the future?

I guess I am partly repeating myself, but:

1. Having fsck be OK with erasure is not enough. It tells you nothing 
about anonymization. If the hash is the same in 5000 instances that's 
pseudonymization, not anonymization. You need to ensure a different 
hash in each instance, and you need to ensure there's no easy way to 
reconstruct the data from its hash. Hence $random_number (or let's call 
it $huge_random_number, it should have x bits if the hash has x bits). 
If you have the SHA1 64ca93f83bb29b51d8cbd6f3e6a8daff2e08d3ec it's too 
easy to figure out the plaintext (it's "Peter" BTW).

2. If you use a random UUID you cannot reconstruct the data from its 
hash, but you have the same issue about UUID reuse. Plus, you lose the 
ability to verify the author's name as part of the commit.

> Okey, so you're not reading the GDPR in some literal sense, but you're
> coming to a conclusion that's supported by ... what? To echo Theodore
> Y. Ts'o E-Mail have you consulted with someone who's an actual lawyer on
> this subject?

I'm replying in private conversation about this one. It's not relevant 
for this discussion.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
