Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8077BC4363C
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 00:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15887206B6
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 00:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DutRxXiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgJEAPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 20:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJEAPk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 20:15:40 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9515AC0613CE
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 17:15:38 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id b142so5440760ybg.9
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bvTc21gdhojW5XqybcngiHTefIO6HKR8lDLiMXZMYUw=;
        b=DutRxXiBLH8qiA7FNmRVXlErmEoeITl3yPkcy3e9YeZpNMtl1gnHBTiaTxSwvb/mFl
         y9ESb0BDezQlBp0ni1f7GfmMqE/GH3sVA4aNvf0NUPflNnb/GH2yVJ/MWGy4A0bCMISr
         6H8VdjQaOY+fsHpMJwxKXszi7cv+UD6VPAcEM0VxmTdDfFyqmlfKxp03jVXiGplV5f/A
         wFxAnfl2ywdgzCOuo85H4pwTdAVVPgNS7HVXyBLRXYh1KG9Sd2FgdIHt+NER0BIZagKl
         +4ZL7UYHQm4EE0wn7X/HYwALG03piCR0uY1Y1sV9HKrl3JVmesonHPhjt22qR4mjmVUV
         5jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bvTc21gdhojW5XqybcngiHTefIO6HKR8lDLiMXZMYUw=;
        b=KMTzlCh2EqKIyyWpv4CleYGaJdjlGDAC2i4skKrvmc2Bx3NQJGsbDVOGUkVEHMkYF/
         7gLwaT2ea/Ry3YIHNKRqzqkCHnA/lYxltmiLNnCP/gThtZsiZ5nq7a5FaeG9C5laa3X2
         k1ZCCJD8sd/YzlteNj9ZwdKZ1Ge9Al2YcH9UGr+p0zwK3sVTMNgO1y+T6CzqE8tx8bzF
         0AEKnKrlmCpGivMeTSKuQFj2/h6WdvFc6icJBKzoqtuoiZ0wXjBjkz0DlDQuODVuz7pg
         51Nz6hfh3JR+hH7yBMgPEl7g5eo7mX4Pot06tJPV+MTaeUCkwiOmJ5/ZctUzyHtBCbrH
         iWdw==
X-Gm-Message-State: AOAM532U7H64Di2Y/fpFVz2uS3KS8mIpvRHBcg6hmY7/ErJtVFECNXiB
        v6U03zrB9PBGDoqOQKG8fAq6TUrPz3wkJ5qoK7I=
X-Google-Smtp-Source: ABdhPJw2APIr6RI1p8Hc7TMR5JP1kTAxhHVPOza3Ne028aYVsU75qWGbojEFmpGdrYwS0bjKdjXmr3NDNtgCQmeqZG0=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr15004918ybe.520.1601856937467;
 Sun, 04 Oct 2020 17:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.742.git.1601763568860.gitgitgadget@gmail.com>
In-Reply-To: <pull.742.git.1601763568860.gitgitgadget@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 5 Oct 2020 08:15:26 +0800
Message-ID: <CANYiYbHtC1VkMJ=R=q+g4jbU5GJiBQMczUtj=LD=x=F2KLpfwg@mail.gmail.com>
Subject: Re: [PATCH] po: adjust for the recent change in send-pack/transport-helper
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
=E4=BA=8E2020=E5=B9=B410=E6=9C=884=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=
=8D=886:19=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As of 4d04658d8b5 (send-pack/transport-helper: avoid mentioning a
> particular branch, 2020-06-24), the message does not mention any branch
> name anymore.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     po: adjust for the recent change in send-pack/transport-helper
>
>     I hope that I am being helpful here... Please let me know if I should
>     just leave the translations alone instead.
>

Will update "po/git.pot" after the release of git 2.29.0-rc0. And
other l10n team leaders will fix the issue you found accordingly.

Thank you for the update.

--
Jiang Xin
