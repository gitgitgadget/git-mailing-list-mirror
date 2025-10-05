Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431802628D
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679754; cv=none; b=dILtqCk2IcNgGQtgNd8TtpxcS9Cny90zRTzY4H8E8pRNe5/dNXfEA16r1pHJFrmf8ZsthKD6RBCz5yXgThVBkUp+EJ2taj5bsE5Su90izVo9yevMV/x5VaLF+21WDdGCKL38YoxMG5touZWjUenRFvHVqyfbKzUhVeaFH1/gMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679754; c=relaxed/simple;
	bh=CtFwYmufx5Jlr+PxDclex9HVNylbdqIIvzECCDhGl3s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V2MwPkozX8dIOziMTwyMJXmcKjPHH1Tn/cFykTBhN6DAMc4nAWJhspY0eHUPEdrhikBXSNxhv+BgHeQt6h+MmXmMwuvppcjh59OJ0jBUqeCCprAzHukFHBaVINhYaODFPnZ5MAd5JYi9K69Yy6QFRUepuW/T8XWAoLcZuebH1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=l6fJF9BX; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="l6fJF9BX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759679747; x=1760284547; i=l.s.r@web.de;
	bh=0fzA4UB9wsW7mx7nYx6ICauAGI6AjEdq3SPoCApRCl8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l6fJF9BXZEx9nlWbjCC0BYL19yQs2r9trIAccUW+aqhnS2nvE3HoQ6Do0pMDRpFj
	 4k2G6wEVOcLZrSWPYPLpU+Enm6mP2mrV18/ARNN5vhz93pQljpQvrF25leMvohpsB
	 4BTXpF7/WRdFKqWl5Xd1dpfSc6H0oWGfHHx0DC5W6QqhBfdKSeiH6nPlYgYxyernu
	 skenwwgdadCwyDX/FKkfy7gs2VBUOpZIlmcs0f2TL+I5yArjrLxZlox3bzfzCFn3T
	 lvw73GMhHZz335Nc/h9NCv4KF1ZePQVquB/aytLAtLBV9rOlganELdqs4OkmAsMWQ
	 yrcLF4MAfJML+OO08g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqIB7-1uRReC0qrD-00aXpt; Sun, 05
 Oct 2025 17:55:47 +0200
Message-ID: <f99b93d5-3de2-4077-8818-9272e812c289@web.de>
Date: Sun, 5 Oct 2025 17:55:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/5] add-patch: let options k and K roll over like j and J
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Language: en-US
In-Reply-To: <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/BVzSllOMn1ogjaaXCUZULifrqkV6z18yEncHxU+uBCaHPnNakP
 Ay4hwjffHkPTWaIuW/neXl3ddQIDg+Lr2qkd7NseoaqqUjxfv47t+MNKAh8te+62NN7VQRn
 jfJYq97R+VfWkxMQxF4zcWLe7HHUkEy69Cvw4f0UIPGhRy5xvNIkYVeodk9kb/NZRivUUyf
 DPmRr/g+iSsy/K8oIAYhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bjT+UhIjnTs=;2AY37DJL4HC8Dc8kBzNlNi0LlW+
 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

Options j and J roll over at the bottom and go to the first undecided
hunk and hunk 1, respectively.  Let options k and K do the same when
they reach the top of the hunk array, so let them go to the last
undecided hunk and the last hunk, respectively, for consistency.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-add.adoc |  4 ++--
 add-patch.c                | 18 ++++++++++++-----
 t/t3701-add-interactive.sh | 40 +++++++++++++++++++-------------------
 3 files changed, 35 insertions(+), 27 deletions(-)

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
index da75618dcb..52e881d3b0 100644
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
@@ -1584,7 +1591,8 @@ static int patch_update_file(struct add_p_state *s,
 			}
 		} else if (s->answer.buf[0] =3D=3D 'K') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
-				hunk_index--;
+				hunk_index =3D dec_mod(hunk_index,
+						     file_diff->hunk_nr);
 			else
 				err(s, _("No previous hunk"));
 		} else if (s->answer.buf[0] =3D=3D 'J') {
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
