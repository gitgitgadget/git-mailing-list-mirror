From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] merge: handle --ff/--no-ff/--ff-only as a tri-state option
Date: Tue, 02 Jul 2013 10:42:39 +0200
Message-ID: <51D2927F.3040207@alum.mit.edu>
References: <20130701070143.GB17269@suse.cz> <51D197AD.1070502@alum.mit.edu> <20130701195407.GK17269@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 02 10:42:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtwAm-0007Ut-Mh
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 10:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267Ab3GBImr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 04:42:47 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:44697 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932141Ab3GBImn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jul 2013 04:42:43 -0400
X-AuditID: 12074412-b7f656d00000102f-05-51d292820cd0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.43.04143.28292D15; Tue,  2 Jul 2013 04:42:42 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r628gd4V023489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Jul 2013 04:42:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130701195407.GK17269@suse.cz>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqNs06VKgwZyj0hZdV7qZLBp6rzBb
	7Jwyn9mB2ePiJWWPMwuOsHt83iQXwBzFbZOUWFIWnJmep2+XwJ1xf+sztoKmyIr1t9+yNTB+
	de1i5OSQEDCR+PNwPjOELSZx4d56ti5GLg4hgcuMEg82fgJLCAlcZZJ4eLYQxOYV0JZo3XWB
	DcRmEVCVOD5nBSuIzSagK7Gop5mpi5GDQ1QgTOLKb1WIckGJkzOfsIDYIgJKEt8m7mcHsZkF
	rCVWvD7MBGILC/hLHP/bwQ6xKlfiwZR7YPWcQCPnvvvICjKSWUBdYv08IYhWeYntb+cwT2AU
	mIVkwyyEqllIqhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXTy80s0UtNKd3ECAlaoR2M
	60/KHWIU4GBU4uFVmHcxUIg1say4MvcQoyQHk5Io75QJlwKF+JLyUyozEosz4otKc1KLDzFK
	cDArifDe9AYq501JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4DUFGSpY
	lJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitH4YmCUgqR4gPYuBmnnLS5IzAWKQrSe
	YtTlOPBjy3tGIZa8/LxUKXHeAyBFAiBFGaV5cCtgKeoVozjQx8K8y0CqeIDpDW7SK6AlTEBL
	suvAlpQkIqSkGhgZ+qZfT71XcOgY//NY9fYo2V7+BzdDze+wSCmlzngkWRdR+cfB4J7s3MNT
	VAT9Oje/LVISE/PpvtD0w8vz7CUDs2PzzpdxnX3rz/ZifsWqirc9xi713ndez3/Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229376>

On 07/01/2013 09:54 PM, Miklos Vajna wrote:
> This has multiple benefits: with more than one of {"--ff", "--no-ff",
> "--ff-only"} respects the last option; also the command-line option to
> always take precedence over the config file option.
> 
> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
> ---
> 
> On Mon, Jul 01, 2013 at 04:52:29PM +0200, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> If I find the time (unlikely) I might submit a patch to implement these
>> expectations.
> 
> Seeing that the --no-ff / --ff-only combo wasn't denied just sort of 
> accidently, I agree that it makes more sense to merge allow_fast_forward
> and fast_forward_only to a single enum, that automatically gives you 
> both benefits.

Thanks a lot for taking this on!  I would definitely be happy to be able
to set merge.ff=false without preventing the use of explicit "--ff-only"
from the command line.

See comments below...

