Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C9C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581B664DDC
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhBYUgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:36:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56198 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhBYUeI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 15:34:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD05A1211C6;
        Thu, 25 Feb 2021 15:33:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nOtrMtBywVwuItCa0olz9JFORqU=; b=xS76Be
        OmB6TKajciA41tstQA2cqR7/BUM3H41kWyG4tDm+nkDUsZrjC376YiZxzCIuC1J8
        L/Fgpg7pzIwk+G3n3L0619spd3dbQs40r9PrkEyiW6OnQ3v/HyvXBwZ219Z53vgF
        50pT70zlyjiJM8YcoRtHx9Aea+ncv0QBL/Yhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mmunP5z429Lb1VM76Vf1+IJ3KYtK/qeO
        /zbEy/WMtf46msVwxp/22QScmC2/5i5xmCxXSEw+TqrYgGXk5wS/nqNT3zc8CyGf
        ZN2Fw0Y2KwMOQQMBEaD1HWQEQm/JRLhcV3UORIODqf1BFVbE4k2MPo2Tj16WZY7G
        ctIwxwIYVsg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A52931211C5;
        Thu, 25 Feb 2021 15:33:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF6FB1211C2;
        Thu, 25 Feb 2021 15:33:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 3/6] commit: add a reword suboption to --fixup
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210225100855.25530-4-charvi077@gmail.com>
Date:   Thu, 25 Feb 2021 12:32:59 -0800
In-Reply-To: <20210225100855.25530-4-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Thu, 25 Feb 2021 15:38:58 +0530")
Message-ID: <xmqq7dmvubus.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A742D376-77A8-11EB-9BDF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> `git commit --fixup=reword:<commit>` creates an empty "amend!" commit
> that will reword <commit> without changing its contents when it is
> rebased with --autosquash.
>
> Apart from ignoring staged changes it works similarly to
> `--fixup=amend:<commit>`.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>  builtin/commit.c | 46 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 56ae15a762..82e77aa61d 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1177,6 +1177,27 @@ static void finalize_deferred_config(struct wt_status *s)
>  		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
>  }
>  
> +static void check_fixup_reword_options(int argc) {
> +	if (whence != FROM_COMMIT) {
> +		if (whence == FROM_MERGE)
> +			die(_("You are in the middle of a merge -- cannot reword."));
> +		else if (is_from_cherry_pick(whence))
> +			die(_("You are in the middle of a cherry-pick -- cannot reword."));
> +	}
> +	if (argc)
> +		die(_("cannot combine reword option of --fixup with paths"));

It would be easier if the user is told "foo" in the message when

    $ git commit --fixup=reword:HEAD~ -- foo

(from your tests) is attempted, no?

> +	if (patch_interactive)
> +		die(_("cannot combine reword option of --fixup with --patch"));
> +	if (interactive)
> +		die(_("cannot combine reword option of --fixup with --interactive"));
> +	if (all)
> +		die(_("cannot combine reword option of --fixup with --all"));
> +	if (also)
> +		die(_("cannot combine reword option of --fixup with --include"));
> +	if (only)
> +		die(_("cannot combine reword option of --fixup with --only"));
> +}
> +
>  /* returns the length of intial segment of alpha characters only */
>  static size_t get_alpha_len(char *fixup_message) {
>  	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
> @@ -1261,18 +1282,25 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  
>  	if (fixup_message) {
>  		/*
> -		 * As `amend` suboption contains only alpha
> -		 * character. So check if first non alpha
> -		 * character in fixup_message is ':'.
> +		 * As `amend`/`reword` suboptions contains only alpha
> +		 * characters. So check if first non alpha character
> +		 * in fixup_message is ':'.
>  		 */
>  		size_t len = get_alpha_len(fixup_message);
>  		if (len && fixup_message[len] == ':') {
>  			fixup_message[len] = '\0';
>  			fixup_commit = fixup_message + ++len;
> -			if (starts_with("amend", fixup_message))
> +			if (starts_with("amend", fixup_message) ||
> +				starts_with("reword", fixup_message)) {
>  				fixup_prefix = "amend";
> -			else
> +				if (*fixup_message == 'r') {

> +					check_fixup_reword_options(argc);
> +					allow_empty = 1;
> +					only = 1;

OK.  We make sure that there is no pathspec and then by giving
only==1, we ignore any difference that already may exist between
HEAD and the index.  IOW

	edit somefile
	git add somefile
	git commit --fixup=reword:<commit>

will still record the same tree as HEAD, without affected by the
addition of somefile to the index that is done before.

Good.

> +				}
> +			} else {
>  				die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
> +			}
>  		} else {
>  			fixup_commit = fixup_message;
>  			fixup_prefix = "fixup";
> @@ -1558,11 +1586,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
>  		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
>  		/*
> -		 * TRANSLATORS: please do not translate [amend:]
> -		 * Here "amend" is an option to the --fixup command
> -		 * line flag, that creates amend! commit.
> +		 * TRANSLATORS: please do not translate [(amend|reword):]
> +		 * Here "amend" and "reword" are options to the --fixup
> +		 * command line flag, that creates amend! commit.

I am not sure this comment is all that helpful to the translaters.
If they are not allowed to translate <amend|reword> part, telling
them what that part means does not help them very much.

	Leave "[(amend|reword):]" as-is, and only translate <commit>.

would be more direct without distracting them with useless piece of
information, no?

>  		 */
> -		OPT_STRING(0, "fixup", &fixup_message, N_("[amend:]commit"), N_("use autosquash formatted message to fixup or amend specified commit")),
> +		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
>  		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
