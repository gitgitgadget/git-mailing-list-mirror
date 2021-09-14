Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC493C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B461161130
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhINTAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhINTAk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:00:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7A7C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 11:59:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so8880763plp.7
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVqaniXCEOE0nRJCXuGjNhw6e2yCXJ09xMMjvMW8/YQ=;
        b=PqavO5ai/bp32LwfLGyp541bH+Y2ElVxDbgm/oMaEY5Xt3IWakbdNUurrEpT8KlodV
         dS72kWxRRqt3R69Oo04xRTsVE996ygHOFeKpPO9s/r3uUHis/d/Tu3YWR1arhWYVU7S/
         P/cUl/95kLGMTqw9+qkZ3J1EuuigHYKlcuFvMm9UCtGDqieGaUOAadhEckTD+9om/1XT
         IJ7udcwFdKJ193JfmTlMgwKyDRwcxLg8iTIA5iTpl9Q1BkHuEXW1sKtxwnJucScwEZ0j
         1Pl05YOA7vReOl3fxKcFTguzH8Bj+3p3Kyjl+EFIeo97NZCXCwsHg5uCWoaRNXJpNXvW
         mmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVqaniXCEOE0nRJCXuGjNhw6e2yCXJ09xMMjvMW8/YQ=;
        b=PAFtt7Rqw9Uf7eB83luMAIgv61aHFNohj5rg1QTUbzRh9RpmcKa1p0hXNvz32LBdGO
         NBlDC4WqGYW9CIrjwntLkLbBxRCc2dQ1pNY2KnlSaBRR5R0QMU4DotEliTQgseMzzhQb
         iVpuTqaUWwW74cJvv55cjcEUvnQYwin6BZKtKFDrLGKjpHn/Nx6VVlLbbz/AeYtHg7PT
         b8IGAjAjU+hzIAwu5eCuC4220y5Jb7rZN7tY78RNMUVr6b33/zEkkbN0Q9C7hzUD+43k
         oYP6n285StCaAvfqtBmCdcn446Oyng8pFgUYrrejX9Y5J+/xZVl7rPYCSTJEW+gM54se
         V7dw==
X-Gm-Message-State: AOAM531jH0TFafSLYjBS7KG8qdt6xcgf63WQXprOPvO4QbqbFldF2wry
        gMFuiOKc/HaKJTsB3PLUXAmm6Vti7z9EiWitQkzn14eH
X-Google-Smtp-Source: ABdhPJyxk3TUNzC0pnD6nXe6RGZBH7P7wA/yszi+0DFrpA57AXnBkXOyjeF7CNZ5fIhjBjR+v3qFCKXywwVi9SA+aOc=
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id
 w16-20020a170902a710b029012b9b9fc461mr16471615plq.59.1631645962233; Tue, 14
 Sep 2021 11:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net> <YUDAUi627d6TVmUy@coredump.intra.peff.net>
In-Reply-To: <YUDAUi627d6TVmUy@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 14 Sep 2021 20:59:09 +0200
Message-ID: <CAN0heSoRLHzuv0S26YLnKWpiisshD_fiRmfL5ZMYxAkht-uXWg@mail.gmail.com>
Subject: Re: [PATCH 4/9] serve: provide "receive" function for object-format capability
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Sept 2021 at 17:33, Jeff King <peff@peff.net> wrote:
> repository algorithm). Since the check_algorithm() function would now be
> done to a single if() statement, I've just inlined it in its only
> caller.

s/done/down/, I believe.

> There should be no change of behavior here, except for two
> broken-protocol cases:

FWIW, I agree with this.


Martin
