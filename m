Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC6C63777
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A07246A6
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTIBBZYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgKROQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgKROQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 09:16:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928FFC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:16:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r17so2419604wrw.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OwsWJSK14kfxg1iN5mCg2N3JJba4qBNLiGyzRVFZ5CE=;
        b=rTIBBZYydHoaEfFXmqx/CYq0s+jg1ilk3SdgZVBvEVJ4K3hbZ/MA/5dSnx6UyGzQw4
         GmvdDQhqj28Rwfyk4p69c/zh6UkZnHrCW3ib102GVbqWnZwyRCmmmsmwm0O7+Ghnru2K
         5youstZIELTuVx+DnupmYSG4jRTC3XALVCOp8AkgtcIg6OIKl2w8FpR1JNtn48FEZa7x
         dOM11K9Ts6qiKwKc1lngxLZH7nP9aNy/cQ1miMaJgToWvgBribD51hE/FcW8JEdljixv
         EyF+m84ZYfGgFmPx1Q2omHbneji2fr+BPYZQg8QrzF4WL/OUmnq721dzb22/cFMXxGln
         Eo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OwsWJSK14kfxg1iN5mCg2N3JJba4qBNLiGyzRVFZ5CE=;
        b=nu7wcoRDrQpTAAXkjHNLaJ39h0U+2FExOjuyhnJhef1HdpQ/SN5EzsE9qI7cxa0/cS
         pMT09Pt2MF8yB/csUJu5R1fkw/7TbEmILvPFkuPaPZqJzq+1YKGWlX7s+y+IRRQ8B0R/
         UWN82U3ungBn9ExEAIbhimcIHt7nPDO5XKWwQCbC3lHPnd/TIQH3GylJAGFM1up/7SFp
         5fsM/dWX4gPaEbmUcmb4Vc6J80MrKUXHtUn+f9iOYa9BnufYOjhrtTtbbMhls8pP/1NU
         t01TTWTpUW32nes/rsqltwSVIV2lindWWPOSZsZ/yGq1wRpcYFrolbOgCaegxHGvsfZA
         QRRA==
X-Gm-Message-State: AOAM530iQi74pAKI7gxtjjEA1VXTifrvOV6xmMkSuc1COwC9VLEd/2n2
        TxxY4WVG/Nrk5fNfAsjMdXFB3jxVLxaohW5soc4=
X-Google-Smtp-Source: ABdhPJxww0zGxFXrrlZPfb8/Dq4fGkLO0Chv9NLc4McBNqt0kEOBTe7I6N9ubk9xoiSRouTlCUM0T8c2OtGKeBJF/SA=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr4971768wrr.319.1605709003291;
 Wed, 18 Nov 2020 06:16:43 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
 <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet> <87h7psg6lz.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet> <87ima2rdsm.fsf@evledraar.gmail.com>
In-Reply-To: <87ima2rdsm.fsf@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 18 Nov 2020 08:16:32 -0600
Message-ID: <CAMP44s2Uf4tkBdHWFV6e3K3VqCksJxwz52kgWzTBN_SAHnof-w@mail.gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 7:32 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> I do 100% agree that the s/master/main/g change of the default should be
> made in one form or another. In my mind that doesn't even require a
> consideration of the political motivations at this point as far as
> git.git is concerned, just:

Others disagree.

While the political motivation shouldn't be a central concern, I
suspect the vast majority of users have no idea this change is coming,
and when they see the warning they will likely complain... Strongly.
The fact that this change is extremely politically charged will become
a factor.

>  1. Major Git hosting providers already made the change

That's their decision. The Git project shouldn't be held hostage to
third party decisions.

>  2. Realistically a lot/majority of git's user base interact with that
>     in a major way.
>
>  3. A discrepancy in any default between /usr/bin/git and those
>     providers is more confusing than not.

That's a problem for GitHub et al. Fortunately they can tell their
users to set init.defaultbranch to whatever they want.

>  4. #3 doesn't mean they say "jump" we say "how high" whatever the
>     change is.
>
>     But in this case the default is an entirely arbitrary default. Not
>     e.g. that they decided to add some ill-thought out header to the
>     object format or whatever.

I don't agree it is arbitrary, otherwise you could set the default to
"loremipsum". Moreover, even if was arbitrary, it was arbitrary in
2005, not 2020 where "master" is already widely used in basically
*all* the documentation everywhere. Some people have been using this
name for 15 years, they won't give it up just like that.

People will complain, especially if they don't see a good reason for the ch=
ange.

--=20
Felipe Contreras
