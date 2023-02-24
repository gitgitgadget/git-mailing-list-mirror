Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20174C6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBXRxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjBXRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:53:30 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1E15166
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:53:30 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 130so2365pgg.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yh9uQgZs9xrAyvkXOi418HqzGAPIug7dlk8fErjJYXA=;
        b=Pf9L4oKI7avh5/Q5KsXInyhvx9/Oko68PiG6Jkuzz9lAfAK80Y4ZfSYanv2ud6fvox
         be0gZLVgSb22GlHJSJtE22LgMIOBvBhuzUS/IJCRyU179Yh/GXrY1RACmpUZTTNvkfGs
         hZPdy4gbzIZ4fRNy5ztRRZqpcp8/RXIsECqWkW0GJWPKNn2tytkcZQ/OHBJqtAddip3U
         Ce8u4W7pVTR4iwSFP1OEN4SgaW1NJIInM4IsG40cOyDGnSfKB0IECWO++2mTkYwkPlJF
         X9Eo7O+cbAAmsFP82/hKST20i8DTA/5rfDw/KMBej8/hUi/Etjmk/CQjDRPg7cGnizjd
         kUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yh9uQgZs9xrAyvkXOi418HqzGAPIug7dlk8fErjJYXA=;
        b=HtnDDeN+k+D3q9aKbEVg/qPgBRd7+PintwNHGap6/OKAKNShIP53aEwBOR4kzdNRpi
         lON2wQEwzKBvUR63/CPCXCmeijS/bpm1aeQzVNmolgQbHV1m0NYxUt5BH+Fh0o1XhdbG
         ToSyYLvkOJe/gglNILj+yAbhQqt6iRewL5GtIZsRY625u0Mooo29PV9phh1R/e9nhpsv
         Z3MJgRoqQn24Dt9XuvGaumPhATayjPxKF3vknFv/aXyW7FBFksAKl+t7kDeu4g4bJRc7
         bOx93VlQDCs+jD8fDYDmsdTG1dhK5dpS1tMfBdItuZ0h4h6plGD8+o1prwASf2rqnRGv
         BXMA==
X-Gm-Message-State: AO0yUKVaakVlUA0oXOKatHjwwXqpc0jSv/yzYxGbuns4OpMPSdTYEhGk
        bCwNdhMC3n15IEkeCVs9F7s=
X-Google-Smtp-Source: AK7set9Nu5tWj6nliygB+oxuHfj9uQhKx1qXBR6LA8p//OSeWjjuu0PrVr+OHdAiK1IhUp9q4nExrA==
X-Received: by 2002:a62:cf45:0:b0:5a8:ecb1:bf1 with SMTP id b66-20020a62cf45000000b005a8ecb10bf1mr13286018pfg.19.1677261209302;
        Fri, 24 Feb 2023 09:53:29 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id e1-20020a62ee01000000b00594235980e4sm7911665pfi.181.2023.02.24.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:53:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/21] ref-filter: drop unused atom parameter from
 get_worktree_path()
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
        <Y/hahKMhm4EYz3Pf@coredump.intra.peff.net>
Date:   Fri, 24 Feb 2023 09:53:28 -0800
In-Reply-To: <Y/hahKMhm4EYz3Pf@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 24 Feb 2023 01:34:44 -0500")
Message-ID: <xmqqmt530x2f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The get_worktree_path() function is used to populate the %(worktreepath)
> value, but it has never used its "atom" parameter since it was added in
> 2582083fa1 (ref-filter: add worktreepath atom, 2019-04-28).
>
> Normally we'd use the atom struct to cache any work we do, but in this
> case there's a global hashmap that does that caching already. So we can
> just drop the unused parameter.

If this were part of a codepath that were more table-driven, we
might have needed to use uniform function signature across these
helper functions, but it is not the case, and this solution indeed
is much nicer than marking it UNUSED.



> diff --git a/ref-filter.c b/ref-filter.c
> index f8203c6b05..434a28c830 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1822,7 +1822,7 @@ static void lazy_init_worktree_map(void)
>  	populate_worktree_map(&(ref_to_worktree_map.map), ref_to_worktree_map.worktrees);
>  }
>  
> -static char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
> +static char *get_worktree_path(const struct ref_array_item *ref)
>  {
>  	struct hashmap_entry entry, *e;
>  	struct ref_to_worktree_entry *lookup_result;
> @@ -1881,7 +1881,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  			refname = get_refname(atom, ref);
>  		else if (atom_type == ATOM_WORKTREEPATH) {
>  			if (ref->kind == FILTER_REFS_BRANCHES)
> -				v->s = get_worktree_path(atom, ref);
> +				v->s = get_worktree_path(ref);
>  			else
>  				v->s = xstrdup("");
>  			continue;
