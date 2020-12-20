Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BD2C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57ED22C9C
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgLUV4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:56:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:33045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgLUV4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 16:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608587658;
        bh=SbXA2H0UtdPgDGmPGxgqMMIZ8uiLJHySvAsGqFgSoTg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Wf8Sjw5yzbY5BjLvnOlkkSPLygCJOBE8veIBF4BPQRl5lAA/WVmWedOIKfyAE7SrD
         juTeqrCN4JfSfFcs/bUmzAOhR5p+RIJ4KWA6y0FgGRxH2Ikd81c99n/HLKlIRhv/SQ
         eA1CwDaPMVlZ6rKiWnwxv1rlHrE2AJwlHxMrkorQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([89.1.213.150]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1kb2kA2pIi-00IlWe; Mon, 21
 Dec 2020 22:54:18 +0100
Date:   Sun, 20 Dec 2020 16:25:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
In-Reply-To: <nycvar.QRO.7.76.6.2008280412030.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2012201623490.56@tvgsbejvaqbjf.bet>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com> <20200826011718.3186597-4-gitster@pobox.com> <nycvar.QRO.7.76.6.2008280412030.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aL0nQ5qzVT12JbiBVAFuB6QGIHye1Txx6/b+Tl0uk6BqWqaZQQV
 rbhGWfLMafjOfs3ejeDBUdus2mgzZW6no2jYE6/mDzxirYCy8gh6D9MYNmBu2r8qumcI0Ey
 M+jXjokIxis6rTkRv8WRWp3ywemSNttESiscEGsOKl/qY6eKoCNNqpBTOhO8gDgPQ0ffJ75
 THiqN/RoHiihk+uRuH90g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bxAWywvzx3A=:Of6VhfDBaSxMVwEGEJn8WE
 Dhtyj6XEK0prDCBwmhSRYMI37l9/K91S1p/oJEoeUavZ0NlVuIKfhGb8ExVNu9Z+YrZZfae8N
 Oj2NNqRS89EqrPbIOrJkcW0xPwgpyY2ahaUEUhV80g43MC8DmNXpLjQmsg4wChCUY+lFaqnfq
 Ic7X6SETLkagN4SYsY1yuoLp4ZqOSAL9I31ZYeIgoyH3u+8bgYMdQZHL3wvn6MlIMrlNzMBFC
 PjH6MhjJhTX7VJstW+ow6Mmgs4lzS+NM+Zr5R4f1kmB0XWZqb2YUitJPO1e2NwKXc3u+MbvbL
 SyzhglcH5LaqaY2YblKvUQjqi5YGNpu5h/9ub2JfRLumPbZitb49R0c1BI30CSA+8cfSQwn4M
 dlUXfCCIyCyq7aXXR3F+83cil4FJ5YQevsl76pXtF/4f00zM0ZM3WAc1YGCmLXgH/HjGPO6cP
 JhU6sEVjliL36JebXKVugZJBF+rq/QUYe990DNWZOgAHyy/9tqXv9/v0KUV2IleOiz2AOIyJL
 Xzpjiju708QF72srhVAtNkF9Uhc/P86PCHvoOlpwcwpioyeO+726VmkTNWg+OSuTJgzGeZ2D1
 MpLcrqy2i/EZ7dV8hiaqnUhlLPzQhcZp6Y9fe7JO9fRueBvfqOrM67HfF+Ss9gzKtd/W15Ipf
 HFzUNDwfNkMq6iAR507EqmNJYNKGIGEBvxtdKKt5GYY7hngEZO/O2Wj8wzBdX948IZQrdJyr9
 8OSaSJrky5QZf742WU1kB6aG+JHgeRA+NZ5/7u1bCrCz1x1nt0DC5P+ggwO1V3OvxXPbWo5Ik
 rs0vY3rDaKPsZ/AupcRpCh1FhgsjRlxgMasKwOb8rzOknk1lpf96RjU7ZMSt2EpvxszuDu4XW
 +pqlio3IRIvLBSz5NcXwAEAQQKF1nhlPgdzvxJOEs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 28 Aug 2020, Johannes Schindelin wrote:

> On Tue, 25 Aug 2020, Junio C Hamano wrote:
>
> > diff --git a/git.c b/git.c
> > index 8bd1d7551d..927018bda7 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -839,6 +839,8 @@ int cmd_main(int argc, const char **argv)
> >  	 * that one cannot handle it.
> >  	 */
> >  	if (skip_prefix(cmd, "git-", &cmd)) {
> > +		warn_on_dashed_git(argv[0]);
> > +
> >  		argv[0] =3D cmd;
> >  		handle_builtin(argc, argv);
> >  		die(_("cannot handle %s as a builtin"), cmd);
> > diff --git a/help.c b/help.c
> > index d478afb2af..490d2bc3ae 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -720,3 +720,37 @@ NORETURN void help_unknown_ref(const char *ref, c=
onst char *cmd,
> >  	string_list_clear(&suggested_refs, 0);
> >  	exit(1);
> >  }
> > +
> > +static struct cmdname_help *find_cmdname_help(const char *name)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(command_list); i++) {
> > +		if (!strcmp(command_list[i].name, name))
> > +			return &command_list[i];
> > +	}
> > +	return NULL;
> > +}
> > +
> > +void warn_on_dashed_git(const char *cmd)
> > +{
> > +	struct cmdname_help *cmdname;
> > +	static const char *still_in_use_var =3D "GIT_I_STILL_USE_DASHED_GIT"=
;
> > +	static const char *still_in_use_msg =3D
> > +		N_("Use of '%s' in the dashed-form is nominated for removal.\n"
> > +		   "If you still use it, export '%s=3Dtrue'\n"
> > +		   "and send an e-mail to <git@vger.kernel.org>\n"
> > +		   "to let us know and stop our removal plan.  Thanks.\n");
> > +
> > +	if (!cmd)
> > +		return; /* git-help is OK */
> > +
> > +	cmdname =3D find_cmdname_help(cmd);
> > +	if (cmdname && (cmdname->category & CAT_onpath))
> > +		return; /* git-upload-pack and friends are OK */
> > +
> > +	if (!git_env_bool(still_in_use_var, 0)) {
> > +		fprintf(stderr, _(still_in_use_msg), cmd, still_in_use_var);
> > +		exit(1);
> > +	}
> > +}
>
> I need this on top, to make it work on Windows:
>
> -- snipsnap --
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Subject: [PATCH] fixup??? git: catch an attempt to run "git-foo"
>
> This is needed to handle the case where `argv[0]` contains the full path
> (which is the case on Windows) and the suffix `.exe` (which is also the
> case on Windows).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git.c  | 3 ++-
>  help.c | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/git.c b/git.c
> index 71ef4835b20e..863fd0c58a66 100644
> --- a/git.c
> +++ b/git.c
> @@ -851,7 +851,8 @@ int cmd_main(int argc, const char **argv)
>  	 * that one cannot handle it.
>  	 */
>  	if (skip_prefix(cmd, "git-", &cmd)) {
> -		warn_on_dashed_git(argv[0]);
> +		strip_extension(&cmd);
> +		warn_on_dashed_git(cmd);
>
>  		argv[0] =3D cmd;
>  		handle_builtin(argc, argv);
> diff --git a/help.c b/help.c
> index c93a76944b00..27b1b26890be 100644
> --- a/help.c
> +++ b/help.c
> @@ -724,9 +724,12 @@ NORETURN void help_unknown_ref(const char *ref, con=
st char *cmd,
>  static struct cmdname_help *find_cmdname_help(const char *name)
>  {
>  	int i;
> +	const char *p;
>
> +	skip_prefix(name, "git-", &name);
>  	for (i =3D 0; i < ARRAY_SIZE(command_list); i++) {
> -		if (!strcmp(command_list[i].name, name))
> +		if (skip_prefix(command_list[i].name, "git-", &p) &&
> +		    !strcmp(p, name))
>  			return &command_list[i];
>  	}
>  	return NULL;
> --
> 2.28.0.windows.1

How about this instead (to fix that part of the CI failures of `seen`)?

=2D- snipsnap --
=46rom e8ce19db04657b6ef1c73989695c97a773a9c001 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 28 Aug 2020 14:50:25 +0200
Subject: [PATCH] fixup??? git: catch an attempt to run "git-foo"

This is needed to handle the case where `argv[0]` contains the full path
(which is the case on Windows) and the suffix `.exe` (which is also the
case on Windows).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 git.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 7544d2187306..c924c53ea76f 100644
=2D-- a/git.c
+++ b/git.c
@@ -854,6 +854,7 @@ int cmd_main(int argc, const char **argv)
 	const char *cmd;
 	int done_help =3D 0;

+	strip_extension(argv);
 	cmd =3D argv[0];
 	if (!cmd)
 		cmd =3D "git-help";
@@ -875,12 +876,11 @@ int cmd_main(int argc, const char **argv)
 	 * So we just directly call the builtin handler, and die if
 	 * that one cannot handle it.
 	 */
-	if (skip_prefix(cmd, "git-", &cmd)) {
-		warn_on_dashed_git(argv[0]);
+	if (skip_prefix(cmd, "git-", &argv[0])) {
+		warn_on_dashed_git(cmd);

-		argv[0] =3D cmd;
 		handle_builtin(argc, argv);
-		die(_("cannot handle %s as a builtin"), cmd);
+		die(_("cannot handle %s as a builtin"), argv[0]);
 	}

 	/* Look for flags.. */
=2D-
2.30.0.rc0.windows.1

