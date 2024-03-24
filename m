Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925114AA8
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711267238; cv=none; b=mNpkYmrfOUOvy3awBqfQ6R2T1Jnn5ufJXMVkgbPhZRlEE4OO3CE7xCgG2RyL6T6mFMw0QpCJTsYAdtZQR77CmidaUHWTiCzWz3fP9xUHxY+fMxGHTbJB477wiFzZsKYEg/P1vCJ5tCpG8L/u5MGXkGzk0Icvsz158gkTGYG0E5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711267238; c=relaxed/simple;
	bh=KH0C+x2X+5N9D3wVFwO1Xo9UYmcWPWBYI3Z1/VJk4so=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RgfRHYhkV8UGvFyqU6TEYoSGneSPBEBXGt8ABD8eGe4JaAvmk234zCllH/OutaWWEsHoVRkN+puq1k4kdLaWVBBwySRs2z0xDaUCYGyARXd6/4zj37k++g+FS97OfbCTxrYNkfySLpDjwAmWrhIZ/9dstY4SNY3DoQfNEPMHxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=LRFfxzv1; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="LRFfxzv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711267227; x=1711872027; i=l.s.r@web.de;
	bh=gTclcn7+oW8t738MZQbgDkM0yQ1dofk8+jBsF1YeiiM=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=LRFfxzv1Uo/6O4WvLATHyFgVgzgoBaIef9hbr0r+EWQjxzZ3VuOdAVEPi4Sy+SI9
	 bMddQW1NLd85aosSeVJO2s/D9VjfrpWE/EqovaEbpdSCNvqU0aVczBB88lNuqN4x3
	 nI+rmrnbZtPrCGS8JugNjl0XWWe8caFUZgPOiR4a5wkwAFaUlXd1tppXQ+pJFIV7N
	 JTHaLscAZHIENgD7OcPCrN1ZepnH64WjBctCM1xo6vdLrCSvSvdXNCUf6XAUe8Iwz
	 uxssZnbzBOLddRlzqCkd1A69f65+xd3T4KIo9YClaPEA81Jz/JdyJ/EJIl4TutSfK
	 dBDzkbh+m76bKKOcmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbTL1-1rCU2f0dWj-00bry4 for
 <git@vger.kernel.org>; Sun, 24 Mar 2024 08:55:16 +0100
Message-ID: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
Date: Sun, 24 Mar 2024 08:55:15 +0100
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
Subject: [PATCH 1/2] factor out strbuf_expand_bad_format()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SVN/FFBfCY8A/C7cb8LC0CYmfLoOkJnCo660QlQwq/rI/KK/Han
 2j6b9//dR1HzyJ88J5wwRtp/MjGDPpPDwYxgQ8yTuhhantcovF4IbWmX+Y6gk6fjr0fnfEz
 nSD0Cu7gybmPj21KA69K9/SlEwZQwva26FHc9dehQUDkp5FaF0krHt2B3IVbTQ5QCWDyNLm
 3tcdIBo5pj5ENHcwyGo2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:463lOuvEgyI=;vUDgSrJW1s3cLfpStVWkAdTizqk
 UBxqsnP2SkdFyUL8JyoJ8Nj7u93RXnkv54nJWtxXCl7/ZG69G3CIw9OsJ1Xqg01htn5LJ82p5
 tV2dlXrOcS04Woy6EXpec3KTwRtk8V9f4/IFEv9nmdO0e+7DxqOK/zJam/ZpVGshpxZJDaQ7U
 XpuAckwSNLBVA1ZZD3GyqXoBBOzPSVX9H33CcvNLK1WDg7+EW/hFX2+7fxJGxdmCeN2wQJC/v
 MDxp8RCqaC1Zgto1ymewIdiEPlqBr53vDWDf3oImTQsfPVM4YlwtopyRrC/Z/AD7+LNPE1PG2
 yf/0ToL30W9xZ1emYeRbLHIjaFenEwzq0JaVai69XVltqpF2/R4JTmYeas8nwWVZDiC3VKqod
 fLuidp8Moplv2HVQEpfUnQi8esboUE1g5ELF13o4IQfSbkk7tN0wYjJRXzODM9Yu4f7HSV0Kx
 e8L/Q1zuc1tTbJjpBaa+v/20pb+hgD8Cn5XlZEUxYYRsCGTtkyeb5yhSk/Qs4XSu62tYy+uRe
 V1tvitdlXb+PQqq4kEjk5u9SP5BeKTwTAcdcjtfBOdrvaDM8ORUzZp+J6pslGpJMtE8vRzN+9
 xmXMNBCF2rodlPXIBFFzoWPnt95WffcBQTq92rzrxoS9lainQ335t9SJC+9VDavgK4AblNhrx
 9QhJwJVzG015wS5vzUHlCHsMeIoatnS1nTUycxKg0oYFGxh0k7Q0/+iC2sb0ej40YiglivdZ7
 Gk7Df8oGyOraZwC0jYzvlwYh/w5jM/Tj7VWtFZ9YjQFWIRXVohbO0mIkTMtC1/EZZfKa2px2i
 VrGf4xWerv1L3vI+3hyM5H0y7gIUZi9WmlhBQIAnNpLiE=

