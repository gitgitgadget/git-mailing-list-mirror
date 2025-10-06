Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF214221F1A
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771423; cv=none; b=CyJFbdDrinREcvK2sqZH9Ulf2J3A/7G2na0XH+wmnLQ/r1AAtcmNBfA1KLIz/i+X3lhno3qo1kW2tYgTh0xjBw4xXMkwd3K1LdkqrHjrhUfsJw85oRTMRENoFmjZpjQ1MeHGdKoC0FApHP/mUyHq/lmRF4B6cyEvTRifC2elZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771423; c=relaxed/simple;
	bh=EE7UyOTuwzWa0kb00vQPy8pCwbwkGQXYxI/J5DiNTV4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QMbO5PmhFPjls+OzxvXNOOt00DVwK91waAFVoJhwHRVn8AT8YzKv+pLVHmonATi44cldj9tI8AWQ1J9na2iBkRowLclgHIYDsj5zKN2XZ9U5jtHcZkHJMha7dxWdeVg/vWKSgN84w3eYgSCP3KoDvRJw4u5fqOwS6EuC8a3yeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=l7mM4bpH; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="l7mM4bpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759771415; x=1760376215; i=l.s.r@web.de;
	bh=E6x2tUGW5RIC6P2MSATTonU9fWv1jF8b/erwcmnJh7Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l7mM4bpHmdn2NAOMjvaBLvHoyaWs2GpNlt2uykdTuIlX5jIcQTh+6Zpaled9vmn6
	 hlrwTa+vOgW0GpjLuDvJ+SsaqrKNQ/mh86EQEYNhCSceuYCmDGj5qCdeuTher8thf
	 hjVW0L7ER/UvB1nO6ol1nkJUB7fIMq2Z49sL0yfbUQDRguac0ekOumZzbzCLKiNk1
	 XYqfkkpgwQNMCF8/s+kQFUym5T9sjr1KNBISHw6d10nfaSm+MhOThQWSkJq0rwlEE
	 7wFp6k5NF0rm9c+xYPYB+G71qgFOh5VluXS8S0/Io4eMY2obLuJeBIbYXHIlE1et4
	 KlJiOdzLTHLMZVkutA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1uiL4k0xlV-00QLJB; Mon, 06
 Oct 2025 19:23:35 +0200
Message-ID: <a00f7c63-0d29-4a7c-bef1-bd7bf94d3420@web.de>
Date: Mon, 6 Oct 2025 19:23:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 5/6] add-patch: let options a and d roll over like y and n
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
X-Provags-ID: V03:K1:csmBDQxQp6pDOqIOHvmaKINjULaIoYGANs4fPoL5KLenfpOIlNB
 7cicZhTtujePypidUhHLoE3LUYOCNfSqjxbqIZ5CsUvbXXN+2iAauf38VKaijTphNWFrW6i
 Ut3slyc7CozJEp/OmXUDNlA5Ae6y128Taq9RaHEvtA59Zi8pz97HYCncjLMDwQWwzUtJXoQ
 XhZvxc6egyKC4Fvl5+GiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FZNvo7YblmE=;RoDf64bITMM5FsZm9w96wDMWY4p
 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

Options a and d stage and unstage all undecided hunks towards the bottom
of the array of hunks, respectively, and then roll over to the very
first hunk.  The first part is similar to y and n if the current hunk is
the last one in the array, but they roll over to the next undecided
hunk if there is any.  That's more useful; do it for a and d as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 add-patch.c                | 15 +++++++++++++++
 t/t3701-add-interactive.sh | 12 ++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 4f314c16ec..6da13a78b5 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1418,6 +1418,17 @@ static size_t inc_mod(size_t a, size_t m)
 	return a < m - 1 ? a + 1 : 0;
 }
=20
+static bool get_first_undecided(const struct file_diff *file_diff, size_t=
 *idx)
+{
+	for (size_t i =3D 0; i < file_diff->hunk_nr; i++) {
+		if (file_diff->hunk[i].use =3D=3D UNDECIDED_HUNK) {
+			*idx =3D i;
+			return true;
+		}
+	}
+	return false;
+}
+
 static int patch_update_file(struct add_p_state *s,
 			     struct file_diff *file_diff)
 {
@@ -1572,6 +1583,8 @@ static int patch_update_file(struct add_p_state *s,
 					if (hunk->use =3D=3D UNDECIDED_HUNK)
 						hunk->use =3D USE_HUNK;
 				}
+				if (!get_first_undecided(file_diff, &hunk_index))
+					hunk_index =3D 0;
 			} else if (hunk->use =3D=3D UNDECIDED_HUNK) {
 				hunk->use =3D USE_HUNK;
 			}
@@ -1582,6 +1595,8 @@ static int patch_update_file(struct add_p_state *s,
 					if (hunk->use =3D=3D UNDECIDED_HUNK)
 						hunk->use =3D SKIP_HUNK;
 				}
+				if (!get_first_undecided(file_diff, &hunk_index))
+					hunk_index =3D 0;
 			} else if (hunk->use =3D=3D UNDECIDED_HUNK) {
 				hunk->use =3D SKIP_HUNK;
 			}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 385e55c783..9d81b0542e 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1364,24 +1364,24 @@ test_expect_success 'options J, K roll over' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'options y, n, j, k, e roll over to next undecided (1=
)' '
+test_expect_success 'options y, n, a, d, j, k, e roll over to next undeci=
ded (1)' '
 	test_write_lines a b c d e f g h i j k l m n o p q >file &&
 	git add file &&
 	test_write_lines X b c d e f g h X j k l m n o p X >file &&
 	test_set_editor : &&
-	test_write_lines g3 y g3 n g3 j g3 e k q | git add -p >out &&
-	test_write_lines 1  3 1  3 1  3 1  3 1 2 >expect &&
+	test_write_lines g3 y g3 n g3 a g3 d g3 j g3 e k q | git add -p >out &&
+	test_write_lines 1  3 1  3 1  3 1  3 1  3 1  3 1 2 >expect &&
 	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success 'options y, n, j, k, e roll over to next undecided (2=
)' '
+test_expect_success 'options y, n, a, d, j, k, e roll over to next undeci=
ded (2)' '
 	test_write_lines a b c d e f g h i j k l m n o p q >file &&
 	git add file &&
 	test_write_lines X b c d e f g h X j k l m n o p X >file &&
 	test_set_editor : &&
-	test_write_lines y g3 y g3 n g3 j g3 e g1 k q | git add -p >out &&
-	test_write_lines 1 2  3 2  3 2  3 2  3 2  1 2 >expect &&
+	test_write_lines y g3 y g3 n g3 a g3 d g3 j g3 e g1 k q | git add -p >ou=
t &&
+	test_write_lines 1 2  3 2  3 2  3 2  3 2  3 2  3 2  1 2 >expect &&
 	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
 	test_cmp expect actual
 '
=2D-=20
2.51.0
