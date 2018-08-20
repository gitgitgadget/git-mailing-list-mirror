Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286571F954
	for <e@80x24.org>; Mon, 20 Aug 2018 15:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeHTTLm (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 15:11:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39425 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeHTTLm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 15:11:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so8019wmq.4
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pXw5pFuGZFrFIWokTiQRVC7m9GFQpUtELUwT5Fc+md0=;
        b=pjPC4ImcvMT8xlOCZnlSrDsoZzxJs1mqJhYTaxYspCmubEd/LIZEMmapsAXK0oNYPW
         xDOddOWVMvGcQ7rgs6RPYj1F/D35TPz34I/DzZaDHbuQ30H3sJKVEcTeO3bnF5h2otBv
         ih+qkONAaE0YLxDeBhdHty9wO45cNLz9PQ0LWTPzjS7Q/cOoyc5gKaZQQ7QTyZi0pH8b
         9RiU7X2iC/MNdMJ9Q8VSBRkvqg2r2fMVoJlxzNTFpSdmIyhA5VwCdoYYGnbk/qOHH0EF
         rYyHRe3DgLB7SjnDDdmfe0gPaKPpAbL6TfIbEwFSYqls/LvD1TTPphCHCfSnBRlpn90M
         +gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pXw5pFuGZFrFIWokTiQRVC7m9GFQpUtELUwT5Fc+md0=;
        b=tfy22XoDVJScNF4wdDmB+xiB9nibaQbGcYE+yFnh6VYM30FmrZDjus3a/EVETXmAFp
         K+PWXd6kNeNWe3kcQfT9PerJxjElRmptLhz4/wsgZS65B/a3FIeXbJqNRO3ZT4/sJWFv
         zbihwRubSld6rK/cJ7LNHAskkocvPlesMlSFd2/U9MyEslHK5zkuuGn04pRDPBnNW0HK
         TTPXQ4Pc35sfH4HSA0H0RrmVqSRL8xAkoQBCGNdPbVx/YA60vx8ZW1d+dYIlHmwjl8DP
         Z+m7fSopuHvV7Y1hWQ6ELcBrOAiwswzB9k/SBEEMEAS1FvMQZMelTJL5BYperRXdU42L
         fF0g==
X-Gm-Message-State: APzg51CsIDuqclVnRLB8MdNNQFr09LZ/n+7zlgrcXXE02bd03goxzakG
        FeckTgVIRwRlwex2CWr+SGA=
X-Google-Smtp-Source: ANB0VdYtjb/oxiA0AWBgY4Fvy40Ll6oUiEjkIGK+wmwFzzsjFU4ky5sdMGZ/9I1nWzfb9HLVGiqvFg==
X-Received: by 2002:a1c:1bca:: with SMTP id b193-v6mr4124wmb.6.1534780529146;
        Mon, 20 Aug 2018 08:55:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r8-v6sm8083682wmh.37.2018.08.20.08.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 08:55:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already staged
References: <20180820154120.19297-1-pclouds@gmail.com>
Date:   Mon, 20 Aug 2018 08:55:28 -0700
In-Reply-To: <20180820154120.19297-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 20 Aug 2018 17:41:20 +0200")
Message-ID: <xmqqwoslav7z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +commit.preciousDirtyIndex::
> +	If some changes are partially staged in the index (i.e.
> +	"git commit -a" and "git commit" commit different changes), reject
> +	"git commit -a".

Or perhaps better yet, go into yes/no interaction to confirm if you
have access to interactive terminal at fd #0/#1, perhaps?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 213fca2d8e..489e4b9f50 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -98,6 +98,7 @@ static const char *author_message, *author_message_buffer;
>  static char *edit_message, *use_message;
>  static char *fixup_message, *squash_message;
>  static int all, also, interactive, patch_interactive, only, amend, signoff;
> +static int allow_dirty_index = 1;
>  static int edit_flag = -1; /* unspecified */
>  static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
>  static int config_commit_verbose = -1; /* unspecified */
> @@ -385,10 +386,24 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>  	 * (B) on failure, rollback the real index.
>  	 */
>  	if (all || (also && pathspec.nr)) {
> +		int compare_oid = all && !allow_dirty_index;
> +		struct object_id previous_oid;
> +
> +		if (compare_oid) {
> +			if (update_main_cache_tree(0) || !the_index.cache_tree)
> +				die(_("error building trees"));

Hmph, when we conclude a conflicted merge with "commit -a", wouldn't
we fail to compute the "before" picture, with higher-stage entries
stil in the index?

> +			if (the_index.cache_tree->entry_count >= 0)
> +				oidcpy(&previous_oid, &the_index.cache_tree->oid);
> +			else
> +				oidclr(&previous_oid);

The cache-tree covers no entry, meaning the index has no cache
entries?  Shouldn't we setting EMPTY_TREE_SHA1_BIN or something
instead?

> +		}
>  		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
>  		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
>  		refresh_cache_or_die(refresh_flags);
>  		update_main_cache_tree(WRITE_TREE_SILENT);
> +		if (compare_oid && the_index.cache_tree &&
> +		    oidcmp(&previous_oid, &the_index.cache_tree->oid))
> +			die(_("staged content is different, aborting"));

I was hoping that it is an easy change to teach add_files_to_cache()
to report how many paths it actually has "added" (modifications and
removals are of course also counted), which allows us not to waste
computing a throw-away tree object once more.

There only are three existing callers to the function, and only one
of them rely on the current "non-zero is error, zero is good"
semantics, so updating that caller (and perhaps vetting the other
callers to see if they also _should_ pay attention to the return
value, at least to detect errors of not number of paths updated)
shouldn't be that much more effort, and would be a good update to
the API regardless of this new feature, I would think.

>  		if (write_locked_index(&the_index, &index_lock, 0))
>  			die(_("unable to write new_index file"));
>  		commit_style = COMMIT_NORMAL;
> @@ -1413,6 +1428,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
>  		return 0;
>  	}
> +	if (!strcmp(k, "commit.preciousdirtyindex")) {
> +		allow_dirty_index = !git_config_bool(k, v);
> +		return 0;
> +	}
>  
>  	status = git_gpg_config(k, v, NULL);
>  	if (status)
