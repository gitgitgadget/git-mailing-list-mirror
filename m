Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3A1624C0
	for <git@vger.kernel.org>; Thu, 14 May 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773597; cv=none; b=oHl6qWJ6ObN6ElZSSTgMVVcdxeSavswtcBYvEX4K5IGOgI/UhhCnVPl/1xTyyzRKlxbFx+5dzHUdIuOPNCJeEFjojCWyOhDnjM14clYUKbAg06d6Qex6AXxlMvptnxyXz1xcPuTU0xLc4cAO4X8pKjQpVnqYCTAUg1pq9rIDclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773597; c=relaxed/simple;
	bh=ibo5E6hS6Z8RzS6e/C98f64QZg4vj/RQmA68t2CjalI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m6SsbLJOdqfQ3xLy5YF1gfYo6QocLitPgEYqVhhURGYC5Hc9nEzBzC9h96ANnFsU/ryEXU4Y4U1NlmhHmJDf+vue53vcfqN6SnvSsisDjga2rWhOjOoa+PSb3GoK28wqPZvq8E5AxFvRcLKdwYU2tNUbDZexZokxtKINU667aOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdE53VQ7; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdE53VQ7"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56f70865797so4409907e0c.1
        for <git@vger.kernel.org>; Thu, 14 May 2026 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778773595; x=1779378395; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCanl2UTdnJmm5I1wrST2Zf4CXnElEoaku2wr4IvBUQ=;
        b=IdE53VQ7rnT6V+Y/ZpLwWN5MqXgKcG/CKhIKYJGBIjh+nfmHVJ7f9xZpND85ansvDH
         TQkC2eGlRiePLwDmyhIlBQVYhm9wqXQ1a2mmqSVW2b9rkxpziqBJs6U7hgkF/GMu85Q8
         EjO/DdNYQxUHP2Yb9d65Zk+4Br2uJ/OUypwGNCEOiZJNtnz1qSsT+mwAk4e6J1mdFIqo
         4X6pGvXntZzrMJEabSKLkuv/XODvyDRyJ6QoCGy8cY0E1NLm1yAwlXxRsGdKU/lySXdo
         YOLY7NGnPsKsh6hGQBa1jDCdCm7WeK/17ogS0ghMK9uQrQa/3AzvUDj9qpICQwNisOJM
         qAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773595; x=1779378395;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gCanl2UTdnJmm5I1wrST2Zf4CXnElEoaku2wr4IvBUQ=;
        b=ky4zgRjE8dP2adEib8hA2vmrGr46t46DHJ8T9eN+0nq3rFVp/d+Jz1jVXScRL8p+NX
         1v6jP0EY0t10C3XPJnXidTutzoTkFobS4J6d7/JkSkrN4VoEAbOoQ3CETi0i819fP67G
         5QUopnc/B8+DJj+kVpEwlRMCOvb+7KdGP8ejp3nm0wVyV+B7H2iQ8+dyhuTiH7SLkeUQ
         ZaB91W1C7H6sAt8xUvUZAXFFSa3NCDEq0auWu3zgdidejwHYTNkC2IfWTk1MjLn8yFPD
         CmIP/cRNx+ZRJCPZc2XBBECE+TVQ33S/st70zpUBojrr5jFFU8PXKIO2qYUwd0z6QxY6
         Z9TQ==
X-Gm-Message-State: AOJu0Yy8RxAt2lH/aiADf/9AVyfxnJU3HOvhrLTKmmGjfeLlYai72E6m
	9eDZKrVSZZ6hOQ4PzPdvZT+8obMTZDFI6EMpqs7RSZeG9EhPqAajkthOvFhfHw==
X-Gm-Gg: Acq92OEpqQFn0jgLWN2zsR+VNTI7P/d7cHHzm7+QZxcSiSZvGs0kojx+RiNj1mhBiFQ
	+Q2zDXvcNFI2Uu25grNSeDO/JvBSsMH6Mzy8d5EEMvmuTQQu0xBA+aUGGl5qEjBkcsjqbtErTFy
	aIOjvhO3MacsahKGDkVFhvXfFDU+LBrpmfh3mpAbWiF8fVihLpEemfwzVShWuVT3JBEgrH7Pn6M
	3WDwFPtewB4ZjHENAts2X5VOcK6EeJt5euxWXkroz7B3XdAJ3p/GTn3hFA2vCEkxNYwSZlq2/VI
	elYoNB4hoNbTF1sbFgZ4qG/kpjCj3svTM/EJyzzWxrFc7DG0jNOiGKi5ncE7fEFiVFUhbJualZg
	MlAy66LDW8IOFNnpEjZTaah1ImRkrH2rPwVgHcyRL/4e+8gsRNrHbxx8KeIwxBl/+3vXC1F+zaY
	Mljhzm3GZaZVyuYTExYflfoyiWicEpHfs8lR6kB1A=
X-Received: by 2002:a05:6122:a01:b0:56e:f1d2:c3ca with SMTP id 71dfb90a1353d-575e8668f46mr4501101e0c.2.1778773595057;
        Thu, 14 May 2026 08:46:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.126.102])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2dc41fsm26397656d6.25.2026.05.14.08.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:46:34 -0700 (PDT)
Message-Id: <b2d81438117a716417a031c74b678a8f91701af4.1778773592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 15:46:30 +0000
Subject: [PATCH 1/3] daemon: fix IPv6 address corruption in lookup_hostname()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Sebastien Tardif <sebtardif@ncf.ca>,
    Sebastien Tardif <sebtardif@ncf.ca>

From: Sebastien Tardif <sebtardif@ncf.ca>

getaddrinfo() is called with AF_UNSPEC hints, so it may return IPv6
results. However, the code unconditionally casts ai_addr to
sockaddr_in and passes AF_INET to inet_ntop(). On IPv6-only hosts,
this reads from the wrong struct offset, producing garbage IP
addresses.

Fix this by checking ai_family and extracting the address pointer
into a local variable before calling inet_ntop() once with the
correct family. Die on unexpected address families.

Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
---
 daemon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 0a7b1aae44..80fa0226d8 100644
--- a/daemon.c
+++ b/daemon.c
@@ -674,9 +674,20 @@ static void lookup_hostname(struct hostinfo *hi)
 
 		gai = getaddrinfo(hi->hostname.buf, NULL, &hints, &ai);
 		if (!gai) {
-			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
+			void *addr;
+
+			if (ai->ai_family == AF_INET) {
+				struct sockaddr_in *sa = (void *)ai->ai_addr;
+				addr = &sa->sin_addr;
+			} else if (ai->ai_family == AF_INET6) {
+				struct sockaddr_in6 *sa6 = (void *)ai->ai_addr;
+				addr = &sa6->sin6_addr;
+			} else {
+				die("unexpected address family: %d",
+				    ai->ai_family);
+			}
 
-			inet_ntop(AF_INET, &sin_addr->sin_addr,
+			inet_ntop(ai->ai_family, addr,
 				  addrbuf, sizeof(addrbuf));
 			strbuf_addstr(&hi->ip_address, addrbuf);
 
-- 
gitgitgadget

