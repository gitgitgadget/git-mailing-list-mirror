Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB316C2D0E1
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE172078E
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6GUZy2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgIGPYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgIGPXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 11:23:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B060C061574
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 08:23:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so14689827wme.5
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WMOqNkZSePONLcDVeFThC2ORHbUDJoC6krxKuIEq+hk=;
        b=U6GUZy2eBscz/BLeRpK+opQaRYKuX2trEfg/y0maEfzAdS0Z3imYfQ4vSrRS45y/lr
         szjyXdtKJUJaheyjrJbEoRIl+ToSSPzumCpKRHL4xFEgyUdzui6P/PcnTe1Op9E1FAYE
         RcDm5WNi0TruUKNwTZ0uSuEWx3Mh/Y1K23l+jVZXm8xVz0xroww0G4+dCutEJ86mkr7x
         dlEwZyQKOE4CV7nXhsRICorDgqDMxkglmnjOXRBx68ic2d9fuSfPY0lCf5rf0dihVzkB
         0AKtuubm/TWVsBMzZr35yEh5LwFZ40U66BpYq9wkqs+gh7cudf7P3Vzn3L8sH7CBfav7
         acag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WMOqNkZSePONLcDVeFThC2ORHbUDJoC6krxKuIEq+hk=;
        b=Gr+ZsJ8zyYtmC2qii7J/i2ynpK46++FGEURmhMd1E36/twDGbpXWPuiWuDQ/bLXMLn
         sOPLmHwUWUMldUN56pxWisdyeWd7Oq703fZf7TVjj3RkJOvpJKsWOC61n8zqU0hNM+0m
         /V/kvtz/kw2HSLxoQhsddEZlFAqimTVilOq+HVr2hEhYZC3Xpkfn9nbTX3F6W7aYNxVP
         eGaetg/DQWPUrVSVKWKHjWk9uFnmOtgycC2I6QKULpAHHApuApnnPxaP1esgnzcQnvoE
         1mrW/ZexYZkduF2yCOzBq4dbPY5a0uVaKi4oLQDpIxj4zHAW7NwQ6s+ZGVjMdTgEtMg6
         T7OA==
X-Gm-Message-State: AOAM533VJ5by9cKRGUWxM9EPMKY4E1JpOl8VlTYRnGbSQA1XrXAgyyUz
        blFGIkNhZEflQ96r/6cOsiQa1onOlzo=
X-Google-Smtp-Source: ABdhPJxTxfbJB5Jqe1aAQRU61Qgh4RWIbC40KlEk/rO+ymSoha9NSlkesGtZjR8pI5ypHdeDS+H8ww==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr22387313wmi.55.1599492217483;
        Mon, 07 Sep 2020 08:23:37 -0700 (PDT)
Received: from [192.168.1.240] (125.35.7.51.dyn.plus.net. [51.7.35.125])
        by smtp.gmail.com with ESMTPSA id b76sm27725994wme.45.2020.09.07.08.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 08:23:36 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <624d9e35-29b8-4012-a3d6-e9b00a9e4485@gmail.com>
Date:   Mon, 7 Sep 2020 16:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi

Thanks for working on this, making --force-with-lease safer would be a 
valuable contribution

On 04/09/2020 19:51, Srinidhi Kaushik wrote:
> The `--force-with-lease` option in `git-push`, makes sure that
> refs on remote aren't clobbered by unexpected changes when the
> "<expect>" ref value is explicitly specified.

I think it would help to write out 
`--force-with-lease[=<refname>[:<expect>]]` so readers know what 
"<expect>" is referring to

> For other cases (i.e., `--force-with-lease[=<ref>]`) where the tip
> of the remote tracking branch is populated as the "<expect>" value,
> there is a possibility of allowing unwanted overwrites on the remote
> side when some tools that implicitly fetch remote-tracking refs in
> the background are used with the repository. If a remote-tracking ref
> was updated when a rewrite is happening locally and if those changes
> are pushed by omitting the "<expect>" value in `--force-with-lease`,
> any new changes from the updated tip will be lost locally and will
> be overwritten on the remote.
> 
> This problem can be addressed by checking the `reflog` of the branch
> that is being pushed and verify if there in a entry with the remote
> tracking ref. By running this check, we can ensure that refs being
> are fetched in the background while a "lease" is being held are not
> overlooked before a push, and any new changes can be acknowledged
> and (if necessary) integrated locally.

