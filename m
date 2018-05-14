Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C38A1F51A
	for <e@80x24.org>; Mon, 14 May 2018 02:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeENCdx (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 22:33:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36857 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeENCdw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 22:33:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id n10-v6so12185840wmc.1
        for <git@vger.kernel.org>; Sun, 13 May 2018 19:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uIWQ46yUUO9yZq1hNDaG2sytufwCuXgKM5m8ASF6iCA=;
        b=BJ6zaskrZSsOPrKuFuTE6/onciEI7QYv24Q/eN10/6fvKPNL0+er13WEZboHmey7lQ
         1fi6HzqxNXkV9xvhSi6JerNFu/RhHABOet1N7o5iNPVz1MaS/1pbyUw4nS/FR34zLP5o
         Y5MPJomU1lTi/ThnqOMZTkpuCFjn2g8WvVXD5+PhLLcTHwkuXaFNMupul0yqbdpAmfcH
         PVPamCVHmuXxMnv3geKn0eJ+WJXIq2FwXX2sJ2RvKubjxNsni7AfuD8FaVX0LqhgI5Ob
         PvSKgOKd+Kai8buZY/k9MSbsSINKKFoQbjDxGk8ICvTFKyKl5SKXgzOb1ejBSsZdWgtw
         18lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uIWQ46yUUO9yZq1hNDaG2sytufwCuXgKM5m8ASF6iCA=;
        b=ZCxy4Tq1Gq5fCPYnRnD1GFfEySIak8ggbmvEPD81Cbb8c+EB6T6dFxsKfr1SL8oRS8
         6MkVNQ96Fd9PdwPfpZWWTA0rGUJerGgRzjpha9+Mhl8LZrlvwey2mulvjb1vIsJ++dfB
         MM4Y5SwoV+O+ZgES7kxDiDGMsMVE3L7fN5s+GQ6btjCNGEVz65Z+KYOogM3Oo52CylTo
         Ga9NW9D4QE6kxwJpoHg6VZrq4MH2svCClUhb8THS3OT/BSxs9d4sxONnJZTeirzqkQCx
         dcF/Re6ipGX1cCFksVpNqAleO6EM5QF2UetYTX0gxNjUQaqA5Dqhr1lU2MAdRJNId+77
         V91g==
X-Gm-Message-State: ALKqPweG9FyqezKYqmESNlzEGwZSQOiCKaQsG+PM6j4IU5lK//jY5GlQ
        VsnU6/VitEifyK1V+GSwiqY=
X-Google-Smtp-Source: AB8JxZrTgAur74XR8Wrhf3kDy26WB3YufFcsYBQcukPHKOxiimLPzMYpaL0DbK2NKfIBjDHF8ms7Aw==
X-Received: by 2002:a1c:ef0c:: with SMTP id n12-v6mr4186446wmh.123.1526265231098;
        Sun, 13 May 2018 19:33:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t14-v6sm9254398wrm.82.2018.05.13.19.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 19:33:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] apply: add --intent-to-add
References: <20180513175438.32152-1-pclouds@gmail.com>
        <20180513175438.32152-2-pclouds@gmail.com>
Date:   Mon, 14 May 2018 11:33:48 +0900
In-Reply-To: <20180513175438.32152-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 19:54:38 +0200")
Message-ID: <xmqqo9hjc6er.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Similar to 'git reset -N', this option makes 'git apply' automatically
> mark new files as intent-to-add so they are visible in the following
> 'git diff' command and could also be committed with 'git commit -a'.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/git-apply.txt |  9 ++++++++-
>  apply.c                     | 38 +++++++++++++++++++++++++++++++------
>  apply.h                     |  1 +
>  t/t2203-add-intent.sh       | 12 ++++++++++++
>  4 files changed, 53 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index 4ebc3d3271..2374f64b51 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -9,7 +9,7 @@ git-apply - Apply a patch to files and/or to the index
>  SYNOPSIS
>  --------
>  [verse]
> -'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
> +'git apply' [--stat] [--numstat] [--summary] [--check] [--index | --intent-to-add] [--3way]
>  	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
>  	  [--allow-binary-replacement | --binary] [--reject] [-z]
>  	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
> @@ -74,6 +74,13 @@ OPTIONS
>  	cached data, apply the patch, and store the result in the index
>  	without using the working tree. This implies `--index`.
>  
> +--intent-to-add::
> +	When applying the patch only to the working tree, mark new
> +	files to be added to the index later (see `--intent-to-add`
> +	option in linkgit:git-add[1]). This option is ignored if
> +	`--index` is present or the command is not run in a Git
> +	repository.

