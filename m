Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C93839BD
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302045; cv=none; b=DIO1p/zkG/bGhQhjCqGl5iwFQUlnhxTIExiSrRW8W0ZEE+Oih700Ia8jLusk4hXq41ZpLQ+gOnOfrwFRh7ipncAPyCOluS/EdwsGGtK1vIqJvp+6X3LakhVR79QGHHJZI4fExB36XeYYbcl26vubKOP+hd4ORot9R9YEesGaZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302045; c=relaxed/simple;
	bh=VCm4vpDJOh5clJe3CHbLt4meRZG96OWuf9sjrdijzMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQ3tgjyM/NkKYWOC7na9TXYy4Xy8OhhZbINQ4EWnITimITdJc7FS6BBYEHeq9zhIZDWDnC/S7TVXL2VJilZnbA9uSp4qgOJckPE1zCnVEERu8ah2m44HgJigtaERnogFIiCv/Sb42l0LATEKv5wlzdoHIdjuAjBrQvAhOfaJn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LPdgaCDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xd2EX+37; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LPdgaCDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xd2EX+37"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBA511400082;
	Mon,  1 Jun 2026 04:20:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 04:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302042;
	 x=1780388442; bh=wPwM9AVOYHIcx1YH6oWcYoeBUzdE0DIusnDmUQOvHtc=; b=
	LPdgaCDj9XjXdgMxkvELJCwCuHf2MhgjAUjR0vPvviFqdJwqTuOWOi1EbjaFm7+y
	e2FbzE1DpEsNIux7UvGmzser+kQz+FB/Xge9NQH2dYTOuKIsP59z+TC/bYGv+aFj
	crEw0yvdssAM48d78j452Cku+UZaX/gykF4j/kL8diKA+2GwhOM/nNJKa5gALqZd
	W8yz++YplYPfzDCA0XKwEWmw7NbQS3ytk5wiEpy2pXIYvL2fUqL/KfTGU95Ho6Xw
	Bm4NzllApavHvqT1D4HxwnX35lL4PkIu+SKVGc+SOojWSMhYlx/VCJhJKP1TAtYA
	2c++gAcK5Ccz4IoJRwD/pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302042; x=
	1780388442; bh=wPwM9AVOYHIcx1YH6oWcYoeBUzdE0DIusnDmUQOvHtc=; b=X
	d2EX+37Fb3FgLso+e//ENjUjqWe4neiInSTIn4rgw37BbQqhDgNocoE28YB/MUw4
	ViylcGBtOEeuSBiNRL9dOQqPwBbydmP6dWnAx01hwedsxqi8suazfxrRWy+k3BX+
	Mq2ojPdfCpcapUbKq4c2p9WllIg4LyoFU12iDTYKcKSmm7KQkIhBzEVvtKc9LkOJ
	+cAryu/TmZyJlxO6rgSkRQFwJqnP2luqbh4Y2oqVC46jg+MqYWPHDzf3YMKtLoPY
	WQ0d0KzTDLsND+5qJYwZPeL/z83hwwTLzTcdwbZuDAc839iGG8/vLri4j/Vgxx0i
	9aDVdd3BS11Sqfoorki4g==
X-ME-Sender: <xms:2kAdahYq8RWbYcuF-S9KeelqSrR4OJ6FqipA6yXsVyAsiyqbRi5yrw>
    <xme:2kAdauZOWrwvMcWN7alHH5469jwOOgZPEKkVtBMKLZZZVCBWEJjEuY3Xs2TSSoO79
    2fiIc8haErvJp3rLIqCg-3GJDdO02O-abxBBBuUy15UdTvtLl7rHQ>
