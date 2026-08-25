Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB73CFF61
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681048; cv=none; b=APHarp8+x11kl9+UZBFrA0A5f1X0dnGXfGGfvqFUdvSlatWP1etg1eYdRLBeN+bnp3b26mxuSXxMciAv03JBK1dxVZ+qQ1sLN7J3XohfhS31mEeBcC1VqSwpX3SBJdQUPrt0ADCGY5pE1NCoVKdpuqqssrR4JnPXhNbw5QCxQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681048; c=relaxed/simple;
	bh=oKIkwQ6MhCsh+ajBsqmwR9V1o9lzN0CykStmeoagNyQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSBnF0AnZGzmJ+02Z9JRBy9Q/D80O8kS+8LpcNHYN6YJwNjDePzkEiNIjmaL5RgQxInrDMblxPbgdcRi/XwAllh2hzfnQ1KIoCCZ8pcmqZgOv+EMHowzmio5zsNwvZoMgfHUVyb7jb+Pkyd5qHm2ydXotPtlwzHuWO4lHr1wunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=huEQb+hm; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="huEQb+hm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787681037; x=1788285837; i=l.s.r@web.de;
	bh=11WMdvXvw+PeMNXyFTgH0S9+L6kpGj2uygj+ern5w6I=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=huEQb+hm8lm6j9iLLuvF2QzopSNwF7G/OiFa7Korf6LWe7KpG/gXFyCLp6qWroce
	 wBvtnpbto6iZ5D9JFacMeKaRNsuAw6oVqskk+JGuPJ2bealAbJAYOHHeV5edl3p76
	 loT7s61aPfyRNUa1nlIWMs8oo5jnM2lhYJDBMzSSog4ME4tPzs2xGt7janerjB6gP
	 31EBylTmmdpeoRI+HDLEGoJfW4+lkfuE0WiPzFT5c+k7Q9la8qcItl131jfaV6RrB
	 7Zx+1jB7XqgK83XMHGZqmJ21O8B5OVY4FPmkEqgfB3UPKzZAOgjYKF1KywWBA9Tq+
	 UJYfsVOy8psa+ZutSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXXND-1xQe4R44Ip-00Nej1 for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 20:03:57 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 3/4] worktree add: trim slashes when deriving branch name from path
Date: Tue, 25 Aug 2026 20:03:49 +0200
Message-ID: <20260825180350.2099-4-l.s.r@web.de>
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
X-Provags-ID: V03:K1:akH+Ly+7StYcAFeRkMZ5iKihQ5zjLj8ur4hZVEwGeym+NWRfbz0
 so9cPE7FwbjiKq8jSO/doD9yoh4dUnZ0IsFBSSoOD3fWWgZLaiM+M714ZQSNDQQ7C/A6/rn
 vfPpuk0o9vQG8Qr10zTQgw9F+DJiDFaLmlG5oMOMspnndimM4pUqnXBylBzs0XFVQLJVBD+
 /P48i1D5USWphfvZN4Ong==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5+312/hBbeE=;rPy0v59OK2IwZBGugV3cVsCic3n
 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
 0V5f0RZg==

worktree_basename() sets `n` to the length of `path` without trailing
path separators, not to the length of the basename.  This matters when
deriving a branch name from a path with more than one component.  E.g.:

   path: /new/worktree/
   s:         ^
   n:    |-----------|

So here xstrndup(s, n) copies up to 13 characters from "worktree/",
effectively to the end of the string, including the trailing dash.

Path separators are not allowed at the end of branch names, so strip
them off by calculating the basename length and extracting just that
part.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/worktree.c      |  4 ++--
 t/t2400-worktree-add.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a53e815cc9..01c245778e 100644
=2D-- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -769,7 +769,7 @@ static char *dwim_branch(const char *path, char **new_=
branch)
 	int n;
 	int branch_exists;
 	const char *s =3D worktree_basename(path, &n);
-	char *branchname =3D xstrndup(s, n);
+	char *branchname =3D xmemdupz(s, path + n - s);
 	struct strbuf ref =3D STRBUF_INIT;
=20
 	branch_exists =3D !check_branch_ref(the_repository, &ref, branchname) &&
@@ -878,7 +878,7 @@ static int add(int ac, const char **av, const char *pr=
efix,
 	if (opts.orphan && !new_branch) {
 		int n;
 		const char *s =3D worktree_basename(path, &n);
-		new_branch =3D new_branch_to_free =3D xstrndup(s, n);
+		new_branch =3D new_branch_to_free =3D xmemdupz(s, path + n - s);
 	} else if (opts.orphan) {
 		; /* no-op */
 	} else if (opts.detach) {
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 280d2e2c07..7e2811fa77 100755
=2D-- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -298,6 +298,11 @@ test_expect_success '"add" with <branch> omitted' '
 	test_cmp_rev HEAD bat
 '
=20
+test_expect_success '"add" with trailing slash and <branch> omitted' '
+	git worktree add waffle/bit/ &&
+	test_cmp_rev HEAD bit
+'
+
 test_expect_success '"add" checks out existing branch of dwimd name' '
 	git branch dwim HEAD~1 &&
 	git worktree add dwim &&
@@ -388,6 +393,14 @@ test_expect_success '"add --orphan (no -b)"' '
 	test_cmp expected actual
 '
=20
+test_expect_success '"add --orphan with trailing slash (no -b)"' '
+	test_when_finished "git worktree remove -f -f neworphan" &&
+	git worktree add --orphan ./neworphan/ &&
+	echo refs/heads/neworphan >expected &&
+	git -C neworphan symbolic-ref HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success '"add --orphan --quiet"' '
 	test_when_finished "git worktree remove -f -f orphandir" &&
 	git worktree add --quiet --orphan -b neworphan orphandir 2>log.actual &&
=2D-=20
2.55.0

