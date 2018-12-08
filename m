Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E4520A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 06:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeLHGoc (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 01:44:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56099 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHGoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 01:44:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E6A219A68;
        Sat,  8 Dec 2018 01:44:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TJnO7GOl3SnfEMoBIC5bzgSgwjA=; b=lGVgA2
        hKZMxeVpeQxSTjNZML3/Blzl5KG3yFjSGyVeQjmol4gZoF0beGm7xbwC88Kvgz3X
        DfdgA5uvkdXKgiGXraCoHXZBi1aIG5ujIqqxWxwE5E+7Bwrj6veDdGFJ93HL12Yf
        DSlBLPYLLfSJHWe61/u2Hu27blFfEjlV6RDWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rhxaQn+hbwrhRCXINb2EEppjGWvyAZpK
        IhgeqKRKKhUP32ljTDQ//MQhR2SIloX2lCDeQelCtlT1pf2P15+DwnO3VSK31KcG
        x/A6NsCAUpR4rb1uZaDpFmDHEwprnCjs9blhTuwGAkYetKnuvgk9fpWheS9+n9dp
        QmrIcWuZJPo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 274E019A67;
        Sat,  8 Dec 2018 01:44:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2CD9D19A66;
        Sat,  8 Dec 2018 01:44:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] submodule: unset core.worktree if no working tree is present
References: <20181207235425.128568-1-sbeller@google.com>
        <20181207235425.128568-3-sbeller@google.com>
Date:   Sat, 08 Dec 2018 15:44:23 +0900
In-Reply-To: <20181207235425.128568-3-sbeller@google.com> (Stefan Beller's
        message of "Fri, 7 Dec 2018 15:54:23 -0800")
Message-ID: <xmqqwook7c1k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3C693E4-FAB4-11E8-A362-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This reintroduces 4fa4f90ccd (submodule: unset core.worktree if no working
> tree is present, 2018-06-12), which was reverted as part of f178c13fda
> (Revert "Merge branch 'sb/submodule-core-worktree'", 2018-09-07).
>
> 4fa4f90ccd was reverted as its followup commit was faulty, but without
> the accompanying change of the followup, we'd have an incomplete workflow
> of setting `core.worktree` again, when it is needed such as checking out
> a revision that contains a submodule.
>
> So re-introduce that commit as-is, focusing on fixing up the followup

I was hoping to hear (given what 0/4 claimed) a clearer explanation
of what this change wants to achieve, but that is lacking.

No need to grumble about an earlier work was that turned out to be
inappropriate for the codebase back then.  Repeatedly saying "this
is needed" without giving further explaining why it is so, or
anything like that, would help readers.

Just pretend that the ealier commits and their reversion never
happened, and further pretend that we are doing the best thing that
should happen to our codebase.  How would we explain this change,
what the problem it tries to solve and what the solution looks like
in the larger picture?

	When removing a working tree of a submodule (e.g. we may be
	switching back to an earlier commit in the superproject that
	did not have the submodule in question yet), we failed to
	unset core.worktree of the submodule's repository.  That
	caused this and that issues, exhibited by a few new tests
	this commit adds.

	Make sure that core.worktree gets unset so that a leftover
	setting won't cause these issues.

or something like that?  I am just guessing by looking at the old
commit's text, as the above two paragraphs and one sentence does not
say much.

> diff --git a/submodule.c b/submodule.c
> index 6415cc5580..d393e947e6 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1561,6 +1561,18 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>  	return ret;
>  }
>  
> +void submodule_unset_core_worktree(const struct submodule *sub)
> +{
> +	char *config_path = xstrfmt("%s/modules/%s/config",
> +				    get_git_common_dir(), sub->name);
> +
> +	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
> +		warning(_("Could not unset core.worktree setting in submodule '%s'"),
> +			  sub->path);
> +
> +	free(config_path);
> +}
> +
>  static const char *get_super_prefix_or_empty(void)
>  {
>  	const char *s = get_super_prefix();
> @@ -1726,6 +1738,8 @@ int submodule_move_head(const char *path,
>  
>  			if (is_empty_dir(path))
>  				rmdir_or_warn(path);
> +
> +			submodule_unset_core_worktree(sub);
>  		}
>  	}
>  out:
> diff --git a/submodule.h b/submodule.h
> index a680214c01..9e18e9b807 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -131,6 +131,8 @@ int submodule_move_head(const char *path,
>  			const char *new_head,
>  			unsigned flags);
>  
> +void submodule_unset_core_worktree(const struct submodule *sub);
> +
>  /*
>   * Prepare the "env_array" parameter of a "struct child_process" for executing
>   * a submodule by clearing any repo-specific environment variables, but
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 016391723c..51d4555549 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -709,7 +709,8 @@ test_submodule_recursing_with_args_common() {
>  			git branch -t remove_sub1 origin/remove_sub1 &&
>  			$command remove_sub1 &&
>  			test_superproject_content origin/remove_sub1 &&
> -			! test -e sub1
> +			! test -e sub1 &&
> +			test_must_fail git config -f .git/modules/sub1/config core.worktree
>  		)
>  	'
>  	# ... absorbing a .git directory along the way.
