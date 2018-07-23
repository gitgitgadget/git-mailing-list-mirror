Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F46E1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbeGWROg (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 13:14:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55716 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388161AbeGWROg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 13:14:36 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so2319160itl.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nq0XZa6VR1q0lyMwYtFUCuWUHRtlFj5FjqPwHUkLxD0=;
        b=Gi2m7CjW4gtUZZufvXbpAErga2isU79Xbc1n3aOyXlPw1t5mEq3J7ibwCZ8UmDtZVj
         MEofoDRLyvJUgKgrL5/PB2gQuU/JgX3oHgABq7R8Rm4pkOb3vFEC7gZmrqtJI6WvsOpl
         tf/zOQLlBE27oLtIkL0O02AnSBpEMvt+WsqnZC7A+eu9Msj52YoCUALHnH2mzts+2pSj
         R8X7YwS/7LTRX9b8fFZzuWQTdHbFyBplMkRBRN6HLEHOlRRfXtV/4bTjoNyXpPf1uPHw
         477qPcxPLuEzL0KDuMiVObL5ZBT9tZNs91CSgoKC4Cu5dhygXHctA+2v/987Ez9mY2t0
         VBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nq0XZa6VR1q0lyMwYtFUCuWUHRtlFj5FjqPwHUkLxD0=;
        b=FgzeCiJsirb375DsFhXRefQf4Ve//JwtfFa0Q3Pj1TtaKyEhvV02cVtkZnBtTNyB5x
         1pCHHcYlJMWujcjMH6QJ3apsRPfUnpwCwpI3SFep9kF2spJwV1fwZbuipnKPW5bsFj8W
         qwq7oh9Q9W65lhehbBMajiKTUhC9g6+xWRqluDDobBGGfOuo1wCezSHmvnT14FGEBwVb
         sddKFG2r3W2Btftks+F4yw1RCdibXhgFtKLmsvPueErN4Kcpfqkdh9BDiex6FI2/m1+i
         Qj4i5q873tOXE4L+BDovvzR5uShxM9NlRyUNLmMLCvuhZe4l2k+4yc2n41mcoarfrDKt
         ZVNA==
X-Gm-Message-State: AOUpUlEHfEkPEVU4mG58iqFsRtrJVESeK6NCKlo36q0rcy/EcvnLUTTF
        Q+vU9a+Zjmi/MaI28JlMaFxHbjer9ZjdoV2qAJQ=
X-Google-Smtp-Source: AAOMgpe5C0HJ6SC0tBiVqq5vOZjQ83FlR6Xg/sSQq1nJBL+lLyqZX4hJXYelEQCwV1h3LzIxtN+Ia+ySqT20ZjKhevg=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr10940691itc.68.1532362360171;
 Mon, 23 Jul 2018 09:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com> <20180722095717.17912-4-sunshine@sunshineco.com>
In-Reply-To: <20180722095717.17912-4-sunshine@sunshineco.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 18:12:14 +0200
Message-ID: <CACsJy8AGwbrEFU2bTynXyQi1DmEYtwHrtmefMz+jD13GQs=9HQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] format-patch: teach --interdiff to respect -v/--reroll-count
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 11:57 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> The --interdiff option introduces the embedded interdiff generically as
> "Interdiff:", however, we can do better when --reroll-count is specified

Oh boy. --reroll-count was added in 2012 and here I am typing
--subject-prefix='PATCH vX' everyday, thinking that somebody should
really do something about it. I've learned --reroll-count today!

> diff --git a/revision.h b/revision.h
> index 61931fbac5..ffeadc261a 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -215,6 +215,7 @@ struct rev_info {
>         /* interdiff */
>         const struct object_id *idiff_oid1;
>         const struct object_id *idiff_oid2;
> +       const char *idiff_title;

I feel we're abusing struct rev_info a bit for this since this
interdiff thing is very builtin/log.c's business and not at all
related to rev walk. Is it possible (and easy) to just pass
idfff_title from cmd_format_patch to make_cover_letter()? If it's a
lot of code, then I guess we can just leave it here.
-- 
Duy
