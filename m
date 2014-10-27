From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RFC] grep: add color.grep.matchcontext and color.grep.matchselected
Date: Mon, 27 Oct 2014 12:47:14 -0700
Message-ID: <xmqqtx2ps3b1.fsf@gitster.dls.corp.google.com>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
	<544D3A3C.4080906@web.de> <544E8D89.3030201@web.de>
	<xmqqy4s1s44h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 20:47:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiqGA-00038G-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 20:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbaJ0TrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 15:47:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752711AbaJ0TrR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2014 15:47:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6EAF1AD8C;
	Mon, 27 Oct 2014 15:47:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R0l2l5ykMftQ
	AuvvOBPrskAYZ8M=; b=fiSC4WQUNKpTMJBIt+RLkPp08O6Ods2oHohx/XtUuj9m
	t+KjRt/b8bmpnkyIYdT8XLPok9ZsJLcVOMfKEQRhtn9W5bVS0qOe/pUdoeSX4TTa
	8FpdI73M075IT84h4CLFAUghOrKlC4ILSfmfxbFSuH5lFLN0M9XdXbo9O+2ywD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HAjjFT
	9y108vIKwv5PrcaNSVdgmNh/HTH84zVBBMhQqM4VSPASTkP2ZNL9qgm+ycgeruuc
	7QWCt2fkRyT2gi2SHCP+thXpMH9BE9Qn5mNTNNWQY0hcY+CLnXS1wjQBpNRvWmz5
	hX9t4qREkkjELshU6qSs+QAJ+Kmwpc0xbJ17s=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB01C1AD8B;
	Mon, 27 Oct 2014 15:47:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D3E31AD88;
	Mon, 27 Oct 2014 15:47:15 -0400 (EDT)
In-Reply-To: <xmqqy4s1s44h.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Oct 2014 12:29:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D540782-5E12-11E4-924C-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> The config option color.grep.match can be used to specify the highli=
ghting
>> color for matching strings.  Add the options matchContext and matchS=
elected
>> to allow different colors to be specified for matching strings in th=
e
>> context vs. in selected lines.  This is similar to the ms and mc spe=
cifiers
>> in GNU grep's environment variable GREP_COLORS.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> Only *very* lightly tested, and a test for t/is missing anyway.  Jus=
t
>> wanted to quickly show what I meant.  You'd set color.grep.matchCont=
ext=3D""
>> to turn off highlighting in context lines.  What do you think?
>
> I didn't realize that people wanted to see pieces on non-matching
> lines highlighted.  It makes certain sense, e.g. it would allow you
> to spot near-misses, but that is only true for lines that neighbour
> real hits, so...
>
> I like this approach better in that it makes those who want a
> different behaviour to do the work without breaking the expectation
> of those who are used to the established behaviour.

=46WIW, here is a backport on top of maint-1.8.5 with Zoltan's tests,
not because I wanted to apply this as a bugfix to maintenance track,
but because I wanted to compare with what has been queued already.

To apply to post f6c5a296 (color_parse: do not mention variable name
in error message, 2014-10-07) codebase, the mangling I did for two
calls to color_parse() function needs to be undone, obviously.



 Documentation/config.txt |  6 +++-
 grep.c                   | 29 +++++++++++----
 grep.h                   |  3 +-
 t/t7810-grep.sh          | 94 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab26963..aa881fc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -860,7 +860,11 @@ color.grep.<slot>::
 `linenumber`;;
 	line number prefix (when using `-n`)
 `match`;;
-	matching text
+	matching text (same as setting `matchContext` and `matchSelected`)
+`matchContext`;;
+	matching text in context lines
+`matchSelected`;;
+	matching text in selected lines
 `selected`;;
 	non-matching text in selected lines
 `separator`;;
diff --git a/grep.c b/grep.c
index c668034..f950651 100644
--- a/grep.c
+++ b/grep.c
@@ -35,7 +35,8 @@ void init_grep_defaults(void)
 	strcpy(opt->color_filename, "");
 	strcpy(opt->color_function, "");
 	strcpy(opt->color_lineno, "");
-	strcpy(opt->color_match, GIT_COLOR_BOLD_RED);
+	strcpy(opt->color_match_context, GIT_COLOR_BOLD_RED);
+	strcpy(opt->color_match_selected, GIT_COLOR_BOLD_RED);
 	strcpy(opt->color_selected, "");
 	strcpy(opt->color_sep, GIT_COLOR_CYAN);
 	opt->color =3D -1;
@@ -96,12 +97,22 @@ int grep_config(const char *var, const char *value,=
 void *cb)
 		color =3D opt->color_function;
 	else if (!strcmp(var, "color.grep.linenumber"))
 		color =3D opt->color_lineno;
-	else if (!strcmp(var, "color.grep.match"))
-		color =3D opt->color_match;
+	else if (!strcmp(var, "color.grep.matchcontext"))
+		color =3D opt->color_match_context;
+	else if (!strcmp(var, "color.grep.matchselected"))
+		color =3D opt->color_match_selected;
 	else if (!strcmp(var, "color.grep.selected"))
 		color =3D opt->color_selected;
 	else if (!strcmp(var, "color.grep.separator"))
 		color =3D opt->color_sep;
