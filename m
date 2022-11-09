Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D16AC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 03:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKIDK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 22:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiKIDKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 22:10:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DB1C909
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 19:10:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v17so25339987edc.8
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 19:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvXIk/Hb/QAoEfnseEJQ0osC7S2HY3RiXiRlfjyoeFc=;
        b=H+mGfMiIduqqj747Czt+bwJ/i1MdQgr06LBeTHyZU8YMcn172J4hQ92J0FN/JB0CgY
         zPBLNsgRb7D/haLugwq7tS9Gi+56L+94kwQVWQYHtYMt3MBlvuXLfZYtkIwC82zM5H1F
         MK+TwOMuvChNAIhg44deP50LlDqaN2YPEonde8M1aFKo7uVanlEGajmEWv1+kQJG//PS
         K65LWf6PNXrd1Ba7GCOUYoceF3H3kHA3EWM0dd8tH0k//vXT77GCPEcTwHwDoJ0zonV4
         iTrfMUjYxat4emVtbG8zNmFTlDx0RcdouU+1Dy5HV/ymJuFAI45+RmG6I5jvcQNkXl5w
         NH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvXIk/Hb/QAoEfnseEJQ0osC7S2HY3RiXiRlfjyoeFc=;
        b=AbAzkVAlMTQ5gofa8IljPUFettu6vmTL6Baf1VGbY5M8tpdTbJ6Xnxcdkv8wN90cwj
         1COo1dOof1nT3rTzd3h33eMKWphh/cEtAhDetZGXSkZ8G1gscAeF65YBoTVNZOmKaCHV
         QL0wiQOp0pGZy326JwFyI49hZFneHY6uOpnwGGTdOVphH2Cf1mxM9Rxj8vmZKRXvXRFv
         BsuvHA+NWW0ipCFphF8dSOomCaqi6RcfkM+MM3flRqdmiyfQegqtk4Moeue80EdALbuB
         uNyUcUIX6+TW3niFFOxXc5QT5/lU0ghxtPJWU2rj4bZHBUVjFnWBAPIka1Tf51/WpXXI
         94tA==
X-Gm-Message-State: ACrzQf1JwEk4Gortt/sdNs7fitbKrpZVcdCgA/oIKXCcTJvkHg1QqE6/
        pWtg0Rdnwy8GL0kOZyQqhtLxKvKr1DHzHQ==
X-Google-Smtp-Source: AMsMyM43jjavcalyxKYi7Ps37w3vMdy7kV7ox67AoA3aVGVe+36eYoXbkBqpdmf7/92y5JeSvNzKDQ==
X-Received: by 2002:a05:6402:a47:b0:462:a70e:31a6 with SMTP id bt7-20020a0564020a4700b00462a70e31a6mr57725678edb.233.1667963453551;
        Tue, 08 Nov 2022 19:10:53 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id mf23-20020a170906cb9700b007ad86f86b4fsm5361232ejb.69.2022.11.08.19.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:10:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osbUK-000orR-1z;
        Wed, 09 Nov 2022 04:10:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] fetch: refactor --submodule-prefix
Date:   Wed, 09 Nov 2022 04:06:45 +0100
References: <20221109004708.97668-1-chooglen@google.com>
 <20221109004708.97668-3-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221109004708.97668-3-chooglen@google.com>
Message-ID: <221109.8635asrfer.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Glen Choo wrote:

> Since we've previously documented that repository.submodule_prefix is
> only set for submodules, introduce repository.is_submodule for
> distinguishing between the_repository and a submodule (although, this
> turns out to be unused, since no caller uses repository.submodule_prefix
> for that purpose).

There's more to chew on here, but just briefly on this:

> diff --git a/repository.c b/repository.c
> index 5d166b692c..1d454a0ac4 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -229,6 +229,7 @@ int repo_submodule_init(struct repository *subrepo,
>  		}
>  	}
>  
> +	subrepo->is_submodule = 1;
>  	subrepo->submodule_prefix = xstrfmt("%s%s/",
>  					    superproject->submodule_prefix ?
>  					    superproject->submodule_prefix :
> diff --git a/repository.h b/repository.h
> index 24316ac944..1bc4afc2b6 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -119,10 +119,15 @@ struct repository {
>  	 */
>  	char *worktree;
>  
> +	/*
> +	 * Whether this struct represents a submodule of this process's main
> +	 * repository.
> +	 */
> +	int is_submodule;
> +
>  	/*
>  	 * Path from the root of the top-level superproject down to this
> -	 * repository.  This is only non-NULL if the repository is initialized
> -	 * as a submodule of another repository.
> +	 * repository.
>  	 */
>  	char *submodule_prefix;
>  

Just deleting that "is_submodule" header addition and the assignment you
added on top of 4/4 has this series compile. So "this turns out to be
unused" ... because it's added here, but never used? So why do we need
to add it?