An addition safety measure would be to check the reflog of the local 
commit and the tip of the remote tracking branch dates overlap. 
Otherwise if there is an implicit fetch of a remote head that has been 
rewound we still push the local branch when we shouldn't.

> The new check will cause `git-push` to fail if it detects the presence
> of any updated refs that we do not have locally and reject the push
> stating `implicit fetch` as the reason.

'implicit fetch' is a rather terse message - can we say something along 
the lines of "the remote has been updated since the last merge/push"?

> An experimental configuration setting: `push.rejectImplicitFetch`
> which defaults to `true` (when `features.experimental` is enabled)
> has been added, to allow `git-push` to reject a push if the check
> fails.

Making this available with features.experimental initially is probably a 
good idea, I hope it will become the default if in future versions.

> Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
> ---
> 
> Hello,
> I picked this up from #leftoverbits over at GitHub [1] from the open
> issues list. This idea [2], for a safer `--force-with-lease` was
> originally proposed by Johannes on the mailing list.
> 
> [1]: https://github.com/gitgitgadget/git/issues/640
> [2]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.1808272306271.73@tvgsbejvaqbjf.bet/
> 
> Thanks.
> 
>   Documentation/config/feature.txt |  3 +
>   Documentation/config/push.txt    | 14 +++++
>   Documentation/git-push.txt       |  6 ++
>   builtin/send-pack.c              |  5 ++
>   remote.c                         | 96 +++++++++++++++++++++++++++++---
>   remote.h                         |  4 +-
>   send-pack.c                      |  1 +
>   t/t5533-push-cas.sh              | 86 ++++++++++++++++++++++++++++
>   transport-helper.c               |  5 ++
>   transport.c                      |  5 ++
>   10 files changed, 217 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> index c0cbf2bb1c..f93e9fd898 100644
> --- a/Documentation/config/feature.txt
> +++ b/Documentation/config/feature.txt
> @@ -18,6 +18,9 @@ skipping more commits at a time, reducing the number of round trips.
>   * `protocol.version=2` speeds up fetches from repositories with many refs by
>   allowing the client to specify which refs to list before the server lists
>   them.
> ++
> +* `push.rejectImplicitFetch=true` runs additional checks for linkgit:git-push[1]
> +`--force-with-lease` to mitigate implicit updates of remote-tracking refs.
> 
>   feature.manyFiles::
>   	Enable config options that optimize for repos with many files in the
> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index f5e5b38c68..1a7184034d 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -114,3 +114,17 @@ push.recurseSubmodules::
>   	specifying '--recurse-submodules=check|on-demand|no'.
>   	If not set, 'no' is used by default, unless 'submodule.recurse' is
>   	set (in which case a 'true' value means 'on-demand').
> +
> +push.rejectImplicitFetch::
> +	If set to `true`, runs additional checks for the `--force-with-lease`
> +	option when used with linkgit:git-push[1] if the expected value for
> +	the remote ref is unspecified (`--force-with-lease[=<ref>]`), and
> +	instead asked depend on the current value of the remote-tracking ref.
> +	The check ensures that the commit at the tip of the remote-tracking
> +	branch -- which may have been implicitly updated by tools that fetch
> +	remote refs by running linkgit:git-fetch[1] in the background -- has
> +	been integrated locally, when holding the "lease". If the new changes
> +	from such remote-tracking refs have not been updated locally before
> +	pushing, linkgit:git-push[1] will fail indicating the reject reason
> +	as `implicit fetch`. Enabling `feature.experimental` makes this option
> +	default to `true`.
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 3b8053447e..2176a743f3 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -320,6 +320,12 @@ seen and are willing to overwrite, then rewrite history, and finally
>   force push changes to `master` if the remote version is still at
>   `base`, regardless of what your local `remotes/origin/master` has been
>   updated to in the background.
> ++
> +Alternatively, setting the (experimental) `push.rejectImplicitFetch` option
> +to `true` will ensure changes from remote-tracking refs that are updated in the
> +background using linkgit:git-fetch[1] are accounted for (either by integrating
> +them locally, or explicitly specifying an overwrite), by rejecting to update
> +such refs.
> 
>   -f::
>   --force::
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 2b9610f121..6500a8267a 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -69,6 +69,11 @@ static void print_helper_status(struct ref *ref)
>   			msg = "stale info";
>   			break;
> 
> +		case REF_STATUS_REJECT_IMPLICIT_FETCH:
> +			res = "error";
> +			msg = "implicit fetch";
> +			break;
> +
>   		case REF_STATUS_REJECT_ALREADY_EXISTS:
>   			res = "error";
>   			msg = "already exists";
> diff --git a/remote.c b/remote.c
> index c5ed74f91c..ee2dedd15b 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -49,6 +49,8 @@ static const char *pushremote_name;
>   static struct rewrites rewrites;
>   static struct rewrites rewrites_push;
> 
> +static struct object_id cas_reflog_check_oid;
> +

