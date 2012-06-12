From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git bisect old/new
Date: Tue, 12 Jun 2012 16:54:18 -0700
Message-ID: <7vr4tkhys5.fsf@alter.siamese.dyndns.org>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <1339541765-2078-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 13 01:54:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seauo-0001cX-ME
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 01:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab2FLXyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 19:54:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403Ab2FLXyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 19:54:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10E9C9D2B;
	Tue, 12 Jun 2012 19:54:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UMCchVcVCTai8aq7XuLg09wjMJQ=; b=VEzdbP
	AzyDuxuwo1BnZr8PmP/TCQEP3aQzdN16Div6LoMsyJ93xeFcHGCC4Ol6Y8e4zCrU
	cNDiVBhngLf+iatxjIDSKTJhA12royVGLG+fd/L/A8bo47dpbJfTDPdsCIv/7Mtd
	GI8zNeyrEEkqfKfTtjkhn8AHbpQxzyMlw0jN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j9vU+tEdUiF3bHEC0MxxOGNWl1DIiPGD
	IX7NVLrlwMjy2Hf/98xVdYZe0UGJOrcd13MUNvFPI/AVrh7bU8zYs5DkwqhdCIwn
	4qXnTCxgzoeKdtUyP8vNu4UkwK217OiPJGpproHOPWDAqEhdrtvkUS69JGyIsvJK
	soMX6SmzsGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0665D9D2A;
	Tue, 12 Jun 2012 19:54:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F2879D29; Tue, 12 Jun 2012
 19:54:20 -0400 (EDT)
