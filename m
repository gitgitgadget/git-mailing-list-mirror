Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3C221F1A
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771373; cv=none; b=bkZpKfFQ0H7NnyTVWE+rWj5kseCUjKl8PY1qH1SYfCIHHagxHxOr1mU4RMRr6DN5wR1fyB+XKL2IKtTgAhqmeGKDcrj2Vm6gyf/TZSVFDpA0hEBGDK8IncbJs8eCBVOz7RBqf2YfTBhwETLQJn+wLMzybLzVSmuMpfN0mfNMO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771373; c=relaxed/simple;
	bh=K/h8Q8KXg1Hmp/KMeCyG+5tLvcunjAwpTHtE8EtNpNg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mkPEXNUSlKeTkLiTpKoMyi/b5mgO0+0xge+jVBMnpxhnqSDQdFx3D6rxaYsLMqV01wK9X/vqSxNCxWjwYLfPi435GVTizVJI65vzrcobD44ZEBHu3u8HVQPCfUXww6olMf18y33xteuXiHUURnpHnB3bLskf/AS0tW3zJnxlWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ITVsbRxq; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ITVsbRxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759771358; x=1760376158; i=l.s.r@web.de;
	bh=hfJ8c4csqmXPHZSGuBp/u/KoSUuZrGWm+zeFLXMPx+U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ITVsbRxq96D0muLId9xb/ZjHabRX+PjSLkhhfnb+KXA8eWs2mAWBzpzhwqeQm9xO
	 2kA+YRFYyFOIRf01kOR1k9AQAOk6KV3TVAyh7BbbsBafxaP4jyM4SnSgNCF/9tkHf
	 HCD52nMHOj/RayNgwCu8/m+IZ1+2WMC03utadYTMJiPleGj2smpMK5RLYcs0nekWa
	 gQqqST5eq504T3o80RuTq63dxqruF2kaSNpig8B9YeKOZGiZMTznHYuB+R40PhaMA
	 LrwhvszkkUVFKD+vUPsDgC+z+b+zzJBGKi6xCrqMoXpfeXiO+w9bMac6jgCLXfSe+
	 x+Yb13ampGuMqDIygg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLAVc-1unbHI3PnO-00WC2f; Mon, 06
 Oct 2025 19:22:38 +0200
Message-ID: <f46cd8f4-5382-4879-963d-3a31ed1552a7@web.de>
Date: Mon, 6 Oct 2025 19:22:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 4/6] add-patch: let options k and K roll over like j and J
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Language: en-US
In-Reply-To: <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UIXYirZH2DcuLfSaEBAeLfBMZTljVHly6UUwA1c0dTGzyLlXZU9
 xIcgT6CEeaZ0/yOkONlsMCOS/dUpfQBhndDEjNWVE/QVVZUeOCf1j3aMN1hySjOMYSH0l+4
 ne4L2Lm6R/OkI0YBVhYyGtSC5PGzxputUaq3Qjpcqki1BkP3kFIpWQCWdsWZ8SDMp1bQ4Uy
 hzHHQKOQ3Rea2xwO8XFkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G+yU8Z2K0hY=;UQmObRmk96atsY+smG7dWpluwBR
 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

Options j and J roll over at the bottom and go to the first undecided
hunk and hunk 1, respectively.  Let options k and K do the same when
they reach the top of the hunk array, so let them go to the last
undecided hunk and the last hunk, respectively, for consistency.  Also
use the same direction-neutral error messages.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-add.adoc |  4 ++--
 add-patch.c                | 22 ++++++++++++++-------
 t/t3701-add-interactive.sh | 40 +++++++++++++++++++-------------------
 3 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 596cdeff93..3116a2cac5 100644
=2D-- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -344,8 +344,8 @@ patch::
        / - search for a hunk matching the given regex
        j - go to the next undecided hunk, roll over at the bottom
        J - go to the next hunk, roll over at the bottom
-       k - go to the previous undecided hunk
-       K - go to the previous hunk
+       k - go to the previous undecided hunk, roll over at the top
+       K - go to the previous hunk, roll over at the top
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
        p - print the current hunk
