From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] status: give more information during rebase -i
Date: Thu, 04 Jun 2015 10:06:41 +0200
Message-ID: <vpqfv67zylq.fsf@anie.imag.fr>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<1433368825-24617-3-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume =?iso-8859-1?Q?Pag=E8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 04 10:10:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0QEC-00025K-8D
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 10:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbbFDIHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2015 04:07:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59304 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773AbbFDIGq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 04:06:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5486eXo004224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jun 2015 10:06:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5486f1k022482;
	Thu, 4 Jun 2015 10:06:41 +0200
In-Reply-To: <1433368825-24617-3-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Thu, 4 Jun 2015
 00:00:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Jun 2015 10:06:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5486eXo004224
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434010002.00629@ze3h1lEcP/TfAJmWIP7Y2w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270755>

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> +  (use git rebase --edit-todo to view and edit)

You're still missing double-quotes around "git rebase --edit-todo".

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> +Last command(s) done (1 command(s) done):

Can't we just have "1 command"/"2 commands" instead of this (s). It's
particularly bad since it is already within parenthesis.

See the doc for Q_() in po/README and
http://www.gnu.org/savannah-checkouts/gnu/gettext/manual/html_node/Plur=
al-forms.html
for more details.

> +void get_two_last_lines(char *filename, int *numlines, char **lines)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	FILE *fp;
> +
> +	*numlines =3D 0;
> +	fp =3D fopen(git_path("%s", filename), "r");
> +	if (!fp) {
> +		strbuf_release(&buf);
> +		return;
> +	}
> +	while (strbuf_getline(&buf, fp, '\n') !=3D EOF) {
> +		(*numlines)++;
> +		lines[0] =3D lines[1];
> +		lines[1] =3D strbuf_detach(&buf, NULL);
> +	}
> +	fclose(fp);
> +}
> +
> +void get_two_first_lines(char *filename, int *numlines, char **lines=
)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;;
> +	char *line;
> +	FILE *fp;
> +
> +
> +	*numlines =3D 0;
> +	fp =3D fopen(git_path("%s", filename), "r");
> +	if (!fp) {
> +		strbuf_release(&buf);
> +		return;
> +	}
> +	while (strbuf_getline(&buf, fp, '\n') !=3D EOF) {
> +		stripspace(&buf, 1);
> +		line =3D strbuf_detach(&buf, NULL);
> +		if (strcmp(line, "") =3D=3D 0)
> +			continue;
> +		if (*numlines < 2)
> +			lines[*numlines] =3D line;
> +		(*numlines)++;
> +	}
> +	fclose(fp);
> +}
> +
> +static void show_rebase_information(struct wt_status *s,
> +				    struct wt_status_state *state,
> +				    const char *color)
> +{
> +	if (state->rebase_interactive_in_progress) {
> +		int i, begin;
> +		int numlines =3D 0;
> +		char *lines[2];
> +		get_two_last_lines("rebase-merge/done", &numlines, lines);
> +		if (numlines =3D=3D 0)
> +			status_printf_ln(s,color,_("No command done."));

space after comma.

You may want to play with clang-format/clang-format-diff to have a tool
tell you this instead of asking a human.

I think english people would make this plural (No commands done).

> +		else{
> +			status_printf_ln(s,color,
> +				_("Last command(s) done (%d command(s) done):"),
> +				numlines);

Q_() ?

> +			begin =3D numlines > 1? 0 : 1;
> +			for (i =3D begin; i < 2; i++) {
> +				status_printf_ln(s,color,"   %s",lines[i]);
> +			}
> +			if (numlines > 2 && s->hints)
> +			   status_printf_ln(s,color,
> +				_("  (see more at .git/rebase-merge/done)"));

I'd write explicitly 'in file ...' instead of 'at'.

You need to use git_path here, it may not be ".git" in some contexts.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
