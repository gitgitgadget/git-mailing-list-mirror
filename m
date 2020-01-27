Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B0FC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8F7214D8
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 13:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="s/eHvztW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgA0N6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:58:05 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:46653 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgA0N6F (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Jan 2020 08:58:05 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id w4tripK4GpLtbw4tvijiba; Mon, 27 Jan 2020 14:58:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1580133483; bh=DLsRXR7GihjNHSCyMc4tUdsWWZqQRkHGIlgEyToxTa8=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:From:
         Subject;
        b=s/eHvztWyxfu4NplEtmiXb2QSIDwnQyrEjClnReVTbpmMkew9i1kpwKE5MneSHEvO
         CY3U5k60UeOnqUGO/9H3PNJFPzfVThCawPM9vtI5oAOxNJ8Yeh4isBODo4MUKoihBD
         4FCbE2L7KlR6N53EWkHsS5oGpDMn8rR1pjW7QhrRZi7okQDT19WBrTJNq5BoUnt7d9
         geCLmnsE4aspbIV5h8SjD4Ac4dHTlC9CrBUeR6xnoy9Cnv+mNvbUucK61iex0F2Emo
         70tBfqQx68DIE7OkuFs36toj7KPBU6F+mbhK1NFm5O8gZTq/q+12+O3trmxefs3TEL
         zWiEc7kDQtXDw==
Received: by mail-ot1-f42.google.com with SMTP id r27so8389117otc.8
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 05:58:02 -0800 (PST)
X-Gm-Message-State: APjAAAX+y633czZsxzxRERcmoSNSTZtGicy9gsBtsTP3S51mD+xTjPm9
        oG3C1SGvvnnqWBusXy1tnalAc7R/LGHO1fnVaZs=
X-Google-Smtp-Source: APXvYqybHTQu7EICKbu4R2GxyhUfg/Ra9m53u54ELH6KsfIbfY09bwk6L8Sv1Z3fbaVJ2BqHRPlEed2FfpLtVoKE5KI=
X-Received: by 2002:a05:6830:2111:: with SMTP id i17mr11837712otc.24.1580133479232;
 Mon, 27 Jan 2020 05:57:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <xmqqy2tx3l1y.fsf@gitster-ct.c.googlers.com> <CAOw_e7Y7w2Az65iuzWT5SHLv+iHwFZ=ZE11TFS=m0Vh59M2a=A@mail.gmail.com>
In-Reply-To: <CAOw_e7Y7w2Az65iuzWT5SHLv+iHwFZ=ZE11TFS=m0Vh59M2a=A@mail.gmail.com>
Reply-To: hanwenn@gmail.com
From:   Han-Wen Nienhuys <hanwen@xs4all.nl>
Date:   Mon, 27 Jan 2020 14:57:48 +0100
X-Gmail-Original-Message-ID: <CAOw_e7bADPs4USipfPkLuzYfQv7u59fQRzCECw_jq5jW81LyyQ@mail.gmail.com>
Message-ID: <CAOw_e7bADPs4USipfPkLuzYfQv7u59fQRzCECw_jq5jW81LyyQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4wfJuRUnN8XQr0eT3kQnV32wwy+ikZ5zeSI5WKN7cq+0STLWdoykbcMR+4dkS0XVZ033+Fy0XujNSH50p9yocTI85U8e/JASyJtFu8zbYvAO9Gwp3vMo07
 M9aFgUt02XObUMyvDFy5SKJzdnd44oEk3HDpNnpWso2v3vk0lAqK4ua5JMdpkkfRUxgRPM8ccosHEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 2:52 PM Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> >  * Mixed indentation and many whitespace breakages make the code
> >    distracting to review.
>
> Do you mean in the changes to refs/reftable-backend.c? Or the imported code?
>
> The imported code is uniformly formatted with clang-format.
>
> Is there a clang-format setting for uniformly formatting to Linux/Git
> style? I really love automated formatting, so we don't have to spend
> time debating irrelevant details.

Ah, there is a .clang-format entry in the git repository already. Thanks!
