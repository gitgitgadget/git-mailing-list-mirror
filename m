From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 24/39] i18n: bisect: enable l10n of bisect terms in messages
Date: Wed, 01 Jun 2016 10:38:21 -0700
Message-ID: <xmqq4m9czu5u.fsf@gitster.mtv.corp.google.com>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
	<1464799289-7639-25-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed Jun 01 19:38:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8A6E-0008Bz-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 19:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbcFARiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 13:38:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751385AbcFARiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 13:38:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86B2321655;
	Wed,  1 Jun 2016 13:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lC4Zbv6Pihbljrnw9st8uyFkyPM=; b=kD6o1m
	MvNY7O++4bKcSdUiqRuihpSTIT2lCz6pvgWLXnv81X4x0SI5IHA6yniRdA0A0pyV
	OmxK6dgQSmQrrEXE3+PUMeSP4T2UjQnMwBI8SPeHmaB1PnmNP3OUKOBY37fHwHcq
	OzXWN34487WsLQuohriLi1vdcGXZRVxdm5CTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZHjrq9BGudZNsOnNfk9p1qy/OJtEqQPd
	4fZQ2BlQWnBWu/y4H3oJ2vjYLHCnvZ5d9OX9k3sdbdt3AhFmfoQ6d3VSKV56zQ7n
	5iqYiFjt8IocSUL/1ekrjOwz8acJw5NxctErDTurgsQXP6PAJJLehUKWqhPeldB+
	75KfOWnLeH0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C83521654;
	Wed,  1 Jun 2016 13:38:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0AFA2164F;
	Wed,  1 Jun 2016 13:38:22 -0400 (EDT)
In-Reply-To: <1464799289-7639-25-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Wed, 1 Jun 2016 16:41:14 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A34978D4-281F-11E6-BC63-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296137>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> +enum term { BAD, GOOD, OLD, NEW };
> +static const char *term_names[] = {
> +/* TRANSLATORS: in bisect.c source code file, the following terms are
> +   used to describe a "bad commit", "good commit", "new revision", etc.
> +   Please, if you can, check the source when you are not sure if a %s
> +   would be replaced by one of the following terms. */
> +	N_("bad"), N_("good"), N_("old"), N_("new"),  NULL
> +};
> +
>  /* Remember to update object flag allocation in object.h */
>  #define COUNTED		(1u<<16)
>  
> @@ -725,12 +734,12 @@ static void handle_bad_merge_base(void)
>  	if (is_expected_rev(current_bad_oid)) {
>  		char *bad_hex = oid_to_hex(current_bad_oid);
>  		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
> -		if (!strcmp(term_bad, "bad") && !strcmp(term_good, "good")) {
> +		if (!strcmp(term_bad, term_names[BAD]) && !strcmp(term_good, term_names[GOOD])) {
>  			fprintf(stderr, _("The merge base %s is bad.\n"
>  				"This means the bug has been fixed "
>  				"between %s and [%s].\n"),
>  				bad_hex, bad_hex, good_hex);
> -		} else if (!strcmp(term_bad, "new") && !strcmp(term_good, "old")) {
> +		} else if (!strcmp(term_bad, term_names[NEW]) && !strcmp(term_good, term_names[OLD])) {
>  			fprintf(stderr, _("The merge base %s is new.\n"
>  				"The property has changed "
>  				"between %s and [%s].\n"),
> @@ -739,7 +748,7 @@ static void handle_bad_merge_base(void)
>  			fprintf(stderr, _("The merge base %s is %s.\n"
>  				"This means the first '%s' commit is "
>  				"between %s and [%s].\n"),
> -				bad_hex, term_bad, term_good, bad_hex, good_hex);
> +				bad_hex, _(term_bad), _(term_good), bad_hex, good_hex);

These "bad" and "good" that are compared with term_bad and term_good
are the literal tokens the end user gives from the "git bisect"
command line.  I do not think you would want to catch them with

    $ git bisect novo <rev>
    $ git bisect velho <rev>

unless the user has done

    $ git bisect --term-old=velho --term-new=novo

previously.

And that "custom bisect terms" case is covered by the last "else"
clause in this if/elseif cascade (outside the context we can see in
your message).

The only thing you need to do around here is to mark the string as
translatable.  I do not think we need "enum term", or term_names[].

> @@ -747,7 +756,7 @@ static void handle_bad_merge_base(void)
>  	fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
>  		"git bisect cannot work properly in this case.\n"
>  		"Maybe you mistook %s and %s revs?\n"),
> -		term_good, term_bad, term_good, term_bad);
> +		_(term_good), _(term_bad), _(term_good), _(term_bad));

Likewise for all _(term_good), _(term_bad) and use of term_names[]
we see in this patch.
