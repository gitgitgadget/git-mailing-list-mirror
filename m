Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F1C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 04:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiDEEaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 00:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiDEEaD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 00:30:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F78C5FD2
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 21:28:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f18so8393921edc.5
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 21:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1f7q4KgyxfXMAjgKW/OW2Jkl3WSnlLCh2CpbEzJULzg=;
        b=U1HmywIois2wRoMQxsY56fM9/26VXsRYloYCMfadSjoZYhXa9abZKCMZ8DDKiFdC83
         NGZ3gVQ9oyHFcS3xMfqcXdmr2VuVCqi65GEvFKnqIkjGUIRfoWZptT4ILXgAYzPhBVs6
         rcTiiieizOKW286s1cPrneriFDFLGQzeunJXBWbmmFEOWBa30i9PwpS70SmfrpihRpB4
         IgZ0EmbGj77Ek9uoVHJVRWmjHiolqeOFW1YsI5wY2UKY8GL6uGsDhq8VKXhEZzCdaeli
         QxGtq1kLNn+vKE6JKPbd+GQPZK9W7obw4DmvsuQR9LM7+mdpwsBf7BN20mXhkgPDnD41
         TVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1f7q4KgyxfXMAjgKW/OW2Jkl3WSnlLCh2CpbEzJULzg=;
        b=JwkDThLKyMMYNwxIKQTjj5MpJ8I3ZX/QfCTCAjnn+Z/dpDwba4GVXCNVXLoQ9m6DWL
         Ugsj3TBV75vBf1NuN326CX+433BYfwdOxVrn8Lghm9eNM5BC7KAJJd/MJ77xhwNUK4Bx
         hRH8Rcm2YXCZ32ADpoHSWMRS7omFH/XecavlPuDvP3k7GrWRMNX7UgbcCyTc0dwWJjtQ
         rsFFBcbdf4gBD0rGASQlEjK/kDjup6E9d8kGmJ+42qw/qqwKIjrCimpeMtbaq/cmLkhv
         bDpMhyQwZK32+KVZr2on+pprZjgLwPw8wdHu2gObjK6YBQvP8DxTwt9V99vntluf7Tlg
         3F6w==
X-Gm-Message-State: AOAM531X0JZzEsKq38/vggEvB3TeICqrxsvvWMpeW8OhaMtbGhdBGMWn
        b+ha25K59H/az63KGYjKN0z9tlsxxyW4i4uWBsNP7w==
X-Google-Smtp-Source: ABdhPJygtapXH6Zh7fXtTJndkrbJ/4BnbbXVYO+QCGatasdgQobRW59qb2uqGSVKEbeQE3sAeA+pQ2Ox8wMIpy3U5c4=
X-Received: by 2002:a50:954b:0:b0:41a:c9cb:8778 with SMTP id
 v11-20020a50954b000000b0041ac9cb8778mr1543632eda.165.1649132881081; Mon, 04
 Apr 2022 21:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
 <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com> <BL0PR12MB484938E9950EBCA08315544CC8E59@BL0PR12MB4849.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB484938E9950EBCA08315544CC8E59@BL0PR12MB4849.namprd12.prod.outlook.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 5 Apr 2022 06:27:48 +0200
Message-ID: <CAPMMpoggSvPox5tM3B_NZ0GwLzg7LtHkXGhby1mZqpkehZ1G0Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] git-p4: Various code tidy-ups
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 4:46 PM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>
> I'm using pylint 2.12.2 on Python 3. I agree there are still many pylint warnings - especially if we start trying to cut down the disable list. However, quite a few of them are false positives.
>
[...]
>
> I used autopep8 to locate the issue I fixed here. It's not nearly as thorough as pylint, but PEP8 itself is very patchy in regard to the issues the authors chose to address.
>

Thx for the feedback! I will play.

>
> > I personally have an interest in making sure this script keeps running correctly
> > under python2, so I plan to test this when I can. I imagine this is already
> > accounted for in the t98xx suite somewhere, but I haven't found it.
>
> Can you give me a bit more information about this, because I was going to try and push for the git-p4 to discard Python 2 support later this year in a bid to simplify the code, reduce the testing burden, and move toward cleaner pylint output.
>

Now that you question it, I'm thinking a bit about how I got there:

I work with a Perforce repository that has a long and colorful
history, with users from many countries on at least three different
platforms (windows, linux, osx), and as such both user metadata and
changelist descriptions have used inconsistent encodings.

When running git-p4 under python2, any author and CL description
metadata that is not valid utf8 is simply carried over as-is, and the
"invalidly encoded" data just carries into the git repo. (that can
later be interesting when working with the resulting git repo in
python3, of course - at a minimum decoding errors then need to be
swallowed, when minor data loss is acceptable)

Under python3, the import fails when some of this stuff gets decoded
into unicode strings. Obviously the right thing to do is to figure out
exactly what fails under python3, and figure out how to fix it, but I
have historically just swept it under the rug and kept using python2
which doesn't bother trying to "interpret" the inconsistently-encoded
byte sequences.

I'll try to look into this and see whether git-p4 itself can be made
to be more forgiving under python3, or whether there is an even better
solution where inconsistently-encoded Perforce metadata can somehow be
harmonized. Either way, I'll try to contribute some
test_expect_failure tests.
