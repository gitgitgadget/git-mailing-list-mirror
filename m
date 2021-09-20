Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A7C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530E160F26
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhITHq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 03:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhITHq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 03:46:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3BBC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:45:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v5so57244518edc.2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XHk6LOlRHCEEpW9Qvy316LvuONkLWAlyYcUGfRJxSWw=;
        b=OYtrfXioVlmkWZPh9MSlvoRYBPPUEC6kasgxvLeDjhlWcu5a8hbGv4wosv82PI8+RO
         LDViBYKdRrKTeJM9WlhGxsx9/fv+5c15YAg00Kk7fSlkyXN6Br+ChilAjg87YPu2EGLy
         vZU4mP12PAhrWhH9qj06AL4N2yAaLccEZUL89bs3BQ1PWh3sRvnFRfchVuHe1xIXbdkY
         nl0m3uu+PyQwpBrGRvfdolHIRU0dC1zixPfUdeitFWchU2HMIV0oUPVXzysAaZMPUvkz
         TpMyc3zx6PhpTbp3FTgPgjAZCPWbzvXDVhhEWPcp3dY8VViCeKshW5vwkQDnJfYPLABe
         goEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XHk6LOlRHCEEpW9Qvy316LvuONkLWAlyYcUGfRJxSWw=;
        b=6ytvJizm43bAgiWHv73q8ZMpLWvkfSbhdikOVBRMB6RHPCZLirHrBrd9ucjjfAbK7a
         9cD9j7X9OZSGRXQGtqqb468OdzOaWXJ+uu0RWeC0NA6R6I7CoNj2AnCvY5eZW1iMLhBA
         XHRtjsE6E/JTDlJlcDSIqVzXdbyOXwFF0beLHdSzZFhnyfBa6XVdi+SuKFDouGaA6ysa
         tUOQqefxgHCkmgAI889gWDER5+aarRZWVau6bqKDwU6IsA3DxYqMcu+5cTVqzY/sYX/C
         2qCouUSDnMrteirG1ATtczTSrBZf3o/wJz+9o9hJTr8k/vQNkFmnSKaVZNv1gp7an8hw
         poEg==
X-Gm-Message-State: AOAM533ul87nmgmJkvUS05nJvTGZPkfEkTxAwK3Iu1zOqZON5sS9IRn7
        V/s8iXD+La7+MY600O0G0PFUkG24JPuW6YYAKtI=
X-Google-Smtp-Source: ABdhPJxOIKsNoUu3mj3JvMuSwjtB6p9JXEriM5JjNmBamYXwTAXkuCb6aHvQcOLJul7XgJh7rCa/O/ZTG5wJa+qE6b0=
X-Received: by 2002:a17:907:995a:: with SMTP id kl26mr27295204ejc.6.1632123928553;
 Mon, 20 Sep 2021 00:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local>
In-Reply-To: <YUYPgF6tRQ5ERYWL@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 20 Sep 2021 15:45:17 +0800
Message-ID: <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Christian Couder <chriscool@tuxfamily.org>
Cc:     Taylor Blau <ttaylorr@github.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8819=E6=97=A5=
=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8812:10=E5=86=99=E9=81=93=EF=BC=9A
>
> [+everybody from upthread to cc]
>
> On Thu, Sep 02, 2021 at 10:40:45PM -0400, Taylor Blau wrote:
> > Are we interested in participating in the December 2021 round of
> > Outreachy? September 3rd (tomorrow at 4pm UTC) is the initial community
> > application deadline.
>
> The project deadline of September 23rd is fast approaching, and we do
> not have any proposed projects or signed-up mentors.
>
> If you are interested in mentoring, the time to sign-up and propose a
> project is definitely ASAP :-). You can do so by clicking "Submit a
> project proposal" at:
>
>     https://www.outreachy.org/communities/cfp/git/
>

I haven't thought of any good projects for the time being,
Christian, any ideas?

> Thanks,
> Taylor

Thanks.
--
ZheNing Hu
