Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA751C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 16:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiI3Qpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 12:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiI3Qpw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 12:45:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B658510AB1D
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 09:45:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rk17so10220974ejb.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=OMFgN4TAVZsGBlv9a052cf+dCw3ri1MRofNKO6O1qao=;
        b=iONwTiXOKEEUAao/3MPJGPsNqqeP/I1j/RhhXay7LjPDbfSmRl6z0GAPf/S7mpmObR
         ld8du1W9hCsXmiewcgYGkI5nhGD8wijuGc/ryAYYANS1/A6W5T5zbLL6UssQknnQZlIp
         VhcczCKBu8yhA5vrEVPLh6RU2B0KZF4q0ZlYGmC0KaxcKGA6oBfgGfD4AEzTkgKIQZbY
         lDwgdNxL7I6FRfJMevvvPrywCwWa+8owgoMbIbhwnWj6gfM7Cv3iqx382F9lzjzqoAmv
         qvH+JnFcyQhkK7DEtVV1+j5uML5oe5xUAotXHwTGrIAO7YIbShXUdoZRDe2DPySUkjTx
         CCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=OMFgN4TAVZsGBlv9a052cf+dCw3ri1MRofNKO6O1qao=;
        b=tU3uzZyhOtaSnviCOQT4bq2XDl8E97N1Vr1/hrO8lGUABwtYBwaLhQ08UFm0JxP16j
         59rT4Ve/ifygA0ZFwsm1w2SKAYDgkHGZd6NnG8mCaz1X0/s1QApPezmu5KOjNs73KrA/
         NTeo29ET4UXe10W2tsETDVTI8cO9BtyqiRKtOE19IgktUsC9qPUZHv17+nLcvEBw1RQ1
         LfGYjifjhf5ibCa5vVg6XkJkO+7ARpK1M0qWH8qJsBSHcBfdOVij6f7VQfaiKJh+enXB
         +id2d02sAAoUke5QCNUKZaPWFuzekhMtzMs/tyUdFVaEBAEQYRTJ1ysRJbNAJfs3ekRc
         quaA==
X-Gm-Message-State: ACrzQf2cb2bSjHh9W3MhDQjj2G6FM/H2mSt5Mh8VB0aA8ufaAmETBaye
        89qFqs4xlI0hhASIA7uxG/8=
X-Google-Smtp-Source: AMsMyM6kVuiNqbquqdI4cdMrXA69eXU0Wdi8NmXT6iTnSfyUxFE1UPAFc6+H4MNipu79MJD2RKWfoA==
X-Received: by 2002:a17:907:d9e:b0:782:28a4:8ced with SMTP id go30-20020a1709070d9e00b0078228a48cedmr6909234ejc.542.1664556349172;
        Fri, 30 Sep 2022 09:45:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z34-20020a509e25000000b0045393e56488sm2028186ede.58.2022.09.30.09.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:45:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oeJ90-001ldj-1y;
        Fri, 30 Sep 2022 18:45:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] sequencer: duplicate the result of
 resolve_ref_unsafe()
Date:   Fri, 30 Sep 2022 18:45:12 +0200
References: <20220930140948.80367-1-szeder.dev@gmail.com>
 <20220930140948.80367-6-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20220930140948.80367-6-szeder.dev@gmail.com>
Message-ID: <220930.86mtagvmit.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 30 2022, SZEDER G=C3=A1bor wrote:

> When 'git rebase -i --update-refs' generates the todo list for the
> rebased commit range, an 'update-ref' instruction is inserted for each
> ref that points to one of those commits, except for the rebased branch
> (because at the end of the rebase it will be updated anyway) and any
> refs that are checked out in a worktree; for the latter a "Ref <ref>
> checked out at '<worktree>'" comment is added.  One of these comments
> can be missing under some circumstances: if the oldest commit with a
> ref pointing to it has multiple refs pointing to it, and at least one
> of those refs is checked out in a worktree, and one of them (but not
> the first) is checked out in the worktree associated with the last
> directory entry in '.git/worktrees'.
>
> The culprit is the add_decorations_to_list() function, which calls
> resolve_ref_unsafe() to figure out the refname of the rebased branch.
> However, resolve_ref_unsafe() can (and in this case does) return a
> pointer to a static buffer.  Alas, add_decorations_to_list() holds on
> that static buffer until the end of the function, using its contents
> to compare refnames with the rebased branch, while it also calls a
> function that invokes refs_resolve_ref_unsafe() internally [1], and
> which overwrites the content of that static buffer, and messes up
> subsequent refname comparisons.

Good catch...

> Use xstrdup_or_null() to keep a copy of resolve_ref_unsafe()'s return
> value for the duration of add_decorations_to_list().

...and this makes sense...

>  	const struct name_decoration *decoration =3D get_name_decoration(&commi=
t->object);
> -	const char *head_ref =3D resolve_ref_unsafe("HEAD",
> +	const char *head_ref =3D xstrdup_or_null(resolve_ref_unsafe("HEAD",

...but let's change this to a "char *" then...

>  						  RESOLVE_REF_READING,
>  						  NULL,
> -						  NULL);
> +						  NULL));
>=20=20
>  	while (decoration) {
>  		struct todo_item *item;
> @@ -5965,6 +5965,7 @@ static int add_decorations_to_list(const struct com=
mit *commit,
>  		decoration =3D decoration->next;
>  	}
>=20=20
> +	free((char *)head_ref);

...so we don't need this cast...?
