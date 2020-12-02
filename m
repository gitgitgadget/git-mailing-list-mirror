Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7735DC64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 04:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17636221FC
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 04:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgLBEeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 23:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLBEeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 23:34:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4230C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 20:33:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id e25so2011318wme.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 20:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0K6dQcWKO0d1CVwWp0Jm5iZC7PYcbG40hKAhXLrQAl8=;
        b=luvXVCQBJc3cjvAgcqYPk23kw8crwJLDeZX4S4OrHE0bwdndXq53oYvaS+QI38R+OR
         z3YxvMWyvNv1+g+bM1puFUSAG6a+UvbC2GkTPDP5cZ70zK60dFMRt9RV1a6xFM1TrXH2
         rRpQJ52AlpLZ3G+NtwPOdCEJ2cspiYV0n+mqAnXAI7EESGIWMjqtJRHc8r7BlGZr8uwE
         VKOuSHVKTwqkBdFJ4c5ZBzB06MZOic3hpmUSCVn8F5FtbUEX1lPE/vlj2bjGtJLla7l4
         2I+IAPFoK3BK06VXIbuk9Rh7yOJirZNzd8DDrnrrT2BOtHs+exhST2wOc7mEGprl6Vsn
         zOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0K6dQcWKO0d1CVwWp0Jm5iZC7PYcbG40hKAhXLrQAl8=;
        b=afeFE2ib6DHsTF1P6Ev1+Nka/1w692oPznJasMWJYcAVnl1vSG8wFxlfedmPWuHOXT
         u35LKIebKtZpNYTh4tfUs+VtpJ4sAfv2/ymy7RtOOkZVNJiTh2U/zo49pqpulXsYyPOS
         vjZs8lZafYgHDM47kfLfXtn+BZy2JClb/cN2xYAjucMLQopgvISl6zctCCN1aJsQjCpP
         ZORARmSkg8FqC4rtVnv62vmCLIHvi3dZAu6MCWFH8PnDv7RMsS575Zcxw/ey+bKu2n+o
         0CYy6aX537FxMGe7lqgdNUKWu09rX4NFteOtPGgM721hVoI6qI/Oizx7jQ3HyNggejnM
         vPwA==
X-Gm-Message-State: AOAM531MFk87llJPBJigOM26/R6A75KAPegLV/dGUzriPj5TtHZavHBV
        R39pwLgCky13VGJsViZ0zsi8ACn8chvNLY5+Txk=
X-Google-Smtp-Source: ABdhPJzhni4H/iR9PBwoTmpwfyxjzcLFedt0e/LFUMiJXi78DR/Djgn+8ADzAJtPNx+R2LfrvtKwlpBj9Po7OBObVzA=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr917331wmg.37.1606883609341;
 Tue, 01 Dec 2020 20:33:29 -0800 (PST)
MIME-Version: 1.0
References: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 22:33:18 -0600
Message-ID: <CAMP44s3c3UiSBUXGfmMi7tTLik6JQv+fDsii0HYOJAx3r2ZXWA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2020, #06; Mon, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 11:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
> with '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

What happened to the git pull ff-only topic?

There's about three proposals flying around with no feedback [1][2][3].

In the meantime the annoying warning is still there.

[1] https://lore.kernel.org/git/20201125032938.786393-1-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/20201125020931.248427-2-alexhenrie24@gmail.com/
[3] https://lore.kernel.org/git/20201123224621.2573159-2-felipe.contreras@gmail.com/

-- 
Felipe Contreras
