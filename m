Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8ACC433E4
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C9622BEA
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4whFcg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgH0Tq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgH0Tq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:46:28 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88CEC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 12:46:27 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id m12so1524319vko.5
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwermHRiym3rpWn/ZetDriAzbRx1BpUyjyc9p2jl4Qk=;
        b=C4whFcg9uuW7RxeGg5iWFoeCRINAhr2N+URw5YwIxm5yzqGQwjMYK5w8RNmgTRjZ49
         0Nvgp2RE4Ep7+j1mlCWLj2huuLEW4bFJat6aN9/KJCPliBEZAPGdWG9aKFQVVkwqK36m
         70NYBy80U6orLVOgbNr7cbSI2e1b6l+OeQOAYtFLQWeHtPPL9w980o625FFUcDt1KPav
         iD5IZKziQs0RFo5jpP2Um8RBob2F6UZiI9FNukgwqsq25M3KOeZg0+UMMpM0p+DwUGPS
         6sHmlxbo3TKO2kwdw6iVloj0xiZeVJQSkxS+/sstgB7kdGw8t//1vnjWvRJQ2zDM5YMp
         ffDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwermHRiym3rpWn/ZetDriAzbRx1BpUyjyc9p2jl4Qk=;
        b=hTkqhgoIkuYOFteHP7g0nMSljhNZv1knREmSxLrpzW36re1vIZ/9CHTn5U6W7MK+Zr
         VMUzJo75MumKo/AH6A5uoksaV5cPqNDedyzeDuZGsyRWdf/mEWVvd2bQiSauExEawNjs
         cYamzbfozGZzGY7MSiTzKOG7vJmtkAZoIQkk9tQznX/4xS9ywMD6NHV+e2zIV1YzfP3C
         J6wvdODtjSLI+XGNvly/QeNKTE+v7RGirN4EjchKM2rTX95swxKFS9Iv7QAWKGCAdAFc
         JqYLPyHABQpieHyT/5aAzbmPpjF+lTtS9I8tbCfK54MSA5Hch0ViUz4rSZdUjHJiGTWN
         M/RQ==
X-Gm-Message-State: AOAM530pIYkyeRhw2grO2Apeubd9oD6d5wvgBu3VAehvl2fkz6dBwSdD
        qjoYW+hmB1ExrKJflkdnBlS0OGasCjmTzA0QCeU=
X-Google-Smtp-Source: ABdhPJwr33ncjgpKjQ+g2eV6RybLCJarVNJLm995/bSOr/T+AQbAVljpZ/QRLf3BuSmf8zEASD5siHoPpFaALjDxWr4=
X-Received: by 2002:ac5:c4e9:: with SMTP id b9mr10103940vkl.67.1598557586399;
 Thu, 27 Aug 2020 12:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtuwnq3x1.fsf@gitster.c.googlers.com> <C5814BWVXMP3.1GJ83FMKYSFTY@homura>
In-Reply-To: <C5814BWVXMP3.1GJ83FMKYSFTY@homura>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 27 Aug 2020 12:46:15 -0700
Message-ID: <CAPUEspjmnjX5Lwd1cSdDzJRdRUGT8Gk6At7BchRsX=fsuAZE9Q@mail.gmail.com>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 12:35 PM Drew DeVault <sir@cmpwn.com> wrote:
> Do you think this whole workstream could be averted by dropping the
> $prompting check in the in-reply-to branch?
>
> Or would that still constitute a breaking change to user workflows?

I think the "breaking change" is changing the default (which needs
fixing as well).

but an interesting idea would be to add a config so the prompting
could be skipped which would be something that people could add to
their per repository config (as needed).

Carlo
