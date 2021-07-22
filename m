Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BCC63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFEF461001
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhGVIeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhGVIeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 04:34:16 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822CC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 02:14:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b6so4688295iln.12
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=newbNUzoVXHrzqm8sKdg7Blz7erZ4tMbfDYrVk+Wgxo=;
        b=Q77q387aHaAlFsnvAvCAyKkEecJreojAt1BQz9ax9Whw6WiF6nw2tKSfOehC6SvQVg
         cljeRFCMQQGfwI/vQPvA9FRqELfzl23oXA3rEJV7JLtAQYjRLvjW2SLPlWdPdOok0KpB
         Pawy/SywkOaTsFpc9BzszLWTS2QS+R3OJ/h2ObhruoG2mo8etMnNilYCsx7kf+tAd4hz
         +TJVRB+jrmPg1DOUb0CSF7zob0ASpQCUqeho1uk3CNEvuPPsivQgBMS6fvmXY68FrU2e
         qgnjjQwLAC3QoEpXmhN9KFZ9GBBQEOvO6w/a2CJIp6pc8uxhP/lcrveL3zKPrI5EyTJb
         UbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=newbNUzoVXHrzqm8sKdg7Blz7erZ4tMbfDYrVk+Wgxo=;
        b=GbVCOBHC3mfKzIr72ake0ezw/sjkv5u0xCVPhuR3UgVw+KacfYTtCSyoYmDdDSBh0f
         K6IEqUyyW89Pd8mH8+1+AECpFcEwvpo0u9slq0l5BUdwo0JLRzZCkNmiS/muTbWqlZBb
         unmMAHB4vYoWWVd+qVh34U5N43uhoWn3/7HpfhvqIEydXAmKOC6Uw/Pg6LTnhtU++8TW
         Xpcneb008vopy5nrSXkbfRvmYmCE1+6vInV2Z5drgLEAjVYr8UQfyUtpySHmtvS3euzF
         GVxWeOMgaR0IKLKjC2/yaPX2V27K/zCICgYMGKQ2U1E7RE74W8kPVU+QyQBttv8HhYTY
         Ogxg==
X-Gm-Message-State: AOAM530owJG9qmI9q8O9vlLtdm0I1gntMMo2O40J+VKxhDCwF1SQ2ONR
        f0OMD1/O/2bsYy+q55XDi7DZ7SVvA6IQbl2o5Js=
X-Google-Smtp-Source: ABdhPJxlMsTO6qRpT5Z/pSY2bpAjvlx5wtNfT08RJ9pKIf37DZbccHdpAtDZLBIVClKjFWhPSgngs3tvrBGHd0ky+FA=
X-Received: by 2002:a05:6e02:ea9:: with SMTP id u9mr26883466ilj.174.1626945290924;
 Thu, 22 Jul 2021 02:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
 <a7b4e45f14a27bd67172e24660f448e4c9cce5d8.1626939557.git.gitgitgadget@gmail.com>
 <CAP8UFD3nmnu7fEOG75O46qEKtFHppbeZy3Y-NkPTCgphM5MPqA@mail.gmail.com>
In-Reply-To: <CAP8UFD3nmnu7fEOG75O46qEKtFHppbeZy3Y-NkPTCgphM5MPqA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 22 Jul 2021 17:15:15 +0800
Message-ID: <CAOLTT8SNgbJRnmtfL4J=ypo1Q98gY9DE3g6BjBnX895tkMLcng@mail.gmail.com>
Subject: Re: [PATCH 1/5] [GSOC] ref-filter: add obj-type check in grab contents
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8822=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:51=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Thu, Jul 22, 2021 at 9:39 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Only tag and commit objects use `grab_sub_body_contents()` to grab
> > object contents in the current codebase.  We want to teach the
> > function to also handle blobs and trees to get their raw data,
> > without parsing a blob (whose contents looks like a commit or a tag)
> > incorrectly as a commit or a tag.
> >
> > Skip the block of code that is specific to handling commits and tags
> > early when the given object is of a wrong type to help later
> > addition to handle other types of objects in this function.
>
> Small nit in case the series is rerolled: it looks like this commit
> would change only `grab_sub_body_contents()`, but there are a few
> changes to grab_values() too. Maybe you could add that it's needed to
> pass a `struct expand_data *data` instead of only `void *buf` to both
> `grab_sub_body_contents()` and `grab_values()` to be able to check the
> object type.
>
Indeed so. I will add them.

Thanks.
--
ZheNing Hu
