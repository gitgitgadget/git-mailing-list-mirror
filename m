Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05A2C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 16:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiI1Q1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiI1Q1g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 12:27:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EE49AF96
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 09:27:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a8so21133788lff.13
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=giUcgKAB0wxZaglLpPH3bjm2dtAioKeZg7psZDd2yQs=;
        b=JMwUbJZ5h6WwXHKif+RWmY9MI+fH7MghqXGFAERPrtriqscagROje6jcyq0fTxSn52
         DzQNs2EYyZChgzr5b1oqlFL4/U34LI/nJdDg48N7OjIK84VBbnSD1L6evHq1Q44qABYh
         tyhpO+ZrZkivK0wlWWKOQMaaSm8pJF5B5/xA+hV4fn8ktw1anvId3wwYVRpARJYjCXoP
         g4nqIsZT9muSuphyrOHA45xBG3ywO7jGpIq54dBaEuGF32EKofaPEethGeVu1DIc6UkJ
         UrmAbs+z8hX94p3HZ0U1qeYQZYu2M3t9bfNN5fUUbK43VSqzlmHd1XS8vR+vZqS1h7s+
         eOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=giUcgKAB0wxZaglLpPH3bjm2dtAioKeZg7psZDd2yQs=;
        b=mc+s8hUwnS0aJOWKf5YfTkbjnS9xV9im96wo5m4fDZBU7XRE+qgTKcP6oUTfHfUuca
         vLZ6Kz4OnLM0Pgh4bthJfUMVLtBQ3XcKZoSusaM7VOW34UgGj2Ld68zqUln2lIP2pt08
         NrxRDwMpgMvbb85pmI98jqWP8RxFO0eqWXnjx1yN8eT0cxZYFxVgn0s46htPlaWybGE4
         moOhv/A4MtYAFMN2ofQN3USogwiN6eWfgAAhYr4Udo2sgwE6JkPuA2XxQMZRqIkerj2N
         FOQeV5y46CVYKt9COPE7olegJ0Q7ZRZmGNrX5vM+/qQ8OuFTg8tPfEjcqlC3Ox9wP5ym
         GNww==
X-Gm-Message-State: ACrzQf2IcR/vTiwKScmrdNHUUZzh1lMqJEgsNGsNUCZaZnlNPQZg7I8F
        0EhF+1T02ED+L3lxMtel1ThYlNoxWP3ye0XGybQ=
X-Google-Smtp-Source: AMsMyM4f/FbzDtKercDlD6iR+ME7UnhJO5G4w0xbwQdsiAUmgXmZk6BSCQIPnGxM/i1lw7uscmap7+1KIqkfrgiWoNo=
X-Received: by 2002:a19:5015:0:b0:498:fe6c:39de with SMTP id
 e21-20020a195015000000b00498fe6c39demr12365726lfb.263.1664382453168; Wed, 28
 Sep 2022 09:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220928050432.701512-1-alexhenrie24@gmail.com> <220928.86tu4rwmzk.gmgdl@evledraar.gmail.com>
In-Reply-To: <220928.86tu4rwmzk.gmgdl@evledraar.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 28 Sep 2022 10:27:21 -0600
Message-ID: <CAMMLpeTbuV4_xRbGLMBTz9U+XL1MzoL_TZO_GjE4Dar8DenhDw@mail.gmail.com>
Subject: Re: [PATCH] bugreport: clarify that -o expects a directory and not a file
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 9:13 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Hi, there's an outstanding patch of mine queued in "seen" that fixes the
> same issue. I sent a re-roll of it after you submitted this (but the v1
> had been in "seen". See:
> https://lore.kernel.org/git/patch-v2-17.35-97873747a1e-20220928T082458Z-a=
varab@gmail.com/

Thanks! It looks like you caught a lot more inconsistencies than I
did. Let's forget about my patch and just wait for yours to be merged.

> Per that change I think the right thing here is to convert both to use
> "<path>".
>
> I don't really have a strong opinion per-se on if we use "<dir>" or
> "<path>", but from grepping around the latter seems more common, even in
> cases where we mean "a path that's only a dir".

My main concern is that the usage string says that `git bugreport -o`
expects a file when in fact it expects a directory. I don't have a
strong opinion on whether the usage string should say <dir> or <path>;
either is more correct than <file>.

-Alex
