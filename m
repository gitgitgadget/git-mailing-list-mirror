From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 02/19] rebase -i: reword complains about empty commit despite --keep-empty
Date: Tue, 08 Jul 2014 13:37:38 -0700
Message-ID: <xmqqpphf8u3x.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<b7ee74ddb785f0e087b30ca6be11723ca199fa03.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 22:37:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4c98-0003PT-P9
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 22:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbaGHUhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 16:37:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62000 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbaGHUhp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 16:37:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E635264C1;
	Tue,  8 Jul 2014 16:37:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7v4fOziLU1Pmuf4w85bAzZtnWSE=; b=eta9o8
	hrdVFJAz0IjAef3gIKdWgTGlCT8vWjBzZp3OHsdiz+dWF//Wh1mpn4e+4WmLZNfz
	coBU5pjuaztd/PE7PKJZywXSRlwkoJkEv9MIh1ZPL/0Ot47nEHq9DJDNqFMNcV5s
	fj5d1bBm3tYFXv2VKea5lE4hPDjxghNzZXci0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=REJJLG9k5AQzPc4SdfVoWoxzeGfefZ9z
	xK+RKr4qDavYcyiICwPsnbkZg7rP0SqwQF3wWmERH8atTciGI++4Uvnprh7jHYap
	ycbH94H7d1Ku7DKE296jnw/CoMKz5gfAdkBPpoYHN4YnD/Vlw4vQeM866b9lup1D
	RmEo1IFtZj8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14BD3264C0;
	Tue,  8 Jul 2014 16:37:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B3CF8264BE;
	Tue,  8 Jul 2014 16:37:24 -0400 (EDT)
In-Reply-To: <b7ee74ddb785f0e087b30ca6be11723ca199fa03.1404323078.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 2 Jul 2014 19:47:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AB30162E-06DF-11E4-972E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253045>

Fabian Ruch <bafain@gmail.com> writes:

> Subject: rebase -i: reword complains about empty commit despite --keep-empty

I had to read the title and then the log twice before understanding
that the above is not "change the complaint message" (i.e. "reword
complaints" spelled incorrectly) but is a description of the current
behaviour (i.e. "the command complains when 'reword' is used on an
empty commit") that is not accompanied by an evaluation ("ok, it
complains; are you saying it is a good thing or a bad thing?") or an
action ("if it is a bad thing, what are you doing about it?").

Perhaps

	rebase -i: allow rewording an empty commit

or something?

> The to-do list command `reword` replays a commit like `pick` but lets
> the user also edit the commit's log message. If `--keep-empty` is
> passed as option to git-rebase--interactive, empty commits ought to
> be replayed without complaints. However, if the users chooses to
> reword an empty commit by changing the respective to-do list entry
> from
>
>     pick fa1afe1 Empty commit
>
> to
>
>     reword fa1afe1 Empty commit
>
> , then git-rebase--interactive suddenly fails to replay the empty
> commit. This is especially counterintuitive because `reword` is
> thought of as a `pick` that alters the log message in some way but
> nothing more and the unchanged to-do list entry would not fail.
>
> Handle `reword` by cherry-picking the named commit and editing the
> log message using
>
>     git commit --allow-empty --amend
>
> instead of
>
>     git commit --amend.
>
> Add test.
>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh    | 2 +-
>  t/t3404-rebase-interactive.sh | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index e733d7f..689400e 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -504,7 +504,7 @@ do_next () {
>  
>  		mark_action_done
>  		do_pick $sha1 "$rest"
> -		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
> +		git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
>  			warn "Could not amend commit after successfully picking $sha1... $rest"
>  			exit_with_patch $sha1 1
>  		}
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8197ed2..9931143 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -75,6 +75,14 @@ test_expect_success 'rebase --keep-empty' '
>  	test_line_count = 6 actual
>  '
>  
> +test_expect_success 'rebase --keep-empty' '
> +	git checkout emptybranch &&
> +	set_fake_editor &&
> +	FAKE_LINES="1 reword 2" git rebase --keep-empty -i HEAD~2 &&
> +	git log --oneline >actual &&
> +	test_line_count = 6 actual
> +'
> +
>  test_expect_success 'rebase -i with the exec command' '
>  	git checkout master &&
>  	(
