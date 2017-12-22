Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C841F404
	for <e@80x24.org>; Fri, 22 Dec 2017 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933539AbdLVI75 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 03:59:57 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44299 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933524AbdLVI7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 03:59:54 -0500
Received: by mail-qt0-f194.google.com with SMTP id m59so35456601qte.11
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 00:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7kP8HRDSG269FSPolSwbogUS+hWTvQWrGoRx2XXb2bI=;
        b=OO4wEmXIEnzwzCCA6QK0N4mT3MWY62JaD8EH/Ruz7phSIDtXitAaUtvrX6OUIplf8u
         TrMjhOLK66C1gKqfroqnhYF4agNUdxa76WscaMOKZSyGbIaXN1OabOZaI5qHx96RXnQU
         dVhgczfzrvpPW1oR3+2Fv2Ple43xjVGTc3DmXfDnnxdrMW1SBcIz1YbH0JfmrHImJQKX
         xnSF67ScHJWlF51+KsC4NzdgHjmVP/Y+U0tsKCK9jbMn4us+r/dWN5f7GtQXoujm3H/n
         quFHs/3u6rw3zzfm7cdLWQgzk4tTQIMioqf4TLxNKvxdRVmJF8/qyhTvGfiDQZDt8y19
         AbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7kP8HRDSG269FSPolSwbogUS+hWTvQWrGoRx2XXb2bI=;
        b=NkuZQ5CmH6JKgCva7vkGwVxynO0PP7QRZN0rvtuhls7vCkr/h/hlOPZCKmZn//loXM
         HFS5m5rZQlmvuQh0DvCNl3DRtV3yvhfrclTtY8n2WVDGKo4iymJsAa4JfpnhDNPPrECK
         NB0ekhZRdlf36iCNMpGQ4eHHGuq50fAFJxWMazm3rGvj6XvfyJnaAloxKkH8yFjrgC8I
         lfboH6V/eyaXxHUlOe742AOkYX3txD3nboH30zTnhb/newLRc+lHZw2S789fOYrwmmjr
         7oJQgAOGaOe+YhExqdqNWGc9ockiL3t/dnCYvQSpg2f4T3XAGIbryT72t+3EKwd+fPh6
         Mb5Q==
X-Gm-Message-State: AKGB3mJz/IfmDhtEHDHiK9u//iWX2WtCEUYt8AWzWuFHbC7b+cJxuJME
        n2dO5Si3HA+2m9u+lcZsOICL9FT7DuLGXw+TsSs=
X-Google-Smtp-Source: ACJfBosLempHX+HENjrnABGo+STqYLz6vaK8a3DLPDiOSB96kRKRqQwHvLcG2Y3Iy9c2zkbqc+MWuP/RFE3UbqKOyxw=
X-Received: by 10.237.59.22 with SMTP id p22mr18691779qte.34.1513933193319;
 Fri, 22 Dec 2017 00:59:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Fri, 22 Dec 2017 00:59:52 -0800 (PST)
In-Reply-To: <504cafe3-2960-af2d-10fe-51e8ba3d2213@web.de>
References: <504cafe3-2960-af2d-10fe-51e8ba3d2213@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Dec 2017 03:59:52 -0500
X-Google-Sender-Auth: dcUgU_TIayWp3b3xIT6SQ34W7d0
Message-ID: <CAPig+cQaQ9ae1e4eMfJMG4wykXe2tTgtvpxB1_Z=3XbitYeQyw@mail.gmail.com>
Subject: Re: [PATCH] http: use internal argv_array of struct child_process
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 3:14 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Avoid a strangely magic array size (it's slightly too big) and explicit
> index numbers by building the command line for index-pack using the
> embedded argv_array of the child_process.  The resulting code is shorter
> and easier to extend.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> diff --git a/http.c b/http.c
> @@ -2041,13 +2040,10 @@ int finish_http_pack_request(struct http_pack_req=
uest *preq)
> -       ip_argv[0] =3D "index-pack";
> -       ip_argv[1] =3D "-o";
> -       ip_argv[2] =3D tmp_idx;
> -       ip_argv[3] =3D preq->tmpfile;
> -       ip_argv[4] =3D NULL;
> -
> -       ip.argv =3D ip_argv;
> +       argv_array_push(&ip.args, "index-pack");
> +       argv_array_push(&ip.args, "-o");
> +       argv_array_push(&ip.args, tmp_idx);
> +       argv_array_push(&ip.args, preq->tmpfile);

Not necessarily worth a re-roll, but using the "pushl" variant would
make it clear that "-o" and tmp_idx are related and would ensure that
they don't accidentally get split up if someone inserts a new "push"
in the sequence in the future.

    argv_array_push(&ip.args, "index-pack");
    argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
    argv_array_push(&ip.args, preq->tmpfile);
