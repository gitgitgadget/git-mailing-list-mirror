Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BCCC43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 17:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA7B2078E
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 17:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOBV9zdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgIERWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgIERWM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 13:22:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414E4C061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 10:22:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so5481558lfr.4
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mJEvDkjvpKvVKhyQZHFu42UJBcx/e2EONWi8Np7yKCo=;
        b=ZOBV9zdm3NKKAI03rNZVm1+ze8yYqKIcYyzLpdPsOmtYbBUrCmmQ3FSmrfz6lRp6lM
         mki8peiYxbBGl5K2g3MI+VlE149Ocv/168tY2qM1AALNARdmxtiVhRmW3IQkYXA/P0nh
         jy3hUsBirj4qQ0nrXLp6VVwL33oPpNRWrAO3CeYLTbs03BgNfwquZ+tJ0epJoJWboyyp
         RYOFxHwfqntQL0dAt15U8/vjj72NdVWBMHUnzyKd+PgHdIX3d8Q3JPT9jk3jTwjwAPvd
         07sLLi5liS/kSn4Zs+L1Ot1iobFlRXge1H8wELOF895fLWDw/IFXIC9esf7G7i0mOaxB
         6TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=mJEvDkjvpKvVKhyQZHFu42UJBcx/e2EONWi8Np7yKCo=;
        b=uHXHjd0hXG1OYW4CjQrHtjYpp0Vmp8WPDmv3rKEO3KULTWs7T5/eo/yHDMHIGkuWzL
         xx+zlPpwdt5JzWMe92pxitIry//SpC2j0Rc/UTMsA3ylC8jZzOhNmtPVnWkZXqfHw/lL
         z6iMmxU/yjJqEanAjQ4uJF6zjQDq8FFlHsEMoQkUY6ovuAX0UMkhKMq+NSWWqveDpPHk
         vUUG6cTfkpMjXtpzD2U4DYAAq13xMALuzwS+9ZveKIYMjQb8MSzjjqxnIuagFWtpsH+1
         T2LNFQ/Kb2kZXoVdHz/EIanT76pmtZ/ngyc9TdPuYldRhUFzgp3IrYKmXLeYdFDctsuc
         LPoA==
X-Gm-Message-State: AOAM532olfprIoYPoyAFZohQ8Kgrkj1F70gZRaS+xKhB0zx+JDhepPpU
        MAVUoKa5OLmX0yDUa3AsRZY=
X-Google-Smtp-Source: ABdhPJy7YX09FxXYKoovD01/fYp4Dm/EUhziJLvT4p3KyL2LqkBbfhHWwBfLlga81HiqV3wgJukNgw==
X-Received: by 2002:a05:6512:31c2:: with SMTP id j2mr6670502lfe.85.1599326530067;
        Sat, 05 Sep 2020 10:22:10 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id g63sm2579796lfd.28.2020.09.05.10.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 10:22:09 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99?= =?utf-8?Q?bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
References: <cover.1596480582.git.me@ttaylorr.com>
        <cover.1599172907.git.me@ttaylorr.com>
        <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
Date:   Sat, 05 Sep 2020 19:22:08 +0200
In-Reply-To: <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 3 Sep 2020 18:46:28 -0400")
Message-ID: <85h7sc9m0v.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

[...]
> While we're at it, instrument the new 'get_or_compute_bloom_filter()'
> with two counters in the 'write_commit_graph_context' struct which store
> the number of filters that we computed, and the number of those which
> were too large to store.

[...]
> @@ -1414,12 +1433,25 @@ static void compute_bloom_filters(struct write_co=
mmit_graph_context *ctx)
>  		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
>=20=20
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
> +		int computed =3D 0;
>  		struct commit *c =3D sorted_commits[i];
> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, c, 1);
> +		struct bloom_filter *filter =3D get_or_compute_bloom_filter(
> +			ctx->r,
> +			c,
> +			1,
> +			&computed);
> +		if (computed) {
> +			ctx->count_bloom_filter_computed++;
> +			if (filter && !filter->len)
> +				ctx->count_bloom_filter_found_large++;

How do you distinguish between no changed paths stored because there
were no changes (which should not count as *_found_large), and no
changed paths stored because there were too many changes?  If I remember
it correctly in current implemetation both are represented as
zero-length filter (no changed paths could have been represented as all
zeros filter, too many changed paths could have been represented as all
ones filter).

No changes to store in filter can happen not only with `--allow-empty`
(e.g. via interactive rebase), but also with merge where all changes
came from the second parent -- we are storing only changes to first
parent, if I remember it correctly.

This is a minor issue, though.

> +		}
>  		ctx->total_bloom_filter_data_size +=3D sizeof(unsigned char) * filter-=
>len;
>  		display_progress(progress, i + 1);
>  	}
>=20=20
> +	if (trace2_is_enabled())
> +		trace2_bloom_filter_write_statistics(ctx);
> +
>  	free(sorted_commits);
>  	stop_progress(&progress);
>  }

Best,
--=20
Jakub Nar=C4=99bski