X-ME-Received: <xmr:2kAdahkyp7lKwTnp6ZcwkqeNRJD-Vi1WwjTRUN8PCRiojOdUkpE6eb-cKChYyViY5RWJemhP-1yhgOgdoqF8N9N48qu-hKukYJ7jO63AMJUn>
X-ME-Proxy-Cause: dmFkZTGoVC3PWkC/M98GLpgwKSp8+X2EEbK9QrLPRCVzfq6z8mGb2cg1WSKI0P1YF6K99Q
    xKY18KC2TzQ71gWxrLtHBcpqPwInMMILQwQmN+IaQps5jv2t4yhm/OcWnxr3PAuKdie/5H
    xdZiEXHfq3CyGlKpLwv2vL5myW19uyY8AtAnQMD9jV84wJQFe0QGymylYpZQO++m8ND1Hj
    j7fjS2tB+vIBobG7JpZXtzobTDeXEGy6yi7zeMBs162gs+xcsIodAA21pY4HTX/IAVCIU8
    kOLzJFDG9r9Lr/xlbzdlHVCtb2SlM1MPmdQV95SWFIB7kaTFV8arUy82aX0eqGVCnq+EVH
    +bnzOl6nwq/8eCZBO5Ody+T0ImClLYiDPOkVZVcuVWR8giv20Ng0FHCYLvIGITK+ZuIDNt
    H/3FZEaBvKiuHV9f5yPQOl9KavyxxlCQxrp7lp5mZOXZcXTIhbjDgM3q5GHAVyaglVvMJz
    13xTEv8kCsuGTt1fTLdM1yTKFRj6rQIrZ+rulKpFfoE4C2c5qri6cma3fBNEeBse1T7Gbk
    sr0xWFczbn0RjiSyJ/EnveB4Y+cwBkRSwtu6Bduf+/XATgcsjyuWem8yxMTWWCR/2mEXlG
    xQ06KUlb+OKPISEsZSHGwIzRN8SWXJ4FN9xfWz8hArdJ+3WsMwS/C72t7AGg
X-ME-Proxy: <xmx:2kAdaqwTGUiQmflhrlStcdoGZxUl7Z8Xf8tLj7d12Xo57njZrJ2jFA>
    <xmx:2kAdavNlsG7Qni6GuE4LVXGLl8pBDQN7D2RQjLqVIPREG9Pp_Ygj1A>
    <xmx:2kAdauSlT_D_60uwe40qWvM_N5Qzri5zVLypKzqdDYMgZgqeGml5Ug>
    <xmx:2kAdatYsuWJslZDA9c_mj5cV_2LvP94Iyyn8fXFbUY4MHNzvj9X-yA>
    <xmx:2kAdakz7gt7501UQTBTz9DgvhjVNJcVExjwbI0bamSyBNEgMFjiFzmY5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e7c3bb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:28 +0200
Subject: [PATCH v2 05/18] odb/source-loose: wire up `close()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-5-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Wire up a new `close()` callback for the loose source and call it from
the "files" source via the generic `odb_source_close()` interface. The
callback itself is a no-op as the loose source has no resources that
need to be released on close.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 1 +
 odb/source-loose.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/odb/source-files.c b/odb/source-files.c
index 10832e81e4..59e3a70d80 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -36,6 +36,7 @@ static void odb_source_files_free(struct odb_source *source)
 static void odb_source_files_close(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
+	odb_source_close(&files->loose->base);
 	packfile_store_close(files->packed);
 }
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index e0fe0d513d..65c1076659 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -21,6 +21,11 @@ static void odb_source_loose_reprepare(struct odb_source *source)
 	odb_source_loose_clear_cache(loose);
 }
 
+static void odb_source_loose_close(struct odb_source *source UNUSED)
+{
+	/* Nothing to do. */
+}
+
 static void odb_source_loose_reparent(const char *name UNUSED,
 				      const char *old_cwd,
 				      const char *new_cwd,
@@ -53,6 +58,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->files = files;
 
 	loose->base.free = odb_source_loose_free;
+	loose->base.close = odb_source_loose_close;
 	loose->base.reprepare = odb_source_loose_reprepare;
 
 	if (!is_absolute_path(loose->base.path))

-- 
2.54.0.926.g75ba10bac6.dirty