rather than using a global variable I think it would be better just to 
pass this value around using the cb_data argument of the reflog callback 
function

>   static int valid_remote(const struct remote *remote)
>   {
>   	return (!!remote->url) || (!!remote->foreign_vcs);
> @@ -1446,6 +1448,22 @@ int match_push_refs(struct ref *src, struct ref **dst,
>   	return 0;
>   }
> 
> +/*
> + * Consider `push.rejectImplicitFetch` to be set to true if experimental
> + * features are enabled; use user-defined value if set explicitly.
> + */
> +int reject_implicit_fetch()
> +{
> +	int conf = 0;
> +	if (!git_config_get_bool("push.rejectImplicitFetch", &conf))
> +		return conf;
> +
> +	if (!git_config_get_bool("feature.experimental", &conf))
> +		return conf;
> +
> +	return conf;
> +}
> +
>   void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>   			     int force_update)
>   {
> @@ -1471,16 +1489,21 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>   		 * If the remote ref has moved and is now different
>   		 * from what we expect, reject any push.
>   		 *
> -		 * It also is an error if the user told us to check
> -		 * with the remote-tracking branch to find the value
> -		 * to expect, but we did not have such a tracking
> -		 * branch.
> +		 * It also is an error if the user told us to check with the
> +		 * remote-tracking branch to find the value to expect, but we
> +		 * did not have such a tracking branch, or we have one that
> +		 * has new changes.
>   		 */
>   		if (ref->expect_old_sha1) {
>   			if (!oideq(&ref->old_oid, &ref->old_oid_expect))
>   				reject_reason = REF_STATUS_REJECT_STALE;
> +			else if (reject_implicit_fetch() && ref->implicit_fetch)
> +				reject_reason = REF_STATUS_REJECT_IMPLICIT_FETCH;
>   			else
> -				/* If the ref isn't stale then force the update. */
> +				/*
> +				 * If the ref isn't stale, or there was no
> +				 * implicit fetch, force the update.
> +				 */
>   				force_ref_update = 1;
>   		}
> 
> @@ -2272,23 +2295,67 @@ static int remote_tracking(struct remote *remote, const char *refname,
>   	return 0;
>   }
> 
> +static int oid_in_reflog_ent(struct object_id *ooid, struct object_id *noid,
> +			     const char *ident, timestamp_t timestamp, int tz,
> +			     const char *message, void *cb_data)
> +{

using the callback data we would have something like

struct oid *remote_head = cb_data;
return oideq(noid, remote_head);

> +	return oideq(noid, &cas_reflog_check_oid);
> +}
> +
> +/*
> + * Iterate through the reflog of a local branch and check if the tip of the
> + * remote-tracking branch is reachable from one of the entries.
> + */
> +static int remote_ref_in_reflog(const struct object_id *r_oid,
> +				const struct object_id *l_oid,
> +				const char *local_ref_name)
> +{
> +	int ret = 0;
> +	cas_reflog_check_oid = *r_oid;
> +
> +	struct commit *r_commit, *l_commit;

Our coding style is to declare all variables before any statements, so 
this should come above `cas_reflog_check_oid = *r_oid` but that line 
wants to go away anyway.

> +	l_commit = lookup_commit_reference(the_repository, l_oid);
> +	r_commit = lookup_commit_reference(the_repository, r_oid);
> +
> +	/*
> +	 * If the remote-tracking ref is an ancestor of the local ref (a merge,
> +	 * for instance) there is no need to iterate through the reflog entries
> +	 * to ensure reachability; it can be skipped to return early instead.
> +	 */
> +	ret = (r_commit && l_commit) ? in_merge_bases(r_commit, l_commit) : 0;
> +	if (ret)
> +		goto skip;

Rather than using a goto it would perhaps be better to do

if (!ret)
	ret = for_each_reflog_...

> +
> +	ret = for_each_reflog_ent_reverse(local_ref_name,
> +					  oid_in_reflog_ent,
> +					  NULL);

using the callback data we'd pass r_oid rather than NULL as the last 
argument

> +skip:
> +	return ret;
> +}
> +
>   static void apply_cas(struct push_cas_option *cas,
>   		      struct remote *remote,
>   		      struct ref *ref)
>   {
> -	int i;
> +	int i, do_reflog_check = 0;
> +	struct object_id oid;
> +	struct ref *local_ref = get_local_ref(ref->name);
> 
>   	/* Find an explicit --<option>=<name>[:<value>] entry */
>   	for (i = 0; i < cas->nr; i++) {
>   		struct push_cas *entry = &cas->entry[i];
>   		if (!refname_match(entry->refname, ref->name))
>   			continue;
> +
>   		ref->expect_old_sha1 = 1;
>   		if (!entry->use_tracking)
>   			oidcpy(&ref->old_oid_expect, &entry->expect);
>   		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
>   			oidclr(&ref->old_oid_expect);
> -		return;
> +		else
> +			do_reflog_check = 1;
> +
> +		goto reflog_check;

I'm not too keen in jumping here, can't we just check `do_reflog_check` 
below?

Best Wishes

Phillip

>   	}
> 
>   	/* Are we using "--<option>" to cover all? */
> @@ -2298,6 +2365,21 @@ static void apply_cas(struct push_cas_option *cas,
>   	ref->expect_old_sha1 = 1;
>   	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
>   		oidclr(&ref->old_oid_expect);
> +	else
> +		do_reflog_check = 1;
> +
> +reflog_check:
> +	/*
> +	 * For cases where "--force-with-lease[=<refname>]" i.e., when the
> +	 * "<expect>" value is unspecified, run additional checks to verify
> +	 * if the tip of the remote-tracking branch (if implicitly updated
> +	 * when a "lease" is being held) is reachable from at least one entry
> +	 * in the reflog of the local branch that is being pushed, ensuring
> +	 * new changes (if any) have been integrated locally.
> +	 */
> +	if (do_reflog_check && local_ref && !read_ref(local_ref->name, &oid))
> +		ref->implicit_fetch = !remote_ref_in_reflog(&ref->old_oid, &oid,
> +							    local_ref->name);
>   }
> 
>   void apply_push_cas(struct push_cas_option *cas,
> diff --git a/remote.h b/remote.h
> index 5e3ea5a26d..f859fa5fed 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -104,7 +104,8 @@ struct ref {
>   		forced_update:1,
>   		expect_old_sha1:1,
>   		exact_oid:1,
> -		deletion:1;
> +		deletion:1,
> +		implicit_fetch:1;
> 
>   	enum {
>   		REF_NOT_MATCHED = 0, /* initial value */
> @@ -133,6 +134,7 @@ struct ref {
>   		REF_STATUS_REJECT_FETCH_FIRST,
>   		REF_STATUS_REJECT_NEEDS_FORCE,
>   		REF_STATUS_REJECT_STALE,
> +		REF_STATUS_REJECT_IMPLICIT_FETCH,
>   		REF_STATUS_REJECT_SHALLOW,
>   		REF_STATUS_UPTODATE,
>   		REF_STATUS_REMOTE_REJECT,
> diff --git a/send-pack.c b/send-pack.c
> index 632f1580ca..fe7f14add4 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -240,6 +240,7 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
>   	case REF_STATUS_REJECT_FETCH_FIRST:
>   	case REF_STATUS_REJECT_NEEDS_FORCE:
>   	case REF_STATUS_REJECT_STALE:
> +	case REF_STATUS_REJECT_IMPLICIT_FETCH:
>   	case REF_STATUS_REJECT_NODELETE:
>   		return CHECK_REF_STATUS_REJECTED;
>   	case REF_STATUS_UPTODATE:
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index 0b0eb1d025..840b2a95f9 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -13,6 +13,41 @@ setup_srcdst_basic () {
>   	)
>   }
> 
> +setup_implicit_fetch () {
> +	rm -fr src dup dst &&
> +	git init --bare dst &&
> +	git clone --no-local dst src &&
> +	git clone --no-local dst dup
> +	(
> +		cd src &&
> +		test_commit A &&
> +		git push
> +	) &&
> +	(
> +		cd dup &&
> +		git fetch &&
> +		git merge origin/master &&
> +		test_commit B &&
> +		git switch -c branch master~1 &&
> +		test_commit C &&
> +		test_commit D &&
> +		git push --all
> +	) &&
> +	(
> +		cd src &&
> +		git switch master &&
> +		git fetch --all &&
> +		git branch branch --track origin/branch &&
> +		git merge origin/master
> +	) &&
> +	(
> +		cd dup &&
> +		git switch master &&
> +		test_commit E &&
> +		git push origin master:master
> +	)
> +}
> +
>   test_expect_success setup '
>   	# create template repository
>   	test_commit A &&
> @@ -256,4 +291,55 @@ test_expect_success 'background updates of REMOTE can be mitigated with a non-up
>   	)
>   '
> 
> +test_expect_success 'implicit updates to remote-tracking refs with `push.rejectImplicitFetch` set (protected, all refs)' '
> +	setup_implicit_fetch &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	git ls-remote dst refs/heads/master >expect.master &&
> +	git ls-remote dst refs/heads/master >expect.branch &&
> +	(
> +		cd src &&
> +		git switch master &&
> +		test_commit G &&
> +		git switch branch &&
> +		test_commit H &&
> +		git fetch --all &&
> +		git config --local feature.experimental true &&
> +		test_must_fail git push --force-with-lease --all 2>err &&
> +		grep "implicit fetch" err
> +	) &&
> +	git ls-remote dst refs/heads/master >actual.master &&
> +	git ls-remote dst refs/heads/master >actual.branch &&
> +	test_cmp expect.master actual.master &&
> +	test_cmp expect.branch actual.branch &&
> +	(
> +		cd src &&
> +		git config --local feature.experimental false &&
> +		git push --force-with-lease --all 2>err &&
> +		grep "forced update" err
> +	)
> +'
> +
> +test_expect_success 'implicit updates to remote-tracking refs with `push.rejectImplicitFetch` set (protected, specific ref)' '
> +	setup_implicit_fetch &&
> +	git ls-remote dst refs/heads/master >actual &&
> +	(
> +		cd src &&
> +		git switch branch &&
> +		test_commit F &&
> +		git switch master &&
> +		test_commit G &&
> +		git fetch  &&
> +		git config --local push.rejectImplicitFetch true &&
> +		test_must_fail git push --force-with-lease=master --all 2>err &&
> +		grep "implicit fetch" err
> +	) &&
> +	git ls-remote dst refs/heads/master >expect &&
> +	test_cmp expect actual &&
> +	(
> +		cd src &&
> +		git push --force --force-with-lease --all 2>err &&
> +		grep "forced update" err
> +	)
> +'
> +
>   test_done
> diff --git a/transport-helper.c b/transport-helper.c
> index c52c99d829..75b4c1b758 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -779,6 +779,10 @@ static int push_update_ref_status(struct strbuf *buf,
>   			status = REF_STATUS_REJECT_STALE;
>   			FREE_AND_NULL(msg);
>   		}
> +		else if (!strcmp(msg, "ignored fetch")) {
> +			status = REF_STATUS_REJECT_IMPLICIT_FETCH;
> +			FREE_AND_NULL(msg);
> +		}
>   		else if (!strcmp(msg, "forced update")) {
>   			forced = 1;
>   			FREE_AND_NULL(msg);
> @@ -896,6 +900,7 @@ static int push_refs_with_push(struct transport *transport,
>   		switch (ref->status) {
>   		case REF_STATUS_REJECT_NONFASTFORWARD:
>   		case REF_STATUS_REJECT_STALE:
> +		case REF_STATUS_REJECT_IMPLICIT_FETCH:
>   		case REF_STATUS_REJECT_ALREADY_EXISTS:
>   			if (atomic) {
>   				reject_atomic_push(remote_refs, mirror);
> diff --git a/transport.c b/transport.c
> index 43e24bf1e5..588575498f 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -567,6 +567,10 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
>   		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
>   				 "stale info", porcelain, summary_width);
>   		break;
> +	case REF_STATUS_REJECT_IMPLICIT_FETCH:
> +		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
> +				 "implicit fetch", porcelain, summary_width);
> +		break;
>   	case REF_STATUS_REJECT_SHALLOW:
>   		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
>   				 "new shallow roots not allowed",
> @@ -1101,6 +1105,7 @@ static int run_pre_push_hook(struct transport *transport,
>   		if (!r->peer_ref) continue;
>   		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
>   		if (r->status == REF_STATUS_REJECT_STALE) continue;
> +		if (r->status == REF_STATUS_REJECT_IMPLICIT_FETCH) continue;
>   		if (r->status == REF_STATUS_UPTODATE) continue;
> 
>   		strbuf_reset(&buf);
> --
> 2.28.0
> 
