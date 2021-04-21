Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D89C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 22:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D01611F1
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhDUW1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 18:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbhDUW1S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 18:27:18 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0068C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 15:26:44 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q62-20020a6275410000b029026407f235dbso4560447pfc.23
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4w0OEY4SffFKBz63pAiXSDhSZG4G1iBei7eJxT6d8gM=;
        b=qvaEB+OT+4yJRjX1Ox6XOGjWiqVc8sRpaOrvj7o7oggfVub0NnxW/4GrujlYhcPHls
         yuSzl9SL+XNfC4ZEOV8ccE/gn57cihd08W60r2YMzATTZT2PWQ/7JzXxgx6IawKeNZm8
         jdO4gJkQZAUiYsOvT3hsnpCI5ay+6ytjhOA9OqDQ+vZpTuczx4AdoQvuuBmhB7oBsmwk
         d+7CjeNUfelPKBDFMOI+Ls2TpnpIQlcTIMb5yQOZjI/qwZuY6GXFe5JYDWHPND3vfvJS
         asJMe+3/rCw0qpSVa+0AVHGD7IZoQc5eh8IhjhbO/ftjtNI+FodXTp6+P/lGUDwyUvpL
         wDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4w0OEY4SffFKBz63pAiXSDhSZG4G1iBei7eJxT6d8gM=;
        b=SIL3sfbs90Wq8qMZdIeJD6iobHvCr+BGDoaTQEqM7VIRJfRzUe5K165y6oCr2bv3/a
         yz/hU4yGl+bE/yudA1I+bWN3dFbpMqtLV693Ih1BdpQ/H6MGqbWftGE1NGC68+dzKoOL
         lGuUwzW/Xx+WEE/84rejJdqEyMxyo+xWIoDhcEJVtOeebM7J2OFcMpXue3mwK/7XO/Wb
         5N46z8lWMu4RGSuMV/5aPtpqIT0HnePbicHu1z4zawO4uRsk83LHDDDT5wat7F8VOcey
         X97xt6wUbsmDpl9a/r0vI+VuYexmxDFkOR8ppNhUsuNWeIJBKfaNuVz/FZcwT1QWXZpn
         v+Ww==
X-Gm-Message-State: AOAM533kUfbSlRpelEIiI6WE1Xi0aWm/B55f+teF3kRW1bKETVihZvvD
        /4wOcq3nDPhr+awaZchBTh/dE96zSmtIpRomkECQ
X-Google-Smtp-Source: ABdhPJxIygGuaQGj/60osNwf/BXJFbArFVoqnOcOAkEVwYvDmHvvrmGR+xGj7UbrhxGooRAeR8YHL2r6RbdFcQzKTzJK
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7b85:b029:e9:5e4e:e873 with
 SMTP id w5-20020a1709027b85b02900e95e4ee873mr222548pll.7.1619044004328; Wed,
 21 Apr 2021 15:26:44 -0700 (PDT)
Date:   Wed, 21 Apr 2021 15:26:42 -0700
In-Reply-To: <patch-6.8-f337a5442d-20210420T133218Z-avarab@gmail.com>
Message-Id: <20210421222642.1025049-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-6.8-f337a5442d-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: Re: [PATCH v2 6/8] commit.c: don't use deref_tag() -> object_as_type()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, me@ttaylorr.com, newren@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Change a use of the object_as_type() function introduced in
> 8ff226a9d5e (add object_as_type helper for casting objects,
> 2014-07-13) to instead assume that we're not dealing with OBJ_NONE (or
> OBJ_BAD) from deref_tag().
> 
> This makes this code easier to read, as the reader isn't wondering why
> the function would need to deal with that. We're simply doing a check
> of OBJ_{COMMIT,TREE,BLOB,TAG} here, not the bare-bones initialization
> object_as_type() might be called on to do.

I think the benefit of using object_as_type() here (functionality that
checks the object type, with optional "quiet" behavior) outweighs the
drawback (additional functionality that we don't need). If we're worried
that the reader would wonder about the OBJ_NONE case, we can include the
BUG check as you did.

> Even though we can read deref_tag() and see that it won't return
> OBJ_NONE and friends, let's add a BUG() assertion here to help future
> maintenance.

This is reasonable.

> diff --git a/commit.c b/commit.c
> index 3d7f1fba0c..c3bc6cbec4 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -31,13 +31,22 @@ const char *commit_type = "commit";
>  struct commit *lookup_commit_reference_gently(struct repository *r,
>  		const struct object_id *oid, int quiet)
>  {
> -	struct object *obj = deref_tag(r,
> -				       parse_object(r, oid),
> -				       NULL, 0);
> +	struct object *tmp = parse_object(r, oid);
> +	struct object *obj = deref_tag(r, tmp, NULL, 0);

This change isn't unnecessary, I think. "tmp" isn't used anywhere else.
