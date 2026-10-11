Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7B33E346
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791752986; cv=none; b=UJUYciUEU97fQwYTayWa7d4p5hYD/a8Gu7goFxdDXcR3RPUFGeCD33tLBPaCSNMDKMXsSbq02g7koJDZ5JAfBc4uEdxLUSIbA7Dke+1B/TGTfRuiK8AUjyzIVj1BToY3sZVIAVAyW/4J3Tom8fTRn4bocjdUaOAwORCmmF0k/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791752986; c=relaxed/simple;
	bh=5ODtUnBztAVQ0CFVjazKwFQ1xYz/5nDV/EyoVrNjZAA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DbMaoEJJZKO/NVE05S5g+tvQ4A8b2hlTOc7bWDewHk3QeLmeb8vqwb5ekFDTVJnVSEH3cljhMWoZtNgV/DggzOSb76+aJeqICatE2Cr38sPBQoR0ChMVJVnz0KJO0eL3bDQfxg2Svf/zUmFddD91o6LSXqEL79v/KKJ5FydWIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xfding.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEzx1Ksd; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xfding.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEzx1Ksd"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1813fea7dso20389875e9.2
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 14:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791752983; x=1792357783; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S0o5lcXh7kuOA6HAbMj+m4QbqoUBZj5s7NpcAAf9TD4=;
        b=ZEzx1KsddlOg6UAZpwJQPHAiQTqlqZbhSNG43/exUuXTAhRq5Hn/5VX0UkcxCk9KSH
         3BGwzWlaqCNwVVxo9ETaZ7trS/pPXm46jxMubK0OU8VaA1ptmlVrhQejDACMPF2sGs6A
         SybpRq4gHmnj1obCVs60PEZD+f98UI2sZg+K+jAE742upbGlU1/9SR9lZU1Mw7nL+xme
         EKT1KyyUVSAYMa1xFeNMPbg39uLbEBvDRAKiE33Y5G1JHvVE6z+SXRxW+ANV8grN5ut+
         kugr/XAqr186cWc6gdFnr1xsBH8VYPn12NB4P5VWbjLRln7q9dG9RAzsZG57Ts5jrBZb
         AAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791752983; x=1792357783;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0o5lcXh7kuOA6HAbMj+m4QbqoUBZj5s7NpcAAf9TD4=;
        b=1YV1lWymxf5ZKiqskpJyhgnccwWDErHuAHFYOwG7nw7Go+QGF2sOdeUG1Lt10a91j/
         1mKw8Qlcj27Tg/CM15atg3dKN738F3MBSqnLTlKzZRxLnQwH8lRxmd6QrPb5PNP3G3fc
         2j+hQg08kn1nxq7S948PHZjlX5djdqVF2YNkOofHK61u762rfpNsXUDtyex/mwfMEfPk
         tjXZqNYdjV6K06mWTygexdK4raZA7sxmYDI0xnQY5ipH3EWV/HSc+lsmPeAMNPu0P0Ys
         4d/V+UJG8M/wdGHEl3/C7TYj4+r5CovdEr7uo9Tck6XIS3RinnQlo7gOZEBIEREPrUa9
         THwQ==
X-Gm-Message-State: AFq9FYK/ixdjTLLnDmp0ZEdx+YdRx3P1AKxMAAn+no58skCOVTthRrXI
	3e5QSWIBCEMHEEmHQupA2CBfHs1jLt8BC9LWqVrI0vvF01WtCI/D11o7KHpzILFjozDX5Pbdmbm
	qSavYr+d1Rcz8i/uyNOVJmZtgbC+rDF9vMNkRl+z3f9fABoBCnOoX6pAFuIWWoLrcqvDduFot8s
	ngqg5fxRr0Z30lEdSbTa2tvX0G1HrT/5V3
X-Received: from wmdi5.prod.google.com ([2002:a05:600c:2905:b0:4a1:8c1a:a82e])
 (user=xfding job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8709:b0:4a0:20c7:6d4c
 with SMTP id 5b1f17b1804b1-4a18e3eccebmr145867185e9.0.1791752982779; Sun, 11
 Oct 2026 14:09:42 -0700 (PDT)
Date: Sun, 11 Oct 2026 21:09:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261011210928.3900020-1-xfding@google.com>
Subject: [PATCH] imap-send: use ASN1_STRING_length
From: Xiangfei Ding <xfding@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, dev+git@drbeat.li, davidben@google.com, 
	xfding <xfding@google.com>, Xiangfei Ding <dingxiangfei2009@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"

From: xfding <xfding@google.com>

X.509 has never stipulated that ASN1_STRING shall be null-terminated in general.
In OpenSSL, `ASN1_STRING_get0_data()` returns an internal pointer to
the raw string payload, which is lucky for us null-terminated. This is probably
about to change as OpenSSL derivatives like BoringSSL would adopt changes so
that the data buffer would not be null-terminated anymore.

Strictly speaking, printing or accessing `ASN1_STRING` data should always query
`ASN1_STRING_length`. This means that we should adapt `host_matches` and
`verify_hostname` to use `strncasecmp` and print strings with designated length.

Signed-off-by: Xiangfei Ding <dingxiangfei2009@protonmail.ch>
Signed-off-by: Xiangfei Ding <xfding@google.com>
---
 imap-send.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index bf1d2cf74d..bd306b8d0a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -225,19 +225,21 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 static int host_matches(const char *host, const ASN1_STRING *asn1_str)
 {
 	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
+	int pat_len = ASN1_STRING_length(asn1_str);
 
 	/* embedded NUL characters may open a security hole */
-	if (memchr(pattern, '\0', ASN1_STRING_length(asn1_str)))
-	    return 0;
+	if (memchr(pattern, '\0', pat_len))
+		return 0;
 
-	if (pattern[0] == '*' && pattern[1] == '.') {
+	if (pat_len >= 2 && pattern[0] == '*' && pattern[1] == '.') {
 		pattern += 2;
+		pat_len -= 2;
 		if (!(host = strchr(host, '.')))
 			return 0;
 		host++;
 	}
 
-	return *host && *pattern && !strcasecmp(host, pattern);
+	return *host && strlen(host) == (size_t)pat_len && !strncasecmp(host, pattern, pat_len);
 }
 
 static int verify_hostname(X509 *cert, const char *hostname)
@@ -278,8 +280,9 @@ static int verify_hostname(X509 *cert, const char *hostname)
 		return error("cannot get certificate common name");
 	if (host_matches(hostname, cname))
 		return 0;
-	return error("certificate owner '%s' does not match hostname '%s'",
-		     ASN1_STRING_get0_data(cname), hostname);
+	return error("certificate owner '%.*s' does not match hostname '%s'",
+		     (int)ASN1_STRING_length(cname),
+		     (const char *)ASN1_STRING_get0_data(cname), hostname);
 }
 
 static int ssl_socket_connect(struct imap_socket *sock,
-- 
2.56.0.385.gd3acb90ef8-goog

