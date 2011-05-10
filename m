From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v3 6/6] git-grep: Bail out when -P is used with -F or -E
Date: Tue, 10 May 2011 07:24:39 +0200
Message-ID: <20110510072439.6b288715@mkiedrowicz>
References: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1304977928-7142-7-git-send-email-michal.kiedrowicz@gmail.com>
	<7vfwonmikr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 07:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfh5-0006Tq-VB
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab1EJFlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 01:41:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34044 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1EJFlI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 01:41:08 -0400
Received: by eyx24 with SMTP id 24so1731870eyx.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 22:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=LqXLUEffuitAdWOFfq40NVXsaQ1NkpzAr66i4BYv4n4=;
        b=q4KKRJS+AsKaQJhloVAFcNdJVQoNpKAazVOM3rwTFd1GJEv/3SXUp/DIBd4ZbLfyBW
         GNYPEVD0UqhiuBGHesmjEmxc77o6gSs3+C1hEGwfeXlpF6sPGtiUTzhVNHBlyhScz8ut
         s+2y5NPrrCaMDzvRSBQZsOZ6+PNfRbsuaDt2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=HvAn2LvrEpeKunbXmQg9Ndy0abnXs82dpo8d/piSpA9wpVQEAaEsq/IgKlPhW3dfSC
         B5gJUha11g6JUvFY3IiNGj8qjy3kM3GzIVHd8VvUtO39+/oFPr/wmpsBkm/0MifPfwo0
         /9gR8tpL4SvYqBnp8+g0OzPPXm6rM7cXJq+2w=
Received: by 10.14.38.14 with SMTP id z14mr3634877eea.169.1305005081811;
        Mon, 09 May 2011 22:24:41 -0700 (PDT)
Received: from mkiedrowicz (pc10.ivo.park.gdynia.pl [153.19.128.10])
        by mx.google.com with ESMTPS id s62sm4012740eea.10.2011.05.09.22.24.41
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 22:24:41 -0700 (PDT)
In-Reply-To: <7vfwonmikr.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173303>

On 09.05.2011 18:48:36 -0700 Junio C Hamano <gitster@pobox.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > This also makes it bail out when grep.extendedRegexp is enabled.
>=20
> That is a no-starter.  "git grep -P foo" from the command line should
> just ignore the configured default.  It is not entirely your fault,
> as I think you inherited the bug from the existing code that lets
> grep.extendedRegexp interact with the "--fixed" option from the
> command line.
>=20
> > But `git grep -G -P pattern` and `git grep -E -G -P pattern` still
> > work because -G and -E set opts.regflags during parse_options() and
> > there is no way to detect `-G` or `-E -G`.
>=20
> How about following the usual pattern of letting the last one win?
>=20
> Perhaps like this?  This is not even compile tested, but should apply
> cleanly on top of, and can be squashed into, your 6/6.  You of course
> would need to rewrite the commit log message and documentation, if yo=
u
> said only one of these can be used.

Sounds good, thanks.

>=20
> We would need some tests for "grep -P", no? =20

What about those in patch 5/6?

> Please throw in the
> "last one wins" and "command line defeats configuration" when you add
> one.
>=20
> Also I deliberately said "--ignore-case and -P are not compatible
> (yet)"; shouldn't you be able to do ignore case fairly easily, I
> wonder?  Isn't it just the matter of wrapping each one with "(?i:"
> and ")" pair, or anything more involved necessary?

If you look at patch 3/6 you will see:

+
+	if (opt->ignore_case)
+		options |=3D PCRE_CASELESS;
+
+	p->pcre_regexp =3D pcre_compile(p->pattern, options, &error,
&erroffset,
+			NULL);

and also

+test_expect_success LIBPCRE 'grep -P -i pattern' '

in patch 5/6 :). Or perhaps it doesn't work for you?

