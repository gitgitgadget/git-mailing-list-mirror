Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AFF51F731
	for <e@80x24.org>; Sat,  3 Aug 2019 06:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfHCGvu (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 02:51:50 -0400
Received: from mout.web.de ([212.227.15.3]:45915 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfHCGvu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 02:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564815103;
        bh=OqLuD2fkFqgN4pPS4Jx8GLWuT7XOyjJsWfQqa2SyI7A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bL6aMvTBxzN1rtepDTVafa2GV4pJUBEbWAoRLu6lfpqoFh/+0iQVVQJej7by+MoW5
         V+833cQ8l4maCKozkQ6HJ4PZ6TXHJ50RRYbfPUjpVyEO0c5CzcUzTRG/k93fEOBoAJ
         rssflFn4V8xrG4OgqXGtLOuVQZqsmkBh031Or06g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKa0t-1hsyPQ18Wl-001zFb; Sat, 03
 Aug 2019 08:51:43 +0200
Subject: Re: Simplify-by-decoration with decorate-refs-exclude
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?=c3=89tienne_SERVAIS?= <etienne.servais@voucoux.fr>,
        git@vger.kernel.org,
        =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
 <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
 <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
 <5de287e9-a8e8-780a-7d39-2229b61914ca@web.de>
 <xmqqh86zjmcg.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <64bc5556-b098-7991-b7c2-3483277bb73c@web.de>
Date:   Sat, 3 Aug 2019 08:51:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqh86zjmcg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:56pYAdvPhSw0qpLNwgRTHVjpp+t/OZ4SOKgybfQt9gvwPwHzE1T
 xA/yYqGVNY22EE7T4yINq6MyiJ9/8dz3oMreaweCyrt4F/DJjZpi+LwhyWIULSSoKRq1P3e
 emtdzUEOBrLF5oVeFO9oyGPenEuIEIYko/+AFzZmZx/53zqFoTLBrG/AAnd+JAH6VGYjvBp
 q+oDXatOmGQfMed+0rV1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GrvKfQPi2VQ=:mozbkZX3wdMnQ9oBqANTfA
 tegzS//XC6kCBGyBhgIG15m0cbSWrJvLzZveNjcg49/4asaLC/tiGZ6koWaFI277YYCaSnpFe
 jU/7ADzbaX4RUia8xgMB3XQ4QIC1aXAff1dUSnMMzHYrv3lUSxUbifzyXS8Ubtm3+WSEDw6tP
 x/kncvR3PPOn8Ep32P4qc2b2m8fBXMVGfL3TjYopH8WHO6ZjDos9Bc2+onaQ6HaP7F8CURW9B
 i6RXOPzNsUiE5zTw1wN/iHjtmdF2gkyF2xZ28UYefiql2Ie/3bL0cMsWUQON/KiiaMm6ayuvQ
 N8hYHNk6qo3Zmsy4ObBn9UaAtuJBOFEwnpHfzmlf9qBxN9ZWP+HBR5gr4K6E/jV4oTUk5Hb7J
 /XeVGvH0q9q5cp9pQ8fS1PmGjIdwvL2NnYArz6zyRIAwfsXSGLojTQAikySkB67mvtAnN2Uqn
 cNa2Y79vFejXwNFsRQpKmu2s2jz9F09bEQX2pHvBir04+DRm3ardipt9MGdzVjoidSif107nR
 egm3h+HUjTm8FXt0KLaXNTX8zxE4hWaaUgm5QIXqMJW2ce+YriuNEIWjG1+ROmRM0bx/ESile
 5O/WqbT3uaORw5hDzWaL7sUh0xkiOb4txAhMoBz1CfE08sVJ0jOOUK/BE72jn+KEk5LiJPWAi
 9Ig9yZ5M+gwz2m3mz+3PqVza+WMzFoEoq/cTDGA/87V5j73VOlevqeZWK17iz/oP9uTYJDDur
 yGY+TEiHRnU9OBoqQIcqrrhfwg6+FW+MOHa0tK0FOESd1HNEWB+Zt9UcMvUIYomjv7h9hUyT8
 XWHb0VVqK3y6jHMC47fsuVVAGvVdo5OZIYSCpxVTM3zanuABLQ3+7l2sQMljlF0SDZq9FTgYi
 yBMuG03fc9jhqebAS/b0Y/OBDemGzaotyuVy+PuFPZMIaFsLgiG2Uva0hXLirqCNyTRHRJHvD
 yxfYFsNLY5+BbF1yEUae+QYaafZ+boMyAjo3MIfI3QYdswpjcafiHgl/xTbFNoX/bYX2YIKDN
 83Xcy9EAPZuXSXiaaQENx7OR8gUumfTtI977ZDrbCCl5WsYVdvR/r/jBUNUXt2FuyhN+4Q7Nh
 G93zW9MESV4v+jn/59hBlOV6XTYev3pwP+i35D/REEfNvBu+b/RCd2RQgpLiPJuLXZRDJNsu+
 0gGCc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.19 um 23:20 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Having cmd_log_init_finish() call load_ref_decorations() before
>> setup_revisions() would indeed solve the issue as well.  But we need
>> to call the latter to check if --pretty=3Draw was given and avoid loadi=
ng
>> decorations in that case, don't we?
>
> I was thinking about giving an instance of the decoration_filter to
> either rev_info or setup_revision_opt, and moving the call to
> load_ref_decorations() and the decision to make that call from
> cmd_log_init_finish() to setup_revisions().

Sure, but we'd need to move the code to handle the raw format as well, no?
Perhaps like this?  It depends on callers of parse_revision_opt() calling
setup_revisions() before using decorations.  And it may have other side
effects; I'm not comfortable with this change.

=2D--
 builtin/log.c  | 10 +++++-----
 revision.c     | 17 ++++++++++++++++-
 revision.h     |  4 ++++
 t/t4202-log.sh | 15 +++++++++++++++
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 1cf9e37736..5a1544276f 100644
=2D-- a/builtin/log.c
+++ b/builtin/log.c
@@ -203,6 +203,10 @@ static void cmd_log_init_finish(int argc, const char =
**argv, const char *prefix,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);

+	rev->decoration_filter =3D &decoration_filter;
+	rev->decoration_given =3D decoration_given;
+	rev->decoration_style =3D decoration_style;
+
 	if (quiet)
 		rev->diffopt.output_format |=3D DIFF_FORMAT_NO_OUTPUT;
 	argc =3D setup_revisions(argc, argv, rev, opt);
@@ -245,16 +249,12 @@ static void cmd_log_init_finish(int argc, const char=
 **argv, const char *prefix,
 		 * "log --pretty=3Draw" is special; ignore UI oriented
 		 * configuration variables such as decoration.
 		 */
-		if (!decoration_given)
-			decoration_style =3D 0;
 		if (!rev->abbrev_commit_given)
 			rev->abbrev_commit =3D 0;
 	}

-	if (decoration_style) {
+	if (rev->decoration_style)
 		rev->show_decorations =3D 1;
-		load_ref_decorations(&decoration_filter, decoration_style);
-	}

 	if (rev->line_level_traverse)
 		line_log_init(rev, line_cb.prefix, &line_cb.args);
diff --git a/revision.c b/revision.c
index 07412297f0..709d6a273c 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2063,7 +2063,6 @@ static int handle_revision_opt(struct rev_info *revs=
, int argc, const char **arg
 		revs->simplify_by_decoration =3D 1;
 		revs->limited =3D 1;
 		revs->prune =3D 1;
-		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order =3D REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order =3D 1;
@@ -2716,6 +2715,22 @@ int setup_revisions(int argc, const char **argv, st=
ruct rev_info *revs, struct s
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log =3D revs->expand_tabs_in_log_default;

+	if (revs->pretty_given && revs->commit_format =3D=3D CMIT_FMT_RAW) {
+		/*
+		 * "log --pretty=3Draw" is special; ignore UI oriented
+		 * configuration variables such as decoration.
+		 */
+		if (!revs->decoration_given)
+			revs->decoration_style =3D 0;
+	}
+
+	if (revs->decoration_style)
+		load_ref_decorations(revs->decoration_filter,
+				     revs->decoration_style);
+	else if (revs->simplify_by_decoration)
+		load_ref_decorations(revs->decoration_filter,
+				     DECORATE_SHORT_REFS);
+
 	return left;
 }

diff --git a/revision.h b/revision.h
index 4134dc6029..67ffe095a9 100644
=2D-- a/revision.h
+++ b/revision.h
@@ -186,6 +186,7 @@ struct rev_info {
 			pretty_given:1,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
+			decoration_given:1,
 			zero_commit:1,
 			use_terminator:1,
 			missing_newline:1,
@@ -269,6 +270,9 @@ struct rev_info {
 	/* line level range that we are chasing */
 	struct decoration line_log_data;

+	struct decoration_filter *decoration_filter;
+	int decoration_style;
+
 	/* copies of the parent lists, for --full-diff display */
 	struct saved_parents *saved_parents_slab;

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index c20209324c..bb66d1d93c 100755
=2D-- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -837,6 +837,21 @@ test_expect_success 'decorate-refs and decorate-refs-=
exclude' '
 	test_cmp expect.decorate actual
 '

+test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach (HEAD -> master)
+	reach (tag: reach, reach)
+	seventh (tag: seventh)
+	Merge-branch-tangle
+	Merge-branch-side-early-part-into-tangle (tangle)
+	tangle-a (tag: tangle-a)
+	EOF
+	git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+		--decorate-refs-exclude=3D"*octopus*" \
+		--simplify-by-decoration >actual &&
+	test_cmp expect.decorate actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=3Dfull >expect.full &&
 	git log --oneline --decorate=3Dshort >expect.short &&
=2D-
2.22.0
