Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F85C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959822080A
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+ruOg4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgIHSTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgIHSR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 14:17:27 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AF1C0613ED
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 11:17:27 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id d2so39327vkd.13
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mxqBxKqEoaTRh0L3jiA92zTsgi5AH3aJawYPN1FtGBU=;
        b=A+ruOg4tFIZTYjfBWJWyNvtfW4OJtc139/PisNwbxIQA+i4Y18H70SqxjtF/fwksZ3
         PtWztKL7QpVLglXjRSmD6UAzbuKapsA8Wy+Q2rNl/bb2CH8Sm2avtEqQvtOP6oHKepZ+
         iuPKKOCM/UaEICO28mBm1snkvJgETCR0/BMzAlrVPKorAAxxJm5Ub6XJ/wbGhaFNKqYn
         DjqJNBKsn0BXgpVu1ZaOhYB0kdLhEoVggdAGSKPHDLm/HTADTPMSX+Es79wKZkP90n5f
         9A6DJw/LuXgCpO2LWTymrTHw2TsYXUEh0j0xGEZWMds51Fs/K7cIYBNxRcrA5UqrjrY3
         AtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mxqBxKqEoaTRh0L3jiA92zTsgi5AH3aJawYPN1FtGBU=;
        b=XtMW+ojVLcmg62zx7dyI2jyM3TQ1bVAew9zHGn81fnPlSq5CjCg2sNKgYY8UNfBXhz
         XYvn6b0WKMv82u0wAC4LaJW8Zf/BPBHp1QhvpPZax9oNLL6+tfYIAfdSdSQR3Kv9IuUZ
         IaZ0n1u/v8HE1ikZwArEA8vWDYvbnNMjJjdAtCR/wKje4W/WdFHFm7O3q+eozO9DCrzZ
         as9pppS5Dhm9YeHwKFIFy41+BBEH4gg5T4+B5ppn/CHaN3+u5D2MYe581WxRxDmlnyzR
         g7325vXUbY8E9zwwUTd5l2JgTbVF+7PzyYqQXor4N5zX6kYQm3lrBUrOZG4UtAczCBAb
         xXgA==
X-Gm-Message-State: AOAM530ENgxmfO97guvb4HjbXnlBZeetcYq6pKnD5ibYTxcoeEqBVwPf
        sr0uX58rzWaj6oxYAQqazn7IC0CQzrbkwOKt+UziC4USYdY=
X-Google-Smtp-Source: ABdhPJw+UJxgVqQxybvLTq2L0CeDaIXq+ecoDzqWUH/dDH6LNA4CEr2i1GEfdl8uUKn5md7gr+fTw0Qp7wh7WhidG8A=
X-Received: by 2002:a1f:5f05:: with SMTP id t5mr302996vkb.8.1599589045899;
 Tue, 08 Sep 2020 11:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.712.git.1598628333959.gitgitgadget@gmail.com>
In-Reply-To: <pull.712.git.1598628333959.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 8 Sep 2020 20:17:14 +0200
Message-ID: <CAFQ2z_MJ8nD3Z3m8P9HS4O6jbs7u3y5h8a6Nvy3Pa=d6s40=9g@mail.gmail.com>
Subject: Re: [PATCH] refs: move REF_LOG_ONLY to refs-internal.h
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 5:25 PM Han-Wen Nienhuys via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> REF_LOG_ONLY is used in the transaction preparation: if a symref is invol=
ved in
> a transaction, the referent of the symref should be updated, and the symr=
ef
> itself should only be updated in the reflog.

Jun, are you waiting for me to do anything with this patch?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
