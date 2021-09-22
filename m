Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD3EC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5045A61168
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 08:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhIVIez (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhIVIey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 04:34:54 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19302C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 01:33:25 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id 19so1277684uaf.12
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qgCXw4hOGVf7GJFd/PlTHqdQDSKXU1H8ISW+GcSecpc=;
        b=U+G4ItkMIuoiZRP5dqa2hBJiZApiIOtywpSu8k9EzeNVdmIvpxE4Uaht2Pi3ixvv9b
         yguxyNEB5se8SD3rE7+JiAtDJq0/oF43+WUc9DIwvbzmmMzzTVpI9erwp+BYTCMQtS7v
         RREbcEZjFYJArEHH7/AporvjDOZ7lxVTlg/s4pkW1BpCEfcRXaPbKW2qvxMafWE07SUy
         ub00o7hNmPGr76tsp1kiusM1Dz+NsB10PWZid41TT/CAL0B3TQa1hU0FPJXLWCmEwtse
         K9pZ0HgSyOJw2wB8FMqCB0MIsxrWVojcWLz6hj1/xSdVcQhmw35KNiLGMoI+uoo2PRBA
         7G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qgCXw4hOGVf7GJFd/PlTHqdQDSKXU1H8ISW+GcSecpc=;
        b=WX5EsnDaXVq1xlmRMNLlPHLfRY3+dkpHiNG6gMngwGt9r/+jY4yopMZHYcVTqO4Zx/
         9GVEqpiusQAtamQUJVxqN/fVwffQnNuo4WVCir6O8HN8wJaIAeZeas1YUTSvv8w/NjNW
         9InimTXLpXQpPXrFgCCUonaNiUYH18OqVg5QD/lvai5051SicVXJYoMxikdBdtkvhFRE
         V8WgykLE6CivJ6qWCUZzDrsqHOaMcOB3mh3lkzG29TDT1nssVxL2liq0H4CrPrTrMecj
         Sp5X1/T6cTohw1+m+5pUn9aYWfpt1oyeDhcjXKOsSDYUmJUFidw0BdKE2C6beZCi8s8h
         1ybQ==
X-Gm-Message-State: AOAM531Xgs6xeOXjfa8P2T7g+3Y2GZ3pVZg/ylLHtTp4BHBipeswjDpB
        05uW2TF5vPshyeIzJhr10r/0gIdlJMiuCgvQByg=
X-Google-Smtp-Source: ABdhPJxxVkw3AtIGE6foKVeh9dB6172y2w8BqeJC37aDRLHxOj3z4DpB5Yw42wCM594IVa8NBJvoy3CxtZC8rU0Lnkk=
X-Received: by 2002:ab0:7c4a:: with SMTP id d10mr20429945uaw.138.1632299604107;
 Wed, 22 Sep 2021 01:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 01:33:12 -0700
Message-ID: <CAPUEspg3pT1F5YMwGuwvmiyMGoYLUB0neHeunXnLxwc_G9zN-A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] test-lib tests: split off subtest code in t0000
 into lib-subtest.sh
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 5, 2021 at 5:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> The only tricky part of this series is the "clever" way of (ab)using
> the object store and tags to detect copy/pasted tests. For this v3
> I've split that up into its own commit, see [56]/9 for the removal of
> the copy/pasting and the assertion, respectively.

I think this series would be better without that assertion (commit).

While it is cool, it seems misplaced as it makes sense running ONLY
when subtests had been added, and therefore probably as part of some
"lint" job (ex: "as part of the static analysis CI job"), instead of
every time this is called.

FWIW, it is not only the conceptual misplacement that is a problem,
but as coded a bug in git, could make these tests fail for a totally
unrelated reason and therefore be confusing.

Other than that and my comment about probably avoiding the in series
rewriting of a function which might have been me not understanding the
commit message, got my "Reviewed-by" for what it is worth.

Carlo
