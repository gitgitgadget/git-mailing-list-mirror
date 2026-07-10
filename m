Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56743B3D0
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701689; cv=none; b=FXlHCXcWn/JEM+2MnKGdH8Ph2/Jk188OfFwooU4NHXGD9pOs4ZTcPILCmkfAokfK1VRxFsAmLFAGTpICXU2BYilpdqROy6xjysYG69EMsL6cuKz/orCYmHlkWykI764l81gpTGrz5U+OEzI62Bc9Z8wWJLL9ICgWxErfutcRx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701689; c=relaxed/simple;
	bh=GpctcVfvABnkFE7+LJzuCd5zRVxTojrxGO+kprXw534=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3UpZMySGbXBt9OOWzGOK5K7GVQotUn67nfnVhMWCCldnz7RE0HLlWZdsn74C2sUtv9wKs3+NIveWRDC0h5+j8/c/ERSXmMzqSwfcHXttONjylAS9jKIpP6lkOvzKbbrI3AuPTKmqDH1HW8kltLsvjGCIapoKexYWWJ0Oiup664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRB/XHK8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRB/XHK8"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47de008b020so582824f8f.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701687; x=1784306487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQ/55N/3UITj2aDUmhVqJ+/Dm0RvOshB7nYEs0KYrpE=;
        b=cRB/XHK8M/cIjpMVmeY847Z7mPrplupbPTNoV0voC+Ad2NBtJgg7OAuJmaCAJgMdxi
         djQU1q0DYoq2lc0wJnLZQJPygXuVR+/yiCb9kqOzPDYXVrkjLRpHPArkA0E5b1VQYNTL
         hHlHQP4PfJ1vjICyZnb3C0Bk/JGw8LaVlkeK4kJPafn2fjQaen/wgj9oVCN8bs4kFI6+
         duSDjmrl0oVXXiTxbqWXNyjDXYO6y5gHaYIl6vEpkMJVvtnqSZO30y3sjRmPPPRBswQI
         hKM5aRhvwcp6p2bBRckOZfjgfn0MDX9ufTJC4OjoqQc0x0euJSR513KULuWHiBDk1Mqh
         EeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701687; x=1784306487;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQ/55N/3UITj2aDUmhVqJ+/Dm0RvOshB7nYEs0KYrpE=;
        b=DznClnM9IV/6FCxeUpeIcDf2FB6hE7DEVbzv7qtIArFf8DOr6/vmTZ0IjFkEihtk5Z
         OOwaRh/irfnA/uCgTf21Kg1/o6OASL6fa3miQeYbDjXKZAlCoGGHRifpFcBWOJzFjWt0
         BKGVDp86Fvc+a3rr9U/GNkK+mISTaAsSF7qNgyvEROtcvxAg/cmzzF92Sr+JWA9hXWcz
         pALkgiJYrQGx/+1YaW8g8u+IVfZ40bcvqwc+/DcDI+QHb9iMqQgFduvATkuJ9eqmiPad
         BeNMV/wqu2+mFfBffoZDtS/P3CIUpEjpMbjt1ZCyhICubykUxn5WGPlWeJU+vjctl01/
         kUxQ==
X-Gm-Message-State: AOJu0Ywz0u9UtHhzcr65BIbnQURzfrr80MxkkOvrFH6Pih5/soT5EHNd
	WLdMxrxWl7JbK0FCYrxJwWy/Q9EsmgbfEofTZxGfyfBv6uWOB8JRKcpJbL7Q3QdD
X-Gm-Gg: AfdE7cnvirQrnTBHRFbF93Y/UBzdZc6KEgVJzXHbEEyt1QrQ/wblLlGv3R5MdRDLgsM
	kfWBHzX6weZfh9TIWQbWMqyjjAMtV9UNYzZUi4UIdBb0aze+G5zstrjy5atUG+taHuSTAvh52yW
	IsaCkiDjtah8VsDiQsRipKDGaBdJLWK1f7DOUSpINjYt2W/rMFKvVmoG2YOg7XBDGudCyoLJo0A
	2XmVhI3sgsaLXqVP13ushadVu1NtZgJWTGdfvp0sedsDOGxRulwuBcS8vtoWCDuyjsJS9VpuGxB
	M2yyQs2pE0sIFD/UC539uE9itGSJgTICUN7jDRYyjI5XqBYdC8hcE9eeXjBMPKUKEuWg+GWRu7D
	XFY0ButRTPUN8Z4rnYla+/JZWOSnIDT9ZztwRytZvnl8E8CHlG7MU1q1RCzWgpW3v6mawqmsG8S
	l3AzaZRQrbw9B7rfTZAaBgwLgIUhvWLqy31hrs9Kl5w2rYW56GfR0R+LjGfiYWJ3G+ZLsB2KDSY
	5IBMns1yG61lEPxFjCXDsa7djza5g/+fyFb1u63p0OtD0bYmx7cqKzrePO/TZ6CGm0KTby8lJ0D
	Wc+NKegk6JBga+izvMDNBIsd+xf2CReyRs3mVk8sHbnNJQcZHTg6qCKyhsnu8ywmx06SQY6B9Aj
	vofgZg7mNagZLQ3CVRmxn
X-Received: by 2002:a05:6000:18a6:b0:47d:ed1d:818d with SMTP id ffacd0b85a97d-47f06daa708mr5443553f8f.14.1783701686753;
        Fri, 10 Jul 2026 09:41:26 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:26 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v16 04/13] fetch-pack: fix hash_algo variable type
Date: Fri, 10 Jul 2026 18:41:10 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-4-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

hash_algo_by_name() returns "unsigned int", but the variable that it is
assigned to is "int".

Change hash_algo variable type to match hash_algo_by_name() type, also
make it const because it is never modified.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f13951d154..eea72b2500 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1395,7 +1395,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);

-- 
2.54.0
