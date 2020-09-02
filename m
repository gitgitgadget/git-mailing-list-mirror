Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F745C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EC820829
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="QbLxUFOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgIBQQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgIBQQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 12:16:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5AC061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 09:16:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v12so6622274ljc.10
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyjgLDyQZGFMYBWrgezgwPq/6H4UlTM/V9XPK/xWH6k=;
        b=QbLxUFORu7qV3X0EbdUkUpHvUayIT0dnWa8ikLy08tNZAHG1tF9CVnJ2xhz+ifgP3G
         uNg+6uoO0gIcnnc85ITWvq412EcDNlbZrxZWfsQhT+mmbuyFHDACEUikTJWuUph6MQPl
         h4dud6sEckVjhH+Yovp+mzaI5+szxLkNRnyuwb73VGDjjdjXkyQtT8W6D8T+bOvoHd9B
         6OA6ljgDbp7BiZMlW9uaGqxym0KQJLKSb3tFsl8tk5Z3MKksz99X6fVmCWG52pboYWJC
         ds0pw5EZU+iAvwOBPHHZXulG8mrt+g/0sGzL6FDB/R7vhW3Jm6PrFLLLi8IWwoA6ATt4
         Nezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyjgLDyQZGFMYBWrgezgwPq/6H4UlTM/V9XPK/xWH6k=;
        b=MsRBMr6U3gUaTSqEVnGmG0cmnGAF1/0jzvTxd7tpuddDybOKHZWhHxp9sI85Xr7NYU
         lZQG/H5eBVJTkV51Oy2WC5yd/zI5iTzufAd/5RVsxdh+OpeQwz8xkpO0kPn4Wcy8wZY2
         /a4XIli068y6s/8BzxfSwP0fOPtJymE8BzpNDw/ug0q2XgClhcmKCH2xpJiefhEtonic
         1R6ObVbcQ4jp+ETap6h3uXER/Q0iMebnUQ2ELH9TEDuuVRGolqBfEMyY2Jmqz36370/p
         2o8BClUR/T0KuvKYvOb/yURIYtkeBYGs+ol3iHjLXmDMtbTPwAm6wcFD4AvWG/WC+L3F
         750w==
X-Gm-Message-State: AOAM530Uvx24yqdpyAPJvboHGY87N8+dFuaW4Z+GewZJVKyYiuqxqFfY
        /6JmjgZXxvYG7dmzOiq9OrHBdp8HEFbjrelaKNYeVQ==
X-Google-Smtp-Source: ABdhPJzTbga6B+NAIA4ca4xgso6DnejyooyWUENZJc/lkqWtiLQyPiN37egHQHV5DvAPnmYfOjM+HFYzkBHC+mKBME0=
X-Received: by 2002:a2e:a370:: with SMTP id i16mr3812863ljn.22.1599063377440;
 Wed, 02 Sep 2020 09:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599026986.git.matheus.bernardino@usp.br>
 <f53782f14c5f53da5d5537b369a810a94f9ce184.1599026986.git.matheus.bernardino@usp.br>
 <CAPig+cSLjMabeLgkg9N7+ZJ1jotbpJx0FAnjkpNSt0Lf+Q0wNQ@mail.gmail.com>
In-Reply-To: <CAPig+cSLjMabeLgkg9N7+ZJ1jotbpJx0FAnjkpNSt0Lf+Q0wNQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 2 Sep 2020 13:16:06 -0300
Message-ID: <CAHd-oW5gk16=Tmhi_e43vVCufM9=zd8jtZJ_EFJVLmC4dJ06=w@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] t1308-config-set: avoid false positives when using test-config
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 2, 2020 at 3:57 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Sep 2, 2020 at 2:18 AM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> > One test in t1308 expects test-config to fail with exit code 128 due to
> > a parsing error in the config machinery. But test-config might also exit
> > with 128 for any other reason that leads it to call die(). Therefore the
> > test can potentially succeed for the wrong reason. To avoid false
> > positives, let's check test-config's output, in addition to the exit
> > code, and make sure that the cause of the error is the one we expect in
> > this test.
> >
> > Moreover, the test was using the auxiliary function check_config which
> > optionally takes a string to compare the test-config stdout against.
> > Because this string is optional, there is a risk that future callers may
> > also check only the exit code and not the output. To avoid that, make
> > the string parameter of this function mandatory.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> > diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> > @@ -14,10 +14,7 @@ check_config () {
> >                 expect_code=0
> >         fi &&
> >         op=$1 key=$2 && shift && shift &&
> > -       if test $# != 0
> > -       then
> > -               printf "%s\n" "$@"
> > -       fi >expect &&
> > +       printf "%s\n" "$@" >expect &&
>
> This change in behavior is quite subtle. With the original code,
> "expect" will be entirely empty if no argument is provided, whereas
> with the revised code, "expect" will contain a single newline. This
> could be improved by making the argument genuinely mandatory as stated
> in the commit message. Perhaps something like this:
>
>     if test $# -eq 0
>     then
>         BUG "check_config 'value' argument missing"
>     fi &&
>     printf "%s\n" "$@" >expect &&

Thanks for catching this. I will add the check.

> > @@ -130,7 +127,8 @@ test_expect_success 'check line error when NULL string is queried' '
> >  test_expect_success 'find integer if value is non parse-able' '
> > -       check_config expect_code 128 get_int lamb.head
> > +       test_expect_code 128 test-tool config get_int lamb.head 2>result &&
> > +       test_i18ngrep "fatal: bad numeric config value '\'none\'' for '\'lamb.head\''" result
> >  '
>exit
> The complex '\'quoting\'' magic leaves and re-enters the single-quote
> context of the test body and makes it difficult to reason about. Since
> this is a pattern argument to grep, a simpler alternative would be:
>
>     test_i18ngrep "fatal: bad numeric config value .none. for
> .lamb.head." result

Will do, thanks.

> Aside from that, do I understand correctly that all other callers
> which expect a non-zero exit code will find the error message on
> stdout, but this case will find it on stderr?

Right. This happens because, for a "value not found" error,
test-config will exit with code 1 and print to stdout. This is the
only case where it exits with a non-zero code and prints to stdout
instead of stderr.

With that said, I'm wondering now whether we should change the
function's signature from:

`check_config [expect_code <code>] <cmd> <key> <expected_value>`

to:

`check_config <cmd> <key> <expected_value>`
`check_config expect_not_found <cmd> <key> <value>`

The second form would then automatically expect exit code 1 and check
stdout for the message 'Value not found for "<value>"'. With this we
can avoid wrong uses of check_config to check an arbitrary error code
without also checking stderr.

> That makes one wonder
> if, rather than dropping use of check_config() here, instead
> check_config() should be enhanced to accept an additional option, such
> as 'stderr' which causes it to check stderr rather than stdout
> (similar to how 'expect_code' allows the caller to override the
> expected exit code). But perhaps that would be overengineered if this
> case is not expected to come up again as more callers are added in the
> future?

That's an interesting idea. However, because some callers may want to
use test_i18ngrep instead of test_cmp, I think the required logic
would become too complex.