In-Reply-To: <1339541765-2078-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 (Valentin Duperray's message of "Wed, 13 Jun 2012 00:56:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED8DC844-B4E9-11E1-81A8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199871>

Valentin Duperray <Valentin.Duperray@ensimag.imag.fr> writes:

Please make sure that you have Christian who took the time to review
the previous round on Cc:, and have addressed the issues raised in
the review.

> Some commands are still not available for old/new:
>
>      * git bisect start [<new> [<old>...]] is not possible: the
>        commits will be treated as bad and good.
>      * git rev-list --bisect does not treat the revs/bisect/new and
>        revs/bisect/old-SHA1 files.
>      * thus, git bisect run <cmd> is not available for new/old.
>      * git bisect visualize seem to work partially: the tags are
>        displayed correctly but the tree is not limited to the bisect
>        section.

Would be easier to review if the subject is marked as RFC while
these todo items are still there.

Also before going too far into the implementation, I think it is a
good idea to think how you are going to address the above issues. I
suspect the changes to bisect.c will have to be vastly different
depending on that plan.

> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index e4f46bc..fc63894 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -18,8 +18,10 @@ on the subcommand:
>  
>   git bisect help
>   git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
> - git bisect bad [<rev>]
> - git bisect good [<rev>...]
> + git bisect (bad|new) [<rev>]
> + git bisect (good|old) [<rev>...]
> + git bisect new [<rev>]
> + git bisect old [<rev>...]

Huh?

> +If you are not at ease with the terms "bad" and "good", perhaps
> +because you are looking for the commit that introduced a fix, you can
> +alternatively use "new" and "old" instead.
> +But note that you cannot mix "bad" and good" with "new" and "old".
> +
> +------------------------------------------------
> +git bisect new [<rev>]
> +------------------------------------------------
> +
> +Same as "git bisect bad [<rev>]".

It somewhat makes me feel uneasy to see a sentence without any verb.

> +------------------------------------------------
> +git bisect old [<rev>...]
> +------------------------------------------------
> +
> +Same as "git bisect good [<rev>...]".

Likewise.

> +You must run `git bisect start` without commits as argument and run
> +`git bisect new <rev>`/`git bisect old <rev>...` after to add the
> +commits.

What happens when you do:

	git bisect start
        git bisect new HEAD
        git bisect old v1.0.0

and then

        git bisect bad v1.2.0

Does it error out?  For that matter, what happens if you do this?

	git bisect start
        git bisect new HEAD
	git bisect good v1.0.0

Note that I am not suggesting to document the behaviour here.

> @@ -374,6 +401,18 @@ In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit
>  has at least one parent whose reachable graph is fully traversable in the sense
>  required by 'git pack objects'.
>  
> +* Look for a fix instead of a regression in the code
> ++
> +------------
> +$ git bisect start
> +$ git bisect new		# Current version is fixed
> +$ git bisect old bugged_version	# bugged_version was the last version
> +				# known to be unfixed

We do not usually use "bug" as a transitive verb that means "to
break".  Perhaps "buggy_version" is easier to read and gramatically
more correct.

> ++
> +The "new" commits are the fixed ones and the "old" commits are the unfixed ones.
> +At the end of the commit session, you will have the first fixed commit.
> +

commit session?  Is it a bisect session?

> diff --git a/bisect.c b/bisect.c
> index 48acf73..38de2d5 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -21,6 +21,9 @@ static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
>  static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
>  static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD", NULL, NULL};
>  
> +static const char *bisect_bad;
> +static const char *bisect_good;
> +
>  /* bits #0-15 in revision.h */
>  
>  #define COUNTED		(1u<<16)
> @@ -403,9 +406,10 @@ struct commit_list *find_bisection(struct commit_list *list,
>  static int register_ref(const char *refname, const unsigned char *sha1,
>  			int flags, void *cb_data)
>  {
> -	if (!strcmp(refname, "bad")) {
> +	if (!strcmp(refname, bisect_bad)) {
>  		current_bad_sha1 = sha1;
> -	} else if (!prefixcmp(refname, "good-")) {
> +	} else if (!prefixcmp(refname, "good-") ||
> +			!prefixcmp(refname, "old-")) {

It feels kind of strange that only one of "bad" or "new" is allowed,
while "good-X" and "old-Y" can coexist and be used interchangeably.

> @@ -731,18 +735,25 @@ static void handle_bad_merge_base(void)
>  	if (is_expected_rev(current_bad_sha1)) {
>  		char *bad_hex = sha1_to_hex(current_bad_sha1);
>  		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
> +		if (!strcmp(bisect_bad,"bad")) {

s/,/, /;

But see below.  It feels wrong to always running string comparison
when we know there are either good/bad mode or old/new mode.

> -	fprintf(stderr, "Some good revs are not ancestor of the bad rev.\n"
> +	fprintf(stderr, "Some %s revs are not ancestor of the %s rev.\n"
>  		"git bisect cannot work properly in this case.\n"
> -		"Maybe you mistake good and bad revs?\n");
> +		"Maybe you mistake %s and %s revs?\n",
> +		bisect_good, bisect_bad, bisect_good,
> +		bisect_bad);

You merely inherited this from the original, but shouldn't it be
"mistook" in the past tense?

> @@ -889,6 +900,31 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
>  }
>  
>  /*
> + * The terms used for this bisect session are stocked in
> + * BISECT_TERMS: it can be bad/good or new/old.
> + * We read them and stock them to adapt the messages
> + * accordingly. Default is bad/good.
> + */
> +void read_bisect_terms(void)
> +{
> +	struct strbuf str = STRBUF_INIT;
> +	const char *filename = git_path("BISECT_TERMS");
> +	FILE *fp = fopen(filename, "r");
> +
> +	if (!fp) {
> +		bisect_bad = "bad";
> +		bisect_good = "good";
> +	} else {
> +	strbuf_getline(&str, fp, '\n');
> +	bisect_bad = strbuf_detach(&str, NULL);
> +	strbuf_getline(&str, fp, '\n');
> +	bisect_good = strbuf_detach(&str, NULL);
> +	}
> +	strbuf_release(&str);
> +	fclose(fp);
> +}

While this is not wrong per-se, I am not sure if storing and reading
two lines from this file is really worth the trouble.

Wouldn't it be easier to change the convention so that the presense
of BISECT_OLDNEW file signals that the program is working in the
old/new mode as opposed to the traditional good/bad mode, or perhaps
a single line "true" or "false" in the file tells us if we are in
OLDNEW mode, or something?
