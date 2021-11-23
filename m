Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB51DC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 23:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhKWXNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhKWXNs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 18:13:48 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2E4C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 15:10:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e12-20020aa7980c000000b0049fa3fc29d0so362580pfl.10
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RUYIXehBmXuEt13dd05mFmdc1GICBJJwax5TbMI5qAU=;
        b=i7qYsgBq5HejLITwOfC6jSUNHHcwJjli2X/xA13Y7grSLpY5sGtDSXsAD87J1he6BI
         9jDrR/LBnKzfMf+2zTh56L2WEw6Z5szcbzbFLQfKTNHUh6fB9zy/BZezS+u3K1vrpTQE
         SfoRC4ioOJhrf+/DnKyulFvegfx2hvAC2GkeKQ1nPKcjYFvj+Nn7e69fqGvaYK4zpl/d
         oq47a3fxobvfGa62mifKU0QfgIdDOflpgIwd4FL0ezhtiI3BzGFn9mTUuCLX59po7P0r
         NOfKw15cHC1H/ZK69A6igxEm8Zy6ry7MHK7BhGcCvu+ohA/3VwtEfIRElvE0ppSfe9nH
         Vsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RUYIXehBmXuEt13dd05mFmdc1GICBJJwax5TbMI5qAU=;
        b=ObYfWfENjrQEfp68ZC9c034chmt69K45UWSjTlbi8MhmQX2goPvpMWwrf6F9I6d0uw
         ZqcnMIByAD/4Tuq2xPa6SVmROI/UPVBF/ZOU2kViUbegJCuC45maq5+Q70Cz/B2vV4T4
         UW+7nVEMDPk7+C0soWZriZLNRjPznXVW19k3n0eoix6c8X93Z7cuCuzhFvogE8gCfcQm
         043/TCiBX2PAkh83RusEj0y9zgoPkNzRBahFrVwncm9tih0cnde9aRMISJMm626z2YFR
         uaKVkD6WkG1Z31Mj6HmCAVBaU8KI/NPj24d9Gg8J8xoN6vuOZOONFFP0UCEHiZrxw9ZU
         B07A==
X-Gm-Message-State: AOAM530Wos6tguydy2VRRiiWUhFllPbMUxbNwtQvcGw7LvMGZmyyO2pB
        GV9kMN0W3WmMUnNhvUM5o7LwuMnVQKuhxB0hfqJ3
X-Google-Smtp-Source: ABdhPJx9Rw5LC9C1/bMxN8yhO2BFjrzJba2Cr7IVHMtJRvmhZh5MwKS4yPeAJ7cfms18fw1Q/GBFWscw+DxNC2I5FBdM
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1486:: with SMTP id
 js6mr46237pjb.0.1637709038622; Tue, 23 Nov 2021 15:10:38 -0800 (PST)
Date:   Tue, 23 Nov 2021 15:10:35 -0800
In-Reply-To: <20211122223252.19922-4-chooglen@google.com>
Message-Id: <20211123231035.3607109-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211122223252.19922-4-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: Re: [PATCH 3/4] branch: add --dry-run option to branch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> When running "git branch --recurse-submodules topic"

At this point, this argument has not been introduced yet, so better to
just say "A future patch will introduce branch creation that recurses
into submodules, so..."

> +-n::
> +--dry-run::
> +	Can only be used when creating a branch. If the branch creation
> +	would fail, show the relevant error message. If the branch
> +	creation would succeed, show nothing.

Right now we only plan to use this internally so it's not worth using a
single character argument for this right now, I think. We can always add
it later if we find it useful.

> -	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
> -	    list + edit_description + unset_upstream > 1)
> +	create = 1 - (!!delete + !!rename + !!copy + !!new_upstream +
> +		      !!show_current + !!list + !!edit_description +
> +		      !!unset_upstream);
> +	if (create < 0)
>  		usage_with_options(builtin_branch_usage, options);

Hmm...I think it would be clearer just to call it noncreate_options and
print usage if it is greater than 1. Then whenever you want to check if
it's create, check `!noncreate_options` instead.

> @@ -852,10 +862,20 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		if (track == BRANCH_TRACK_OVERRIDE)
>  			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
>  
> -		create_branch(the_repository,
> -			      argv[0], (argc == 2) ? argv[1] : head,
> -			      force, 0, reflog, quiet, track);
> +		if (dry_run) {
> +			struct strbuf buf = STRBUF_INIT;
> +			char *unused_full_ref;
> +			struct object_id unused_oid;
>  
> +			validate_new_branchname(branch_name, &buf, force);
> +			validate_branch_start(the_repository, start_name, track,
> +					      &unused_oid, &unused_full_ref);
> +			strbuf_release(&buf);
> +			FREE_AND_NULL(unused_full_ref);
> +			return 0;
> +		}
> +		create_branch(the_repository, branch_name, start_name, force, 0,
> +			      reflog, quiet, track);
>  	} else
>  		usage_with_options(builtin_branch_usage, options);
>  

I don't think we should use separate code paths for the dry run and the
regular run - could create_branch() take a dry_run parameter instead?
(If there are too many boolean parameters, it might be time to convert
some or all to a struct.)

This suggestion would require a reworking of patch 2, which is why I
didn't comment there. But if we are not going to use this suggestion and
are going to stick with patch 2, then my comment on it is that it seems
to be doing too much: I ran "git show --color-moved" on it and saw that
quite a few lines were newly introduced (not just moved around).