>  builtin/merge.c  | 65 +++++++++++++++++++++++++++++++++++++-------------------
>  t/t7600-merge.sh | 12 ++++++++---
>  2 files changed, 52 insertions(+), 25 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 2ebe732..561edf4 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -47,8 +47,8 @@ static const char * const builtin_merge_usage[] = {
>  };
>  
>  static int show_diffstat = 1, shortlog_len = -1, squash;
> -static int option_commit = 1, allow_fast_forward = 1;
> -static int fast_forward_only, option_edit = -1;
> +static int option_commit = 1;
> +static int option_edit = -1;
>  static int allow_trivial = 1, have_message, verify_signatures;
>  static int overwrite_ignore = 1;
>  static struct strbuf merge_msg = STRBUF_INIT;
> @@ -76,6 +76,14 @@ static struct strategy all_strategy[] = {
>  
>  static const char *pull_twohead, *pull_octopus;
>  
> +enum ff_type {
> +	FF_ALLOW,
> +	FF_NO,
> +	FF_ONLY
> +};
> +
> +static enum ff_type fast_forward = FF_ALLOW;
> +
>  static int option_parse_message(const struct option *opt,
>  				const char *arg, int unset)
>  {
> @@ -178,6 +186,21 @@ static int option_parse_n(const struct option *opt,
>  	return 0;
>  }
>  
> +static int option_parse_ff(const struct option *opt,
> +			  const char *arg, int unset)
> +{
> +	fast_forward = unset ? FF_NO : FF_ALLOW;
> +	return 0;
> +}
> +
> +static int option_parse_ff_only(const struct option *opt,
> +			  const char *arg, int unset)
> +{
> +	if (!unset)
> +		fast_forward = FF_ONLY;
> +	return 0;
> +}
> +

You allow --no-ff-only but ignore it, which I think is incorrect.  In

    git merge --ff-only --no-ff-only [...]

, the --no-ff-only should presumably cancel the effect of the previous
--ff-only (i.e., be equivalent to "--ff").  But it is a little bit
subtle because

    git merge --no-ff --no-ff-only

should presumably be equivalent to --no-ff.  So I think that
"--no-ff-only" should do something like

    if (fast_forward == FF_ONLY)
        fast_forward = FF_ALLOW;

(Note that there is an asymmetry here, because "--no-ff-only"
*shouldn't* cancel the effect of "--no-ff", whereas "--ff" *should*
cancel the effect of "--ff-only".  This is because --ff-only restricts
what the user wants to allow whereas --ff removes a restriction.  So I
think it is OK.)

>  static struct option builtin_merge_options[] = {
>  	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
>  		N_("do not show a diffstat at the end of the merge"),
> @@ -194,10 +217,12 @@ static struct option builtin_merge_options[] = {
>  		N_("perform a commit if the merge succeeds (default)")),
>  	OPT_BOOL('e', "edit", &option_edit,
>  		N_("edit message before committing")),
> -	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
> -		N_("allow fast-forward (default)")),
> -	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
> -		N_("abort if fast-forward is not possible")),
> +	{ OPTION_CALLBACK, 0, "ff", NULL, NULL,
> +		N_("allow fast-forward (default)"),
> +		PARSE_OPT_NOARG, option_parse_ff },
> +	{ OPTION_CALLBACK, 0, "ff-only", NULL, NULL,
> +		N_("abort if fast-forward is not possible"),
> +		PARSE_OPT_NOARG, option_parse_ff_only },
>  	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
>  	OPT_BOOL(0, "verify-signatures", &verify_signatures,
>  		N_("Verify that the named commit has a valid GPG signature")),

I'm no options guru, but I think it would be possible to implement --ff
and --no-ff without callbacks if you choose constants such that
FF_NO==0, something like:

    enum ff_type {
    	FF_NO = 0, /* It is important that this value be zero! */
    	FF_ALLOW,
    	FF_ONLY
    };

    static int fast_forward = FF_ALLOW;

    static struct option builtin_merge_options[] = {
        [...]
        { OPTION_SET_INT, 0, "ff", &fast_forward, NULL,
        	N_("allow fast-forward (default)"),
        	PARSE_OPT_NOARG, NULL, FF_ALLOW },
        { OPTION_CALLBACK, 0, "ff-only", [...]

because OPTION_SET_INT resets the value to zero if "--no-ff" is
specified, which is just what we need.

> @@ -581,10 +606,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  	else if (!strcmp(k, "merge.ff")) {
>  		int boolval = git_config_maybe_bool(k, v);
>  		if (0 <= boolval) {
> -			allow_fast_forward = boolval;
> +			fast_forward = boolval ? FF_ALLOW : FF_NO;
>  		} else if (v && !strcmp(v, "only")) {
> -			allow_fast_forward = 1;
> -			fast_forward_only = 1;
> +			fast_forward = FF_ONLY;
>  		} /* do not barf on values from future versions of git */
>  		return 0;
>  	} else if (!strcmp(k, "merge.defaulttoupstream")) {
> @@ -863,7 +887,7 @@ static int finish_automerge(struct commit *head,
>  
>  	free_commit_list(common);
>  	parents = remoteheads;
> -	if (!head_subsumed || !allow_fast_forward)
> +	if (!head_subsumed || fast_forward == FF_NO)
>  		commit_list_insert(head, &parents);
>  	strbuf_addch(&merge_msg, '\n');
>  	prepare_to_commit(remoteheads);
> @@ -1008,7 +1032,7 @@ static void write_merge_state(struct commit_list *remoteheads)
>  	if (fd < 0)
>  		die_errno(_("Could not open '%s' for writing"), filename);
>  	strbuf_reset(&buf);
> -	if (!allow_fast_forward)
> +	if (fast_forward == FF_NO)
>  		strbuf_addf(&buf, "no-ff");
>  	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
>  		die_errno(_("Could not write to '%s'"), filename);
> @@ -1157,14 +1181,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		show_diffstat = 0;
>  
>  	if (squash) {
> -		if (!allow_fast_forward)
> +		if (fast_forward == FF_NO)
>  			die(_("You cannot combine --squash with --no-ff."));
>  		option_commit = 0;
>  	}
>  

So there is still a problem with setting merge.ff=false, namely that it
prevents the use of --squash.  That's not good.  (I realize that you are
not to blame for this pre-existing behavior.)

How should --squash and the ff-related options interact?

    git merge --ff --squash
    git merge --no-ff --squash

I think these should just squash.

    git merge --ff-only --squash

I think this should definitely squash.  But perhaps it should require
that HEAD be an ancestor of the branch to be merged?

    git merge --squash --ff
    git merge --squash --no-ff
    git merge --squash --ff-only

Should these do the same as the versions with the option order reversed?
 Or should the command line option that appears later take precedence?
The latter implies that {--ff, --no-ff, --ff-only, --squash} actually
constitute a single *quad-state* option, representing "how the results
of the merge should be handled", and, for example,

    git merge --squash --ff-only

ignores the --squash option, and

    git merge --ff-only --squash

ignores the --ff-only option.

I'm not sure.

> -	if (!allow_fast_forward && fast_forward_only)
> -		die(_("You cannot combine --no-ff with --ff-only."));
> -
>  	if (!abort_current_merge) {
>  		if (!argc) {
>  			if (default_to_upstream)
> @@ -1206,7 +1227,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  				"empty head"));
>  		if (squash)
>  			die(_("Squash commit into empty head not supported yet"));
> -		if (!allow_fast_forward)
> +		if (fast_forward == FF_NO)
>  			die(_("Non-fast-forward commit does not make sense into "
>  			    "an empty head"));
>  		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
> @@ -1294,11 +1315,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  			    sha1_to_hex(commit->object.sha1));
>  		setenv(buf.buf, merge_remote_util(commit)->name, 1);
>  		strbuf_reset(&buf);
> -		if (!fast_forward_only &&
> +		if (fast_forward != FF_ONLY &&
>  		    merge_remote_util(commit) &&
>  		    merge_remote_util(commit)->obj &&
>  		    merge_remote_util(commit)->obj->type == OBJ_TAG)
> -			allow_fast_forward = 0;
> +			fast_forward = FF_NO;
>  	}
>  
>  	if (option_edit < 0)
> @@ -1315,7 +1336,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  
>  	for (i = 0; i < use_strategies_nr; i++) {
>  		if (use_strategies[i]->attr & NO_FAST_FORWARD)
> -			allow_fast_forward = 0;
> +			fast_forward = FF_NO;
>  		if (use_strategies[i]->attr & NO_TRIVIAL)
>  			allow_trivial = 0;
>  	}
> @@ -1345,7 +1366,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		 */
>  		finish_up_to_date("Already up-to-date.");
>  		goto done;
> -	} else if (allow_fast_forward && !remoteheads->next &&
> +	} else if (fast_forward != FF_NO && !remoteheads->next &&
>  			!common->next &&
>  			!hashcmp(common->item->object.sha1, head_commit->object.sha1)) {
>  		/* Again the most common case of merging one remote. */
> @@ -1392,7 +1413,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		 * only one common.
>  		 */
>  		refresh_cache(REFRESH_QUIET);
> -		if (allow_trivial && !fast_forward_only) {
> +		if (allow_trivial && fast_forward != FF_ONLY) {
>  			/* See if it is really trivial. */
>  			git_committer_info(IDENT_STRICT);
>  			printf(_("Trying really trivial in-index merge...\n"));
> @@ -1433,7 +1454,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	if (fast_forward_only)
> +	if (fast_forward == FF_ONLY)
>  		die(_("Not possible to fast-forward, aborting."));
>  
>  	/* We are going to make a new commit. */
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 460d8eb..3ff5fb8 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -497,9 +497,15 @@ test_expect_success 'combining --squash and --no-ff is refused' '
>  	test_must_fail git merge --no-ff --squash c1
>  '
>  
> -test_expect_success 'combining --ff-only and --no-ff is refused' '
> -	test_must_fail git merge --ff-only --no-ff c1 &&
> -	test_must_fail git merge --no-ff --ff-only c1
> +test_expect_success 'option --ff-only overwrites --no-ff' '
> +	git merge --no-ff --ff-only c1 &&
> +	test_must_fail git merge --no-ff --ff-only c2
> +'
> +
> +test_expect_success 'option --ff-only overwrites merge.ff=only config' '
> +	git reset --hard c0 &&
> +	test_config merge.ff only &&
> +	git merge --no-ff c1
>  '
>  
>  test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
