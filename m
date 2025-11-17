Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E027F736
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408580; cv=none; b=BmVcZm6YHvzqih9hPaoe2Y1g5S4uLFzk6bTIiq44unYad2wEuN/U5o4jtd3IJE6xBGzadlrH4Bd/gHxDQd9qChCcHY3KStndlKzyRoBFVpH9m639z87n6T+o7cO5c732a0QZ4dUAbUNUDiNqRJrTaGJfV77onpXD5iWMElD07Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408580; c=relaxed/simple;
	bh=EqcgzSrzYg7qW99iicAxAhzz/eK4pfEH3tulz8S37DA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=tiXZoFxY0OhJJEYNQfaStzLNIQfk4rsmPsJ+hAh42Ns8OakcvKiHqH7siVTdW1tU0MF59xlcnVpoz77Sc5KDnUlNAFHTM3oyFthNFxGu7kz9yNIJqFSwSxmtDqSwAnWR7OkxubqTmK1Pw70mwdP0MI2AtnwIbkdNST4rgcgDutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=QaJJBDSy; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="QaJJBDSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763408576; x=1764013376; i=l.s.r@web.de;
	bh=iMOKY/eBVipdiD3xR6TmUgc+00hBLM0ztOThzil6BPM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QaJJBDSyrkr1hJQndy5Zwig8BtFMRf+/yS3nocgFETzZlehqJr4sWYApw3lOH3lG
	 AokoXIIcegGcbnqGI4PtE5VrkU06DZd4/865iQH4S4+3G/EWBZGo7zoXvU0fq+wLc
	 XI08aG+mdxL5W5A1995k0AsL1c0xkwIzNrMB2z525n05vC2ETsl029qnzr578Aehg
	 E84kDx7LQSFRlxQaHN6yRqSz2pBlUHqXKjU+eLbhJqbPLYX6C6+Mieii6Q+TNbwOf
	 y9PZSUVdE6SAlP8atQ3E3yFTdAWWvFreaxFuga8P8PfyJxxuN3B6bAoXF5HWvGg53
	 W3wn2/6h2S3B3OluXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.146.25]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLmo-1vgPLp3dKM-00LrcP for
 <git@vger.kernel.org>; Mon, 17 Nov 2025 20:42:55 +0100
Message-ID: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de>
Date: Mon, 17 Nov 2025 20:42:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] wrapper: simplify xmkstemp()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vdO/sfIc7VrYhADutC9uMUdmuLuITex8eYPifL0D0eI4Bqjr/Ae
 03Sx+cBaLZ1rc2VvSVtrXsTLD0uWmms0z5X1dkMT06e0+yC7+JS4zCKmrewYkL58b/mP66N
 gWgZ87tKY+Xiev6XvSjcKtelZ3IcQXTadps57litXu8UQGVWExvolM8p8IYjuIvSfTHzjHQ
 GC+1VYzQPesM9uOZA9xvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q9sfXNxjbFA=;6+4AxciiiDXebFTTxag/xN+Udev
 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

Call xmkstemp_mode() instead of duplicating its error handling code.
This switches the implementation from the system's mkstemp(3) to our own
git_mkstemp_mode(), which works just as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 wrapper.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 3d507d4204..d5976b3e7e 100644
=2D-- a/wrapper.c
+++ b/wrapper.c
@@ -421,24 +421,7 @@ FILE *fopen_or_warn(const char *path, const char *mod=
e)
=20
 int xmkstemp(char *filename_template)
 {
-	int fd;
-	char origtemplate[PATH_MAX];
-	strlcpy(origtemplate, filename_template, sizeof(origtemplate));
-
-	fd =3D mkstemp(filename_template);
-	if (fd < 0) {
-		int saved_errno =3D errno;
-		const char *nonrelative_template;
-
-		if (strlen(filename_template) !=3D strlen(origtemplate))
-			filename_template =3D origtemplate;
-
-		nonrelative_template =3D absolute_path(filename_template);
-		errno =3D saved_errno;
-		die_errno("Unable to create temporary file '%s'",
-			nonrelative_template);
-	}
-	return fd;
+	return xmkstemp_mode(filename_template, 0600);
 }
=20
 /* Adapted from libiberty's mkstemp.c. */
=2D-=20
2.51.2
