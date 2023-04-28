Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95130C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 20:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346108AbjD1UWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjD1UWl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 16:22:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8879E93
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:22:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so193080a12.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682713359; x=1685305359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WcpKXLk63EZTkJ0V0qO4XE3pL377es7NyOMtvqTVBfI=;
        b=qaP8bUNX30ACLMnXKkkTOpKP55Tm4oEwsp4metHpFRk61oWMbJWU+Ug1ZQ+15QfZYG
         aXpm0w/8Ck105z0D1Nfi8e/jBO/4o7dT3RZLCkWZQKu1ewZcBfiaW7LGswL7zhxxglXc
         RFMeDHYj9oUv09Sih7fCYNikWHxRE0MI3L4SbFqCJjRtXnnwhZj96kfvq55EwKL0fOAC
         qeWi4V8CLjlSSi/6VGR50NhOavjqjuxrAHERATyzpiknCU0WyCiMI5+wMbhXbWF6ZrOb
         ml1RxPH2uBDXFT4rAQxtyQwO/WG4FGKednNpHUrff+zCLpFkgBwd1Ms+gNPZ2M9ruL3h
         ep6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682713359; x=1685305359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcpKXLk63EZTkJ0V0qO4XE3pL377es7NyOMtvqTVBfI=;
        b=G6upnO7TuFWxXj6axNdPrdz0iszXtGHGwrY4tKXxnkYAp1GtAvFb11vPX3FRqcACJr
         pcyIrQ2GeffXBWnFlx34UdYQdLmX6YVjxOdbHp+xIl6+j6Tn4d+621WxIsHglKrX/Xo0
         dNxwHl3Nx+UmzHZfTV2qkFrrFaNeYgjZpS4qoatsDdP8r9HpUT58agdY14a6vsnF7j+l
         qlVP9lFn+2CsUgPTYIpeI+V4bWh8JTLKyStoJ5Y4wWNmFRe734NR3NUiuFRhOrIwZq+T
         3gUvPPqrTgvBguCtYOJm1Db2XQZCWdaL+1hDeMNqDEmC4+JyfvRVR1Alg9ztsZSwu0Dh
         zwSg==
X-Gm-Message-State: AC+VfDyZXdjCfPOC/SR1KU4o5JhY5ISgz4dFq1iQLiQN2OQthXTvuePc
        H455pqORn+WI9qui0mQya2IN0Fm5HHSO0/F9HKJTWXYTe4T6FA==
X-Google-Smtp-Source: ACHHUZ7rMwy4LzJB9vMsIWfGMdfe9D9spwfzerTDtWYsAPmcFqpUSn9x7vCc9nZWl7LRtIJwaTDDQPqMLOkPEU1T5ro=
X-Received: by 2002:a17:906:4fd6:b0:95f:6517:b965 with SMTP id
 i22-20020a1709064fd600b0095f6517b965mr6682062ejw.10.1682713358610; Fri, 28
 Apr 2023 13:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1470.v2.git.git.1679936543320.gitgitgadget@gmail.com> <pull.1470.v3.git.git.1682707848916.gitgitgadget@gmail.com>
In-Reply-To: <pull.1470.v3.git.git.1682707848916.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 28 Apr 2023 22:22:26 +0200
Message-ID: <CAP8UFD0mfb1HSUGT3Bz1gHhH3fMpGDnMHVf2pT0CjirL0C5zuA@mail.gmail.com>
Subject: Re: [PATCH v3] attr: teach "--attr-source=<tree>" global option to "git"
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>       +--attr-source=<tree-ish>::
>      -+ Read gitattributes from <tree-ish> instead of the worktree.
>      ++ Read gitattributes from <tree-ish> instead of the worktree. See
>      ++ linkgit:gitrevisions[7].

I think it's more sensible to link to gitattributes(5) instead of
gitrevisions(7)

> +static const char *default_attr_source_tree_object_name;
> +
> +void set_git_attr_source(const char *tree_object_name)
> +{
> +       default_attr_source_tree_object_name = xstrdup(tree_object_name);
> +}
> +
> +

One empty line is enough here.

> +static void compute_default_attr_source(struct object_id *attr_source)
> +{
> +       int from_env = 0;
> +
> +       if (!default_attr_source_tree_object_name) {
> +               default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE);
> +               from_env = 1;
> +       }
> +
> +       if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
> +               return;
> +
> +       if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source)) {
> +               if (from_env)
> +                       die(_("bad --attr-source object"));
> +               else
> +                       die(_("bad GIT_ATTR_SOURCE"));

I think it would be better to have just the following instead of the 4
lines above:

die(_("invalid tree object from --attr-source flag or GIT_ATTR_SOURCE
env variable"));

as a bad GIT_ATTR_SOURCE in a subprocess could come from a bad
--attr-source in the main process.

And this way the from_env variable is not needed.

> +       }
> +}

The rest looks good to me, thanks!
