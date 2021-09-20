Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07FC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AFA6115B
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhITQaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhITQaP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 12:30:15 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F7C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:28:49 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id 42so4431298uar.5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXEliqE8PC2I3d2njIU++SjSfaWlcncKJ4GiEQEygjw=;
        b=l/PHnQhiI2z9wUuws8LU1r+4rc/riz4bOkrz+cR5UeUQvccKntTro3fwa45vU11YO/
         iwSlgvClNzcP5jD+nFCPpB5aJoXNsUioW1bM6JXTvA4aLvWCe+Uv01V2cbvWCzfngfTw
         Hs871UWTW7vxILFcZBYaksvWiPmXa8etGDfZsv4jxHWqbDoKJJkJvWwmCSVEy0ubh74k
         xvIGk00ZDhrlxh2yILduQa5vsdTuBp1orYM3bmhuha8b6Z++maAMrdvHD7rHoIUontwH
         LYfRSpWZ6t0kMaYjw7xpuy30NGjZ9DhOv/Bt882hG4dSJEqp20c9qCy7IyDappgyEgJW
         SYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXEliqE8PC2I3d2njIU++SjSfaWlcncKJ4GiEQEygjw=;
        b=E7rWFpg2kXMsSdUty+cqAcTMMRpNzlQp5nHGBw8f7KIvj+U0YCRh/PLF+Q18oJEo2w
         MKT+2yi5rEgFMJfKXpC63roNSI5G+1uhHIiSYcftu5XaP31V2xGo0jltAAUABMTiumqv
         QzaVihAGpBJQM1mZ6P9JEQfLyOUp2v8fRYFA0BdSID406zVNXjm0kIVgaYWP+zcvI2YQ
         iZI/wWpc7l7JCfmtGw8gd5uCAyZK6RUSOV7qrKLiIk68d+veVmapejFIGDD5Uu0kpaoc
         Zlp/3wo67dbvy6C/l7qi+uwHmDqODBeaTaRBd8lJlLEt57NIdPnLlST6OByFjz+uoJFx
         GwHA==
X-Gm-Message-State: AOAM533q+D5g7sBIGT+7od4pmcA7FLzGE2yl+E2IrLmCq92Dy99U9GyL
        sOyJ7Of722hr5cWb0CBleFs39tF9UQHd5zou8DuTr5EG
X-Google-Smtp-Source: ABdhPJzjn2oNQFLQ/Iv4dF34Lx7bG5XXywzK/4sSV79CrSc24tfPxYAuUpmbgbLfTdwmIE+rFiy+6Sm/pBOgDUvO4I8=
X-Received: by 2002:ab0:3d13:: with SMTP id f19mr13112070uax.140.1632155328152;
 Mon, 20 Sep 2021 09:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <375601d7ad94$9eccb5a0$dc6620e0$@pdinc.us>
In-Reply-To: <375601d7ad94$9eccb5a0$dc6620e0$@pdinc.us>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 20 Sep 2021 09:28:37 -0700
Message-ID: <CAPUEsph-n0EEK_HjJoynKvq1H8Uijq9FZsVNmkp7v9LU9WLDNQ@mail.gmail.com>
Subject: Re: nice to have, just sharing - cannot pull with rebase: You have
 unstaged changes
To:     Jason Pyeron <jpyeron@pdinc.us>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git config --global rebase.autostash

will probably help you already without extra code IMHO

Carlo
