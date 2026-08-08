Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF8EEC0
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147347; cv=none; b=IZ6FM/9dM4HUOmxHW+j6Zs6cyXXcmPECfrPAnztWzNKNgcplp3GK+75WzLRRH82yWHFYM9sEE8LjomT1sQjKTZ3GySqCf38GHFtgKxWAzbfJEIHDJGpeKYPvvtLgA11dg8qepsnFvs0VCm5tx3nQk31l+A7hU/zE4/XxKtKAHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147347; c=relaxed/simple;
	bh=SUnVFvl7CwakfRhybDBKDnOSgzVmmE+01FmBfK2gX0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdXLX4bSolkyhEAcRvZd2kjVCyZRMHF4b2zlb6Vt6laOmMZQr+V03pD2pbP4LBxkTbjF/e7Tg+JC2xgflPLAZ1kOE6AuP6TZxxc5ncpNpNjwn7EJYf9Mm9opzGj7QI0YProlbGgs33leN+Z0+zst3ETBGohx0D3m49ob4UaHEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnZq23lh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnZq23lh"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso935325e9.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147345; x=1786752145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DE9JDImRbggnFUEy/aIBwUx1YDtqkPOScxx9VXW02Uc=;
        b=OnZq23lhdNR2uthvpyfgDFqvrhcifrhrYa4FFTEK8r9SeZPnBcABIcu9l2vPgAVL8X
         gKtCgeNbKg7vouyJiKFOoQK5LbT2gpb500ndtC+vKgz8lenyqCuFfRlnX12gFkXs2wmm
         pebIztfZkVc25H6OnUdtM1LvfGOmKcDtcbE4WVLgzbYLCFAY74GnCGAfcEKFltjuXlVV
         ftsF7V45HEI/QsUVPF+NZ+JFcnw7QxkvLgoKPdxEkoPNGeyAiOW/f+iuy8HVDEpy39ze
         Z3lzLNAmPuw23DoST4H+6ZOnUXOUvfu+kYMmAu1Nmntr/2Fpc88+RGU/YluFtbxO/OVt
         2YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147345; x=1786752145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DE9JDImRbggnFUEy/aIBwUx1YDtqkPOScxx9VXW02Uc=;
        b=o0jAVZBoSEc4ncVyMbSj2L2Tsxd4a1IxPkSDkbqqqze0GmvjYGZxzERFqZL/4xYK4D
         mfsUMRcmLuJbC+0luODOMWb6inWNh+w647I4Zh0fJ7xMdK/UBD42szogXmnT1nZWi+iV
         J8wij5iutuV8TGCBivj2P/YoZ0W65QQc7455DAoqeTBpag90Gi2pF2gDrYvWPi+yOu3w
         Odoudl6EJ3xM0oOhCmipptKppdZ1Eu1usuGixH8PJadtD6emXdqRUwPCVednKVtPERBX
         0DalYm7g0J3oq0heRFB/P/juGc2BiZaOX9KDtsgjAFKlxivuXH4wscOnz/Q3Hoi1OOJv
         Bjaw==
X-Gm-Message-State: AOJu0Yyf/Yn8HGocVDUo9kaNLAKzc9mQ9UvARJckj30yGxpsiPcQyAqX
	snaZKJvlUaDhAZM/g0wZ63nIccdcotCepdGAX0dFR3zhVoE0iERzOUi5VTBasFNx
X-Gm-Gg: AR+sD10ZSgec0Apce6M+G1mBF2yexiQngm/G0CmUBouCXf9FcSrNrpGWkbFj5ROSio4
	KrAdJreVJh4cKAOSU+Dph7bvZWnIh2DeHhkSDLXE11qaZHAAVWy9UW0tZo3ME7wwN7/tWhQ1JbI
	2Uspq1FYGsY21GVpaaB/zBdYtkAbZM7TekYrZQM7wuvwPwBCIopSGM1aUl2bkWV8kRbh8TcMZhY
	zIuopks7sS0iu0pIoXarCc+EhzZVbd6McA8bDm2OnUZm66m+2Q0mDJ5lJknvaGcslZzIJo2u2GU
	tC/wGH+BT9XwHWmEvSiwbaa+vU4KwFUUkTqD7vZN+dYj+4fch7UJ0V6ca+7BcDOq5hjcowoAr7+
	3Yl2I65l0hSjHZEqEhgU0/SUIl+rqBRWhb3fpKeYP6ggKwwoAcgnSZdH47j6S9PiJrZeLpkQHIN
	cI3ckR5nlZmA5CNhLcfVJUt/WYYjoqIMJ00prvNj59vAo+ejEAhkfNnR9kRWjoTCB/FjGy/SD0X
	Il3FBZrtglRRfDWLCSXY3JqxCZYNxJ3i+I1qquIp5OYDW1NT6cXx+IU/HhaZf7j71nWqMnChG4y
	yl36PcLOSGB+FRM+KuU0QqOHLCwvhoxkGI+kOiyv+h8oR/E35qsJNjsdcnBRXlQ3wxEUMZcwssH
	BEVUmLcK4zOucKOt/OR+KB0WEZzBrRVHIs5HBx7GCRgSCDMP3BM9gocuV//4GjlMdE2Bg
X-Received: by 2002:a05:600c:3b0a:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-4994e71d7b0mr327510795e9.5.1786147344615;
        Fri, 07 Aug 2026 17:02:24 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:24 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 02:02:16 +0200
Subject: [PATCH GSoC v6 01/10] t5701: use test_file_size() to get the size
 of a file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v6-1-e5cdaf27a49c@gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The 'basics of object-info' test runs 'wc -c | xargs' twice to get the
size of two.t. The pipe to xargs is only there to strip the blanks
that some platforms pad the output of wc with.

Use the test_file_size() helper, which outputs the size directly, and
store the result in a variable. Because 'git rev-parse two:two.t' is
also run multiple times, store its output in a variable as well.

Storing them in variables outside the HERE-document has the added
benefit of preserving their exit statuses.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/t5701-git-serve.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 9a575aa098..51d5dd1ae6 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -344,20 +344,23 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
 test_expect_success 'basics of object-info' '
 	test_config transfer.advertiseObjectInfo true &&
 
+	two_oid=$(git rev-parse two:two.t) &&
+	two_size=$(test_file_size two.t) &&
+
 	test-tool pkt-line pack >in <<-EOF &&
 	command=object-info
 	object-format=$(test_oid algo)
 	0001
 	size
-	oid $(git rev-parse two:two.t)
-	oid $(git rev-parse two:two.t)
+	oid $two_oid
+	oid $two_oid
 	0000
 	EOF
 
 	cat >expect <<-EOF &&
 	size
-	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
-	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
+	$two_oid $two_size
+	$two_oid $two_size
 	0000
 	EOF
 

-- 
2.54.0

