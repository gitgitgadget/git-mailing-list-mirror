From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/12] pretty: share code between format_decoration
 and show_decorations
Date: Mon, 01 Apr 2013 10:53:20 -0700
Message-ID: <7vd2uejfxr.fsf@alter.siamese.dyndns.org>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 19:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMivb-0002l9-BB
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 19:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758340Ab3DARxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 13:53:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756800Ab3DARxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 13:53:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0887511288;
	Mon,  1 Apr 2013 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oUbNKQpeXPjK
	zSYGvmRHoxR6YwQ=; b=dbjQSvIfK99ABKi44fzEbiz2f1vtKuKe8hECUD+0q+Vi
	K/Sx9lqg8bd9GjdgP0fk/JZvEajvOxDg1arX5CPJUeBWw2XWVUKqkiQQ9U4C5prJ
	1cxFtysGskB2Q2LH+g4pQaxYCuL3MIMm8bc01zEpMMsslmnTTqs0Hi3u9M4rrMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gn6QJb
	EE6YVvLt64rZH2UTOOmUQk5puIj2XBWXtGOCJD0OcwGkrZQfmCPR3Cg3eTf/WiyF
	wLdfJNPu6vdAjSrdlBnW098pmF7p6gRhunke88/zvL49I/zvtMUrH5l1whmtRXpO
	L6Igl/MmlG6GMgSf9/u5x2oAAuTd+Kszc9L7o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F145A11286;
	Mon,  1 Apr 2013 17:53:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 405B811283; Mon,  1 Apr
 2013 17:53:22 +0000 (UTC)
In-Reply-To: <1364636112-15065-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 30 Mar
 2013 16:35:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B5B7F32-9AF5-11E2-9123-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219695>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This also adds color support to format_decoration()
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  log-tree.c                       | 60 +++++++++++++++++++++++++-----=
----------
>  log-tree.h                       |  3 ++
>  pretty.c                         | 19 +------------
>  t/t4207-log-decoration-colors.sh |  8 +++---
>  4 files changed, 45 insertions(+), 45 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 5dc45c4..7467a1d 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -174,36 +174,50 @@ static void show_children(struct rev_info *opt,=
 struct commit *commit, int abbre
>  	}
>  }
> =20
> -void show_decorations(struct rev_info *opt, struct commit *commit)
> +void format_decoration(struct strbuf *sb,
> +		       const struct commit *commit,
> +		       int use_color)
>  {
> -	const char *prefix;
> -	struct name_decoration *decoration;
> +	const char *prefix =3D " (";
> +	struct name_decoration *d;

This renaming of variable from decoration to d seems to make the
patched result unnecessarily different from the original in
show_decorations, making it harder to compare.  Intentional?

>  	const char *color_commit =3D
> -		diff_get_color_opt(&opt->diffopt, DIFF_COMMIT);
> +		diff_get_color(use_color, DIFF_COMMIT);
>  	const char *color_reset =3D
> -		decorate_get_color_opt(&opt->diffopt, DECORATION_NONE);
> +		decorate_get_color(use_color, DECORATION_NONE);
> +
> +	load_ref_decorations(DECORATE_SHORT_REFS);

In cmd_log_init_finish(), we have loaded decorations with specified
decoration_style already.  Why is this needed (and with a hardcoded
style that may be different from what the user specified)?

> +	d =3D lookup_decoration(&name_decoration, &commit->object);
> +	if (!d)
> +		return;
> +	while (d) {
> +		strbuf_addstr(sb, color_commit);
> +		strbuf_addstr(sb, prefix);
> +		strbuf_addstr(sb, decorate_get_color(use_color, d->type));
> +		if (d->type =3D=3D DECORATION_REF_TAG)
> +			strbuf_addstr(sb, "tag: ");
> +		strbuf_addstr(sb, d->name);
> +		strbuf_addstr(sb, color_reset);
> +		prefix =3D ", ";
> +		d =3D d->next;
> +	}
> +	if (prefix[0] =3D=3D ',') {
> +		strbuf_addstr(sb, color_commit);
> +		strbuf_addch(sb, ')');
> +		strbuf_addstr(sb, color_reset);
> +	}

Was this change to conditionally close ' (' mentioned in the log
message?  It is in line with the version taken from pretty.c, and I
think it may be an improvement, but I do not think the check is
necessary in the context of this function.  You will never see
prefix[0] !=3D ',' after the loop, because "while (d)" above runs at
least once; otherwise the "if (!d) return" would have returned from
the function early, no?

> +}
> +
> +void show_decorations(struct rev_info *opt, struct commit *commit)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> =20
>  	if (opt->show_source && commit->util)
>  		printf("\t%s", (char *) commit->util);
>  	if (!opt->show_decorations)
>  		return;
> -	decoration =3D lookup_decoration(&name_decoration, &commit->object)=
;
> -	if (!decoration)
> -		return;
> -	prefix =3D " (";
> -	while (decoration) {
> -		printf("%s", prefix);
> -		fputs(decorate_get_color_opt(&opt->diffopt, decoration->type),
> -		      stdout);
> -		if (decoration->type =3D=3D DECORATION_REF_TAG)
> -			fputs("tag: ", stdout);
> -		printf("%s", decoration->name);
> -		fputs(color_reset, stdout);
> -		fputs(color_commit, stdout);
> -		prefix =3D ", ";
> -		decoration =3D decoration->next;
> -	}
> -	putchar(')');
> +	format_decoration(&sb, commit, opt->diffopt.use_color);
> +	fputs(sb.buf, stdout);
> +	strbuf_release(&sb);
>  }
> =20
>  /*
> @@ -625,8 +639,8 @@ void show_log(struct rev_info *opt)
>  			printf(" (from %s)",
>  			       find_unique_abbrev(parent->object.sha1,
>  						  abbrev_commit));
> +		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), stdout);
>  		show_decorations(opt, commit);
> -		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));

We used to show and then reset.  I can see the updated
show_decorations() to format_decoration() callchain always reset at
the end, so the loss of the final reset here is very sane, but is
there a need to reset beforehand?  What is the calling convention
for the updated show_decorations()?  The caller should make sure
there is no funny colors in effect before calling, and the caller
can rest assured that there is no funny colors when the function
returns?

> diff --git a/log-tree.h b/log-tree.h
> index 9140f48..e6a2da5 100644
> --- a/log-tree.h
> +++ b/log-tree.h
> @@ -13,6 +13,9 @@ int log_tree_diff_flush(struct rev_info *);
>  int log_tree_commit(struct rev_info *, struct commit *);
>  int log_tree_opt_parse(struct rev_info *, const char **, int);
>  void show_log(struct rev_info *opt);
> +void format_decoration(struct strbuf *sb,
> +		       const struct commit *commit,
> +		       int use_color);

I think you can fit these on a single line, especially if you drop
the unused variable names (they help when there are more than one
parameter of the same type to document the order of the arguments,
but that does not apply here).  That would help people who run
"grep" on the header files without using CTAGS/ETAGS.

Wouldn't it be "format_decorations()", or does it handle only one?
