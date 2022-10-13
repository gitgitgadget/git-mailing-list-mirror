Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C86C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 06:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJMGtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 02:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJMGtV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 02:49:21 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B265146389
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 23:49:16 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h24so144189qta.7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ApNL5O23pHm8pVAC0nxA9KyTHhuREt+paKc3m6LS3YA=;
        b=QX3V4lMRvcAS2nfSfXDzpJTsyp8DBJnH+MYXe42xnmH4Mx8lnfKcww/Eno/CN/W87C
         Q0dRKxRPXpgxExB6mB62PCguw3WOcWALCre9J5E0RBqq1IGJPjkncoOgUBefkmli60yO
         u9zxdDDffhyVlOmnDwPOm41Zw6SKakw9CR2Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApNL5O23pHm8pVAC0nxA9KyTHhuREt+paKc3m6LS3YA=;
        b=NcFEjK+OwJlgOlaYRYzYGrFMG05t1Bj73fg95NxmGdIZ+nnXXN1TLdZuDux/AhpyuH
         ze5MLv4p8Nx9Mfh6mAlzBexS386tXHjCw4ICG5wR3LQb/DXz+FtUjck8PYW7g7x03832
         Yy9uhc5MNtKwb6K4G3p+r3ZX6PtgniPZwDPEuVW0AntWxffQmC5tdQjTMu1e7NPXwINl
         LkJ8qlS0AQofghi7BUaVTfOsHbtax9DTE9SW+IYF7PAB/zGzfvFMGXl/XmKL48HqzN/6
         8NP6CGw7uwppNg5RKp3oMIEgUlxk/bfBhxn9J0vb/VeLREmgtGanEe2UzpU0ZYgzqYHS
         bh1g==
X-Gm-Message-State: ACrzQf1ZZYg8BlcS2wW9glsainXwqg92yaHj6P8IRxiQArndgh5EAnIk
        +Ai7YVvEYj1qISmNQaqBPkK4PVEDcjHrugaJbsG313tUqT1wGQ==
X-Google-Smtp-Source: AMsMyM7C9H3OCAX1DIV3VDoCB4vt4VEh4DpaVIcYFb481E4EdaGMiEw578iiCRDEIxS7WeoiCxbqbJrYVUxE/Cu2P1A=
X-Received: by 2002:ac8:598b:0:b0:35c:d6a4:ba0a with SMTP id
 e11-20020ac8598b000000b0035cd6a4ba0amr27227087qte.663.1665643755808; Wed, 12
 Oct 2022 23:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com> <xmqqpmewlxmo.fsf@gitster.g>
In-Reply-To: <xmqqpmewlxmo.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 13 Oct 2022 08:49:04 +0200
Message-ID: <CAPMMpojZksy9mvf9kg1qsaUKv6ivc7NPTW7NAaHTrM0D0wQ=Mg@mail.gmail.com>
Subject: Re: [PATCH] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2022 at 8:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> This somehow felt somewhat familiar, so I had to go the list archive
> to find https://lore.kernel.org/git/xmqqmtb8jsej.fsf@gitster.g/,
> which seems to be the previous discussion.
>
> It would have been much easier if you gave readers the original
> context that inspired this design.
>

My apologies, I should have included this link in the commit message -
I tried to "fix it" by reviving the thread in question, but clearly
too little too late.