>=20
>  builtin/grep.c |   58
> +++++++++++++++++++++++++++++++++++++++++++------------ 1 files
> changed, 45 insertions(+), 13 deletions(-)
>=20
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8e422b3..37f2331 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -753,6 +753,15 @@ int cmd_grep(int argc, const char **argv, const
> char *prefix) int i;
>  	int dummy;
>  	int use_index =3D 1;
> +	enum {
> +		pattern_type_unspecified =3D 0,
> +		pattern_type_bre,
> +		pattern_type_ere,
> +		pattern_type_fixed,
> +		pattern_type_pcre,
> +	};
> +	int pattern_type =3D pattern_type_unspecified;
> +
>  	struct option options[] =3D {
>  		OPT_BOOLEAN(0, "cached", &cached,
>  			"search in index instead of in the work
> tree"), @@ -774,15 +783,18 @@ int cmd_grep(int argc, const char
> **argv, const char *prefix) "descend at most <depth> levels",
> PARSE_OPT_NONEG, NULL, 1 },
>  		OPT_GROUP(""),
> -		OPT_BIT('E', "extended-regexp", &opt.regflags,
> -			"use extended POSIX regular expressions",
> REG_EXTENDED),
> -		OPT_NEGBIT('G', "basic-regexp", &opt.regflags,
> -			"use basic POSIX regular expressions
> (default)",
> -			REG_EXTENDED),
> -		OPT_BOOLEAN('F', "fixed-strings", &opt.fixed,
> -			"interpret patterns as fixed strings"),
> -		OPT_BOOLEAN('P', "perl-regexp", &opt.pcre,
> -				"use Perl-compatible regular
> expressions"),
> +		OPT_SET_INT('E', "extended-regexp", &pattern_type,
> +			    "use extended POSIX regular expressions",
> +			    pattern_type_ere),
> +		OPT_SET_INT('G', "basic-regexp", &pattern_type,
> +			    "use basic POSIX regular expressions
> (default)",
> +			    pattern_type_bre),
> +		OPT_SET_INT('F', "fixed-strings", &pattern_type,
> +			    "interpret patterns as fixed strings",
> +			    pattern_type_fixed),
> +		OPT_SET_INT('P', "perl-regexp", &pattern_type,
> +			    "use Perl-compatible regular
> expressions",
> +			    pattern_type_pcre),
>  		OPT_GROUP(""),
>  		OPT_BOOLEAN('n', "line-number", &opt.linenum, "show
> line numbers"), OPT_NEGBIT('h', NULL, &opt.pathname, "don't show
> filenames", 1), @@ -888,6 +900,28 @@ int cmd_grep(int argc, const
> char **argv, const char *prefix) PARSE_OPT_KEEP_DASHDASH |
>  			     PARSE_OPT_STOP_AT_NON_OPTION |
>  			     PARSE_OPT_NO_INTERNAL_HELP);
> +	switch (pattern_type) {
> +	case pattern_type_fixed:
> +		opt.fixed =3D 1;
> +		opt.pcre =3D 0;
> +		break;
> +	case pattern_type_bre:
> +		opt.fixed =3D 0;
> +		opt.pcre =3D 0;
> +		opt.regflags &=3D ~REG_EXTENDED;
> +		break;
> +	case pattern_type_ere:
> +		opt.fixed =3D 0;
> +		opt.pcre =3D 0;
> +		opt.regflags |=3D REG_EXTENDED;
> +		break;
> +	case pattern_type_pcre:
> +		opt.fixed =3D 0;
> +		opt.pcre =3D 1;
> +		break;
> +	default:
> +		break; /* nothing */
> +	}
> =20
>  	if (use_index && !startup_info->have_repository)
>  		/* die the same way as if we did it at the beginning
> */ @@ -925,12 +959,10 @@ int cmd_grep(int argc, const char **argv,
> const char *prefix)=20
>  	if (!opt.pattern_list)
>  		die(_("no pattern given."));
> -	if (opt.regflags !=3D REG_NEWLINE && opt.pcre)
> -		die(_("cannot mix --extended-regexp and
> --perl-regexp")); if (!opt.fixed && opt.ignore_case)
>  		opt.regflags |=3D REG_ICASE;
> -	if ((opt.regflags !=3D REG_NEWLINE || opt.pcre) && opt.fixed)
> -		die(_("cannot mix --fixed-strings and regexp"));
> +	if (opt.pcre && opt.ignore_case)
> +		die(_("--ignore-case and -P are not compatible
> (yet)"));=20
>  #ifndef NO_PTHREADS
>  	if (online_cpus() =3D=3D 1 || !grep_threads_ok(&opt))
>=20
