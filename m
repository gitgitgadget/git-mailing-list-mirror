Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C52C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 17:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCFRki (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCFRkf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 12:40:35 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743B96A06F
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 09:39:53 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-53d277c1834so21997007b3.10
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 09:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678124247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMjsnxkE4y0igt1AxW996OdTBsw/u9fmCel3YquC59g=;
        b=pQqfyvbXm+msQsF/YZEyVLWZ9evGWUZ5S3S9H8TUUGOsewanqoyPVBFADrxzvqMK90
         l0YkL8OD9NFDyMYO6NwNpERa5RHnN6fVnNY/MaT1nCTLnO4gUrkdHyaCH+o6k69AfdqX
         ooxmPSsKdw6848QS5BdTgR5z2GIt/dvSMoFim7rMjx5RISI3EmMwFIJdZj92kH/yjela
         TXX9FbFGLW6UJmrbBvcRTcVY81Drh8y0bKnFmyqvLwBa5jhaNO6RaVpC5Wd13QqXzqa0
         PSlKhKw+dco/0QX1NlshhTDvmU8u9LwutWcM1MXaWEG/1JkoK1ro7QtJNsZ50U73OdI7
         0gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMjsnxkE4y0igt1AxW996OdTBsw/u9fmCel3YquC59g=;
        b=7+R/g4nIqCAYUzsD/ZOKwHSdMPpmzB5OPMMYw/62zDu5BZuwqsmCCTGKDB7D+YbQbN
         HV/WfkxRapFeuBZ8iBru/UfiwO2j2Kn6BXFiYM1Y30ijdEJHQ555qq0UiS9QXHMIwSAU
         Wyd7HqHqxGJu/2cw6H55tJb2J0Y43a6CHODK34JFaNfJMAInKTUAW3hMW9WCKXxVPu0F
         Qrv9sgNmsuKDkB1+v/SN+j07euUe8Uq0yIZHHC5LQzUixtOVNvHM1ZUFCEMMzCpuOBTj
         Tj+cSMvXCsz4yfjlimVe4B6MZLql7Rco86cIjUILLmh/EDN6HT3o8GKZmhkD1kqFFKBY
         6W9w==
X-Gm-Message-State: AO0yUKW5o9gS9L7G1GwbX3ZGX3wfHHQXwwvUc/s01vUrKJg8tvsSWF51
        lpHeg4qBe7/AW+E+ZGD+DkHj9O8OxU8cNOsKlvd+Rw==
X-Google-Smtp-Source: AK7set+8Okt4zQSMvJKLtkhJ3QWclqnA7/u0kvj2xCmz5EgONP8QE0aBFMlG78e2/JHq9kmYEkQtqnEUk3QchsqCHR4=
X-Received: by 2002:a81:7012:0:b0:533:a15a:d33e with SMTP id
 l18-20020a817012000000b00533a15ad33emr9601218ywc.5.1678124246622; Mon, 06 Mar
 2023 09:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
 <20230302220251.1474923-2-calvinwan@google.com> <xmqqv8jiheao.fsf@gitster.g>
In-Reply-To: <xmqqv8jiheao.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 6 Mar 2023 09:37:15 -0800
Message-ID: <CAFySSZABteFiyBYp_S7bur7_K1GkxL3A5DiTiV47iU_t8EpWKQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] submodule: rename strbuf variable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2023 at 4:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > A prepatory change for a future patch that moves the status parsing
> > logic to a separate function.
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > ---
> >  submodule.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
>
> > Subject: Re: [PATCH v9 2/6] submodule: rename strbuf variable
>
> What strbuf variable renamed to what?
>
> I have a feeling that squashing this and 3/6 into a single patch,
> and pass buf.buf and buf.len to the new helper function without
> introducing an intermediate variables in the caller, would make the
> resulting code easier to follow.
>
> In any case, nice factoring out of a useful helper function.
>

A much earlier version squashed those changes together, but it was
recommended to split those changes up; I think I am indifferent either way
since the refactoring is clear to me whether it is split up or not.
https://lore.kernel.org/git/221012.868rllo545.gmgdl@evledraar.gmail.com/
