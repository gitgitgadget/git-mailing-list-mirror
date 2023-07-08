Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B5EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 18:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGHS4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHS4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 14:56:20 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739EECD
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 11:56:19 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-19674cab442so2684302fac.3
        for <git@vger.kernel.org>; Sat, 08 Jul 2023 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688842577; x=1691434577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leOj7HyscK59sKITdMpaoxjlisSXLgF7zY0ku9S3kQk=;
        b=NpqtBYWtR4oerHqItl089OeAGjvG2tHNRYFc9B1AE4feIlS0CNcfX6nKoTP72Y2bsx
         ErTZZ35o/G+8xe+Q3vzMeI1y86vKq5AsIUMQ15WQmoeDpkBmSqIR71ASQijLivihGWQa
         k+CFJW1DO1zxHvuFNZant8bKBElPh/BIAYxohp3ogNDLCEouADQcW3ZVBDSMHED6zQaZ
         ZGENodC65aqS1341f6/0au6jyaAMvBX5STjOlQBxjXVROtKNx7jH/A7E6/KFTyqZ2Iv+
         7iAGNtpOkKJTGZzDO+ZNuaWEIV9+NAOGxpnY1PauKRUYx7RkiQ/G0WcE9OZxI4AC5Z2y
         QWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688842577; x=1691434577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leOj7HyscK59sKITdMpaoxjlisSXLgF7zY0ku9S3kQk=;
        b=kr6ME3AK5y5o8nPdv9gTrzDuz++x3yresb8bap8UeDkIFYzc4knwh9BkHqiMSPlio0
         +nRhyI6FRwUoUsgiTVX750DOGUy0ucu0IkijjECUu6SX03L9HOyXYA3rsnObp6JZRFp1
         aZJ6v8Gqojydt5IJc6bzJbm2kp1aWu4WhRGv5eYtmv2ZqSjP0vrKUtMl6lKAqzVh274u
         TtozOmUrKAq5zPk89U8RhdJmuh/ayUmZMX26qVk7d+P201l19M114qOv2uJdem6HaojS
         d8bnMhcl/KoCMl62N6VVfG6F9hOp2OddwH1gGTIvrJllgK6tvTyBjomVrFgz0yb4UEsl
         IOgA==
X-Gm-Message-State: ABy/qLbUwq10pt32jUmxljIS8TzpVr/DRO3mFZssSjNrTjwXyROfsEh2
        ZPzhOA2ZjQOSJjGbIb0tA18AFwoUmviTZ0m4McuBQfse
X-Google-Smtp-Source: APBJJlFb/NXjWKDUy/bkAZ6x5Pd2l0BL+xDqo6EtJzetlMK99z5WJnGGEUdescZqllB5Fq2M/JChHss1c5iC0E1yPXw=
X-Received: by 2002:a05:6870:8a09:b0:1b0:449e:cff9 with SMTP id
 p9-20020a0568708a0900b001b0449ecff9mr9256874oaq.57.1688842577333; Sat, 08 Jul
 2023 11:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com> <20230706040111.81110-2-alexhenrie24@gmail.com>
 <xmqqttugbxds.fsf@gitster.g> <xmqqo7kobwpj.fsf@gitster.g> <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
 <xmqq8rbra9ti.fsf@gitster.g>
In-Reply-To: <xmqq8rbra9ti.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 8 Jul 2023 12:55:40 -0600
Message-ID: <CAMMLpeQ2P+qQxo17dEdWhMHcmAfTiBoEifp2wUjWVrP+oGSzxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 7, 2023 at 11:52=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> I would rather see us toning the message down, e.g. "Your branches
> have diverged. **IF** you intend to eventually reconcile the work on
> the remote with yours, you could use `git pull` to do so now" is all
> we should say.  If they do not want to keep the work on the remote,
> at the point of seeing "you have diverged", there is nothing they
> need to do.  There is no need to talk about "push --force" and force
> the user to remember that they have to do so later.  When they try
> "git push", an appropriate message should be given anyway, but that
> is not the message you are touching in this patch.

I would be satisfied with toning down this message as you suggest;
you're right that we don't necessarily have to mention force-pushing
here. To keep the message short, we could just replace "(use "git
pull" to merge the remote branch into yours)" with "(use "git pull" if
you want to integrate the remote branch into yours)".

> For that matter, it does not make ANY sense to give "you can pull to
> reconcile" message in the comment you are editing the log message
> while running "git commit".  It would be the most inconvenient time
> to do so.  So it might be necessary to first tweak the code so that
> different messages depending on the codepath are shown, perhaps by
> teaching format_tracking_info() who is calling.

I agree, showing this message in the middle of `git commit` is not
ideal. However, that's a separate issue that can be fixed later; it's
not part of the problem I'm trying to solve in this series.

Thanks for the feedback,

-Alex