It may make sense to make it incompatible with "--index" like you
did, but how does this interact with "--cached" or "--3way"?  It is
unclear from the above documentation.

> diff --git a/apply.c b/apply.c
> index 7e5792c996..31d3e50401 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -136,6 +136,8 @@ int check_apply_state(struct apply_state *state, int force_apply)
>  		state->apply = 0;
>  	if (state->check_index && is_not_gitdir)
>  		return error(_("--index outside a repository"));
> +	if (state->set_ita && is_not_gitdir)
> +		state->set_ita = 0;

I think this should error out, just like one line above does.
"I-t-a" is impossible without having the index, just like "--index"
is impossible without having the index.

> @@ -4265,9 +4267,6 @@ static int add_index_file(struct apply_state *state,
>  	int namelen = strlen(path);
>  	unsigned ce_size = cache_entry_size(namelen);
>  
> -	if (!state->update_index)
> -		return 0;
> -

OK, with this change, only "index-affecting" mode will call into the
function, in the first place.  The current code was wasteful in that
the caller always called and forced this function to do a few useless
computation before it realized that it is not going to touch the index
at all.

> @@ -4305,6 +4304,27 @@ static int add_index_file(struct apply_state *state,
>  	return 0;
>  }
>  
> +static int add_ita_file(struct apply_state *state,
> +			const char *path, unsigned mode)
> +{
> +	struct cache_entry *ce;
> +	int namelen = strlen(path);
> +	unsigned ce_size = cache_entry_size(namelen);
> +
> +	ce = xcalloc(1, ce_size);
> +	memcpy(ce->name, path, namelen);
> +	ce->ce_mode = create_ce_mode(mode);
> +	ce->ce_flags = create_ce_flags(0) | CE_INTENT_TO_ADD;
> +	ce->ce_namelen = namelen;
> +	set_object_name_for_intent_to_add_entry(ce);
> +	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
> +		free(ce);
> +		return error(_("unable to add cache entry for %s"), path);
> +	}
> +
> +	return 0;
> +}

It is somewhat unsatisfactory that we need a whole new function to
record a new path in the index.  IOW, I have a feeling that a bit of
refactoring of add_index_file() should allow us to share more code
between it and this new function.

> @@ -4465,8 +4485,11 @@ static int create_file(struct apply_state *state, struct patch *patch)
>  
>  	if (patch->conflicted_threeway)
>  		return add_conflicted_stages_file(state, patch);
> -	else
> +	else if (state->update_index)
>  		return add_index_file(state, path, mode, buf, size);
> +	else if (state->set_ita)
> +		return add_ita_file(state, path, mode);
> +	return 0;

It is very unfortunate that you need to do (update_index||set_ita)
everywhere else only bevause you want to do this else/if cascade.
I'd rather redefine the bits to mean

    - update-index: we will do something that touches the index
      (hence we need to have the repository, we need to lock the
      index, etc.).

    - ita-only: changes to the existing paths are only reflected to
      the working tree, but new paths are added to the index as
      i-t-a entries.

and make add_index_file() more intelligent, without having to add a
new add_ita_file().

Of course, setting only ita-only without setting update-index is an
inconsistent state.  "--index" would set only update-index, "--ita"
would set both, "--ita --index" would either be an error, or set
only update-index and clear ita-only if we adopt "last one wins"
semantics.

