Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB36C433E0
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 22:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E1C207A1
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 22:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbhABWbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 17:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbhABWbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 17:31:25 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E929C061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 14:30:44 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id q10so12527976vsr.13
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 14:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JT9EeiJ0KXPXQgX8qB3D3pyJH1J8zD6HiTA79SWHEko=;
        b=HvsjHpsrSjRYN1G06omG/OrwpMOrRYzpE3bFu3AgS44wsP4Bn+e5dwHGjcrTvg9DbH
         nXBWz7CofhZIUeIcQGz9/0cM07o+ihsUSVdgJehkA2OTWVwyxLeTFnxh7D982Lz3sWxQ
         kuz6dwxXzCTBC/XZC+cRkj07XpPkqBCmllTip7BpvxbD6sTiUyoZVN4EjMH+r5opuaVR
         TGc1G9PWr6O+jTxe179lCOjkTlccAhuqzqdUAK13lj++v5n97+kzvMLRR/0XrTHPPePH
         jkIILRNzbuKhFOb3TqlNoP7quYHv92t8jIj/1PLlxsm8zsNCCkDiS3UgfL0WDbosQZba
         Prmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JT9EeiJ0KXPXQgX8qB3D3pyJH1J8zD6HiTA79SWHEko=;
        b=rNPSuxHVfQvfPc94pFUHKAuA1dQOQywXNG/hbaWg+Sa199fkMUfOgzqYw6F5fmNZWC
         b6Cxy+dsu7pnZOAfSEATSHWDrGojg8QKKnzUCX3vDW7IR+S1HbQCNEV+DgHX9fSpN8NZ
         rmkzlXJNnyYKpND2/qyKmZjNTOm6CzSFdbfchOfoNb8SZFftVpZuk67DReajdQh4YKXU
         nhPVx9Zvtq+dprNqI3NkHeRbZv3VxgJFkP8F79ZWUDzbjCfF+HL+8yVrbgELJL1SjBt7
         SRs3Dkk/EI5UEuZMfAmLK8Tlx5RZ5EV1HpLbSlYac3XlR9FvfWcGAa69CxlvsKEjp5ZK
         r/hQ==
X-Gm-Message-State: AOAM533X/JpxMG47P84RBtQQBhzr/7XoungtctTC5COKXpTLhg4jKBcy
        WeEQaSEoJ4mfBSOQjJQQO7g3U5B/r8Jm5CUAgz8=
X-Google-Smtp-Source: ABdhPJy9q20my7NeFbBgXB6QNS4VIAx2qodjL6isb22AhfssMYb+pfEpa25HEXljft5Oa5GeN6/69uhzGstsG+3iSso=
X-Received: by 2002:a67:e28a:: with SMTP id g10mr40050004vsf.58.1609626638277;
 Sat, 02 Jan 2021 14:30:38 -0800 (PST)
MIME-Version: 1.0
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
In-Reply-To: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 2 Jan 2021 23:30:26 +0100
Message-ID: <CAN0heSqotLJp3T5XbmeibVcg0RSyqH=69c1tV8-k153-_=CTxg@mail.gmail.com>
Subject: Re: [PATCH] refs: allow @{n} to work with n-sized reflog
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2 Jan 2021 at 02:41, Denton Liu <liu.denton@gmail.com> wrote:
>
> But then if you do
>
>         $ git reflog expire --expire=now refs/heads/newbranch
>         $ git commit --allow=empty -m two
>         $ git show -s newbranch@{1}
>
> you'd be scolded with
>
>         fatal: log for 'newbranch' only has 1 entries
>
> While it is true that it has only 1 entry, we have enough
> information in that single entry that records the transition between
> the state in which the tip of the branch was pointing at commit
> 'one' to the new commit 'two' built on it, so we should be able to
> answer "what object newbranch was pointing at?". But we refuse to
> do so.

The basic idea seems to make sense to me...

> Make @{0} the special case where we use the new side to look up that
> entry. Otherwise, look up @{n} using the old side of the (n-1)th entry
> of the reflog.

> --- a/refs.c
> +++ b/refs.c
> @@ -887,12 +887,16 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
>                 const char *message, void *cb_data)
>  {
>         struct read_ref_at_cb *cb = cb_data;
> +       int at_indexed_ent;
>
>         cb->reccnt++;
>         cb->tz = tz;
>         cb->date = timestamp;
>
> -       if (timestamp <= cb->at_time || cb->cnt == 0) {
> +       if (cb->cnt > 0)
> +               cb->cnt--;
> +       at_indexed_ent = cb->cnt == 0 && !is_null_oid(ooid);
> +       if (timestamp <= cb->at_time || at_indexed_ent) {

... but I can't really say anything about the implementation.

> +test_expect_success '@{1} works with only one reflog entry' '
> +       git checkout -B newbranch &&
> +       git reflog expire --expire=now refs/heads/newbranch &&
> +       git commit --allow-empty -mexpired &&

Minor nit: not sure about "expired" -- maybe "first after expiration".

> +       git rev-parse --verify newbranch@{1}
> +'

Should this capture the output and compare it to, e.g., `git rev-parse
newbranch^`?

> +test_expect_success '@{0} works with empty reflog' '
> +       git checkout -B newbranch &&
> +       git reflog expire --expire=now refs/heads/newbranch &&
> +       git rev-parse --verify newbranch@{0}
> +'

Same here, but comparing to `git rev-parse newbranch`? Both of these
checks seem worthwhile to make sure that we don't just answer
*something*, but that we actually get the right answer, as per your
"redefinition".

Speaking of redefinition, does this warrant an update of the
documentation? That's a genuine question -- having browsed git-reflog(1)
and gitrevisions(7) a bit, I'm not sure.

Martin
