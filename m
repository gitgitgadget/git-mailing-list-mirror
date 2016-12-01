Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806911FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755402AbcLASYv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:24:51 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33266 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755093AbcLASYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:24:50 -0500
Received: by mail-qk0-f169.google.com with SMTP id x190so254037119qkb.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=96d8AkQcFEnW0chMSHO9pB4YHyGp5Q+gqlczdG1PpN0=;
        b=AHA9wy1L1u7k080ckVQgxKvVrWsl1W7BNA4jGRMhn8oYJRp+RlvNP7IO4yTRRp0/mG
         KW8y5/nvKLCUXgQv9t188+hZ2m9Id2VtI/TWtASXu3/870H7+lmAkDjKpmrnwDq/utxU
         WfKB6tHnuyz+TVK9nN2Gt69ag+2yTLsig+VAS0YPoEd5Y6ey1WtwpBPQxvY0GFepP6rn
         YORNhuU1JqoEnwAy7h8D3dJkh4zfYGhTURo6Qy4b7I9YS1FZc5aP5JPeUjH9/G1tcvaM
         jrp0FkfO/j82JXkaWq9dde0qE2j4gPr4W5r68fsHBkIeiVNxHWXhs6qM1MFPb++mUevy
         YzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=96d8AkQcFEnW0chMSHO9pB4YHyGp5Q+gqlczdG1PpN0=;
        b=isihHl9fd9ZapVdNYx6ogTc9M36PKGra2S2tXHy3w3+ctsI5moHNhXqRPf4t8uKaAT
         e7vJjmn74C8PAzltE4ruLND9eZK480rN3uddubYJA6zh+sEd9yE4ymfjn05lXkRfBkIh
         ggiL/y+HrG5x2+8RBHHIotxwIfpg3nPutAPePqQLxUgLx74vqerUIRIlenJh++oN/0aB
         zyY/kIxSHtFA3jJLzSu47H7LlYf6QdWH4WJ7EsX32/SfsiFtj/jDl99kMKSDpF2Wr7tG
         1yWDijxVM5velPKCfJ7g5z19M5RvopzELhQo7JDKdZGTAG14Se1pmoBKkR6glqJ6ypvA
         lWMg==
X-Gm-Message-State: AKaTC00K4tEdj5oDebgnOUTMx09SkJxdhu/1XuPct34oPYTjlWp1BLRC37lLyV715h4vU76450V7QRGKyTqaTD3c
X-Received: by 10.55.186.3 with SMTP id k3mr38188103qkf.47.1480616689592; Thu,
 01 Dec 2016 10:24:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 1 Dec 2016 10:24:49 -0800 (PST)
In-Reply-To: <xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.google.com>
References: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
 <xmqqd1n0552i.fsf@gitster.mtv.corp.google.com> <xmqqtwgb52py.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYS=XWBpEBJsj95FV+j+HLxg=5xqwD73618t7ERYrKUfA@mail.gmail.com>
 <CAPc5daURyXO6-yaOWPhvvdS8Dr5psEEc8MVP4wQJ_AuxyZraRg@mail.gmail.com> <xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Dec 2016 10:24:49 -0800
Message-ID: <CAGZ79kZSEan5uXCUn4iVCWEc9zohMSr+UDyHDyQUHz84H=tR8w@mail.gmail.com>
Subject: Re: Re* git pull --rebase should use fast forward merge if possible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, neuling@dakosy.de
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2016 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:

> +test_expect_success '--rebase fast forward' '
> +       git reset --hard before-rebase &&
> +       git checkout -b ff &&
> +       echo another modification >file &&
> +       git commit -m third file &&
> +
> +       git checkout to-rebase &&
> +       git pull --rebase . ff &&
> +       test "$(git rev-parse HEAD)" = "$(git rev-parse ff)" &&
> +
> +       # The above only validates the result.  Did we actually bypass rebase?

Good catch for the test, but I think we can make the sed regexp simpler, as we
can leave out the second "[0-9a-f]"? (git reflog |sed
"s/^[0-9a-f]*/OBJID/" works here)

The implication of that we'd also match if there is no object id at
all at the beginning,
which sounds fine.

I shortly debated the idea to just cut off anything before the first
space and then expect
"HEAD@{0}: pull --rebase . ff: Fast-forward" only, but why cut off
what we produce
in the first place?

    git reflog --format="%s" -1 >actual &&
    echo "pull --rebase . ff: Fast-forward" >expect &&
    test_cmp expect actual

maybe?
