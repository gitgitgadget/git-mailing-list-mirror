Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172262022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbdBWSSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:18:40 -0500
Received: from lang.hm ([66.167.227.134]:36682 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbdBWSSj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:18:39 -0500
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v1NHqlv6008817;
        Thu, 23 Feb 2017 09:52:47 -0800
Date:   Thu, 23 Feb 2017 09:52:47 -0800 (PST)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Joey Hess <id@joeyh.name>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
In-Reply-To: <20170223173547.qljypk7sdqi37oha@kitenet.net>
Message-ID: <nycvar.QRO.7.75.62.1702230950040.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com> <20170223173547.qljypk7sdqi37oha@kitenet.net>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Feb 2017, Joey Hess wrote:

> Junio C Hamano wrote:
>> On Thu, Feb 23, 2017 at 8:43 AM, Joey Hess <id@joeyh.name> wrote:
>>>
>>> Since we now have collisions in valid PDF files, collisions in valid git
>>> commit and tree objects are probably able to be constructed.
>>
>> That may be true, but
>> https://public-inbox.org/git/Pine.LNX.4.58.0504291221250.18901@ppc970.osdl.org/
>
> That's about someone replacing an valid object in Linus's repository
> with an invalid random blob they found that collides. This SHA1
> break doesn't allow generating such a blob anyway. Linus is right,
> that's an impractical attack.
>
> Attacks using this SHA1 break will look something more like:
>
> * I push a "bad" object to a repo on github I set up under a
>  pseudonym.
> * I publish a "good" object in a commit and convince the maintainer to
>  merge it.
> * I wait for the maintainer to push to github.
> * I wait for github to deduplicate and hope they'll replace the good
>  object with the bad one I pre-uploaded, thus silently changing the
>  content of the good commit the maintainer reviewed and pushed.
> * The bad object is pulled from github and deployed.
> * The maintainer still has the good object. They may not notice the bad
>  object is out there for a long time.
>
> Of course, it doesn't need to involve Github, and doesn't need to
> rely on internal details of their deduplication[1];
> that only let me publish the bad object under a psydonym.

read that e-mail again, it covers the case where a central server gets a blob 
replaced in it.

tricking a maintainerinto accepting a file that contains huge amounts of binary 
data in it is going to be a non-trivial task, and even after you trick them into 
accepting one bad file, you then need to replace the file they accepted with a 
new one (breaking into github or assuming that github is putting both files into 
the same repo, both of which are fairly unlikely)

David Lang
