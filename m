Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44CCC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830B42086A
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ewvhrUXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgH1Mxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:53:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:57299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgH1MxT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598619189;
        bh=CTA7uZkpEcERz9w0QdX1sPAZw9DlmeB3BR1VB5nl02c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ewvhrUXq3zrc3HHgRy9jVzp63mmmI97YNQ9wjXHLNbStRfNi2q8tkVKThSOr1jn8T
         0mf97aDK/mX/y6p5hkgBqUuBHibjto87B1olYgVwvF7Vsy18ifTv8aG/gOKlpF746z
         r67pDvnkw1uOewyNnJ0pLn3rMt59OLbG98gsVZWs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.215.189]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS9C-1kro7D1jfG-00ktd2; Fri, 28
 Aug 2020 14:53:09 +0200
Date:   Fri, 28 Aug 2020 04:13:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
In-Reply-To: <20200826011718.3186597-4-gitster@pobox.com>
Message-ID: <nycvar.QRO.7.76.6.2008280412030.56@tvgsbejvaqbjf.bet>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com> <20200826011718.3186597-4-gitster@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l6sBHifIguOlCEd6fjCxwc0JCXZ5V3P7O58j8ps+1i6B7vgtd5A
 LQupgHLu0MHRjKmm1DNUgmISJsS+2oTI3fMikWndlUn85IR65C6SXIkXgCsRowZAED4sgqo
 7zkl5qy9td2zxDFeClf55YkUgSddKnnkkbzPcBa3XYscacL4DvktyE0LSWBR+GUt4BBrl2T
 GCmnnxIXcnmvcERzqbnig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W+4Mw0+5UU4=:z3+rGBvFtgBTHPcU5iPDj5
 GcbEucmWMyGV5Egf1g5vn4w/4pJvX8kuo7qmsEqh7l0Xi9sWifFdRYrL1E6Ivgn8fdWBeuPZJ
 t2orKNyjCL6vt7IX6JU6k0Oo44koMrSXE9ZbTkHDnxkNJQKrtHpc6EG/VawfK7OZgLxIuEkbj
 PlpjDoFe7tNksJtTS6z0JNNzoqhDdqTK3PebkqTd+eQM3HL6TR7Yx0YY/DJ8qjSF75WJcceMX
 vt74q+6yk9bDf5UHSkBfXBEEBx6X0EPcEcvDjNt1yF58nFOr7/6PNk3IRUG050tYT6JnNG/7v
 EEIlSEp/zl1hUjMV8YfuNDk3pMFdXpn3/pzjeoka9z6z7oeWuI2NAppT70rjtwHyb+/Ft3toH
 k8GGLg5SmeiEjIORRiM/gyszJ0+8HJ96Gd75OXgpP6lufpuCZDWj/sdFN3j9KUOoYv5AFDApe
 YF/D182PH9tPYtJothaIh/cpYt+lszb5poyowRQ9NuoV41I9PKbhiSkc3ro8Vl3nW/k1Hi7+R
 iS5kcTvd4oVfIEEn62sgDWF/Bdg3DAnk+IuY7PIvXUZ8qGoRj9ELMfLbhWWzwIPMrI3FFXLVe
 YW2qGxinD/tpcN3z73YByltZCr+9c6lpmd31XbsdtHivI0sKe69YuXoq4izgQAF1TzENulqZ5
 9MK4mIHarIg+cU5ulOjZKy5Hd+9KmEjE26ccDxbOGkmbAN9uzoKbSJ072UDx2NMLUGwpo2yNy
 Ug8hwc8Kw3XKLhGYK4hyI0C2y3eIa2XnwTRQtUHQ9I6hQpUG+gBIlWeyr2+oholzKyUlBlkxL
 klhX35PQVrTf+HWYGaZK66IVlMPShVFxnTAIGFbtc8iw0nJuzO/Wk/M7oBkfiWTWgEEVmbf1r
 0ABIiAGxUORWVYm4kSEJO+nkrtiWOcxDeqE05A8Ftf+F8d82WrzxpKi/DvCWUFq0d/fYP39n/
 Z/LxcbE69erRk36PGtZB9NZkZ6cXMi0nWn70ZxBb1RfY45OHV3C5EC8k3P4vikeaoDXpE6CCI
 mbNfr1V1vYFZ+Ut/Ye9ZpawZBbSqzJ7CyY46ZckrMuW9dTx7PqwL9973BoO9W+I4ahAhufgSM
 B8E89p3+qN5dVrxYPlu9Lz5CyaqE2Bpqc7RKrO6inOFsUCwULA/0B5AamZkDCXL+yshM7scZk
 KJZS0lK263A49mR2S+MPSIOVom4S1Ohyx1R25yi5MTziKJLyRx1vPInuzlHyDfWoLTc7CTSTY
 ZVgDRSyHAXRwPZKupnB5b6V2JBCu45eSiUxNkBw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 25 Aug 2020, Junio C Hamano wrote:

