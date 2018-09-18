Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E6A1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbeIRWqw (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 18:46:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:52222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729037AbeIRWqv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 18:46:51 -0400
Received: (qmail 6420 invoked by uid 109); 18 Sep 2018 17:13:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Sep 2018 17:13:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9131 invoked by uid 111); 18 Sep 2018 17:13:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Sep 2018 13:13:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2018 13:13:17 -0400
Date:   Tue, 18 Sep 2018 13:13:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] config doc: add missing list separator for
 checkout.optimizeNewBranch
Message-ID: <20180918171317.GB15470@sigill.intra.peff.net>
References: <20180816182653.15580-1-benpeart@microsoft.com>
 <20180918053449.14047-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180918053449.14047-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 05:34:49AM +0000, Ævar Arnfjörð Bjarmason wrote:

> The documentation added in fa655d8411 ("checkout: optimize "git
> checkout -b <new_branch>"", 2018-08-16) didn't add the double-colon
> needed for the labeled list separator, as a result the added
> documentation all got squashed into one paragraph. Fix that by adding
> the list separator.

Obviously the right thing to do, but your patch does not seem to apply
on that commit. Looks like you built it on a more recent commit that
also has checkout.defaultRemote (i.e., probably 'next')?

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ac71ade256..1546833213 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1153,7 +1153,7 @@ and by linkgit:git-worktree[1] when 'git worktree add' refers to a
>  remote branch. This setting might be used for other checkout-like
>  commands or functionality in the future.
>  
> -checkout.optimizeNewBranch
> +checkout.optimizeNewBranch::
>  	Optimizes the performance of "git checkout -b <new_branch>" when
>  	using sparse-checkout.  When set to true, git will not update the
>  	repo based on the current sparse-checkout settings.  This means it

Now the real reason I responded. :)

I just want to plug the recently-added "doc-diff" script, which diffs a
rendered view and makes it easier to catch cases like this. E.g., after
applying your patch:

  $ cd Documentation
  $ ./doc-diff HEAD^ HEAD
  [...]
  diff --git a/6ad88fd5d99b8dcbb69c6f3239ad41e66516d8f7/none/share/man/man1/git-config.1 b/28e258682021a09cd7842e4edbb21ad231c8bb7a/none/share/man/man1/git-config.1
  index 7298292112..fa91b5f2d1 100644
  --- a/6ad88fd5d99b8dcbb69c6f3239ad41e66516d8f7/none/share/man/man1/git-config.1
  +++ b/28e258682021a09cd7842e4edbb21ad231c8bb7a/none/share/man/man1/git-config.1
  @@ -1533,12 +1533,13 @@ CONFIGURATION FILE
              branch. This setting might be used for other checkout-like commands
              or functionality in the future.
   
  -       checkout.optimizeNewBranch Optimizes the performance of "git checkout
  -       -b <new_branch>" when using sparse-checkout. When set to true, git will
  -       not update the repo based on the current sparse-checkout settings. This
  -       means it will not update the skip-worktree bit in the index nor
  -       add/remove files in the working directory to reflect the current sparse
  -       checkout settings nor will it show the local changes.
  +       checkout.optimizeNewBranch
  +           Optimizes the performance of "git checkout -b <new_branch>" when
  +           using sparse-checkout. When set to true, git will not update the
  +           repo based on the current sparse-checkout settings. This means it
  +           will not update the skip-worktree bit in the index nor add/remove
  +           files in the working directory to reflect the current sparse
  +           checkout settings nor will it show the local changes.
   
          clean.requireForce
              A boolean to make git-clean do nothing unless given -f, -i or -n.

Obviously we knew this fix was going to help, but running it on the
original fa655d8411 (versus its parent) and eyeballing the result might
have caught this sooner.

(Though I would not be at all surprised to hear that the script does not
run on Windows, as it relies on things like "man"; patches certainly
welcome).

-Peff