+	else if (!strcmp(var, "color.grep.match")) {
+		int rc =3D 0;
+		if (!value)
+			return config_error_nonbool(var);
+		color_parse(value, var, opt->color_match_context);
+		color_parse(value, var, opt->color_match_selected);
+		return rc;
+	}
=20
 	if (color) {
 		if (!value)
@@ -139,7 +150,8 @@ void grep_init(struct grep_opt *opt, const char *pr=
efix)
 	strcpy(opt->color_filename, def->color_filename);
 	strcpy(opt->color_function, def->color_function);
 	strcpy(opt->color_lineno, def->color_lineno);
-	strcpy(opt->color_match, def->color_match);
+	strcpy(opt->color_match_context, def->color_match_context);
+	strcpy(opt->color_match_selected, def->color_match_selected);
 	strcpy(opt->color_selected, def->color_selected);
 	strcpy(opt->color_sep, def->color_sep);
 }
@@ -1079,7 +1091,7 @@ static void show_line(struct grep_opt *opt, char =
*bol, char *eol,
 		      const char *name, unsigned lno, char sign)
 {
 	int rest =3D eol - bol;
-	char *line_color =3D NULL;
+	const char *match_color, *line_color =3D NULL;
=20
 	if (opt->file_break && opt->last_shown =3D=3D 0) {
 		if (opt->show_hunk_mark)
@@ -1118,6 +1130,10 @@ static void show_line(struct grep_opt *opt, char=
 *bol, char *eol,
 		int eflags =3D 0;
=20
 		if (sign =3D=3D ':')
+			match_color =3D opt->color_match_selected;
+		else
+			match_color =3D opt->color_match_context;
+		if (sign =3D=3D ':')
 			line_color =3D opt->color_selected;
 		else if (sign =3D=3D '-')
 			line_color =3D opt->color_context;
@@ -1130,8 +1146,7 @@ static void show_line(struct grep_opt *opt, char =
*bol, char *eol,
=20
 			output_color(opt, bol, match.rm_so, line_color);
 			output_color(opt, bol + match.rm_so,
-				     match.rm_eo - match.rm_so,
-				     opt->color_match);
+				     match.rm_eo - match.rm_so, match_color);
 			bol +=3D match.rm_eo;
 			rest -=3D match.rm_eo;
 			eflags =3D REG_NOTBOL;
diff --git a/grep.h b/grep.h
index eaaced1..95f197a 100644
--- a/grep.h
+++ b/grep.h
@@ -124,7 +124,8 @@ struct grep_opt {
 	char color_filename[COLOR_MAXLEN];
 	char color_function[COLOR_MAXLEN];
 	char color_lineno[COLOR_MAXLEN];
-	char color_match[COLOR_MAXLEN];
+	char color_match_context[COLOR_MAXLEN];
+	char color_match_selected[COLOR_MAXLEN];
 	char color_selected[COLOR_MAXLEN];
 	char color_sep[COLOR_MAXLEN];
 	int regflags;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f698001..e3eeaf9 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1195,4 +1195,98 @@ test_expect_success LIBPCRE 'grep -P "^ "' '
 	test_cmp expected actual
 '
=20
+cat >expected <<EOF
+space-line without leading space1
+space: line <RED>with <RESET>leading space1
+space: line <RED>with <RESET>leading <RED>space2<RESET>
+space: line <RED>with <RESET>leading space3
+space:line without leading <RED>space2<RESET>
+EOF
+
+test_expect_success 'grep --color -e A -e B with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.matchContext	normal &&
+	test_config color.grep.matchSelected	red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=3Dalways -C2 -e "with " -e space2  space |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+space-line without leading space1
+space- line with leading space1
+space: line <RED>with <RESET>leading <RED>space2<RESET>
+space- line with leading space3
+space-line without leading space2
+EOF
+
+test_expect_success 'grep --color -e A --and -e B with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.matchContext	normal &&
+	test_config color.grep.matchSelected	red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=3Dalways -C2 -e "with " --and -e space2  space |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+space-line without leading space1
+space: line <RED>with <RESET>leading space1
+space- line with leading space2
+space: line <RED>with <RESET>leading space3
+space-line without leading space2
+EOF
+
+test_expect_success 'grep --color -e A --and --not -e B with context' =
'
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.matchContext	normal &&
+	test_config color.grep.matchSelected	red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=3Dalways -C2 -e "with " --and --not -e space2  space=
 |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+hello.c-#include <stdio.h>
+hello.c=3Dint main(int argc, const char **argv)
+hello.c-{
+hello.c:	pr<RED>int<RESET>f("<RED>Hello<RESET> world.\n");
+hello.c-	return 0;
+hello.c-	/* char ?? */
+hello.c-}
+EOF
+
+test_expect_success 'grep --color -e A --and -e B -p with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.matchContext	normal &&
+	test_config color.grep.matchSelected	red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=3Dalways -p -C3 -e int --and -e Hello --no-index hel=
lo.c |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
 test_done
