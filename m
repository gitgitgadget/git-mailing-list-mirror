Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D890C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 06:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C8B6113C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 06:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFUGbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 02:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUGbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 02:31:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E90C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 23:28:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i4so4259877plt.12
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 23:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+qeyw1ycUw+PeqDl34PpuiqT+jpWSgCD0bqeGB0NAfM=;
        b=Meky/+7PC50N0cSpQOaRen51v7cyhh+JgZH4pLzYrhJ8e+RIp3+7VdBzhSWHXSpWO4
         0OIAANYxmBCl+oPRo0Is4Bhuku+lOMSFOtPRnmoTLWbe777t1twHZQrfUYZEovU4xXrc
         H/Xn3yKWG+OpdiAqrTQhzrPeAHOuHsPY0qZS9GbHo3C3fy4qGgEEmsrj+QqDYMttUr9O
         QfljsC6j4eHl1AEEycQks7sBxMK3EahW6+Khu95dHi8BFa2VEX+euHLdiLPdvar6qwtD
         gytroZU7+GAMvMQS/jLQt0AjdW2bWIKQK3ZO+d6NIXdGF69/zhGYIfEyAZsg3wFBw0oY
         NfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+qeyw1ycUw+PeqDl34PpuiqT+jpWSgCD0bqeGB0NAfM=;
        b=JGPi5FYNIB1zMsQo8o5WSXqadDgJmRy9WZ2f51MNwSEDP0Apb99m9s7AYxzm/ZJn+Y
         kFqZZvQAV07RbIdSxfkyrQ30cwDD0JpqSQVykIH9Jm96eSuXd30vO2zNG+mLf1+ZrQfd
         7rCXimIR7DICSLL1ahP372JcK3H2b9Bgx/5H2UwsSDP6f7tpR0Hdl37WtdAcqtROxpWo
         iDn6b23PHxHrsYYcOG/9DCCaTUXn9GkVvD+4dQwpErgh0aJ4i2AIeA8lwbLnKomdsEiG
         ul2Ct0o7TtVSvILCujXPWAwdNR+qgEfKHOqc8s6n6K205dQSx2IFv+PcrMNu39+zLvBZ
         ELNA==
X-Gm-Message-State: AOAM530sfhTS0U1MZ5guck9got3adpFFbU5pKcQNJdfLFTmhn+ZVRc/B
        okK0SfTGOvp2u8ScK0JfkKg=
X-Google-Smtp-Source: ABdhPJybeaPNAhBEb/k3X2tAj9lhXvZwpfaI21+uvaFbY+xbMDRge7vjLP6iTSlHN8yWsvcgZbCz5w==
X-Received: by 2002:a17:902:b609:b029:118:8a66:6963 with SMTP id b9-20020a170902b609b02901188a666963mr16584256pls.65.1624256929351;
        Sun, 20 Jun 2021 23:28:49 -0700 (PDT)
Received: from smtpclient.apple ([119.82.122.172])
        by smtp.gmail.com with ESMTPSA id q21sm17398256pjg.43.2021.06.20.23.28.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 23:28:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [GSoC] My Git Dev Blog - Week 5
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <ac381db1-fb14-2a23-cfee-863840b89493@gmail.com>
Date:   Mon, 21 Jun 2021 11:58:46 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C21B26E-7A17-4BDC-8EF0-5D1A90BECF25@gmail.com>
References: <D32894F5-FC76-4DD2-A2F6-E69AAE88C645@gmail.com>
 <ac381db1-fb14-2a23-cfee-863840b89493@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21-Jun-2021, at 00:46, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> =
wrote:
>=20
> On 19/06/21 7:02 pm, Atharva Raykar wrote:
>> Here's the latest instalment of my weekly Git blog:
>> http://atharvaraykar.me/gitnotes/week5
>>=20
>=20
> Nice blog.
>=20
>> A peek at what's inside:
>>  * The blog starts with a summary of all the relevant things
>>    that have happened so far in my time with Git, including
>>    the status of my submodule-related work.
>>  * A question I had about reading the index into memory
>>    (any kind of help would be appreciated!):
>>    =
http://atharvaraykar.me/gitnotes/week5#some-challenges-with-the-changes-th=
at-are-cooking
>=20
> I've tried to clarify this to an extent in a comment [1] on your =
branch.

Thanks, I'll have a look.

> A few other things:
>=20
>> After Rafael and Eric commented on my patch, I forgot to CC them when
>> I rerolled. New contributors: please check your CC=E2=80=99s before =
hitting send!
>=20
> To add to that, Cc-ing people in the e-mail of all the patches in the =
series
> and not just in the cover letter would be nice too. :) Of course, if =
you have
> a specific reason to not do that, then it's fine.

Okay, I will remember to do this.

>> And my other blooper was to forget signing off one of my patches. =
Oops.
>=20
> Are you aware of `format.signOff` [2] which could save you from issues
> like these?

Thanks, this should have been in my config all along. Unfortunately,
it won't be possible to automate adding the other trailers in my
patches, unless Git learns to read my mind ;-)

>=20
> [1]: =
https://github.com/tfidfwastaken/git/commit/3c46c108a195c42edaab939ab6dd67=
31e52aefc3#r52396546
>=20
> [2]: =
https://git-scm.com/docs/git-config#Documentation/git-config.txt-formatsig=
nOff
>=20
> --=20
> Sivaraam

