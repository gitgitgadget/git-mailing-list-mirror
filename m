From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] format-patch: introduce --base=auto option
Date: Thu, 31 Mar 2016 10:43:48 -0700
Message-ID: <xmqqtwjmo84r.fsf@gitster.mtv.corp.google.com>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
	<1459388776-18066-4-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:43:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algdQ-0000n9-So
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbcCaRnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:43:52 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752654AbcCaRnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:43:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA3B2521FE;
	Thu, 31 Mar 2016 13:43:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yj2ZZRZUZyAxZVX++53mKKNyL0M=; b=Ebi/bf
	oXpM5YxEdC3nq1oBA7Ovv2gIK6/zCKDMOSkDJZh9b9OaUlJAQDflcUvCP3h0KzAd
	uTFpmzPnwfaSaWhli4TFqcX9ZHyt/QEMw4GhCAYEShaUxJ4RvJ28ziwPXWDIJogm
	UpmSySOGHEg9nw1BUZSMk77iFb65zJXJ/YJi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dCVNHJPds/VYSxpzTECPTfsqI1/fwYRU
	RuVVpevwml+YcWIuzjJwlQ5CUx0DaUgdp84yX7fRN80KhLEuHAbRYU2P1CrFxLoa
	ozJe9rSepQJq9HgYvvbF+ITMo4ETQN9gusrMzWHKniC9d9UyaGn9pZbvjW+SrHPr
	2WIyXKZZQvc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B15E0521FD;
	Thu, 31 Mar 2016 13:43:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E41D521F9;
	Thu, 31 Mar 2016 13:43:50 -0400 (EDT)
In-Reply-To: <1459388776-18066-4-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Thu, 31 Mar 2016 09:46:15 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 20B48F9A-F768-11E5-BDF4-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290430>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> Introduce --base=auto to record the base commit info automatically, the base_commit
> will be the merge base of tip commit of the upstream branch and revision-range
> specified in cmdline.

This line is probably a bit too long.

>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Wu Fengguang <fengguang.wu@intel.com>
> Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
> ---
>  Documentation/git-format-patch.txt |  4 ++++
>  builtin/log.c                      | 31 +++++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 067d562..d8fe651 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -290,6 +290,10 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  	patches for A, B and C, and the identifiers for P, X, Y, Z are appended
>  	at the end of the _first_ message.
>  
> +	If set '--base=auto' in cmdline, it will track base commit automatically,
> +	the base commit will be the merge base of tip commit of the remote-tracking
> +	branch and revision-range specified in cmdline.
> +
>  --root::
>  	Treat the revision argument as a <revision range>, even if it
>  	is just a single commit (that would normally be treated as a
> diff --git a/builtin/log.c b/builtin/log.c
> index 03cbab0..c5efe73 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1200,6 +1200,9 @@ static void prepare_bases(struct base_tree_info *bases,
>  	struct rev_info revs;
>  	struct diff_options diffopt;
>  	struct object_id *patch_id;
> +	struct branch *curr_branch;
> +	struct commit_list *base_list;
> +	const char *upstream;
>  	unsigned char sha1[20];
>  	int i;
>  
> @@ -1207,10 +1210,30 @@ static void prepare_bases(struct base_tree_info *bases,
>  	DIFF_OPT_SET(&diffopt, RECURSIVE);
>  	diff_setup_done(&diffopt);
>  
> -	base = lookup_commit_reference_by_name(base_commit);
> -	if (!base)
> -		die(_("Unknown commit %s"), base_commit);
> -	oidcpy(&bases->base_commit, &base->object.oid);
> +	if (!strcmp(base_commit, "auto")) {
> +		curr_branch = branch_get(NULL);

Can branch_get() return NULL?  Which ...

> +		upstream = branch_get_upstream(curr_branch, NULL);

... would cause branch_get_upstream() to give you an error (which
you ignore)?  I guess that is OK because upstream will safely be set
to NULL in that case.

> +		if (upstream) {
> +			if (get_sha1(upstream, sha1))
> +				die(_("Failed to resolve '%s' as a valid ref."), upstream);
> +			commit = lookup_commit_or_die(sha1, "upstream base");
> +			base_list = get_merge_bases_many(commit, total, list);
> +			if (!bases)
> +				die(_("Could not find merge base."));
> +			base = base_list->item;
> +			free_commit_list(base_list);

What should happen when there are multiple merge bases?  The code
picks one at random and ignores the remainder, if I am reading this
correctly.

> +			oidcpy(&bases->base_commit, &base->object.oid);
> +		} else {
> +			die(_("Failed to get upstream, if you want to record base commit automatically,\n"
> +			      "please use git branch --set-upstream-to to track a remote branch.\n"
> +			      "Or you could specify base commit by --base=<base-commit-id> manually."));
> +		}
> +	} else {
> +		base = lookup_commit_reference_by_name(base_commit);
> +		if (!base)
> +			die(_("Unknown commit %s"), base_commit);
> +		oidcpy(&bases->base_commit, &base->object.oid);
> +	}
>  
>  	init_revisions(&revs, NULL);
>  	revs.max_parents = 1;
