Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42685C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B7960F00
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhHMILd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbhHMILd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:11:33 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C7C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:11:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j18so9928829ile.8
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dFD4yH8VpWZXB01O7/QvcyOutA/bI74/tkmZ2C/uXB8=;
        b=slpuqTiQjfFliAuH5KRM4h9wDItS5yk2/wpk5QyWtqWVkxaRBjr9IXJQpbY1CBPj7y
         Zza8WxePAx5c9gRteM9QGoTBS/MlgbqilbMAB9DH/n59M7KCfKeMhZYQx6GUmG5OpeqL
         WvuxCf9YUDBJR9/0Ldj0jE2IHcM9GAe6DdPrFYEDVzvcb9xdTdIW2ywVlNcWAu4XsfCe
         ikZzeKADvhSPbEvhlBz2v5hg/+252k/j8yj2VajJb98ZWPrXht2EkC3WmUa/mb+jvpqX
         vby59xAQEgPBdtRSH4ZANSnMu89ISQSoE5IoDbWa+yqroN0mVldNktjYWo5O8lAUh7iE
         2rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dFD4yH8VpWZXB01O7/QvcyOutA/bI74/tkmZ2C/uXB8=;
        b=pee823kS98Ddp8D4Ksqenpj3xNBHJtNq9LTy3ylGoRKkdJvbq1ZIp1eLriz1Cc70pQ
         CKoygU6iQElzqB9Bu63zDHz0OFSv+5nJ81nRtODVHk3ixOeJSFiU1Bjm3Lp7dRhQYdAi
         yV6+/gWj1Ihz2xJ+/Oo5VuRC/IAQSwcqS74kufKRMJDZ3Us+AFIY1hPD9c5cWBTFgg5D
         dUoFe17esGB/HLJ6YX6Kp7dg3gNOc+qsfyH7BhgAJI+fGRwhtQ45tS4J/JyK1QFMNd9K
         MCqa7wiPaGPN0jitGsKqtZimb3fqFSDP+CO8JdZ7b8ajIi/d9mPEJMKFw91EjXBOnEkF
         TtSA==
X-Gm-Message-State: AOAM530eIotJYNBnWMiU/bQctpblHTsHTsVth0iFDcDyUMV4L/kpZcx/
        aNj0/lm66K1JMYYSNwSlNrCAG7HKgNmhy1jSeyxpYMmWJVR2o+Wyuww=
X-Google-Smtp-Source: ABdhPJwW6w4OFUhwm+tmOb9y7Lv17I7mCtLyX/wpVMnWqi308ItPE3j/UUhcjyAiLsZ4SsUOHihvVI/lNgvbu5d3zfs=
X-Received: by 2002:a92:6b0a:: with SMTP id g10mr953971ilc.17.1628842266257;
 Fri, 13 Aug 2021 01:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7fwbx86.fsf@gitster.g> <7fc86441-add0-b08f-17ae-9e0dc5b010b0@gmail.com>
 <xmqqlf589cor.fsf@gitster.g>
In-Reply-To: <xmqqlf589cor.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 13 Aug 2021 16:10:55 +0800
Message-ID: <CAOLTT8RL_MTqZnW+tPbh=t-3TFbBSYc1XtrqQp=vcWW-xO_MuQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8812=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:19=E5=86=99=E9=81=93=EF=BC=9A
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>
> Thanks again.  Let's make sure the "better advice message" will be
> the approach we'll take in the next cycle.

Thank you both.
Perhaps as Phillip said, this optimization can also be applied to git rever=
t.

--
ZheNing Hu
