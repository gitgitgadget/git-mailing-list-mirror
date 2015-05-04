From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix a translation error in diff-tree
Date: Mon, 04 May 2015 10:47:41 -0700
Message-ID: <xmqqh9rstete.fsf@gitster.dls.corp.google.com>
References: <55476653.e33ac20a.753d.ffffc3cc@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 19:47:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpKT7-00008K-5S
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 19:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbbEDRrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 13:47:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750919AbbEDRro (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 13:47:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBC7B4C9CA;
	Mon,  4 May 2015 13:47:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kH/7WhFTxc4mkhoInY8SFKp0mUQ=; b=t1BY56
	nC78BFkHiUxLCvwt5ZpJHAYUEBHVbnVACz8JvKpkJg0K7gOVdk6j9kdK2IWGpcTb
	hNWU0yjtflQtH8Sqm+Vnhpju6iAhqTiqNywAOtoSEqyHqzrwURfYRYifNkK0CJ1C
	8/LY5PozPNhmTArHVQh8jLXOW2xn78qMvUkYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSuh8HOapMlw1dBDmTz1mUl1hltaxNIP
	3fwKx/VtHnaSdBWlYqLhvz+g4/lT93It5Gj09JHNE3Q7A+7+OSbauUNsCZHoRa/E
	a17vQNrkmofRsODaDhDW0W7Z8/m6TCfMVvEpva7kiPRvxdvql0+IxOneBTqJAfIk
	xcWP/BmV+sE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D38644C9C9;
	Mon,  4 May 2015 13:47:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53E2D4C9BA;
	Mon,  4 May 2015 13:47:43 -0400 (EDT)
In-Reply-To: <55476653.e33ac20a.753d.ffffc3cc@mx.google.com> (Alangi Derick's
	message of "Mon, 4 May 2015 12:22:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA8851CC-F285-11E4-B235-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268335>

Alangi Derick <alangiderick@gmail.com> writes:

[... actually he writes nothing here ;-) ...]

> Signed-off-by: Alangi Derick <alangiderick@gmail.com>
> ---

>> Subject: Re: [PATCH] fix a translation error in diff-tree

Among many ones you sent recently, this title looks the closest in
shape to what SubmittingPatches expects to see.  It however is not
quite there; SubmittingPatches prefers to see an "<area>:" prefix so
that output of "git shortlog --no-merges -100" would give the
readers a better overview of the changes.

When "fix a translation error in diff-tree" appears among 100 other
commits in "git shortlog" output, what kind of change would a reader
imagine this to be, though?

My answer to that question would be: "There was an existing
translation of diff-tree output, that was incorrect in some
unspecified way, and this change corrects that breakage."

And that is not what is going on, so the change is mistitled.
Perhaps

    diff-tree.c: mark error strings for translation

or something, modelling after 8262aaa2 (config.c: mark error and
warnings strings for translation, 2014-08-07), may be more
appropriate.

Having said all that, I do not think we should break scripts by
adding _("") to "git diff-tree" which is a plumbing command whose
output is meant for machine consumption.

>  builtin/diff-tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index 12b683d..602b5f9 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -45,7 +45,7 @@ static int stdin_diff_trees(struct tree *tree1, char *line, int len)
>  	unsigned char sha1[20];
>  	struct tree *tree2;
>  	if (len != 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1))
> -		return error("Need exactly two trees, separated by a space");
> +		return error(_("Need exactly two trees, separated by a space"));
>  	tree2 = lookup_tree(sha1);
>  	if (!tree2 || parse_tree(tree2))
>  		return -1;
> @@ -75,7 +75,7 @@ static int diff_tree_stdin(char *line)
>  		return stdin_diff_commit((struct commit *)obj, line, len);
>  	if (obj->type == OBJ_TREE)
>  		return stdin_diff_trees((struct tree *)obj, line, len);
> -	error("Object %s is a %s, not a commit or tree",
> +	error(_("Object %s is a %s, not a commit or tree"),
>  	      sha1_to_hex(sha1), typename(obj->type));
>  	return -1;
>  }
