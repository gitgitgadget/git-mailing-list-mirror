Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8C1A6813
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890924; cv=none; b=F4evNzeN1UTN7vsjsvIcNbZt+QiYE6QcQwsTilrPzQCxe1boad2m8Ru6zkJHHqgkHGacAipy5S3Q2Rq8nngz7R7hbWIrbMNFDF1/oW5FGo7NM013GvoKn/RR1lcUHQV+8yVKhExFsHu9js+rb60cLvGB7LGlidm8FbpLEVqeHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890924; c=relaxed/simple;
	bh=cQcnhNXREjFyBdX32MniimqUwB1VHdmYzpPcUVWwIx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQKy/XVQGKrXZyadnTxN8ZleRl1C/RDAPby1eYwXSB4nBXMKphI+9xrYBKwiKB9eBkosGwi+ofVjpn+IxpSdlJbDxwi8z1LkizFTcx2/bsusyCizkmPOEkV0SZEfxxby2qMDVyrvZSbYJu9MTWvrzgrYp3NVvUZryHhIeFP6aAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBrUOHts; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBrUOHts"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd21ffaca79so2165197966b.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890921; x=1780495721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlHfPeXeHQOCz7OKklRdQcZ7t0MMjbUh2lMtQ/gkriA=;
        b=kBrUOHtsTQAGVXs4wWkhTmZsQQ+eZFvHLCHtDDmxYf9qPh5/DnIVD40ohN/v321h24
         DCzFHCjsoeM2JukylQKwJKmTtu7UMdDT8MCYLVkjegDxVALvnFBKrvR3bCZ/etlygFNw
         D57w7BsfUYl+M4INCdXQ48JZZUjy5C7qUo1TPx4eCKNjiyDF7kCOLeCPuDvxN5OP298k
         Pmf7WNy3y5BZAiPtvUpWKc9Fvqp5FA64rTSHUyvC+zBos6SrTRnNjQA9af/UbQJpCMdt
         eSSgU7Uce5jaebexLWkFx7QEAKqkin6JayeIMa/o0P0GrXM5BQvAT3m2UFZLZij9Uv31
         TPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890921; x=1780495721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IlHfPeXeHQOCz7OKklRdQcZ7t0MMjbUh2lMtQ/gkriA=;
        b=f7VqALFEgZKbACkZlh3e4ANPdkMFZ34k+il8UKZT1HZP08S6JohNOojPprdwP4D6dC
         VQEaBf7XHYi0S75fpnrWXjmKZ5gQKEQjRCoakgb6rflswOFRyJWwhtAyPt9nUijHTgJx
         /ty6leNoO9yZIrdOvyG1+CSkMo+iJ5LvBaXt8cAmuV4lfqtQVnJpaetncwrohTBbM0+4
         1DKWw7smIYB53mqXDM9ktDCtm8oe+k3gTTSkqP59JsIHRVpQda1u/YGEtzKQMu4Jayrs
         M5SP35/6CQFziXWvut09Y/oMrV7qJUZ9r3fXRHTzHMp+9Fv+Q9SWfUb7xH3MGKM/ht9+
         8Tiw==
X-Gm-Message-State: AOJu0Yx8h2XnEN7Cr5HE4E5uO4tVbNsxSyGiI99kbLmJGjCQAK1nYw2Y
	qB5mm1QSTpp+vAY48HLe5M+llWX0QOp0Db+ZvpnuBo7XlBPHmXFCPuXj80l4tQ==
X-Gm-Gg: Acq92OGK/CGQDGwaH2dEh3LV/KwZ0ppJAVQQhTvieye43NsRyjnI1riFqm3ccq3LPq5
	sEcC+YdYFabiPUoofiJuq6D1M/KpqHQ/v+7MFJoO8kbcBHPf8kRh1nTroWGcigpwEgQxZpUfBmG
	CY1y8o0mOEOo5vLy41yyVRWErBLbzUraozgYICX/lOuXu10glZar9klJHvwc22yWcvDdHXm/cuL
	QecCAtw6/lDGmea11o/YpHgaGgZIkapXsjTfRU77idFVRSxrCTEs1HxckB42A2aZeUqUAcR2RuK
	R6yz8vzVYJ6Vmci4zwYdAZq21mqbJyaMs7SBpsPBd9qJZ1/KNAZpvvaG1+kRCqYMqrgrh7HPTMp
	/O1OODDaJ4t8IOi5Z+aawuoT7zSTZjQAUjEuJMbvOE5hsK8CIOOMaiG+JDchtsjOkV85JvCeNOq
	e9HdPk//H2ZPikc8QGBeqTTjT/eIfQYSaMC+fp/lvEcjbJVmhMjArC/DXowWyedj/cqCDud90tL
	1I4kW+RhGrdeMs+YJbdIbaVXW1wacQJUkXErcw=
X-Received: by 2002:a17:907:7f91:b0:bd5:b27:c02e with SMTP id a640c23a62f3a-bdbff583636mr1438309866b.6.1779890921392;
        Wed, 27 May 2026 07:08:41 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be1ca138bc7sm268122366b.41.2026.05.27.07.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:08:40 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/8] t5710: simplify 'mkdir X' followed by 'git -C X init'
Date: Wed, 27 May 2026 16:08:13 +0200
Message-ID: <20260527140820.1438165-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.275.g96c817d129.dirty
In-Reply-To: <20260527140820.1438165-1-christian.couder@gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's simpler and more efficient to just use `git init client` instead
of `mkdir client && git -C client init`.

So let's replace the latter with the former.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t5710-promisor-remote-capability.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index b404ad9f0a..bf1cc54605 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -177,8 +177,7 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
 
-	mkdir client &&
-	git -C client init &&
+	git init client &&
 	git -C client config remote.lop.promisor true &&
 	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
 	git -C client config remote.lop.url "$TRASH_DIRECTORY_URL/lop" &&
@@ -231,8 +230,7 @@ test_expect_success "init + fetch two promisors but only one advertised" '
 	# Create a promisor that will be configured but not be used
 	git init --bare unused_lop &&
 
-	mkdir client &&
-	git -C client init &&
+	git init client &&
 	git -C client config remote.unused_lop.promisor true &&
 	git -C client config remote.unused_lop.fetch "+refs/heads/*:refs/remotes/unused_lop/*" &&
 	git -C client config remote.unused_lop.url "$TRASH_DIRECTORY_URL/unused_lop" &&
-- 
2.54.0.275.g96c817d129.dirty

