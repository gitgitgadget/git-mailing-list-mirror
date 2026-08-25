Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEA35DA79
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681048; cv=none; b=GzAHhPg9+DAV4Tf52rdoUQjSuXYHwPAHJtTjc7/mcNUKUL+FoJn473aE+enowFB7iHkHXef8COzfLYNmAst5O3qVovf+1qPM0URYYzHOVfyw6v7IG/37xwj106XnK20TKLrZizRH6kwFkAQVFzlgISKePIaciXBhBlGR1c5BFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681048; c=relaxed/simple;
	bh=AwR+CGzcA/ZWDa/xkZvk/fe9aYi/zajfJwef01Vxbbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoLT54UckSBnsfuwcViePiNn1cnFekJITHgzslQFsIcnKK/xfiUmdIQmiJCo1FpJrxubxXi/k+EvL9jvNVjujyJ7cgJ8LWnlb0sOK4I1/SgS/KUje1JiA/5ueoO89w/QDyAieSpAkSycU9LEkfheDSrhZaKEeBxe6JG91Dyw6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=okOZP96O; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="okOZP96O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787681037; x=1788285837; i=l.s.r@web.de;
	bh=Oz4ZpJoLeRrK9w8RWitiUyJEj4Kgq3ik8CFIQoKUTNs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=okOZP96OYYhQkapU1ieFcHr1L5daJbhLNwFmnD4Abw2n0Gz/4aOPB5AUDKaS0zrb
	 MLU1qI+wZXaITPsPAedSve77QCyO2X17DzmmRkDAxAALw7qB2r095Acr6JLmtMhd5
	 yZxzdP0cgi5Ub9P1HFkUK08sxdr4YyQT5+yUn7Q7oNSmCH3AyQP4O58HxmjcgfVec
	 DGPq7FF8xFRmRkEJEioD7U8LSN7K6RHHYUQG+8kT3Alv/7M19QC7/pqaMRBVgSxLw
	 jeb4/uURoReZBKyiu/C/TFfWiCmYs3ZLqAb1OGXrtgk/Ef9jJSvHJqFIktUcsruxo
	 D8FSDcwvMtlnBMpmzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVKI-1whfri3Yos-012ouQ; Tue, 25
 Aug 2026 20:03:56 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Subject: [PATCH 2/4] worktree add: reject separator-only path
Date: Tue, 25 Aug 2026 20:03:48 +0200
Message-ID: <20260825180350.2099-3-l.s.r@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825180350.2099-1-l.s.r@web.de>
References: <20260825180350.2099-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2qFdH9O1pwJ8bUAizCxKeLwZbRDCY9QzlJjqgzDgXRm+8ZgNyP8
 Y6D+3oWGh6KRXKyIdXDenp5qvxDh3iHx/CqkWSWg56zBiKpnbdmA/qmnbF2OKASz41xh3zi
 rvmbhvjj5O+3PtUDeT06aZl/UsSEN1UYCTGqHq9pcPPgK7RWkoKIrrkvzr+L7da62HMkWeb
 oQYz9QgyQUhEIQLWklVtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:djuxhIQuK08=;/Ti365n2qN+RsuJwh0QUFAKsyOM
 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
 =

worktree_basename() extracts an empty basename from a path consisting
only of zero or more path separators.  We can't use that as a worktree
name.  Properly report such a path as invalid instead of triggering a
BUG that asks the user what just happened.

Original-patch-by: Matthias A=C3=9Fhauer <mha1993@live.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/worktree.c      | 2 ++
 t/t2400-worktree-add.sh | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a770dd5ead..a53e815cc9 100644
=2D-- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -491,6 +491,8 @@ static int add_worktree(const char *path, const char *=
refname,
=20
 	name =3D worktree_basename(path, &len);
 	strbuf_add(&sb, name, path + len - name);
+	if (!sb.len)
+		die(_("invalid path '%s'"), path);
 	sanitize_refname_component(sb.buf, &sb_name);
 	if (!sb_name.len)
 		BUG("How come '%s' becomes empty after sanitization?", sb.buf);
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..280d2e2c07 100755
=2D-- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -46,6 +46,10 @@ test_expect_success '"add" refuses to checkout locked b=
ranch' '
 	test_path_is_missing .git/worktrees/zere
 '
=20
+test_expect_success '"add" rejects an empty path' '
+	test_must_fail git worktree add "" HEAD
+'
+
 test_expect_success 'checking out paths not complaining about linked chec=
kouts' '
 	(
 	cd existing_empty &&
=2D-=20
2.55.0

