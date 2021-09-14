Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B012C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C98260E52
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhINTI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhINTIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:08:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFEFC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 12:07:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y8so229032pfa.7
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXf6PRcGFNDo3uhqGxQ8953oBubP4rIuWcWrGP9JmN4=;
        b=Eh4kf/zQMGffJ0O4G1hGHHNjLrhmMaLv+9rJgFITCgfGod579WsTJ0LG08f8QB2M7N
         nJYyfNDVyGiUZ+0TD6mXDOsxaVaw+W1anv/hLl7vpXK9Lit/oPaUHMw2dPdDL7ucvXvG
         Gl5yajWX1gstez4zGjNk4bGqDmemLlzRganc2aRiQ4ulukpAIVs9MAn8F/H8utIRrauU
         NddyOSk2YOgTTHY9btK8R/SNq8hUmoPKzkDXGXTZSUFoQr5Gll0R+0GoNL7NGONXfyqL
         5PeCUYnk7/gPmEt/BWY1+uqkziT/pTnxh6/50uuT+vrw2kmMYQExKzSUd8I9KPmeNn0r
         lXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXf6PRcGFNDo3uhqGxQ8953oBubP4rIuWcWrGP9JmN4=;
        b=N3oZp325Ko4sIextikOdDKHTDQBJdv3IQKa12agd8Iw3n0ftagTMmBuVuLGEctSSkJ
         boN+x/BZZuSuaZDpU67vi7ltTVAoLh/CzToKqBWnRfunHRxnk4Stb7gzlIi424vLLFWJ
         IDMRNJjjTnuX1ObvCrRj/qCiwcCCDi8v/huZ26WzrR5v2WNz88yA6BInc866UTd6pDOa
         porHp/GKgXaFNPXcZD3aXWNOrnwPuVF/iu1clzjrTB0P73kq3FZ5kjAe3YnYcZfizbAb
         7EBy5DdBp9xSjx5RsjTrSpSz62GhBZwDh8IvPL6YzQrl/2r1PmwzjJxj0Gb2odvdrYdy
         Fv0A==
X-Gm-Message-State: AOAM530sGRiF/ZCFTm7GeVsO266BvsnRcnpotAVpi3RmsJ9G8AWIxjpI
        x/2pnAZVxGgtfOVyZfUFJjunsAsX13btznJrC6VRTAu1U0M=
X-Google-Smtp-Source: ABdhPJwbs+lkNmnA+vaDhnQQfoe2vYH9wwsGOHegZI6b4QvGK6RlZnSDbr9W5GiOWjGGsid4m9LxdC28QyeUtSAdJJY=
X-Received: by 2002:a62:64d3:0:b0:43d:ba3:1e2c with SMTP id
 y202-20020a6264d3000000b0043d0ba31e2cmr6306245pfb.5.1631646427603; Tue, 14
 Sep 2021 12:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net> <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
In-Reply-To: <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 14 Sep 2021 21:06:55 +0200
Message-ID: <CAN0heSp9RdFwSo+x5buHSCAOa0Kay7Wcs1tNKTDXWmkCM8Latw@mail.gmail.com>
Subject: Re: [PATCH 7/9] ls-refs: ignore very long ref-prefix counts
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Sept 2021 at 17:38, Jeff King <peff@peff.net> wrote:
>
> One possible solution is to just drop the connection when the limit is
> reached. If we set it high enough, then only misbehaving or malicious
> clients would hit it. But "high enough" is vague, and it's unfriendly if
> we guess wrong and a legitimate client hits this.
>
> But we can do better. Since supporting the ref-prefix capability is
> optional anyway, the client has to further cull the response based on
> their own patterns. So we can simply ignore the patterns once we cross a
> certain threshold. Note that we have to ignore _all_ patterns, not just
> the ones past our limit (since otherwise we'd send too little data).

This all makes sense to me. At some point, we should be able to go "I
don't know what you're trying to do, but let me just ignore all this
craziness and instead try to give you a useful result sooner rather than
later".

I do wonder if we should document that the client can't trust us to
actually do all this culling. In general, I find that it's a matter of
hygiene for the client to do its own checks, but with this change they
actually *need* to do them. (Unless they know our limit and that they're
on the right side of it, but that kind of magic is even less hygienic.)

> +               else if (skip_prefix(arg, "ref-prefix ", &out)) {
> +                       if (too_many_prefixes) {
> +                               /* ignore any further ones */
> +                       } else if (data.prefixes.nr >= MAX_ALLOWED_PREFIXES) {
> +                               strvec_clear(&data.prefixes);
> +                               too_many_prefixes = 1;
> +                       } else {
> +                               strvec_push(&data.prefixes, out);
> +                       }
> +               }

Is it easier to reason about with something like this
(whitespace-damaged) on top?

diff --git a/ls-refs.c b/ls-refs.c
index 839fb0caa9..b3101ff361 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -147,7 +147,6 @@ static int ls_refs_config(const char *var, const
char *value, void *data)
 int ls_refs(struct repository *r, struct packet_reader *request)
 {
        struct ls_refs_data data;
-       int too_many_prefixes = 0;

        memset(&data, 0, sizeof(data));
        strvec_init(&data.prefixes);
@@ -164,14 +163,8 @@ int ls_refs(struct repository *r, struct
packet_reader *request)
                else if (!strcmp("symrefs", arg))
                        data.symrefs = 1;
                else if (skip_prefix(arg, "ref-prefix ", &out)) {
-                       if (too_many_prefixes) {
-                               /* ignore any further ones */
-                       } else if (data.prefixes.nr >= MAX_ALLOWED_PREFIXES) {
-                               strvec_clear(&data.prefixes);
-                               too_many_prefixes = 1;
-                       } else {
+                       if (data.prefixes.nr <= MAX_ALLOWED_PREFIXES)
                                strvec_push(&data.prefixes, out);
-                       }
                }
                else if (!strcmp("unborn", arg))
                        data.unborn = allow_unborn;
@@ -180,6 +173,9 @@ int ls_refs(struct repository *r, struct
packet_reader *request)
        if (request->status != PACKET_READ_FLUSH)
                die(_("expected flush after ls-refs arguments"));

+       if (data.prefixes.nr > MAX_ALLOWED_PREFIXES)
+               strvec_clear(&data.prefixes);
+
        send_possibly_unborn_head(&data);
        if (!data.prefixes.nr)
                strvec_push(&data.prefixes, "");

Maybe even name the macro TOO_MANY_PREFIXES (and bump it by one)
to make the logic instead be

        if (data.prefixes.nr < TOO_MANY_PREFIXES)
                strvec_push(&data.prefixes, out);
 ...
        if (data.prefixes.nr >= TOO_MANY_PREFIXES)
                strvec_clear(&data.prefixes);

Just a thought. I'm reaching to try to find a way to improve this
series. ;-) It was a nice read.


Martin
