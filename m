Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8816BC388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 23:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B8122227
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 23:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNmfWbwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgKSX3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 18:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgKSX3T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 18:29:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B29DC0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 15:29:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l1so8162603wrb.9
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 15:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygJ4vJNDOAXyxtlwBmuJAkbHmMm6n+9K7CZf4We5Mok=;
        b=gNmfWbwZaxf0QVjkNPqlcFZbix2CkkcmT0T285z1rXQXkw3GJ/7WWqrEqm4s03dG/P
         0UVJqkXeXfWMfZkrXFLMr22FFzwtOmJOv59qDo+jhBWdeDKhjc8k0hlzYDIO3p2V4Zvn
         cVOmutEIZzsuOgbUtp8LMsATJaNfip+CRVEtk45mgtovyvZMhq7rJy16fKcc5qYXtnY0
         HAbY+VfsZl1yqPCs4arewgZ4km0lEL9NEnplRVs2PMy8CL/czPMlGAyfwwTSj2dER69X
         ddpIzpoghDe9ALMxJScBcPHjefDHSoDUsDIXC0x1Pi57qZCZ3W4Knjq3jN5YCMjMpFsg
         WNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygJ4vJNDOAXyxtlwBmuJAkbHmMm6n+9K7CZf4We5Mok=;
        b=o0C4Yv2VzKbgkx/gIGsyNsZebjWZLHHv3seXWbN2JVkURJ4hlSnxBUmPtnsLEK440P
         /ZMJrYk1B2KOljp0SfYp2GU5U5KisqgoHQlvTknBylWNBqBUKpBdFkaLiV5tAt66myFN
         uSh+BxdUnJg+R+6O3BO/YIqHuuVSsB/NBRvraG0jna83lnjoCZ9bMg2mbN0AL4T4Gj5X
         yX3fECFnut/TheVy/5OVaM2n/KIM4Ff25VTZQr1pIdoAeHAPHA7P9AkMKgXRSStmZF1l
         BYdd040fURqBRBTRcKSLULes+glxhwWJ2obUxZP2Bmrt82Xm7RqmsfEmIAZgAR+Z66y9
         jyfw==
X-Gm-Message-State: AOAM5317npre2Us47ucqIe/k89mPX3dP9kWzVIff4yoD2DZSsBt2EoWV
        nqyGOWeog2rmoTNucs8rKIH4xw0Sraf7ZTOztW4=
X-Google-Smtp-Source: ABdhPJwhgEILgz9EoGlkrFnNapHkwJiVuaT+1yhU+tQElS4YF1N0d7nRvcgmpsgpqq+al5ujQj1pE+PLBuMEFNhte+M=
X-Received: by 2002:adf:e788:: with SMTP id n8mr12398962wrm.84.1605828557371;
 Thu, 19 Nov 2020 15:29:17 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu> <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu> <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
 <20201115034649.GC3985404@mit.edu> <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
 <20201119133705.7q7yghymvvo7zeq4@chatter.i7.local> <xmqq4kllxcmw.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kllxcmw.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 19 Nov 2020 17:29:06 -0600
Message-ID: <CAMP44s1515GOwTOYv-wz4qMC9Qb6d8cSVSb_CNVwun0+Yj3VxQ@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Brandon Casey <drafnel@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Lukasz Niemier <Lukasz.Niemier@kobil.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 3:25 PM Junio C Hamano <gitster@pobox.com> wrote:

> Some understand well that the primary reason to switch to 'main' is
> to help people who will need to interact with projects and hosting
> providers that have done the same switch already [*1*].  Some do not
> buy that reason well and ask "why?".  You need to give an answer to
> the latter.

How exactly does this help people interacting with GitHub?

The main instructions in GitHub while creating a new repository are:

  echo "# test" >> README.md
  git init
  git add README.md
  git commit -m "first commit"
  git branch -M main
  git remote add origin $url
  git push -u origin main

Changing the default to "main" would modify the instructions to:

  echo "# test" >> README.md
  git init
  git add README.md
  git commit -m "first commit"
  git remote add origin $url
  git push -u origin main

One line. That's it.

Moreover, they can already get rid of that line, all they have to do
is "git init -b main" instead of "git init".

Why haven't they updated the instructions?

Ahh, that's right... it's because the instructions are meant to work
on older versions of git as well.

Therefore, even if the default was changed in Git 2.30, they will not
change the instructions.

It's very likely that even if Git changes the default in 2020, GitHub
will not change the instructions by 2022, possibly 2024 (if the world
still stands).

So how exactly will this change help GitHub and other hosting providers?

The anti-master camp came here *demanding* a name change, and in the
process of discussing many claims were simply taken for granted, even
though no prima facie was offered.

But no, the claim that this change will "help people who will need to
interact with projects and hosting providers that have done the same
switch already" has not met its burden of proof.

In fact, no attempt has even been made to explain *how* it would help.

Cheers.

-- 
Felipe Contreras
