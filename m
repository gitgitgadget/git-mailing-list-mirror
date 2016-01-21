From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/7] diff.c: take "prefix" argument in diff_opt_parse()
Date: Thu, 21 Jan 2016 18:48:44 +0700
Message-ID: <20160121114844.GA19318@lanh>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
 <1453287968-26000-3-git-send-email-pclouds@gmail.com>
 <xmqqr3hc57at.fsf@gitster.mtv.corp.google.com>
 <20160120202946.GA6092@sigill.intra.peff.net>
 <xmqqh9i753by.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 12:48:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMDjR-0006NO-1J
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 12:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759436AbcAULsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2016 06:48:50 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33769 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759427AbcAULsr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 06:48:47 -0500
Received: by mail-pa0-f65.google.com with SMTP id pv5so1653957pac.0
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 03:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mJMLwSrO5ckAOKguSJcocf1RdiHcU/XXNhUGOarS+6w=;
        b=KJ25H6A22qstxPzJl72vcSgxcsIqOCcb4Z5nECH419foXKFBtn5Qf3LWVCNbP1Oncg
         HttRE5IdeOC85oho/0wsafXI3gAXpYsKZi6TP7fkErVXPrFNLnDsGMN8TwDS1/dyAXYx
         wetnF5L6P4N/HlnYKmBDIBgzK/hjQU5+7hZwboVVM0DUmqILOKCFuTrREnPrPNV1815q
         F2mwqMYPeqj7+68KYOjQUb6YuleAVArK7KcgHimTHgrDYP9b2/yrAMWbox9u/RlB9tMp
         jeUaOLrHjFKjN2C3suqGX1ep5Z0XPb+NmlraXatZmXKAumBlHhZ6OVS4CgmqdRFc4d+D
         9TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mJMLwSrO5ckAOKguSJcocf1RdiHcU/XXNhUGOarS+6w=;
        b=ljaXa6vLNL+e/AuQjzdv3EpgWZjqGr6VE4Dfc8rKZWEXrABe+SGLwIckLuKo7texAy
         3bE+tmu1jSQXCcclod6CvIP/XCHx66Fk29dqH+vzkcb2k3LGzdh+vSzIbTs3/xcw8Vi4
         3ehIKk79NDkwPbzmWRqjslhIPV+DocIes7HYgS3AY+IptywLUwnf+rY1WUYaiWbOey5Y
         5VGeo9J+bBVsNcleXqM12ENFV0KkPRMEap2VP64Ylbxke5DBlw7w6l9j7aB++QJwFJT2
         ENvGWads7sVFbg9Jm6hHAPNqcxWdCKzBfAF9/UDI8YcNiYnCbfKTnSMvLp2F4xMpPhy+
         f9tA==
X-Gm-Message-State: ALoCoQmJlKi72Vi6W6F4bEXD7tPbAlRoZpVZP8FNhykGR1Ca1EEtUV2BpqhSIAKOVJ1g9kksjn/IsBCUqCYkFQRKw1KKXyUjEw==
X-Received: by 10.66.144.37 with SMTP id sj5mr59702023pab.69.1453376927456;
        Thu, 21 Jan 2016 03:48:47 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id rt6sm2173595pab.17.2016.01.21.03.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2016 03:48:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 21 Jan 2016 18:48:44 +0700
Content-Disposition: inline
In-Reply-To: <xmqqh9i753by.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284513>

On Wed, Jan 20, 2016 at 01:49:21PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Wed, Jan 20, 2016 at 12:23:38PM -0800, Junio C Hamano wrote:
> >
> >> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> wri=
tes:
> >>=20
> >> > This will be important later when diff_opt_parse() accepts paths=
 as
> >> > arguments. Paths must be prefixed before access because setup co=
de
> >> > moves cwd but does not (and cannot) update command line options.
> >>=20
> >> The above sounds like a sensible thing to do (note: I didn't read
> >> the patch or remainder of the series), but makes me wonder how the
> >> existing --orderfile option works without this support.  Perhaps i=
t
> >> is not working and needs to be updated to take advantage of this
> >> change, too?
> >
> > Yeah, I think it simply does not work.
> >
> >   $ >main-order
> >   $ mkdir subdir && >subdir/sub-order
> >   $ cd subdir
> >   $ git show -Osub-order
> >   fatal: failed to read orderfile 'sub-order': No such file or dire=
ctory
> >   $ git show -Omain-order
> >   [shows diff]
>=20
> Good.
>=20
> Then 2/7 can be rerolled and advertised as "make -O to work from
> subdirectories", and can gradulate regardless of the remainder of
> the series.  Even if the rest needs rerolls to get it right (or
> takes until 2019 to mature ;-), we will have one less change to
> re-review in the process as we can push these early and obviously
> correct part out separately.
>=20

I didn't know there was already an option that takes a path. I read
through the function and found another one. So here's the standalone
patch that fixes both.

