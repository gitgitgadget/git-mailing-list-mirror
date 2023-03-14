Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7878DC74A44
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 19:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCNTiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCNTin (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 15:38:43 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6140C10A94
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 12:38:41 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id op8so12991485qvb.11
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678822720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t64NRJ+Y8bgJCQK2tFTsb3aIVj/pMMfw/aWfYDmYkag=;
        b=B1V4FxGNq7WJcaXrNL4jgAV9eM4jJTvOQxgLDY55CD3G3GgSQu3pwjE7v/RM2D5NHi
         EWXDOK2kZrSRb177nnnBAQ8r0BN6QL4GmurCjeK5jDWL6ZZF6quITFwC+i/9J/yLEaEO
         rtgj0kpGeOONaoOWfaDYRzRE/m5j1G5epwAxRNQH93Zg4c1mjHY44H9bfzearuKDMa2p
         ym54VjlzM4suSiWJ9RA5ax/4B09PSWxkk9gKvDXW4XCjv8J/hrx8XXusmEuwvzl7B2Zv
         B5lC98PP81e4p9EbAu/bz0/TJUBt07he0S6CD9xJJS1/jXfuIRJX0OspzK10IcdPrsjD
         Tyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678822720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t64NRJ+Y8bgJCQK2tFTsb3aIVj/pMMfw/aWfYDmYkag=;
        b=IL7nGY0W/o7DG3HS7pMLXAcVLcqI9POUE6eWAjNEQhhDrkeX3CYwtmrLAODYpg3iN6
         uGzUiPW1AKuqgTko31q2MBjwnUrHh4Fu27cJJtK+LwCatw1zuF6QZT+OcW0Iilx/LUgR
         cL9iO8vLuOf5lCIo9a6sAa7mG8wGmOxl9idUwPehneQsLyKYTA8L79+DlK3E7w6SMI0P
         mZ1KSmmzmjBT3dfjYqUtW7X3xU0/b3utssKC0zhqAAs5I0mgjtfpFTu9uiMaPYhDBxv+
         rYXuhqAVhfDkRGo4iXupH4jXR+jLQGfNw3sYN6uGqBo8uHBcDPE8HNJB2QKBBulM12pL
         a+iA==
X-Gm-Message-State: AO0yUKW1yKFDX5/Yzd6sVCNOhJIql8y9Qs3PtSywHADSwcR19U5ofx6S
        P0xQfuz1uOlWRd5R+sXnuAFAGXgK9Zz07A==
X-Google-Smtp-Source: AK7set9JKp4SXwthsCqb5ZTsaGem5+/dtNKcK7QmpxoebhprFe6HJ80i7p3d9YRA4h4g8NeLzfU8zg==
X-Received: by 2002:a05:622a:1cb:b0:3bf:f7d0:9ba9 with SMTP id t11-20020a05622a01cb00b003bff7d09ba9mr28812766qtw.5.1678822720489;
        Tue, 14 Mar 2023 12:38:40 -0700 (PDT)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id 185-20020a3706c2000000b0070648cf78bdsm2350520qkg.54.2023.03.14.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:38:40 -0700 (PDT)
Date:   Tue, 14 Mar 2023 15:38:39 -0400
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: use HEAD for attributes when using bare
 repository
Message-ID: <20230314193839.wevenngf324pijhb@pop-os>
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
 <0fc704cf1c0724473a61086098d44c3a82938b03.1678758818.git.gitgitgadget@gmail.com>
 <xmqqttynqnnj.fsf@gitster.g>
 <xmqqa60fqld6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa60fqld6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/03/14 10:43AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

Hi Junio,

> 
> > Since referring to in-tree attributes is often useful with any
> > command, not limited to "diff", I wonder if it is feasible to add
> > support for the --attr-source=<tree> option globally, instead of
> > implementing such an option piecemeal.  If your "git diff" in a bare
> > repository starts honoring attributes recorded in HEAD, don't your
> > users expect your "git log" and "git show" to also honor them?
> 
> Just for illustration, here is one way to do so.
> 
> The implementation goes in the opposite direction from the more
> recent trend, which is why I am not making it an official patch, but

Could you explain why this goes against the "more recent trend" for my
understanding?

> with this you can do things like:
> 
>   $ git --attr-source=e83c5163 check-attr whitespace cache.h
>   cache.h: whitespace: unspecified
>   $ git --attr-source=e2f6331a142^ check-attr whitespace cache.h
>   cache.h: whitespace: set
>   $ git --attr-source=HEAD check-attr whitespace cache.h
>   cache.h: whitespace: indent,trail,space

I like the idea of an option that is global. For git-check-attr however, we
already have a --source option. Not sure how big of a deal that is. If we wanted
to, we could put --source on a deprecation path by making it hidden for a
while, etc.

> 
> where e83c5163 is the very first version of Git from 2005 where
> .gitattributes did not exist, e2f6331a142^ is the last version
> before we set whitespace to indent,trail,space, and HEAD is a more
> recent version of our source tree.
> 
> In the following illustration patch, the attr-source tree object
> name is kept as a string as long as possible and at the very last
> minute when we call git_check_attr() for the first time we turn it
> into an object id.  This is because at the very early stage when we
> parse the global option we may not even know where our repository is
> (hence do not have enough information to parse HEAD).  We also figure
> out is_bare_repository() late in the process for the same reason.
> 
> 
> 
>  attr.c | 29 +++++++++++++++++++++++++++++
>  attr.h |  6 ++++++
>  git.c  |  3 +++
>  3 files changed, 38 insertions(+)
> 
> diff --git c/attr.c w/attr.c
> index 1053dfcd4b..2fd6e0eab2 100644
> --- c/attr.c
> +++ w/attr.c
> @@ -1165,12 +1165,41 @@ static void collect_some_attrs(struct index_state *istate,
>  	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
>  }
>  
> +static const char *default_attr_source_tree_object_name;
> +
> +void set_git_attr_source(const char *tree_object_name)
> +{
> +	default_attr_source_tree_object_name = xstrdup(tree_object_name);
> +}
> +
> +
> +static struct object_id *default_attr_source(void)
> +{
> +	static struct object_id attr_source;
> +
> +	if (is_null_oid(&attr_source)) {
> +		if (!default_attr_source_tree_object_name &&
> +		    is_bare_repository())
> +			default_attr_source_tree_object_name = "HEAD";
> +
> +		if (default_attr_source_tree_object_name &&
> +		    is_null_oid(&attr_source))
> +			get_oid(default_attr_source_tree_object_name, &attr_source);
> +	}
> +	if (is_null_oid(&attr_source))
> +		return NULL;
> +	return &attr_source;
> +}
> +
>  void git_check_attr(struct index_state *istate,
>  		    const struct object_id *tree_oid, const char *path,
>  		    struct attr_check *check)
>  {
>  	int i;
>  
> +	if (!tree_oid)
> +		tree_oid = default_attr_source();
> +
>  	collect_some_attrs(istate, tree_oid, path, check);
>  
>  	for (i = 0; i < check->nr; i++) {
> diff --git c/attr.h w/attr.h
> index 9884ea2bc6..a77e3713b2 100644
> --- c/attr.h
> +++ w/attr.h
> @@ -135,6 +135,12 @@ struct git_attr;
>  struct all_attrs_item;
>  struct attr_stack;
>  
> +/*
> + * The textual object name for the tree-ish used by git_check_attr()
> + * when NULL is given to tree_oid.
> + */
> +void set_git_attr_source(const char *);
> +
>  /*
>   * Given a string, return the gitattribute object that
>   * corresponds to it.
> diff --git c/git.c w/git.c
> index 6171fd6769..21bddc5718 100644
> --- c/git.c
> +++ w/git.c
> @@ -4,6 +4,7 @@
>  #include "help.h"
>  #include "run-command.h"
>  #include "alias.h"
> +#include "attr.h"
>  #include "shallow.h"
>  
>  #define RUN_SETUP		(1<<0)
> @@ -307,6 +308,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			} else {
>  				exit(list_cmds(cmd));
>  			}
> +		} else if (skip_prefix(cmd, "--attr-source=", &cmd)) {
> +			set_git_attr_source(cmd);
>  		} else {
>  			fprintf(stderr, _("unknown option: %s\n"), cmd);
>  			usage(git_usage_string);
