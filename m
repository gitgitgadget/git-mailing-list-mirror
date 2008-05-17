From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add color.diff.{header,message} formats
Date: Sat, 17 May 2008 15:07:39 +0200
Message-ID: <20080517130739.GA2326@artemis.madism.org>
References: <1209980316-7340-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="J/dobhs11T7y2rNN";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 17 15:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxMGc-0004gj-IX
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 15:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbYEQNOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 09:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbYEQNOo
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 09:14:44 -0400
Received: from pan.madism.org ([88.191.52.104]:34434 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440AbYEQNOm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 09:14:42 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 May 2008 09:14:42 EDT
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5E04537231;
	Sat, 17 May 2008 15:07:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 711462E499E; Sat, 17 May 2008 15:07:39 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <1209980316-7340-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82347>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Hmmm it seems this patch has been somehow lost somewhere, is there
anything wrong with it ?

On Mon, May 05, 2008 at 09:38:36AM +0000, Pierre Habouzit wrote:
> The goal is to be able to read git log -p more easily, and commit messages
> tends to meld within the diff. Now it's possible to set e.g.
> color.diff.message to 'bold' and read them more easily.
>=20
> Defaults for those two colors are set to normal color to match previous
> behavior.
>=20
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-branch.c      |    2 +-
>  builtin-checkout.c    |    2 +-
>  builtin-log.c         |    8 ++++----
>  builtin-rev-list.c    |    2 +-
>  builtin-show-branch.c |    2 +-
>  commit.h              |    8 +++++---
>  diff.c                |    6 ++++++
>  diff.h                |    2 ++
>  log-tree.c            |    6 +++---
>  pretty.c              |   43 ++++++++++++++++++++++++++++++-------------
>  10 files changed, 54 insertions(+), 27 deletions(-)
>=20
> diff --git a/builtin-branch.c b/builtin-branch.c
> index 19c508a..c2f4227 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -315,7 +315,7 @@ static void print_ref_item(struct ref_item *item, int=
 maxwidth, int verbose,
> =20
>  		commit =3D lookup_commit(item->sha1);
>  		if (commit && !parse_commit(commit)) {
> -			pretty_print_commit(CMIT_FMT_ONELINE, commit,
> +			pretty_print_commit(CMIT_FMT_ONELINE, NULL, commit,
>  					    &subject, 0, NULL, NULL, 0, 0);
>  			sub =3D subject.buf;
>  		}
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index 28722aa..b89851d 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -142,7 +142,7 @@ static void describe_detached_head(char *msg, struct =
commit *commit)
>  	struct strbuf sb;
>  	strbuf_init(&sb, 0);
>  	parse_commit(commit);
> -	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, 0, "", "", 0, 0);
> +	pretty_print_commit(CMIT_FMT_ONELINE, NULL, commit, &sb, 0, "", "", 0, =
0);
>  	fprintf(stderr, "%s %s... %s\n", msg,
>  		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
>  	strbuf_release(&sb);
> diff --git a/builtin-log.c b/builtin-log.c
> index 5e9c256..9efb3ad 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -693,11 +693,11 @@ static void make_cover_letter(struct rev_info *rev,=
 int use_stdout,
> =20
>  	msg =3D body;
>  	strbuf_init(&sb, 0);
> -	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
> +	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, "", committer, DATE_RFC2822,
>  		     encoding);
>  	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
>  		      encoding, need_8bit_cte);
> -	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0);
> +	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, "", 0);
>  	printf("%s\n", sb.buf);
> =20
>  	strbuf_release(&sb);
> @@ -1160,8 +1160,8 @@ int cmd_cherry(int argc, const char **argv, const c=
har *prefix)
>  		if (verbose) {
>  			struct strbuf buf;
>  			strbuf_init(&buf, 0);
> -			pretty_print_commit(CMIT_FMT_ONELINE, commit,
> -			                    &buf, 0, NULL, NULL, 0, 0);
> +			pretty_print_commit(CMIT_FMT_ONELINE, &revs.diffopt,
> +			                    commit, &buf, 0, NULL, NULL, 0, 0);
>  			printf("%c %s %s\n", sign,
>  			       sha1_to_hex(commit->object.sha1), buf.buf);
>  			strbuf_release(&buf);
> diff --git a/builtin-rev-list.c b/builtin-rev-list.c
> index 9199b32..240fc8d 100644
> --- a/builtin-rev-list.c
> +++ b/builtin-rev-list.c
> @@ -103,7 +103,7 @@ static void show_commit(struct commit *commit)
>  	if (REV_DIFF_TST(&revs, VERBOSE_HEADER) && commit->buffer) {
>  		struct strbuf buf;
>  		strbuf_init(&buf, 0);
> -		pretty_print_commit(revs.commit_format, commit,
> +		pretty_print_commit(revs.commit_format, &revs.diffopt, commit,
>  				    &buf, revs.abbrev, NULL, NULL,
>  				    revs.date_mode, 0);
>  		if (buf.len)
> diff --git a/builtin-show-branch.c b/builtin-show-branch.c
> index 019abd3..39a8b04 100644
> --- a/builtin-show-branch.c
> +++ b/builtin-show-branch.c
> @@ -265,7 +265,7 @@ static void show_one_commit(struct commit *commit, in=
t no_name)
> =20
>  	strbuf_init(&pretty, 0);
>  	if (commit->object.parsed) {
> -		pretty_print_commit(CMIT_FMT_ONELINE, commit,
> +		pretty_print_commit(CMIT_FMT_ONELINE, NULL, commit,
>  				    &pretty, 0, NULL, NULL, 0, 0);
>  		pretty_str =3D pretty.buf;
>  	}
> diff --git a/commit.h b/commit.h
> index 2d94d41..6175e0f 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -5,6 +5,7 @@
>  #include "tree.h"
>  #include "strbuf.h"
>  #include "decorate.h"
> +#include "diff.h"
> =20
>  struct commit_list {
>  	struct commit *item;
> @@ -67,13 +68,13 @@ struct rev_info; /* in revision.h, it circularly uses=
 enum cmit_fmt */
>  extern void get_commit_format(const char *arg, struct rev_info *);
>  extern void format_commit_message(const struct commit *commit,
>                                    const void *format, struct strbuf *sb);
> -extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
> -                                struct strbuf *,
> +extern void pretty_print_commit(enum cmit_fmt fmt, const struct diff_opt=
ions *dopt,
> +                                const struct commit*, struct strbuf *,
>                                  int abbrev, const char *subject,
>                                  const char *after_subject, enum date_mod=
e,
>  				int need_8bit_cte);
>  void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
> -		   const char *line, enum date_mode dmode,
> +		   const char *color, const char *line, enum date_mode dmode,
>  		   const char *encoding);
>  void pp_title_line(enum cmit_fmt fmt,
>  		   const char **msg_p,
> @@ -85,6 +86,7 @@ void pp_title_line(enum cmit_fmt fmt,
>  void pp_remainder(enum cmit_fmt fmt,
>  		  const char **msg_p,
>  		  struct strbuf *sb,
> +		  const char *color,
>  		  int indent);
> =20
> =20
> diff --git a/diff.c b/diff.c
> index 29c168d..787c91b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -33,6 +33,8 @@ static char diff_colors[][COLOR_MAXLEN] =3D {
>  	"\033[32m",	/* NEW (green) */
>  	"\033[33m",	/* COMMIT (yellow) */
>  	"\033[41m",	/* WHITESPACE (red background) */
> +	"",	        /* HEADER (normal) */
> +	"",         /* COMMIT_MSG (normal) */
>  };
> =20
>  static int parse_diff_color_slot(const char *var, int ofs)
> @@ -51,6 +53,10 @@ static int parse_diff_color_slot(const char *var, int =
ofs)
>  		return DIFF_COMMIT;
>  	if (!strcasecmp(var+ofs, "whitespace"))
>  		return DIFF_WHITESPACE;
> +	if (!strcasecmp(var+ofs, "header"))
> +		return DIFF_HEADER;
> +	if (!strcasecmp(var+ofs, "message"))
> +		return DIFF_COMMIT_MSG;
>  	die("bad config variable '%s'", var);
>  }
> =20
> diff --git a/diff.h b/diff.h
> index 1fc1939..dba4d5e 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -192,6 +192,8 @@ enum color_diff {
>  	DIFF_FILE_NEW =3D 5,
>  	DIFF_COMMIT =3D 6,
>  	DIFF_WHITESPACE =3D 7,
> +	DIFF_HEADER =3D 8,
> +	DIFF_COMMIT_MSG =3D 9,
>  };
>  const char *diff_get_color(int diff_use_color, enum color_diff ix);
>  #define diff_get_color_opt(o, ix) \
> diff --git a/log-tree.c b/log-tree.c
> index 2b005a2..3bcb113 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -308,9 +308,9 @@ void show_log(struct rev_info *opt, const char *sep)
>  	strbuf_init(&msgbuf, 0);
>  	if (need_8bit_cte >=3D 0)
>  		need_8bit_cte =3D has_non_ascii(opt->add_signoff);
> -	pretty_print_commit(opt->commit_format, commit, &msgbuf,
> -			    abbrev, subject, extra_headers, opt->date_mode,
> -			    need_8bit_cte);
> +	pretty_print_commit(opt->commit_format, &opt->diffopt, commit,
> +	                    &msgbuf, abbrev, subject, extra_headers,
> +	                    opt->date_mode, need_8bit_cte);
> =20
>  	if (opt->add_signoff)
>  		append_signoff(&msgbuf, opt->add_signoff);
> diff --git a/pretty.c b/pretty.c
> index 30c2699..6a67cf4 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -119,7 +119,7 @@ needquote:
>  }
> =20
>  void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
> -		  const char *line, enum date_mode dmode,
> +		  const char *color, const char *line, enum date_mode dmode,
>  		  const char *encoding)
>  {
>  	char *date;
> @@ -146,24 +146,25 @@ void pp_user_info(const char *what, enum cmit_fmt f=
mt, struct strbuf *sb,
>  			name_tail--;
>  		display_name_length =3D name_tail - line;
>  		filler =3D "";
> +		strbuf_addstr(sb, color);
>  		strbuf_addstr(sb, "From: ");
>  		add_rfc2047(sb, line, display_name_length, encoding);
>  		strbuf_add(sb, name_tail, namelen - display_name_length);
>  		strbuf_addch(sb, '\n');
>  	} else {
> -		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
> +		strbuf_addf(sb, "%s%s: %.*s%.*s\n", color, what,
>  			      (fmt =3D=3D CMIT_FMT_FULLER) ? 4 : 0,
>  			      filler, namelen, line);
>  	}
>  	switch (fmt) {
>  	case CMIT_FMT_MEDIUM:
> -		strbuf_addf(sb, "Date:   %s\n", show_date(time, tz, dmode));
> +		strbuf_addf(sb, "%sDate:   %s\n", color, show_date(time, tz, dmode));
>  		break;
>  	case CMIT_FMT_EMAIL:
> -		strbuf_addf(sb, "Date: %s\n", show_date(time, tz, DATE_RFC2822));
> +		strbuf_addf(sb, "%sDate: %s\n", color, show_date(time, tz, DATE_RFC282=
2));
>  		break;
>  	case CMIT_FMT_FULLER:
> -		strbuf_addf(sb, "%sDate: %s\n", what, show_date(time, tz, dmode));
> +		strbuf_addf(sb, "%s%sDate: %s\n", color, what, show_date(time, tz, dmo=
de));
>  		break;
>  	default:
>  		/* notin' */
> @@ -590,6 +591,7 @@ void format_commit_message(const struct commit *commi=
t,
>  static void pp_header(enum cmit_fmt fmt,
>  		      int abbrev,
>  		      enum date_mode dmode,
> +		      const char *color,
>  		      const char *encoding,
>  		      const struct commit *commit,
>  		      const char **msg_p,
> @@ -610,6 +612,7 @@ static void pp_header(enum cmit_fmt fmt,
>  			return;
> =20
>  		if (fmt =3D=3D CMIT_FMT_RAW) {
> +			strbuf_addstr(sb, color);
>  			strbuf_add(sb, line, linelen);
>  			continue;
>  		}
> @@ -629,6 +632,7 @@ static void pp_header(enum cmit_fmt fmt,
>  				;
>  			/* with enough slop */
>  			strbuf_grow(sb, num * 50 + 20);
> +			strbuf_addstr(sb, color);
>  			add_merge_info(fmt, sb, commit, abbrev);
>  			parents_shown =3D 1;
>  		}
> @@ -640,12 +644,12 @@ static void pp_header(enum cmit_fmt fmt,
>  		 */
>  		if (!memcmp(line, "author ", 7)) {
>  			strbuf_grow(sb, linelen + 80);
> -			pp_user_info("Author", fmt, sb, line + 7, dmode, encoding);
> +			pp_user_info("Author", fmt, sb, color, line + 7, dmode, encoding);
>  		}
>  		if (!memcmp(line, "committer ", 10) &&
>  		    (fmt =3D=3D CMIT_FMT_FULL || fmt =3D=3D CMIT_FMT_FULLER)) {
>  			strbuf_grow(sb, linelen + 80);
> -			pp_user_info("Commit", fmt, sb, line + 10, dmode, encoding);
> +			pp_user_info("Commit", fmt, sb, color, line + 10, dmode, encoding);
>  		}
>  	}
>  }
> @@ -708,6 +712,7 @@ void pp_title_line(enum cmit_fmt fmt,
>  void pp_remainder(enum cmit_fmt fmt,
>  		  const char **msg_p,
>  		  struct strbuf *sb,
> +		  const char *color,
>  		  int indent)
>  {
>  	int first =3D 1;
> @@ -728,6 +733,7 @@ void pp_remainder(enum cmit_fmt fmt,
>  		first =3D 0;
> =20
>  		strbuf_grow(sb, linelen + indent + 20);
> +		strbuf_addstr(sb, color);
>  		if (indent) {
>  			memset(sb->buf + sb->len, ' ', indent);
>  			strbuf_setlen(sb, sb->len + indent);
> @@ -737,7 +743,8 @@ void pp_remainder(enum cmit_fmt fmt,
>  	}
>  }
> =20
> -void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
> +void pretty_print_commit(enum cmit_fmt fmt,
> +			 const struct diff_options *dopt, const struct commit *commit,
>  			 struct strbuf *sb, int abbrev,
>  			 const char *subject, const char *after_subject,
>  			 enum date_mode dmode, int need_8bit_cte)
> @@ -747,6 +754,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const str=
uct commit *commit,
>  	const char *msg =3D commit->buffer;
>  	char *reencoded;
>  	const char *encoding;
> +	const char *rstcol =3D dopt ? diff_get_color_opt(dopt, DIFF_RESET) : "";
> +	const char *hdrcol =3D dopt ? diff_get_color_opt(dopt, DIFF_HEADER) : "=
";
> +	const char *msgcol =3D dopt ? diff_get_color_opt(dopt, DIFF_COMMIT_MSG)=
 : "";
> =20
>  	if (fmt =3D=3D CMIT_FMT_USERFORMAT) {
>  		format_commit_message(commit, user_format, sb);
> @@ -789,8 +799,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const str=
uct commit *commit,
>  		}
>  	}
> =20
> -	pp_header(fmt, abbrev, dmode, encoding, commit, &msg, sb);
> +	pp_header(fmt, abbrev, dmode, hdrcol, encoding, commit, &msg, sb);
>  	if (fmt !=3D CMIT_FMT_ONELINE && !subject) {
> +		strbuf_addstr(sb, rstcol);
>  		strbuf_addch(sb, '\n');
>  	}
> =20
> @@ -811,20 +822,26 @@ void pretty_print_commit(enum cmit_fmt fmt, const s=
truct commit *commit,
>  			      after_subject, encoding, need_8bit_cte);
> =20
>  	beginning_of_body =3D sb->len;
> -	if (fmt !=3D CMIT_FMT_ONELINE)
> -		pp_remainder(fmt, &msg, sb, indent);
> +	if (fmt !=3D CMIT_FMT_ONELINE) {
> +		pp_remainder(fmt, &msg, sb, msgcol, indent);
> +		strbuf_addstr(sb, rstcol);
> +	}
>  	strbuf_rtrim(sb);
> =20
>  	/* Make sure there is an EOLN for the non-oneline case */
> -	if (fmt !=3D CMIT_FMT_ONELINE)
> +	if (fmt !=3D CMIT_FMT_ONELINE) {
> +		strbuf_addstr(sb, rstcol);
>  		strbuf_addch(sb, '\n');
> +	}
> =20
>  	/*
>  	 * The caller may append additional body text in e-mail
>  	 * format.  Make sure we did not strip the blank line
>  	 * between the header and the body.
>  	 */
> -	if (fmt =3D=3D CMIT_FMT_EMAIL && sb->len <=3D beginning_of_body)
> +	if (fmt =3D=3D CMIT_FMT_EMAIL && sb->len <=3D beginning_of_body) {
> +		strbuf_addstr(sb, rstcol);
>  		strbuf_addch(sb, '\n');
> +	}
>  	free(reencoded);
>  }
> --=20
> 1.5.5.1.224.g993e4.dirty
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBILtibvGr7W6HudhwRAvPtAKCRvkwTHUzoEjZwTLs+3uEcZnChOQCcDkc+
p681ADRjQQ0zqu9ScNCsQjU=
=tnMC
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