> diff --git a/git.c b/git.c
> index 8bd1d7551d..927018bda7 100644
> --- a/git.c
> +++ b/git.c
> @@ -839,6 +839,8 @@ int cmd_main(int argc, const char **argv)
>  	 * that one cannot handle it.
>  	 */
>  	if (skip_prefix(cmd, "git-", &cmd)) {
> +		warn_on_dashed_git(argv[0]);
> +
>  		argv[0] =3D cmd;
>  		handle_builtin(argc, argv);
>  		die(_("cannot handle %s as a builtin"), cmd);
> diff --git a/help.c b/help.c
> index d478afb2af..490d2bc3ae 100644
> --- a/help.c
> +++ b/help.c
> @@ -720,3 +720,37 @@ NORETURN void help_unknown_ref(const char *ref, con=
st char *cmd,
>  	string_list_clear(&suggested_refs, 0);
>  	exit(1);
>  }
> +
> +static struct cmdname_help *find_cmdname_help(const char *name)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(command_list); i++) {
> +		if (!strcmp(command_list[i].name, name))
> +			return &command_list[i];
> +	}
> +	return NULL;
> +}
> +
> +void warn_on_dashed_git(const char *cmd)
> +{
> +	struct cmdname_help *cmdname;
> +	static const char *still_in_use_var =3D "GIT_I_STILL_USE_DASHED_GIT";
> +	static const char *still_in_use_msg =3D
> +		N_("Use of '%s' in the dashed-form is nominated for removal.\n"
> +		   "If you still use it, export '%s=3Dtrue'\n"
> +		   "and send an e-mail to <git@vger.kernel.org>\n"
> +		   "to let us know and stop our removal plan.  Thanks.\n");
> +
> +	if (!cmd)
> +		return; /* git-help is OK */
> +
> +	cmdname =3D find_cmdname_help(cmd);
> +	if (cmdname && (cmdname->category & CAT_onpath))
> +		return; /* git-upload-pack and friends are OK */
> +
> +	if (!git_env_bool(still_in_use_var, 0)) {
> +		fprintf(stderr, _(still_in_use_msg), cmd, still_in_use_var);
> +		exit(1);
> +	}
> +}

I need this on top, to make it work on Windows:

=2D- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] fixup??? git: catch an attempt to run "git-foo"

This is needed to handle the case where `argv[0]` contains the full path
(which is the case on Windows) and the suffix `.exe` (which is also the
case on Windows).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 git.c  | 3 ++-
 help.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 71ef4835b20e..863fd0c58a66 100644
=2D-- a/git.c
+++ b/git.c
@@ -851,7 +851,8 @@ int cmd_main(int argc, const char **argv)
 	 * that one cannot handle it.
 	 */
 	if (skip_prefix(cmd, "git-", &cmd)) {
-		warn_on_dashed_git(argv[0]);
+		strip_extension(&cmd);
+		warn_on_dashed_git(cmd);

 		argv[0] =3D cmd;
 		handle_builtin(argc, argv);
diff --git a/help.c b/help.c
index c93a76944b00..27b1b26890be 100644
=2D-- a/help.c
+++ b/help.c
@@ -724,9 +724,12 @@ NORETURN void help_unknown_ref(const char *ref, const=
 char *cmd,
 static struct cmdname_help *find_cmdname_help(const char *name)
 {
 	int i;
+	const char *p;

+	skip_prefix(name, "git-", &name);
 	for (i =3D 0; i < ARRAY_SIZE(command_list); i++) {
-		if (!strcmp(command_list[i].name, name))
+		if (skip_prefix(command_list[i].name, "git-", &p) &&
+		    !strcmp(p, name))
 			return &command_list[i];
 	}
 	return NULL;
=2D-
2.28.0.windows.1

