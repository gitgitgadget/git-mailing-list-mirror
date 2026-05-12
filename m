Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B20395AC9
	for <git@vger.kernel.org>; Tue, 12 May 2026 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586973; cv=none; b=YiNwsJagvwKfQyablEQNp293OklmCyCQphgkEd/KLiYcRdQXEJyWxLiulzGgja9qfbA3ynm9f0iQpMcF8Zj9folKW0s9apoc6TbnNKS3NC7Q88T/uw8VDF1/T3/6CUPX9xkpJGv7PccMwxrecw1Al+XH0iCaeG220NjOEcTuHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586973; c=relaxed/simple;
	bh=xkW5miWMjmH9VNUjBY7sZ1QuqZCzTo86xh3oh/L8ovQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PawJ0sCldIqK9O6GFtDst3HYz+0n3nN1jTyfjFcVNvpBvcUcF6wnfmX1InKOOelPM+63Prd7teXCjNFGr+pqBEZpbIKds3gjrlJNeMH8yrRmu+2z0p/oMm2Mcjyx49IttlimdZOcvwxWx/4+W0MJs49Y5rTmM2N5buk1kG7p7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=AbfJQ3hs; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AbfJQ3hs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778586968; x=1779191768; i=l.s.r@web.de;
	bh=n3Dv2+fo64CLBb8Ra3qcfAl0hidGuYqkLFmNFG/HND0=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AbfJQ3hsOSqcx7A69ycBA8Pbb4HeMMcwfN/Y4cuuh/kRx0XOP0IWQbk9+RhBWPWP
	 I61mMdMeJmAfA8ICQM567FAGm+L1THSOvvgVL3fkZUgjglUCQMkPX44myg7yaA+L7
	 fDXEfXVhbt+Vqz/FNeMgekdEJyn2/Sgy6MSam3lfvFahH3qMpEB6DQ6UDwiWDxLdH
	 0U4B8LZpf0VYVLfjz5Kt67KYnsx0GDVfe4SBWXPBigjQXdrFrHhKomIMQVOhr+0JJ
	 n7FgU1Ptho2bYddGa/To4J9+Dj7bbSpa43CFlU7e6G2jlRS5zhQ40MahNRB4CT4Ah
	 qMVVY9yyKsFUaQbNQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoNV4-1xBWsK2ZoW-00pc4j for
 <git@vger.kernel.org>; Tue, 12 May 2026 13:56:08 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 1/4] strbuf: add strbuf_add_uint()
Date: Tue, 12 May 2026 13:56:00 +0200
Message-ID: <20260512115603.80780-2-l.s.r@web.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512115603.80780-1-l.s.r@web.de>
References: <20260512115603.80780-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DRdKvUzi9EVgaNKo0Sm8PNVj9+UskvHug11PrVe038w5liaRuB5
 J+sWiFozGtUvrQzOcdzPcbii6UeUzBbUXr/Baag5GQg1GBvx8xyQF1An1EtLhOs4IDemD9N
 /NsZ6kPrQGZK28Xs6NPczFD4CeTK4Ao4/A6WiRdDAH5ZAi9rIiEFbbme3SSd5dkZviTSGXW
 +sAEYoCFt0AJ5at9dGnFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RfdTyLTs63o=;vw5q5zRuKNqznoUeGLYalLYMu7h
 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
 IQ

strbuf_addf() calls vsnprintf(3) underneath, which supports a plethora
of formatting options.  We can avoid its overhead in basic cases by
providing specialized functions like strbuf_addstr() for strings.  Add
another one, strbuf_add_uint(), for unsigned integers.

Prepare the number string in a temporary buffer.  Make it big enough for
any unsigned integer value: A decimal digit can represent ln(10)/ln(2) =E2=
=89=88
3.32 bits; dividing the number of bits of uintmax_t by 3.3 and rounding
up gives a sufficiently close conservative size estimate.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 strbuf.c | 12 ++++++++++++
 strbuf.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 3e04addc22..9731ecdc1f 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -361,6 +361,18 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, =
...)
 	va_end(ap);
 }
=20
+void strbuf_add_uint(struct strbuf *sb, uintmax_t value)
+{
+	char buf[DIV_ROUND_UP(bitsizeof(value) * 10, 33)];
+	char *end =3D buf + sizeof(buf);
+	char *p =3D end;
+
+	do
+		*--p =3D "0123456789"[value % 10];
+	while (value /=3D 10);
+	strbuf_add(sb, p, end - p);
+}
+
 static void add_lines(struct strbuf *out,
 			const char *prefix,
 			const char *buf, size_t size,
diff --git a/strbuf.h b/strbuf.h
index 06e284f9cc..1089ae687b 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -410,6 +410,12 @@ void strbuf_humanise_rate(struct strbuf *buf, off_t b=
ytes);
 __attribute__((format (printf,2,3)))
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
=20
+
+/**
+ * Add an unsigned decimal number.
+ */
+void strbuf_add_uint(struct strbuf *sb, uintmax_t value);
+
 /**
  * Add a formatted string prepended by a comment character and a
  * blank to the buffer.
=2D-=20
2.54.0

