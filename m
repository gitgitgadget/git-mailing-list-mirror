Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27DD1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 19:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCFTXs (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 14:23:48 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44114 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeCFTXr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 14:23:47 -0500
Received: by mail-qt0-f196.google.com with SMTP id g60so25883240qtd.11
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=51bACso2GB4HpFA5lw+u5boSSaFKz3R5qhyxBw5AfgY=;
        b=AlkKhcTslqkfG8xXV86OtK5HPvsij3NXKcWX1k+4DhSJoE5GD2S2fJzG3KvGwyD56Z
         z1CmI0F4QRFlWeQcjr4Y1Iu/XTtKWh0PJLaoinW33euUTG7+Evby3hfN2Ee6nyKdVT1u
         VobFTsrQxv5w1NuwsYjYFKtCwx4mhJ+MXdYGQib4WuN0fhM+WBd7MX+vvNRTueI4piwq
         dHyw/PTpDMxNg5Qspai9U2RS1lEEa23mUmgW7St0VK66eLJB08fUxUXVd4Mt0tI8HxT5
         jHXfxlOEJkfyh0Ft+wcvwNWWDBduNIrSKFV76+PP2+lbnn21QMCKBD8Qr2YUE9WsYmQU
         UZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=51bACso2GB4HpFA5lw+u5boSSaFKz3R5qhyxBw5AfgY=;
        b=OL07V1k1YLZBWxaK+OQwE1ksMgI/CNJxgW1HgM25EcBat2P1NMI8PyBwZzBoSmRQGO
         xwQlDlBzBTYq5RMXI7WYrRcc5CyJ3kgO+ILvqKpnRUBgbVoPOMOdqZkS6MxVFeIIyISk
         I+9l+o4Rw6jR9zafZ+Gf7lBc4Ffc8KLB7EZvexy2eU/UECJXr9FrAloaFCktnTH++ZJW
         m+k5NU/AXpMC/66SzlFuNjI+BiQ2q+qlFd10JuIr5VeKToQw0zg88e2nQY4/wzX0MgTi
         Di4RARN5OT277St6tamDS/sQezvrZ5kRbmIFrmkrobE0XP6i/eNXh8GjNF4rxCM1lqXX
         fz3Q==
X-Gm-Message-State: AElRT7Haiz+SJYqS7QlKJANecT6X0X5szqHBdpd3/UaOKOqTFiOLqn/I
        /eI/hV0W1uHl0SNqddkUFpQI7xO9rlWwYeOKH7U=
X-Google-Smtp-Source: AG47ELsR4V1qTzMbycHeGWhtZN4To2/bLXWA7Pc3Mw+l/oxYK2FUt22HTRx5ZfVjxR+KiY8I31tT7ZG4yvK0USDlD9s=
X-Received: by 10.200.28.8 with SMTP id a8mr22964193qtk.280.1520364227170;
 Tue, 06 Mar 2018 11:23:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Tue, 6 Mar 2018 11:23:46 -0800 (PST)
In-Reply-To: <1520337165-sup-4504@x1c>
References: <1520337165-sup-4504@x1c>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Mar 2018 14:23:46 -0500
X-Google-Sender-Auth: vDzfWViDfUOYI5O0TDMT_g8fLWQ
Message-ID: <CAPig+cRYsf161-Xomw7daj8XdEBxZAEQQRdOn4krRTpSAFkPOw@mail.gmail.com>
Subject: Re: [PATCH] xdiff: improve trimming preprocessing
To:     Jun Wu <quark@fb.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 6, 2018 at 6:53 AM, Jun Wu <quark@fb.com> wrote:
> xdiff-interface trims common suffix if ctxlen is 0. Teach it to also
> trim common prefix, and trim less lines if ctxlen > 0. So it can benefit
> the default diff command, as seen by profiling: [...]

A few comments (below) based upon a quick scan of the patch...

> Signed-off-by: Jun Wu <quark@fb.com>
> ---
> diff --git a/t/t4066-diff-trimming.sh b/t/t4066-diff-trimming.sh
> @@ -0,0 +1,49 @@
> +test_expect_success 'setup' '
> +  printf "x\n%.0s" {1..1000} >a &&
> +  printf "x\n%.0s" {1..1001} >b &&
> +  cat >c <<EOF1 && cat >d <<EOF2 &&\
> +  printf "x%.0s" {1..934} >>c &&\
> +  printf "x%.0s" {1..934} >>d # pad common suffix to 1024 bytes

The expression {x..y} is not portable to non-POSIX shells.

> +test_expect_success 'git diff -U0 shifts hunk towards the end' '
> +       test_expect_code 1 git diff -U0 --no-index a b |\
> +    fgrep "@@ -1000,0 +1001 @@" &&
> +       test_expect_code 1 git diff -U0 --no-index b a |\
> +    fgrep "@@ -1001 +1000,0 @@"
> +'

Style: Mix of tabs and spaces for indentation. Please indent only with
tabs throughout the patch.

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> @@ -101,42 +101,64 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
> +static void trim_common(mmfile_t *a, mmfile_t *b, long reserved,
> +                       xdemitconf_t *xecfg)
>  {
> +       /* prefix - need line count for xecfg->ptrimmed */
> +       for (i = 0; ++i < smaller && *ap == *bp;) {
> +               lines += (*ap == '\n');
> +               ap++, bp++;

Is there a good reason for not placing 'ap++, bp++' directly in the 'for'?

    for (i = 0; ++i < smaller && *ap == *bp; ap++, bp++)
