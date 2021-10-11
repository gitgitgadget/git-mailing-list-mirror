Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3644C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 21:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9623E60E05
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 21:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhJKVYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 17:24:10 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:38714 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhJKVYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 17:24:07 -0400
Received: by mail-ed1-f50.google.com with SMTP id d9so48817337edh.5
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 14:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENwYXJ0eBZ67lGjsuCHABd+yNRaxOma9r3+rs0jSyJ8=;
        b=z1AVwdjhgZA6KP+VZUOAroZMKRyz9DW0dWVAvXCC/Vo0/GPNlzDWKAfa1PEGqYUx9v
         Pc+sacnD3phbm8c3SBWzbXF7FgpNsT9O5YK5BQ7fEtbV5q6YPEBeBkomhkyHlDZ9FW6Q
         oWT/PIZ8ZCY345sI0Ov20kHURnhoa5nfXTDNJDG3Ts0ZfNqQWzB69t8AIrESnriEalxg
         EN29sGR1I0kNHOXIraVGMYg+c8/gcPWsc5YvoMMXU44ZNfYqEdfVgc1SArpxHe+Ks7hb
         yGgAa6Ka316/1GuWAwQyhCdn0Iz/wqzPK050HJGp5YOOBiQ3iuCFklwhPYUHVcaOkrxJ
         CcIQ==
X-Gm-Message-State: AOAM531tWdm/Bn1iiRAy4yLreMdXmls9b4sQ02fLbdUSDJEAKEpREHst
        cDWrCb3LAR35p9s8gYoH9HAtnxA7amX+nBA04wA=
X-Google-Smtp-Source: ABdhPJwrthW59xZ9QUNu7nlMFX3Te0OXHh+DjQ4Ewv/Z9OqDEplZjnmfNJs4yJRr4zk2z92WBw7rdyfQiAgij43x7E0=
X-Received: by 2002:a17:906:998d:: with SMTP id af13mr25344426ejc.568.1633987326046;
 Mon, 11 Oct 2021 14:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
In-Reply-To: <87lf2zz59w.fsf@osv.gnss.ru>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Oct 2021 17:21:54 -0400
Message-ID: <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push' and 'save'
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

/On Mon, Oct 11, 2021 at 4:17 PM Sergey Organov <sorganov@gmail.com> wrote:
> Stash only the changes that are staged.
>
> This mode allows to easily stash-out for later reuse some changes
> unrelated to the current work in progress.
>
> Unlike 'stash push --patch', --staged supports using of any tool to
> select the changes to stash-out, including, but not limited to 'git
> add --interactive'.

s/using of any/use of any/
...or...
s/using of any/using any/

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
> diff --git a/builtin/stash.c b/builtin/stash.c
> @@ -1656,6 +1716,8 @@ static int save_stash(int argc, const char **argv, const char *prefix)
> +               OPT_BOOL('S', "staged", &only_staged,
> +                        N_("stash in patch mode")),
>                 OPT_BOOL('p', "patch", &patch_mode,
>                          N_("stash in patch mode")),
>                 OPT__QUIET(&quiet, N_("quiet mode")),

Copy/paste error in new help/description string?