Extract a function for reporting placeholders that are not enclosed in a
parenthesis or are unknown.  This reduces the number of strings to
translate and improves consistency across commands.  Call it at the end
of the if/else chain, after exhausting all accepted possibilities.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-files.c | 10 +---------
 builtin/ls-tree.c  | 10 +---------
 strbuf.c           | 20 ++++++++++++++++++++
 strbuf.h           |  5 +++++
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 92f94e65bf..89e7e726c0 100644
=2D-- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -266,7 +266,6 @@ static void show_ce_fmt(struct repository *repo, const=
 struct cache_entry *ce,
 	struct strbuf sb =3D STRBUF_INIT;

 	while (strbuf_expand_step(&sb, &format)) {
-		const char *end;
 		size_t len;
 		struct stat st;

@@ -274,12 +273,6 @@ static void show_ce_fmt(struct repository *repo, cons=
t struct cache_entry *ce,
 			strbuf_addch(&sb, '%');
 		else if ((len =3D strbuf_expand_literal(&sb, format)))
 			format +=3D len;
-		else if (*format !=3D '(')
-			die(_("bad ls-files format: element '%s' "
-			      "does not start with '('"), format);
-		else if (!(end =3D strchr(format + 1, ')')))
-			die(_("bad ls-files format: element '%s' "
-			      "does not end in ')'"), format);
 		else if (skip_prefix(format, "(objectmode)", &format))
 			strbuf_addf(&sb, "%06o", ce->ce_mode);
 		else if (skip_prefix(format, "(objectname)", &format))
@@ -308,8 +301,7 @@ static void show_ce_fmt(struct repository *repo, const=
 struct cache_entry *ce,
 		else if (skip_prefix(format, "(path)", &format))
 			write_name_to_buf(&sb, fullname);
 		else
-			die(_("bad ls-files format: %%%.*s"),
-			    (int)(end - format + 1), format);
+			strbuf_expand_bad_format(format, "ls-format");
 	}
 	strbuf_addch(&sb, line_terminator);
 	fwrite(sb.buf, sb.len, 1, stdout);
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index e4a891337c..bd803ace03 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -100,19 +100,12 @@ static int show_tree_fmt(const struct object_id *oid=
, struct strbuf *base,
 		return 0;

 	while (strbuf_expand_step(&sb, &format)) {
-		const char *end;
 		size_t len;

 		if (skip_prefix(format, "%", &format))
 			strbuf_addch(&sb, '%');
 		else if ((len =3D strbuf_expand_literal(&sb, format)))
 			format +=3D len;
-		else if (*format !=3D '(')
-			die(_("bad ls-tree format: element '%s' "
-			      "does not start with '('"), format);
-		else if (!(end =3D strchr(format + 1, ')')))
-			die(_("bad ls-tree format: element '%s' "
-			      "does not end in ')'"), format);
 		else if (skip_prefix(format, "(objectmode)", &format))
 			strbuf_addf(&sb, "%06o", mode);
 		else if (skip_prefix(format, "(objecttype)", &format))
@@ -135,8 +128,7 @@ static int show_tree_fmt(const struct object_id *oid, =
struct strbuf *base,
 			strbuf_setlen(base, baselen);
 			strbuf_release(&sbuf);
 		} else
-			die(_("bad ls-tree format: %%%.*s"),
-			    (int)(end - format + 1), format);
+			strbuf_expand_bad_format(format, "ls-tree");
 	}
 	strbuf_addch(&sb, options->null_termination ? '\0' : '\n');
 	fwrite(sb.buf, sb.len, 1, stdout);
diff --git a/strbuf.c b/strbuf.c
index 7827178d8e..449eb610f1 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -442,6 +442,26 @@ size_t strbuf_expand_literal(struct strbuf *sb, const=
 char *placeholder)
 	return 0;
 }

+void strbuf_expand_bad_format(const char *format, const char *command)
+{
+	const char *end;
+
+	if (*format !=3D '(')
+		/* TRANSLATORS: The first %s is a command like "ls-tree". */
+		die(_("bad %s format: element '%s' does not start with '('"),
+		    command, format);
+
+	end =3D strchr(format + 1, ')');
+	if (!end)
+		/* TRANSLATORS: The first %s is a command like "ls-tree". */
+		die(_("bad %s format: element '%s' does not end in ')'"),
+		    command, format);
+
+	/* TRANSLATORS: %s is a command like "ls-tree". */
+	die(_("bad %s format: %%%.*s"),
+	    command, (int)(end - format + 1), format);
+}
+
 void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *=
src)
 {
 	size_t i, len =3D src->len;
diff --git a/strbuf.h b/strbuf.h
index e959caca87..c758de3729 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -337,6 +337,11 @@ size_t strbuf_expand_literal(struct strbuf *sb, const=
 char *placeholder);
  */
 int strbuf_expand_step(struct strbuf *sb, const char **formatp);

+/**
+ * Used with `strbuf_expand_step` to report unknown placeholders.
+ */
+void strbuf_expand_bad_format(const char *format, const char *command);
+
 /**
  * Append the contents of one strbuf to another, quoting any
  * percent signs ("%") into double-percents ("%%") in the
=2D-
2.44.0
