Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46489ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiISQk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiISQkz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:40:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690D324BD8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:40:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FAD614E2E3;
        Mon, 19 Sep 2022 12:40:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NwYB3qqOLHoJdwBsojHCurOxny2AfTKP/GwCLW
        HOWX0=; b=sxVoaQvkGzaLjcY/TiPrlGRAzfRLmf7zWteAaGDuYwbOcEmZ3dRK+2
        8Zgs8jhhUDIfpFo+EFyODzBlTQi+VMatQOj7CmpWzvopdzjc8QnG7aNusZGm3mdn
        +rgnO9dVmYZS/oGN0aFtx32ycxu20PUq27DdSvTMi1zdlKSvQMp1c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9404C14E2E2;
        Mon, 19 Sep 2022 12:40:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 093E914E2E1;
        Mon, 19 Sep 2022 12:40:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Arthur Chan <arthur.chan@adalogics.com>,
        Josh Steadmon <steadmon@google.com>,
        David Korczynski <david@adalogics.com>
Subject: Re: [PATCH v4] fuzz: reorganise the path for existing oss-fuzz fuzzers
References: <pull.1353.v3.git.1663542495094.gitgitgadget@gmail.com>
        <pull.1353.v4.git.1663598215154.gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 09:40:51 -0700
In-Reply-To: <pull.1353.v4.git.1663598215154.gitgitgadget@gmail.com> (Arthur
        Chan via GitGitGadget's message of "Mon, 19 Sep 2022 14:36:54 +0000")
Message-ID: <xmqq7d1zco6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2E00596-3839-11ED-9953-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Arthur Chan <arthur.chan@adalogics.com>
>
> This patch is aimed to provide a better organisation for oss-fuzz
> fuzzers and to avoid top-level clustters in the git repository when
> more fuzzers are introduced. In addition, grouping the fuzzers into
> their own directory separate their application on fuzz-testing from
> the core functionalities of the git code. It also provide better
> and tidier structure the oss-fuzz fuzzing library to manage, locate,
> build and execute those fuzzers for fuzz-testing purposes in future
> development.
>
> A new direrctory oss-fuzz has been created and existing fuzzers are
> moved into the new directory. Makefile and .gitignore have been
> fixed accordingly.
>
> CC: Josh Steadmon <steadmon@google.com>
> CC: David Korczynski <david@adalogics.com>

If you mean to tell these people about your work, write these lines
on the header of your outgoing e-mail (or instruct GitGitGadget to
do so), not here (if writing them here is the only way to instruct
GGG to do so then I wouldn't object, but apparently that is not
happening and I had to add them manually to this message.

Thanks.

> Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
> ---
>     fuzz: reorganise the path for existing oss-fuzz fuzzers
>     
>     This patch is aimed to provide a better organisation for oss-fuzz
>     fuzzers and to avoid top-level clustters in the git repository when more
>     fuzzers are introduced. In addition, grouping the fuzzers into their own
>     directory separate their application on fuzz-testing from the core
>     functionalities of the git code. It also provide better and tidier
>     structure the oss-fuzz fuzzing library to manage, locate, build and
>     execute those fuzzers for fuzz-testing purposes in future development.
>     
>     A new direrctory oss-fuzz has been created and existing fuzzers are
>     moved into the new directory. Makefile and .gitignore have been fixed
>     accordingly.
>     
>     Create new .gitignore file for the new directory in v4 and fix the
>     commit message.
>     
>     CC: Josh Steadmon steadmon@google.com CC: David Korczynski
>     david@adalogics.com Signed-off-by: Arthur Chan arthur.chan@adalogics.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1353%2Farthurscchan%2Frelocate-fuzzer-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1353/arthurscchan/relocate-fuzzer-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1353
>
> Range-diff vs v3:
>
>  1:  21714e583aa ! 1:  82d9568ea65 fuzz: reorganise the path for existing oss-fuzz fuzzers
>      @@ Commit message
>           fuzz: reorganise the path for existing oss-fuzz fuzzers
>       
>           This patch is aimed to provide a better organisation for oss-fuzz
>      -    fuzzers, allowing more fuzzers for the git project to be added
>      -    in later development.
>      +    fuzzers and to avoid top-level clustters in the git repository when
>      +    more fuzzers are introduced. In addition, grouping the fuzzers into
>      +    their own directory separate their application on fuzz-testing from
>      +    the core functionalities of the git code. It also provide better
>      +    and tidier structure the oss-fuzz fuzzing library to manage, locate,
>      +    build and execute those fuzzers for fuzz-testing purposes in future
>      +    development.
>       
>           A new direrctory oss-fuzz has been created and existing fuzzers are
>           moved into the new directory. Makefile and .gitignore have been
>      @@ Commit message
>        ## .gitignore ##
>       @@
>       -/fuzz-commit-graph
>      -+/oss-fuzz/fuzz-commit-graph
>        /fuzz_corpora
>       -/fuzz-pack-headers
>       -/fuzz-pack-idx
>      -+/oss-fuzz/fuzz-pack-headers
>      -+/oss-fuzz/fuzz-pack-idx
>        /GIT-BUILD-OPTIONS
>        /GIT-CFLAGS
>        /GIT-LDFLAGS
>      @@ Makefile: SCRIPTS = $(SCRIPT_SH_GEN) \
>        fuzz-objs: $(FUZZ_OBJS)
>        
>       
>      + ## oss-fuzz/.gitignore (new) ##
>      +@@
>      ++fuzz-commit-graph
>      ++fuzz-pack-headers
>      ++fuzz-pack-idx
>      +
>        ## fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c ##
>       
>        ## fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c ##
>
>
>  .gitignore                                          | 3 ---
>  Makefile                                            | 6 +++---
>  oss-fuzz/.gitignore                                 | 3 +++
>  fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c | 0
>  fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c | 0
>  fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c         | 0
>  6 files changed, 6 insertions(+), 6 deletions(-)
>  create mode 100644 oss-fuzz/.gitignore
>  rename fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c (100%)
>  rename fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c (100%)
>  rename fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c (100%)
>
> diff --git a/.gitignore b/.gitignore
> index 80b530bbed2..ed8b9f04e5c 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,7 +1,4 @@
> -/fuzz-commit-graph
>  /fuzz_corpora
> -/fuzz-pack-headers
> -/fuzz-pack-idx
>  /GIT-BUILD-OPTIONS
>  /GIT-CFLAGS
>  /GIT-LDFLAGS
> diff --git a/Makefile b/Makefile
> index d9247ead45b..2d56aae7a1d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -686,9 +686,9 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
>  
>  ETAGS_TARGET = TAGS
>  
> -FUZZ_OBJS += fuzz-commit-graph.o
> -FUZZ_OBJS += fuzz-pack-headers.o
> -FUZZ_OBJS += fuzz-pack-idx.o
> +FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
> +FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
> +FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
>  .PHONY: fuzz-objs
>  fuzz-objs: $(FUZZ_OBJS)
>  
> diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
> new file mode 100644
> index 00000000000..9acb74412ef
> --- /dev/null
> +++ b/oss-fuzz/.gitignore
> @@ -0,0 +1,3 @@
> +fuzz-commit-graph
> +fuzz-pack-headers
> +fuzz-pack-idx
> diff --git a/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
> similarity index 100%
> rename from fuzz-commit-graph.c
> rename to oss-fuzz/fuzz-commit-graph.c
> diff --git a/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
> similarity index 100%
> rename from fuzz-pack-headers.c
> rename to oss-fuzz/fuzz-pack-headers.c
> diff --git a/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
> similarity index 100%
> rename from fuzz-pack-idx.c
> rename to oss-fuzz/fuzz-pack-idx.c
>
> base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
