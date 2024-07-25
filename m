Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A691990BB
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915061; cv=none; b=gwHMzYTbY0JAtt/Rx0wmdpmyEKazvDoEjcR8wgGklbPQBGgx6jIStoXOHtzGqeaNJy8XGVj6Db9KHH9Ihitf+fxCKhxxExQUILVtWSCJMyTWyT+4Yo6Vt2EpVWPf5/y/APboe4Sn1coahJS+xp9uo5adOG1sznsdC+SKOaOHV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915061; c=relaxed/simple;
	bh=ekjA+5nfr5BnZDcwU4iYsUAetNlUUOFC9Q6qOpKcfQ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V3/w/brfxbVihmlVFZVQYpuCazNd88W+dcSURx2APFq5jo/bVZ+rIp46IAy8qHCZvpTazlEpFNRuxKyDiOw7u9E6XQS/QvkVCC4w76d1VfJkS3nggYv6Ngnb/S5xEHfmCGNq4HaHxmpLfIHtxe/cz2j1nstDkCGCU9l9i89w0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAOY48//; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAOY48//"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42808071810so3936105e9.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721915058; x=1722519858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s/HXjMl+rhCQ/YfNOxW8zJoKTIGb+SOaFy0lDgLRpp8=;
        b=cAOY48//SGFXnJZfxlj1FzFav9768rfK54/aLMV+/AVH0VNrgkhB/C5bvqvfi7bult
         u0A93ajpB5l8IFXjB17ULDLWV2K3pA6lR66kqiPaUk5jF1CGVl6PPBarcoUFNxWYQ5Bp
         E7xC3T97EAxMboPL3QeYM9pQqd3Ql4+bRQVHXK+9FdDA6KFyT8O/hgnq6Dpx3wZ2oy0Q
         l7K22qKIRurFK/eUDCYzH6g+edeEPCZ4OLhKO2FtqAIqx0KG5Qu2esh5UhpiECCDG4ue
         ESBaJR8b1ufIEtmkhA0p6qhp+OCljH70c2YNbxlt+fsOKndW2vicASsWQkNHEUI6gr8I
         1imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915058; x=1722519858;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/HXjMl+rhCQ/YfNOxW8zJoKTIGb+SOaFy0lDgLRpp8=;
        b=fa68P3E7/9QNfqJX3BJoIPf7OC17KHEFXvzW6kUeGh1nvVIogQkpA6fJ7q5lJDpt0H
         pX15lh3qIWlR+7RFYJ93ND6gbgtRyOJPou0e7wMmwSeZflPREdJpEQR37qHvUFUoEQ/0
         u6S6f23ZC3FvcGnKEDCN4kNVSsEGsvcbXCJ9rgavaZwfJOFw4nbI/yynr24hbEh/WW3X
         4TBFporOmsufrGwYwAhP57eTxJhkLnzbmXw0zHW51ibdBbF8N05rMRSlrh2C1JpcTXZS
         zsN3x/WOJxAZ0saUAWYoSlsMQ6lHUGGJAa2EKsB90OfeBeL5JaCEbygmA47mWXIP0DH3
         Aizw==
X-Gm-Message-State: AOJu0YzyFqiAuogwoLr8D6bNmAbNIYDQjAlDR22ecetq4HFe2ZajFM1y
	Xz+V53Rvy1BtOTU2J4xiqj4nuWhAC3QPHpeGbWGcH/kqTYT3zbOykpoA5A==
X-Google-Smtp-Source: AGHT+IHHkEwFSbvBQT7dlYHy5LsEL2DecYhSSX4Bfi4OTKZYEJ67VBOKNFpRR2JrM4ERT6GQSFYwQg==
X-Received: by 2002:a05:600c:4f54:b0:426:554a:e0bf with SMTP id 5b1f17b1804b1-42806b8e4c8mr14057515e9.16.1721915058130;
        Thu, 25 Jul 2024 06:44:18 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a69c4sm36418555e9.33.2024.07.25.06.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 06:44:17 -0700 (PDT)
Message-ID: <57073ffc-65ab-48eb-9517-964a6f5141fd@gmail.com>
Date: Thu, 25 Jul 2024 15:44:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] add-patch: test for 'p' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
 <88286ad9-eab7-4461-a407-898737faa6a1@gmail.com>
 <76936fb1-446d-455f-b4e7-6e24dda3c17d@gmail.com>
Content-Language: en-US
In-Reply-To: <76936fb1-446d-455f-b4e7-6e24dda3c17d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test for the 'p' command, which was introduced in 66c14ab592
(add-patch: introduce 'p' in interactive-patch, 2024-03-29).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3701-add-interactive.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5d78868ac1..6daf3a6be0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -575,6 +575,22 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'print again the hunk' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	 10
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	EOF
+	test_write_lines s y g 1 p | git add -p >actual &&
+	tail -n 7 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.46.0.rc0.4.g6f4990c0d4