-- 8< --
Subject: [PATCH] diff: make -O and --output work in subdirectory

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/am.c          |  2 +-
 diff-no-index.c       |  3 ++-
 diff.c                | 14 ++++++++++----
 diff.h                |  2 +-
 revision.c            |  2 +-
 t/t4056-diff-order.sh |  6 ++++++
 6 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9fb42fd..f009b6c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1657,7 +1657,7 @@ static int fall_back_threeway(const struct am_sta=
te *state, const char *index_pa
=20
 		init_revisions(&rev_info, NULL);
 		rev_info.diffopt.output_format =3D DIFF_FORMAT_NAME_STATUS;
-		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1);
+		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.pref=
ix);
 		add_pending_sha1(&rev_info, "HEAD", our_tree, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
diff --git a/diff-no-index.c b/diff-no-index.c
index 8e0fd27..aa81a15 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -252,7 +252,8 @@ void diff_no_index(struct rev_info *revs,
 		else if (!strcmp(argv[i], "--"))
 			i++;
 		else {
-			j =3D diff_opt_parse(&revs->diffopt, argv + i, argc - i);
+			j =3D diff_opt_parse(&revs->diffopt, argv + i, argc - i,
+					   revs->prefix);
 			if (j <=3D 0)
 				die("invalid diff option/value: %s", argv[i]);
 			i +=3D j;
diff --git a/diff.c b/diff.c
index 80eb0c2..2136b69 100644
--- a/diff.c
+++ b/diff.c
@@ -3693,12 +3693,16 @@ static int parse_ws_error_highlight(struct diff=
_options *opt, const char *arg)
 	return 1;
 }
=20
-int diff_opt_parse(struct diff_options *options, const char **av, int =
ac)
+int diff_opt_parse(struct diff_options *options,
+		   const char **av, int ac, const char *prefix)
 {
 	const char *arg =3D av[0];
 	const char *optarg;
 	int argcount;
=20
+	if (!prefix)
+		prefix =3D "";
+
 	/* Output format options */
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch=
")
 	    || opt_arg(arg, 'U', "unified", &options->context))
@@ -3915,7 +3919,8 @@ int diff_opt_parse(struct diff_options *options, =
const char **av, int ac)
 	else if (!strcmp(arg, "--pickaxe-regex"))
 		options->pickaxe_opts |=3D DIFF_PICKAXE_REGEX;
 	else if ((argcount =3D short_opt('O', av, &optarg))) {
-		options->orderfile =3D optarg;
+		const char *path =3D prefix_filename(prefix, strlen(prefix), optarg)=
;
+		options->orderfile =3D xstrdup(path);
 		return argcount;
 	}
 	else if ((argcount =3D parse_long_opt("diff-filter", av, &optarg))) {
@@ -3954,9 +3959,10 @@ int diff_opt_parse(struct diff_options *options,=
 const char **av, int ac)
 	else if (!strcmp(arg, "--no-function-context"))
 		DIFF_OPT_CLR(options, FUNCCONTEXT);
 	else if ((argcount =3D parse_long_opt("output", av, &optarg))) {
-		options->file =3D fopen(optarg, "w");
+		const char *path =3D prefix_filename(prefix, strlen(prefix), optarg)=
;
+		options->file =3D fopen(path, "w");
 		if (!options->file)
-			die_errno("Could not open '%s'", optarg);
+			die_errno("Could not open '%s'", path);
 		options->close_file =3D 1;
 		return argcount;
 	} else
diff --git a/diff.h b/diff.h
index 893f446..4537e38 100644
--- a/diff.h
+++ b/diff.h
@@ -268,7 +268,7 @@ extern int parse_long_opt(const char *opt, const ch=
ar **argv,
 extern int git_diff_basic_config(const char *var, const char *value, v=
oid *cb);
 extern int git_diff_ui_config(const char *var, const char *value, void=
 *cb);
 extern void diff_setup(struct diff_options *);
-extern int diff_opt_parse(struct diff_options *, const char **, int);
+extern int diff_opt_parse(struct diff_options *, const char **, int, c=
onst char *);
 extern void diff_setup_done(struct diff_options *);
=20
 #define DIFF_DETECT_RENAME	1
diff --git a/revision.c b/revision.c
index 0a282f5..14daefb 100644
--- a/revision.c
+++ b/revision.c
@@ -2049,7 +2049,7 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing =3D 1;
 	} else {
-		int opts =3D diff_opt_parse(&revs->diffopt, argv, argc);
+		int opts =3D diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix=
);
 		if (!opts)
 			unkv[(*unkc)++] =3D arg;
 		return opts;
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index c0460bb..43dd474 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -68,6 +68,12 @@ test_expect_success POSIXPERM,SANITY 'unreadable ord=
erfile' '
 	test_must_fail git diff -Ounreadable_file --name-only HEAD^..HEAD
 '
=20
+test_expect_success "orderfile using option from subdir with --output"=
 '
+	mkdir subdir &&
+	git -C subdir diff -O../order_file_1 --output ../actual --name-only H=
EAD^..HEAD &&
+	test_cmp expect_1 actual
+'
+
 for i in 1 2
 do
 	test_expect_success "orderfile using option ($i)" '
--=20
2.7.0.125.g9eec362

-- 8< --
