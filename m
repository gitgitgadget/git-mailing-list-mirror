Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F5284674
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202171; cv=none; b=TgmtCqFuFLktBGo9whIywZn6Kltgq598gYZo/eXcf3op3eY2K+KspKxuRirRg+A4lZfTW8KHBRKrWhZtfKXpI9hph9KXe9kqvW+P8NNdCw90yRT9OH6ytcT/Gv28PktGH7KaMTJGWvbHv+b0KO9eyZyQFMwCC+lLa0zhPjs89jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202171; c=relaxed/simple;
	bh=sCSkhYDOwZzlFX2sD5foyYMvFr8Dvf8s+m4K5KeVyJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I2OPAMBso4IB1a6Bn6/+/eYP2s64uJEGPBs3VzABbnSZ8Rul9Dz4aju9OVYM5gxGSt9KPx9tCHcchF1rQR8Ma520vp9mZ1dE0yZY1qF0HbuwXnP+WtpaPhCTPMUECZYECDL1R3pU6KqFW5Hlfq20OgiOfrOMw0f1ei3YVQU8h60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuqdRAEp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuqdRAEp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1041599f8f.2
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749202168; x=1749806968; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAK998mo5n+ltuuSeQszKHCg79ik0uECcXdBbMR/5UA=;
        b=PuqdRAEpjT8L9B6NN/k61xmcZj6uJzZeSf9qOVLpsHTduTSDrGX56fKlWQlJ9hMwMW
         k3lpbGXFw/oSeLFJQwZwPmq8EZlacTm2jgPjRubD/5bcF+fZ4vB6Xh1yWI7socs+SRFv
         KaKLDgHfk7xveNEg7dwZ2JgJ4O+7fGZpNU3pIVpbzoW6oQUED/ESIsLBodkUC1wLEMPQ
         kHfFpgNy2q325/H4CUoML/tYb+tn8YIg3AOEbHf7XkuhMXa76PivP9h0nsu6jaVQGfmo
         ItVhM4qQz9yqnMT44f7ep/ze3FTPiDHkapN6NfX2PDyn0kwtvf51ZjIdi8fJtIGKyfQy
         pRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202168; x=1749806968;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAK998mo5n+ltuuSeQszKHCg79ik0uECcXdBbMR/5UA=;
        b=RKs5FuQTqztMI4UX0SuWZp07lcDLb30sb/xRiOMhXnTf/+OxyeL1zhTAZ5IFNUkFpZ
         awByXpe9q821mSssPbrxGjj3GgLs5HpE/9JQTiiyuCVwDeW05NiUXOCFA1zhdYmL42+V
         R1Af5UndLLsmwO7fv+jTRCKjXVD2pka8QI+eCMahSNn46mqULcWjZ+Y+ka20zLmcRYC2
         exTrruXwELgZ7LC1XMhy69Z2tymLWynKTWQ6vfIu+5Agw9g6hVw2wGNQxVw/FSsK7z3A
         6k6Qtrsbs86kwhyI9n2VZQoRGQZlik1gduDWNFLOqCDCMyIZkogjXpHMO2DsZuRJ3UER
         M1Aw==
X-Gm-Message-State: AOJu0Yz94nlALOwBsi/oE31+6elqPvshszz8xI8Q9FE2r/angCVWFpt6
	dzgWztSgYovn6AXMZBOD+j6dY1yt/o9HYuJy48PQO6nk+ORsS0l6uEZbHu6VAw==
X-Gm-Gg: ASbGnct7g8doAALdRQAyOONCJlXmmSJ3LGD5m2TAOywykwKjbXLKMLqJslFRBltFsGV
	8NWTuL9h1r6vPV13O74snUyzwJEGGMf2nrCzruwRGsrNyHFH6Q85pUGGGBFDTdxVZzQVMh4yD7i
	tXRIqAeEZwRCmmL+13Lg4K8j8gavhXAncyewRLYWEUaeWhqjAEvRoLnQmTWobxrGon/UcHAMEno
	Mlqm7o6LvtIWGM0dPJDotGHT7wb9gErg7F/oB0CL37XPE0SmxErS8OB4Hob1qhwkiQoX2gEOJUu
	Y2U1KXYiDBhMExVrQlRlQl8mgWxhRA3k0ZvusamkuuLytbhBJwxGb50fiT7cILU=
X-Google-Smtp-Source: AGHT+IGUm1CSJs2s5HMwDYRFCgeCf5ApRWNo3nHrf57lzaSWrszSlVmpHo1he10P6vfsER319RYZmA==
X-Received: by 2002:a5d:5885:0:b0:3a4:ebc4:45a4 with SMTP id ffacd0b85a97d-3a5319ba193mr2631104f8f.5.1749202167874;
        Fri, 06 Jun 2025 02:29:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5322ab845sm1309290f8f.24.2025.06.06.02.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:29:27 -0700 (PDT)
Message-Id: <30325e23ba0d40567cc4ef78e4ba0c3776ef0c06.1749202164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
	<pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
From: "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Jun 2025 09:29:22 +0000
Subject: [PATCH v2 2/4] curl: fix integer variable typechecks with
 curl_easy_setopt()
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Jeff King <peff@peff.net>

From: Jeff King <peff@peff.net>

As discussed in the previous commit, we should be passing long integers,
not regular ones, to curl_easy_setopt(), and compiling against curl 8.14
loudly complains if we don't.

That patch fixed integer constants by adding an "L". This one deals with
actual variables.

Arguably these variables could just be declared as "long" in the first
place. But it's actually kind of awkward due to other code which uses
them:

  - port is conceptually a short, and we even call htons() on it (though
    weirdly it is defined as a regular int).

  - ssl_verify is conceptually a bool, and we assign to it from
    git_config_bool().

So I think we could probably switch these out for longs without hurting
anything, but it just feels a bit weird. Doubly so because if you don't
set USE_CURL_FOR_IMAP_SEND set, then the current types are fine!

So let's just cast these to longs in the curl calls, which makes what's
going on obvious. There aren't that many spots to modify (and as you can
see from the context, we already have some similar casts).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 imap-send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f8e..2e812f5a6e9e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1420,7 +1420,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
-	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
+	curl_easy_setopt(curl, CURLOPT_PORT, (long)srvc->port);
 
 	if (srvc->auth_method) {
 		struct strbuf auth = STRBUF_INIT;
@@ -1433,8 +1433,8 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	if (!srvc->use_ssl)
 		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_TRY);
 
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, (long)srvc->ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, (long)srvc->ssl_verify);
 
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
 
-- 
gitgitgadget

