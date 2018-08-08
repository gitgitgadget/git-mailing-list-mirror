Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7F71F405
	for <e@80x24.org>; Wed,  8 Aug 2018 23:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeHIBn0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 21:43:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42127 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIBn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 21:43:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id y203-v6so2887265ywd.9
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 16:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfGIqgYkGohynu9v41Pi9FfvQDGErzMy1Ni5gMIW0C0=;
        b=cMWbAE3pI6f7mCz4DdbNN5t9VCxqli/tMvN94osY6jNYLQv9+uKJYAsdU7oj62K+nc
         +orNgplV6sx4XZOxxqAC+D4e+tiwM5H9DTJcmxxPI3+NY2tPLszUoIwNDeuiVGkpRWnM
         nLhCa7x16gUa9T3KwWCId3cTWf3LPc9sfsZuwGwDuEc/JOJc/Ww7Xd5KegpkiTBMuqp3
         JpE6RDOM6rGuNOboFp1wfWSiFfI8VglGCQMUr+/kkk0Gph6Z3GkoHHvJhgrClpiUUmIf
         apjL6CwiQZk0qZp7LRgytKZeaQQtRw9KvS9hlyID6qif8GAIn3CS1Ca4bzBZ2GRaQkFK
         NndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfGIqgYkGohynu9v41Pi9FfvQDGErzMy1Ni5gMIW0C0=;
        b=EM+yf+ayvnaqkz8QKnt1cn/F1MZZCMftGUT02A/XxfXQY9hwRCu3DgynwI/+OMRsxN
         RB0exzkFi/C5mfzML96YgLwHhdvoF6n8eAebJSVxMe8epSwbhN+WcbsX6uTa3AzIyBgE
         saCreSeSvofqdKkai2WSXbpno3VJAwhSs3aDBoVz7SVvj7CWgc0ae3ZqSlu0j8hfYdJn
         0pk9sT1yCvxa3AXuT350nlqckYQmQSpO8ql/1MpBYXSntYAcVLhpuCm/BdHRSheozydC
         noPdpMccUQUQ/PCwNEvWVwTfj+a9vz9etHQF6ASOp0kpnXdEQ31yZm02DFaqOmrr+oEb
         s2UQ==
X-Gm-Message-State: AOUpUlFDvbW4H401nY3MdnW7OFUXZ5YlS5rhQjMS6uQgB6wp198zCTl8
        fr+NzkxMYlFOe7uKKF3TGreXiFtfEIHfPQRVkHXGQg==
X-Google-Smtp-Source: AA+uWPymtGxEFwqQaj/gSCJyr9dwBlWdOgUlwZWwXhP6ETqBk+EXPYjMnecplyZmsGoDkvnD4kM755UZDKDkpjH+BuQ=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr2569298ywj.33.1533770491579;
 Wed, 08 Aug 2018 16:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-2-bmwill@google.com>
In-Reply-To: <20180808223323.79989-2-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Aug 2018 16:21:20 -0700
Message-ID: <CAGZ79kYvM5hxbe9ZCuFt=Cgv9W0mmdwdFGJz6+DdhPv4UbEXjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule: create helper to build paths to submodule gitdirs
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 3:33 PM Brandon Williams <bmwill@google.com> wrote:
>
> Introduce a helper function "submodule_name_to_gitdir()" (and the
> submodule--helper subcommand "gitdir") which constructs a path to a
> submodule's gitdir, located in the provided repository's "modules"
> directory.

Makes sense.

>
> This consolidates the logic needed to build up a path into a
> repository's "modules" directory, abstracting away the fact that
> submodule git directories are stored in a repository's common gitdir.
> This makes it easier to adjust how submodules gitdir are stored in the
> "modules" directory in a future patch.

and yet, all places that we touch were and still are broken for old-style
submodules that have their git directory inside the working tree?
Do we need to pay attention to those, too?


> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8b5ad59bde..053747d290 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh

> @@ -577,7 +578,7 @@ cmd_update()
>                         die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
>                 fi
>
> -               if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
> +               if ! $(git config -f "$(git submodule--helper gitdir "$name")/config" core.worktree) 2>/dev/null

This will collide with origin/sb/submodule-update-in-c specifically
1c866b9831d (submodule--helper: replace connect-gitdir-workingtree
by ensure-core-worktree, 2018-08-03), but as that removes these lines,
it should be easy to resolve the conflict.
