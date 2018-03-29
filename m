Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7942F1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 20:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeC2USH (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 16:18:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38170 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeC2USG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 16:18:06 -0400
Received: by mail-wr0-f193.google.com with SMTP id m13so6449884wrj.5
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WvYburdmd8MjP1t7IpUd9RXdbfKPVpsF2OfZ0DgbKZM=;
        b=YNMyTecKUZJIqk0f6KWyAXjcbBrai/ucnQJzompyZxq6EKFANvq0er3j1acg+zVcxi
         46K4RAixcJwbqgoPMT6zcK+nVIBAU2rBzU42MkJsHLWy01Ela7B9CdJtntU7yads8AgW
         EdR3ey8Vc6K6cHnWD1LUj6s5N838QdbHpNf4MBJHKpCgfl4xqTpoQZ6EhwcuMp6zM7nP
         wvwLqscnPKP6DEzyhkjbMGbDANnJCwg3xm2kiXvoiY1UUYvdhLs3X6huJ3g80u1TK83f
         qt6Yifixe6Ph8cAZIsuXuKgBGIjsi1NM6jALxleThI/gsgFYC+XTSou8ZQpSiJxL15Q2
         dm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WvYburdmd8MjP1t7IpUd9RXdbfKPVpsF2OfZ0DgbKZM=;
        b=NDBmk+InCTLkoJ1cIprEM5bvB9q2kf8IzGIUydqn555kKU4wwXbZMLJENhx8urg10K
         RdwCPt1dDL7fs6ezWZKtvoa65U4uS6nqWWSbWmCvsb1EbLjlbdHXwx9hoOVKRs2E0bpI
         gvm3wy9BIrolHwU8mLKc7e3imSZI8I4hMjk6NJXAfq5NigpJBo3W684bVJkRSTCVHxrv
         838gOSBfqPTt/6xGznFu+KyBavl142rrCEQ01qyHOg3pf1EyltrxNb/TAkiXwAVAgoZ4
         O2bSMLoN1dKDee4tq0IfCVR+PtbGYd/vJgEKiNNpXg1W1VD5yeOexOQtD1QLYM9MmWVU
         OMag==
X-Gm-Message-State: AElRT7HJ0hEWcnp6WPdrSZ06bHlkho1Fyqt+oQuWN2Vali6Z2f+tSDc+
        Ni/7YpoPuuKelkjJ8Cluw5E=
X-Google-Smtp-Source: AIpwx4+UHInygNJ4TRxeCyHOaizKqDgrisALy1MRIROYwxy6z23vQ9zOZIMbdWPmX0kOS0wax43Cbw==
X-Received: by 10.223.187.138 with SMTP id q10mr7012423wrg.62.1522354684901;
        Thu, 29 Mar 2018 13:18:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p4sm9954391wrf.27.2018.03.29.13.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 13:18:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: prefer `--type=bool` over `--bool`, etc.
References: <20180328234719.595-1-me@ttaylorr.com>
Date:   Thu, 29 Mar 2018 13:18:03 -0700
In-Reply-To: <20180328234719.595-1-me@ttaylorr.com> (Taylor Blau's message of
        "Wed, 28 Mar 2018 16:47:19 -0700")
Message-ID: <xmqqh8oy63gk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> `git config` has long allowed the ability for callers to provide a 'type
> specifier', which instructs `git config` to (1) ensure that incoming
> values are satisfiable under that type, and (2) that outgoing values are
> canonicalized under that type.
>
> In another series, we propose to add extend this functionality with
> `--color` and `--default` to replace `--get-color`.
>
> However, we traditionally use `--color` to mean "colorize this output",
> instead of "this value should be treated as a color".
>
> Currently, `git config` does not support this kind of colorization, but
> we should be careful to avoid inhabiting this option too soon, so that
> `git config` can support `--color` (in the traditional sense) in the
> future, if that is desired.

OK.

> In this patch, we prefer `--type=[int|bool|bool-or-int|...]` over
> `--int`, `--bool`, and etc. This allows the aforementioned other patch
> to add `--color` (in the non-traditional sense) via `--type=color`,
> instead of `--color`.

OK, it's not just "we prefer" but we add this new "--type" thing, so
that we do not have to worry about having to make --color and other
"types" into double-dash options.  Makes good sense, I would guess.

