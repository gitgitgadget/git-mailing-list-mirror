Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0034C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9465D2073B
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="oBhtON/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfLLTBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:01:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36554 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfLLTBI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 14:01:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so74740lfe.3
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 11:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jz9rKhZCM7p+Bzm/tdHY4FSQSKhfLXm6wg/r86n+yt8=;
        b=oBhtON/Uzg7gRMYqIIPy4LMlvpi7CMkvWKkQXUjU8141AZZ3E2SHMNSmze+9VNbCXk
         ckwiPTOchgSJrGaTCCEcaf/tHWi02ZMxC7Bfk5wKaiSego/+xnLOL9yLzIKsFrMOLQHj
         16UluWmC1kpWSss56+ET/pyg9na+aNg9rRkQWVV178mMESvhjQiKh2xxpu7gG2gArN40
         6MxIe5l3EViVafPiiDbExxJYvSgyVUSfhiHNkrWJN0za8hUnvxfQfvVGt0KdLZqwX4Ix
         x4RKVYnc7QVclatkdJmh7/jTJDbAdgwj3vmDIJ7LlW9oJM2Ch5VuSmOwHUzvU3LTeai0
         VPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jz9rKhZCM7p+Bzm/tdHY4FSQSKhfLXm6wg/r86n+yt8=;
        b=gzhR2xLpb1eXmmyTxo1K66yS1Vqpkg1ICo4BdMwZPgqbY1HaEFzlWTAPP4HbuvL5da
         W+HttgRI70lIigOhxSapAhT+WL66yobBK+0LK8xSPhtbgiRc8eQaU6sfUcQoCC6pNE8p
         2DboTYy03jTLT0QCwLAQ8yLLQgskoS945zame/nymNuAD/JWlIExVouAzbjGefiiopL5
         RijAg5lh1cagJZ7Ur8Q+VSVxttlUWnTDnylTCV+AqUZJchrgJPjjWrLluCmInXCbveut
         FAAQhTEDgBa8XkjrP5/zwbNlr8Xc2zYWjNqOMNjXSggoRoZGhJNkTqVRz+Hg0jWNgXvm
         vngw==
X-Gm-Message-State: APjAAAWeWYGq9mxtnB3Col/tLpOlp+A8eV59pEvYJ95G102bb92tGpoU
        7hiwX/a4EyK3CaVDhTvR3br2X/mtnvMogmmBvevZ8ntBL00=
X-Google-Smtp-Source: APXvYqylHxYB900eIvbU9Bmp3/V4JFv5YMY/F9ekTciQqfB3/mlC2GoFQKVT0wyDFGzagdVYhtSpQ16Xb6tvDvHmaBU=
X-Received: by 2002:a19:f006:: with SMTP id p6mr6588012lfc.94.1576177266240;
 Thu, 12 Dec 2019 11:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207003333.3228-2-yang.zhao@skyboxlabs.com> <20191210103014.GF6527@szeder.dev>
 <CABvFv3Lud80UzFXa6BRMGLwRV6gsJpNcs-mrgOiNHoJL0d+koA@mail.gmail.com>
 <20191212141322.GK6527@szeder.dev> <CABvFv3J8JjXGeAXSWDmK5zDav8qYNQ6Ce-8dPGAmuySGj8xvNg@mail.gmail.com>
 <20191212171516.GL6527@szeder.dev>
In-Reply-To: <20191212171516.GL6527@szeder.dev>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Thu, 12 Dec 2019 11:02:48 -0800
Message-ID: <CABvFv3Ky4K4dFFCJogpY_8Z7Qk3HiUQUMqSch+B+fKDXjjfUeA@mail.gmail.com>
Subject: Re: [PATCH 01/13] ci: also run linux-gcc pipeline with python-3.7 environment
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 12, 2019 at 9:15 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Thu, Dec 12, 2019 at 09:04:24AM -0800, Yang Zhao wrote:
> > Unless there's a very good reason to _not_ use Azure Pipeline's
> > built-in Python version selection support, I believe it's more
> > desirable in the long-run to leverage the feature rather than maintain
> > some custom solution.
>
> Azure Pipelines's built-in Python version selection support only works
> on Azure Pipelines, therefore it's more desirable to have a general
> solution.

That's fair. However, if we actually want to have something unified
that works for Linux and macOS (t90** isn't run on Windows afaict)
then I won't have the bandwidth for it in the near term. I'd be more
inclined to drop the CI changes from the series if we don't want a
stop-gap in the meantime.
