Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37358C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 09:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiFCJge (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiFCJgc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 05:36:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02152C66D
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 02:36:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id v1so4140002ejg.13
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 02:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lZOpEOWo1m4/3hG73ZZfARQrPYsBG3kMdoq7xVcYWtw=;
        b=YMKRZNPp7E5XI40PCgJpeImCpT9x3Q1FzHLa0+W4pUnIVOz+z4rOaMa3+1ae240jtv
         kBLZqyzKU4gsoDGrVFmBOHVEKrpOejKklKoKaCehFsgExFXG6yz/qQQFtb8cvnrF5n2B
         hlParUBPnJu0drxm+HsBRC1t9xwGtPbVK2DjB1S8bDYO1hYLc+f27q2ev/kNB6mDBuNb
         C3VmG9l8PVL7falVeaUb9dUxx+5yskOdaom8lXPvoRzpaPXX4mniDW6Pm91w4Icwp/pd
         wwbUjo8nDmmrMthEjv4kZwxSMrPiXMpeHM2czFgvV3qtNs/D2DQywKNfzyUHDB0Eu7Y/
         uoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lZOpEOWo1m4/3hG73ZZfARQrPYsBG3kMdoq7xVcYWtw=;
        b=K54Kham+vPrfe1ycWLJIbF2eA725eUd3DRI5HGVXeJqMkfZBctq9O43+Sy0nxMFyK9
         /QwEZkkF9/j4Pk9Cj/ixiKPDgNJAApg0uVy0lNBT3E659cGH12U45wq1UfVTgfwbyP3Y
         gCRPGEOK3bWh4sonTMm2kg1clissym3qqonzaIjEGamfptZqzvwl+IyhrQo69YbNyhFH
         KgaZ0ysz8/6sdCPz6KJ8mIj65iuZxmXgySXxJ1GP1AXmV8fXv6py2aC+hWj/ni2Y8dwS
         Tba/MXU5LtQGL9241mWla6MGKb/LOHtMHQbuRe+7yVJZtRna061EClTk1RBn+EKcTc9G
         0YWA==
X-Gm-Message-State: AOAM532LU+0BRiSCLboz3y5TAkWWvx8//qTWZz2ryalmp7vPcEY8C1qp
        vjnH8b63IyZ0vGWDPtLQlko=
X-Google-Smtp-Source: ABdhPJwmUnGU0MeLEs4xboyr3dflQNrD8E/1MVvhVPCZzzYztDTFUm8Epm+eyOXx+6M+OTQAD3Vt1w==
X-Received: by 2002:a17:907:1c94:b0:6fe:8d29:7d8a with SMTP id nb20-20020a1709071c9400b006fe8d297d8amr7634583ejc.346.1654248990262;
        Fri, 03 Jun 2022 02:36:30 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a22-20020aa7d916000000b0042dd4f9c464sm3603508edr.84.2022.06.03.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:36:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nx3jI-001aKp-RL;
        Fri, 03 Jun 2022 11:36:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, me@ttaylorr.com,
        gitster@pobox.com, bagasdotme@gmail.com
Subject: Re: [PATCH v2] commit,shallow: unparse commits if grafts changed
Date:   Fri, 03 Jun 2022 11:30:36 +0200
References: <20220323210803.1130790-1-jonathantanmy@google.com>
 <20220602231145.310564-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220602231145.310564-1-jonathantanmy@google.com>
Message-ID: <220603.86k09yxf4z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 02 2022, Jonathan Tan wrote:

> diff --git a/commit.c b/commit.c
> index 59b6c3e455..1537ea73d0 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -120,6 +120,17 @@ int commit_graft_pos(struct repository *r, const struct object_id *oid)
>  		       commit_graft_oid_access);
>  }
>  
> +static void unparse_commit(struct repository *r, const struct object_id *oid)
> +{
> +	struct commit *c = lookup_commit(r, oid);
> +
> +	if (!c->object.parsed)
> +		return;
> +	free_commit_list(c->parents);
> +	c->parents = NULL;
> +	c->object.parsed = 0;
> +}
> +
>  int register_commit_graft(struct repository *r, struct commit_graft *graft,
>  			  int ignore_dups)
>  {
> @@ -145,6 +156,7 @@ int register_commit_graft(struct repository *r, struct commit_graft *graft,
>  			(r->parsed_objects->grafts_nr - pos - 1) *
>  			sizeof(*r->parsed_objects->grafts));
>  	r->parsed_objects->grafts[pos] = graft;
> +	unparse_commit(r, &graft->oid);
>  	return 0;
>  }
>  
> @@ -253,8 +265,10 @@ void reset_commit_grafts(struct repository *r)
>  {
>  	int i;
>  
> -	for (i = 0; i < r->parsed_objects->grafts_nr; i++)
> +	for (i = 0; i < r->parsed_objects->grafts_nr; i++) {
> +		unparse_commit(r, &r->parsed_objects->grafts[i]->oid);
>  		free(r->parsed_objects->grafts[i]);
> +	}
>  	r->parsed_objects->grafts_nr = 0;
>  	r->parsed_objects->commit_graft_prepared = 0;
>  }

Are we going to have the same issue with tags, c.f. parse_tag() and
there being no unparse_tag()?

(I don't know offhand, just asking)

I have some semi-related (test) changes locally where we do have blind
spots in tag v.s. commit parsing semi-related to this, i.e. in the whole
"unparsed" stage.

So I wonder what happens with a tag that's pointing to a shallow object
that's parsed, but its underlying commit becomes un-parsed.

Or maybe that's impossible, I'm not too familiar with "shallow"...

> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 92948de7a0..ba0a4c5d15 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -170,6 +170,15 @@ test_expect_success 'fetch --update-shallow into a repo with submodules' '
>  	git -C repo-with-sub fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
>  '
>  
> +test_expect_success 'fetch --update-shallow a commit that is also a shallow point into a repo with submodules' '
> +	git init repo-with-unreachable-upstream-shallow &&
> +	git -C repo-with-unreachable-upstream-shallow submodule add ../a-submodule a-submodule &&
> +	git -C repo-with-unreachable-upstream-shallow commit -m "added submodule" &&
> +
> +	SHALLOW=$(cat shallow/.git/shallow) &&
> +	git -C repo-with-unreachable-upstream-shallow fetch --update-shallow ../shallow/.git "$SHALLOW":refs/heads/a-shallow
> +'

Nit: Can this be
e.g. s/repo-with-unreachable-upstream-shallow/repo/. The overly long
repo name makes this much harder to follow. Compare this one which would
clean up after itself too:

	test_when_finished "rm -rf repo" && 
	git init repo &&
	git -C repo submodule add ../a-submodule a-submodule &&
	git -C repo commit -m "added submodule" &&

	SHALLOW=$(cat shallow/.git/shallow) &&
	git -C repo fetch --update-shallow ../shallow/.git "$SHALLOW":refs/heads/a-shallow

(I didn't check if that test really works, i.e. do we have a "repo"
already, but you get the idea...
