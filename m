From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixing unclear messages
Date: Sun, 10 Aug 2014 17:00:45 -0700
Message-ID: <xmqqsil37v4i.fsf@gitster.dls.corp.google.com>
References: <1407683607-4143-1-git-send-email-ash@kambanaria.org>
	<1407683607-4143-2-git-send-email-ash@kambanaria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, avarab@gmail.com, jn.avila@free.fr,
	worldhello.net@gmail.com, marcopaolone@gmail.com,
	marcomsousa@gmail.com, peter@softwolves.pp.se,
	ralf.thielow@gmail.com
To: Alexander Shopov <ash@kambanaria.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 02:01:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGd2p-0007qp-HX
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 02:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbaHKAAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 20:00:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62001 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbaHKAAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 20:00:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68AA9314FD;
	Sun, 10 Aug 2014 20:00:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VKqiEdB0qWPWZP7vHWFkX8EIRR8=; b=koiC/I
	eyausZzuqOohjTDI2lPGXkgmcm93niRvvDxaU8hszSrlfMb1rgpVj+1ASJ4JZR36
	BGrAcZkfaZrcyDLksdhgRcHlfR4KlRlV9pTTKfNLKzXQ/fFCtidI8BMnvFqD72dH
	KoiC/Ibbqaoas5KXXRaH+e67hZRe2e/1miIVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ws3aMOqJrHeeEwvfKbhBvq8yazg8bVvD
	Mh3rSRmZH/BTaKUA/xhlPQff9CAoct9sUAgxbekNmc9ww+awPk94oKW7ZEVzxdlm
	q9gfVw24SYxOj8d2gymy5mWavzUWViUBIQHzxINaklBvTvP09Rg8myXmQzN85l1D
	NZgZ7hdC5Hg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D0FD314FC;
	Sun, 10 Aug 2014 20:00:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B116C314F0;
	Sun, 10 Aug 2014 20:00:46 -0400 (EDT)
In-Reply-To: <1407683607-4143-2-git-send-email-ash@kambanaria.org> (Alexander
	Shopov's message of "Sun, 10 Aug 2014 18:13:27 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8BD03014-20EA-11E4-9345-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255115>

Alexander Shopov <ash@kambanaria.org> writes:

> diff --git a/builtin/clean.c b/builtin/clean.c
> index 1032563..9f38068 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -514,7 +514,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
>  		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
>  		    (is_single && bottom != top)) {
>  			clean_print_color(CLEAN_COLOR_ERROR);
> -			printf_ln(_("Huh (%s)?"), (*ptr)->buf);
> +			printf_ln(_("Wrong choice (%s). Choose again."), (*ptr)->buf);

Why is this an improvement?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 5ed6036..cdc8a4e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1198,7 +1198,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	if (argc == 0 && (also || (only && !amend)))
>  		die(_("No paths with --include/--only does not make sense."));
>  	if (argc == 0 && only && amend)
> -		only_include_assumed = _("Clever... amending the last one with dirty index.");
> +		only_include_assumed = _("You are amending the last commit only. There are additional changes in the index.");

Why is this an improvement?

It would be very good to give a way for people to discover that
"commit --amend -o" (no other arguments) is a good way to amend only
the commit log message without changing the tree even when the user
has already added changes to the index.  But this message only
rewards those who already knew that trick and exercised it---when
they see it, they already know what they are doing.  In other words,
this is really a rare "expert-only" message.  I am not sure if
rewording would add much value to it, especially because it is very
unlikely for anybody to run "commit --amend -o" (no other arguments)
by mistake, expecting something else to happen, which warrant a
warning.

Besides, "amending the last commit only."  implies as if there is a
way to amend more than that (there isn't), and "additional changes
in the index" does not convey any extra information as to what would
happen to them---would they be recorded in the resulting tree, or
would they be left out?

>  	if (argc > 0 && !also && !only)
>  		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");

It may be time to remove these messages, by the way.  This one, and
the previous one, were remnants from the days we transitioned the
default behaviour of "git commit <path>" from "Record changes that
have already been added to the index plus the changes in the given
path" (aka "include/also") to "Record only changes in the given
path, temporarily disregarding the changes already added to the
index" (aka "only").  Giving this warning had some value to remind
people who were used to the then-old default, as the result would be
different with the then-new world order.  But these days, I do not
think people even remember that "include" used to be the default.

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 5568a5b..d9c5911 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1064,7 +1064,7 @@ static void parse_pack_objects(unsigned char *sha1)
>  		nr_delays--;
>  	}
>  	if (nr_delays)
> -		die(_("confusion beyond insanity in parse_pack_objects()"));
> +		die(_("fatal error in function \"parse_pack_objects\". This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org."));

It probably should be spelled die("BUG: ...").

> @@ -1139,7 +1139,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
>  		int nr_unresolved = nr_deltas - nr_resolved_deltas;
>  		int nr_objects_initial = nr_objects;
>  		if (nr_unresolved <= 0)
> -			die(_("confusion beyond insanity"));
> +			die(_("fatal error in function \"conclude_pack\". This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org."));

Likewise.

> diff --git a/builtin/log.c b/builtin/log.c
> index 4389722..d614a20 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -992,7 +992,7 @@ static const char *clean_message_id(const char *msg_id)
>  		m++;
>  	}
>  	if (!z)
> -		die(_("insane in-reply-to: %s"), msg_id);
> +		die(_("wrong format for the \"in-reply-to\" header: %s"), msg_id);

Why is s/insane/wrong format/ an improvement?

> @@ -1065,7 +1065,7 @@ static int output_directory_callback(const struct option *opt, const char *arg,
>  {
>  	const char **dir = (const char **)opt->value;
>  	if (*dir)
> -		die(_("Two output directories?"));
> +		die(_("Maximum one output directory is allowed."));

Why is it an improvement?

> diff --git a/builtin/merge.c b/builtin/merge.c
> index ce82eb2..e92a74a 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -842,7 +842,8 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
>  	struct commit_list *parents, **pptr = &parents;
>  
>  	write_tree_trivial(result_tree);
> -	printf(_("Wonderful.\n"));
> +	printf(_("The first part of the trivial merge finished successfully
> +.\n"));

Huh?

I would buy s/something/BUG: &/;, but I do not think we want to
apply most of the others.

Thanks.