diff --git a/add-patch.c b/add-patch.c
index 106bfcb275..4f314c16ec 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1399,8 +1399,8 @@ static size_t display_hunks(struct add_p_state *s,
 static const char help_patch_remainder[] =3D
 N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "J - go to the next hunk, roll over at the bottom\n"
-   "k - go to the previous undecided hunk\n"
-   "K - go to the previous hunk\n"
+   "k - go to the previous undecided hunk, roll over at the top\n"
+   "K - go to the previous hunk, roll over at the top\n"
    "g - select a hunk to go to\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
@@ -1408,6 +1408,11 @@ N_("j - go to the next undecided hunk, roll over at=
 the bottom\n"
    "p - print the current hunk, 'P' to use the pager\n"
    "? - print help\n");
=20
+static size_t dec_mod(size_t a, size_t m)
+{
+	return a > 0 ? a - 1 : m - 1;
+}
+
 static size_t inc_mod(size_t a, size_t m)
 {
 	return a < m - 1 ? a + 1 : 0;
@@ -1450,7 +1455,9 @@ static int patch_update_file(struct add_p_state *s,
 		undecided_next =3D -1;
=20
 		if (file_diff->hunk_nr) {
-			for (i =3D hunk_index - 1; i >=3D 0; i--)
+			for (i =3D dec_mod(hunk_index, file_diff->hunk_nr);
+			     i !=3D hunk_index;
+			     i =3D dec_mod(i, file_diff->hunk_nr))
 				if (file_diff->hunk[i].use =3D=3D UNDECIDED_HUNK) {
 					undecided_previous =3D i;
 					break;
@@ -1492,7 +1499,7 @@ static int patch_update_file(struct add_p_state *s,
 				permitted |=3D ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
 				strbuf_addstr(&s->buf, ",k");
 			}
-			if (hunk_index) {
+			if (file_diff->hunk_nr > 1) {
 				permitted |=3D ALLOW_GOTO_PREVIOUS_HUNK;
 				strbuf_addstr(&s->buf, ",K");
 			}
@@ -1584,9 +1591,10 @@ static int patch_update_file(struct add_p_state *s,
 			}
 		} else if (s->answer.buf[0] =3D=3D 'K') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
-				hunk_index--;
+				hunk_index =3D dec_mod(hunk_index,
+						     file_diff->hunk_nr);
 			else
-				err(s, _("No previous hunk"));
+				err(s, _("No other hunk"));
 		} else if (s->answer.buf[0] =3D=3D 'J') {
 			if (permitted & ALLOW_GOTO_NEXT_HUNK)
 				hunk_index++;
@@ -1596,7 +1604,7 @@ static int patch_update_file(struct add_p_state *s,
 			if (permitted & ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK)
 				hunk_index =3D undecided_previous;
 			else
-				err(s, _("No previous hunk"));
+				err(s, _("No other undecided hunk"));
 		} else if (s->answer.buf[0] =3D=3D 'j') {
 			if (permitted & ALLOW_GOTO_NEXT_UNDECIDED_HUNK)
 				hunk_index =3D undecided_next;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 8086d3da71..385e55c783 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -333,7 +333,7 @@ test_expect_success 'different prompts for mode change=
/deleted' '
 	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
 	cat >expect <<-\EOF &&
 	(1/1) Stage deletion [y,n,q,a,d,p,?]?
-	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,?]?
+	(1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,p,?]?
 	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]?
 	EOF
 	test_cmp expect actual.filtered
@@ -527,7 +527,7 @@ test_expect_success 'goto hunk 1 with "g 1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -540,7 +540,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
 	EOF
 	test_write_lines s y g1 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -554,7 +554,7 @@ test_expect_success 'navigate to hunk via regex /patte=
rn' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -567,7 +567,7 @@ test_expect_success 'navigate to hunk via regex / patt=
ern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
 	EOF
 	test_write_lines s y / 1,2 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -579,11 +579,11 @@ test_expect_success 'print again the hunk' '
 	tr _ " " >expect <<-EOF &&
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
 	 10
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
 	EOF
 	test_write_lines s y g 1 p | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -595,11 +595,11 @@ test_expect_success TTY 'print again the hunk (PAGER=
)' '
 	cat >expect <<-EOF &&
 	<GREEN>+<RESET><GREEN>15<RESET>
 	 20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>PAGER=
 <CYAN>@@ -1,2 +1,3 @@<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? <RESET>P=
AGER <CYAN>@@ -1,2 +1,3 @@<RESET>
 	PAGER  10<RESET>
 	PAGER <GREEN>+<RESET><GREEN>15<RESET>
 	PAGER  20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? <RESET>
 	EOF
 	test_write_lines s y g 1 P |
 	(
@@ -802,7 +802,7 @@ test_expect_success 'colors can be overridden' '
 	<BOLD>-old<RESET>
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET><MAGENTA=
>@@ -3 +3,2 @@<RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? <RESET><MAG=
ENTA>@@ -3 +3,2 @@<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
 	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? <RESET><MAGENTA=
>@@ -1,3 +1,3 @@<RESET>
@@ -810,7 +810,7 @@ test_expect_success 'colors can be overridden' '
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
@@ -1354,34 +1354,34 @@ do
 	'
 done
=20
-test_expect_success 'option J rolls over' '
+test_expect_success 'options J, K roll over' '
 	test_write_lines a b c d e f g h i >file &&
 	git add file &&
 	test_write_lines X b c d e f g h X >file &&
-	test_write_lines J J q | git add -p >out &&
-	test_write_lines 1 2 1 >expect &&
+	test_write_lines J J K q | git add -p >out &&
+	test_write_lines 1 2 1 2 >expect &&
 	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success 'options y, n, j, e roll over to next undecided (1)' =
'
+test_expect_success 'options y, n, j, k, e roll over to next undecided (1=
)' '
 	test_write_lines a b c d e f g h i j k l m n o p q >file &&
 	git add file &&
 	test_write_lines X b c d e f g h X j k l m n o p X >file &&
 	test_set_editor : &&
-	test_write_lines g3 y g3 n g3 j g3 e q | git add -p >out &&
-	test_write_lines 1  3 1  3 1  3 1  3 1 >expect &&
+	test_write_lines g3 y g3 n g3 j g3 e k q | git add -p >out &&
+	test_write_lines 1  3 1  3 1  3 1  3 1 2 >expect &&
 	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success 'options y, n, j, e roll over to next undecided (2)' =
'
+test_expect_success 'options y, n, j, k, e roll over to next undecided (2=
)' '
 	test_write_lines a b c d e f g h i j k l m n o p q >file &&
 	git add file &&
 	test_write_lines X b c d e f g h X j k l m n o p X >file &&
 	test_set_editor : &&
-	test_write_lines y g3 y g3 n g3 j g3 e q | git add -p >out &&
-	test_write_lines 1 2  3 2  3 2  3 2  3 2 >expect &&
+	test_write_lines y g3 y g3 n g3 j g3 e g1 k q | git add -p >out &&
+	test_write_lines 1 2  3 2  3 2  3 2  3 2  1 2 >expect &&
 	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
 	test_cmp expect actual
 '
=2D-=20
2.51.0
