Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B87C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5053F617E3
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhKQAg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 19:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhKQAg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 19:36:58 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382BC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:34:01 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e7-20020aa798c7000000b004a254db7946so595275pfm.17
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LGT4FouK+YjeTPd8EU0tPb9YA5fWQfrJ43J0BJ2xvU4=;
        b=TfGrczJkn3+kEBwPwADYeTXRQx5BRCA4LjAAUqOJ6M3V0+y1PAGrFgNrQ1yb+Kvd7P
         BFFoF0XfWpwzeueXvSaNs8p9HO1ElbDuZsIze7Pi336pkC0OsKG+MhEZj1fFz+6nIm4w
         DyO67iNiqSQnuctPZrMnCK2BDQqPudnhuoNHJQoSs8+4qQAfmkr5q+2XFGGMIfp3BnZB
         /rSONwnFEoZrweS0tXmm5EoWLjS+UqYiYLpc9abtJaV878XXEdRidGaR/baZ4fJ8IpkT
         dasEuBLruME5AdvHn71/3kgmonhlv7srb7X1iSgYOeSO0Mss+PP0PhI1hbRI2ulIP3dg
         FTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LGT4FouK+YjeTPd8EU0tPb9YA5fWQfrJ43J0BJ2xvU4=;
        b=CCpxw8go5/GzqqU26T3lG435HuHMuGOJgLuvyI/Lw9tw/bYoo5FqSU3KEsUyg07tJL
         cVmzhW0vkySVSgcWkXVzzv+zK1rNSaaBdWiF2c5D74VaDhMptqLxxDy9xxTrRaP1ALCB
         ldXPCYOmKNvOcRfWR6FUKr1QTrQDIP/hTgKXvVrDPYO/81WjLKXDFvhUPo8brUvYgfim
         jjH9IjoH2rjmz8BP6xnD3xNMo+7Sl5lWIrjtN6je3BuDqSxGxVokfbQs6tcgoGdNVNsg
         gWHAKMIiBwSit3z5hUfVDABjHvNrN1Ead8e+U0HMak9PAkR8bPWsIj5MTL5G8FMTlsoC
         T2yw==
X-Gm-Message-State: AOAM533BlqnjjqLWknHqj5Lb8IcZczGt6GPy/Zv9VilIOKZfzOVcHcKr
        VEivY016Uw82q24TDYnGwGRpi11ggQRYBw==
X-Google-Smtp-Source: ABdhPJxV6bLAaH0dmjuhQBI+pSJhNb8uALi+POSXVGomZrtOQVDYVO/2a/BvMgSYwK0F8Z1YPrsEBcowqnn/FA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f283:b0:141:f719:c434 with SMTP
 id k3-20020a170902f28300b00141f719c434mr48959672plc.79.1637109240612; Tue, 16
 Nov 2021 16:34:00 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:33:52 -0800
In-Reply-To: <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
Message-Id: <kl6lczmzipsf.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
Subject: Re: [PATCH v4] branch: add flags and config to inherit tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> I've addressed Glen's feedback from V3. However, this brings up a new
> issue that was not obvious before: "branch.<name>.merge" can be
> specified more than once. On the other hand, the existing tracking setup
> code supports only a single merge entry.

Yes, for istance, install_branch_config() uses git_config_set_gently(),
which will override duplicate values.

> For now I'm defaulting to use the first merge entry listed in the
> branch struct, but I'm curious what people think the best solution
> would be.

I can think of at least two possibilities:

The first would be to parse the information into our native data
structures. This is pretty much what you've done in v4, but insteaed of
defaulting to the first merge entry, we would iterate over all of the
possible merge entries and...

> @@ -139,7 +166,9 @@ static void setup_tracking(const char *new_ref, const=
 char *orig_ref,
> =20
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst =3D (char *)orig_ref;
> -	if (for_each_remote(find_tracked_branch, &tracking))
> +	if (track !=3D BRANCH_TRACK_INHERIT) {
> +		for_each_remote(find_tracked_branch, &tracking);
> +	} else if (inherit_tracking(&tracking, orig_ref))
>  		return;
> =20
>  	if (!tracking.matches)

we get rid of the assumption that we can use a single 'struct tracking'.
when track=3DBRANCH_TRACK_INHERIT. Of course, this isn't as simple as
calling install_branch_config() repeatedly, because that would override
"branch.<name>.merge" over and over.

> This may be another point in favor of =C3=86var's suggestion to
> reuse the copy-branch-config machinery.

This is the second option, which is pretty simple. Inheriting the branch
tracking info is a matter of copying the config, which we already do
when we copy branches in builtin/branch.c:

	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
	strbuf_release(&oldref);
	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
	strbuf_release(&newref);
	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0=
)
		die(_("Branch is renamed, but update of config-file failed"));

Between these two options, I think the first is a better long-term
solution because I think that parsing the config into our own data
structures is generally less error-prone than operating directly on a
file (e.g. using the data structures was what made this bug obvious to
us in the first place, using repo->config will handle multiple config
files correctly). I don't see '--track=3Dinherit' as being _that_
conceptually similar to copying a branch; I see it as a different mode
of tracking that just so happens to be implementable by copying some
sections in the branch configuration.

But as a practical matter, I don't see any obviously terrible short-term
downsides to just copying the config. It's no less correct than our
branch copying logic and I'm afaid of introducing unintended
consequences by mucking around with install_branch_config().
