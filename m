Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1143C5540
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029522; cv=none; b=huNYOSYVPJmkjHsEEblVdLyRqVYoACGV8sDnAM1FvifZlIGwAsP6EijD9FmDPVtn9hbUGIR+E5d6v5WuuOXHOYOphSkEpWWlt8QoLRz1bcarDZnpZrCekuDiHWSNw2FvWLc44KFxXEd1EOBdSjEuVdiWVbC9Ns/eL2I/zwk5Wbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029522; c=relaxed/simple;
	bh=GpctcVfvABnkFE7+LJzuCd5zRVxTojrxGO+kprXw534=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS40R95MKQXRVvr45axg/YYtJoOGIzGCcvdIhBOekg56Ld86wNEKT9nNykR72lsw7XFJDWfkZnu4qqlr3VrxFEeXzPL+SM4p4xahXbbtzwklza81Og7PYjpQT1BhL6AwxZQiOLpIcBXgMrOLb30isZ6f8ezQahnNxTfqgyAOTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9ejkDNK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9ejkDNK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c733f15aso38588265e9.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029518; x=1784634318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQ/55N/3UITj2aDUmhVqJ+/Dm0RvOshB7nYEs0KYrpE=;
        b=p9ejkDNKetto/EEMfQ9+ju8hx6LdeE65qZHypq7IgGa1cC5+pgrQsBXpwj8oixT13Z
         vAYkU2W2PdPhhYE0s1GekSrTXOyi9zozADiewNYly+8DcZM4fX0AMx4wA16wGsC4DLms
         //50SxDjVoUM/gcsdDVDcRvdLZt9/gOK4gUdX7dRSqseg9zHx4IisvLjqASLDkplHHXk
         OeU71hn05JrZJAplRmELHvKSaBK7p4bEkaW4Gaic5shOdxJxzEiimJwo0R7eYmPfEYYI
         +p8J/OJlD+ZY11otWauy/ut0z3ufCdMFw08zyXVoHZmEV34kVVU1pTmxxtuhG05fARFT
         99Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029518; x=1784634318;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQ/55N/3UITj2aDUmhVqJ+/Dm0RvOshB7nYEs0KYrpE=;
        b=YTITlsgwVDznfGmFfFVkr34or510D2ZgHfxIF4D1t49kMmo7w/6vKXYUC9lhdy2LrB
         wZbCn+q5Hl7YjmNgDlLh577jOllIYrqC1NWHArh+To280F+FxDzQIC1XMtrZt/1fChlG
         twbad+S+5tOy4wxx7obbQilqW3IEAUlnH9ek7cxBWijolYXtac4fYPULhE8iPRuR/OQI
         yjO9x6/IS+5T7vx11rzOP4R0cmykp11RBb50tbDjAvNqEDkLr7U3+0Dc79XMBf/vDQQt
         Dyfc1/+xKrDKIg4VNjDzr7Pq80jjY1Q+NC8Bh94wvsAcIQdnG3A4fX7atZ7jV+f8lqXD
         MJ6w==
X-Forwarded-Encrypted: i=1; AHgh+RrKz2N+FqJsA5lzE/nl6cJ3tPkb91NIQTWjuDUq7sqRZumH0BzphSq4GJmlyIulXFc0sEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+z9XRkCFAGWTMyWQFchYYx5NrjkFJUbU+sldhZA56iEvWrHBQ
	UOm17y3rs0XTr2XXl8jAAn2R5sp2lqZOKT+kbtKmra8GF/3v6c86OvU3
X-Gm-Gg: AfdE7cmmg0I6beBqiDMxUC/hLRH0beT6PFniImLbXV2mSVhaK/LnnCuCDJ8+CBtdmCl
	8NtH8SGbVX4tA9xxTUk7VGJHWEidV9CkCL3Q0UZXDe7cYYeGcIAF5CYwMx4OSV2jOTurNqB9fF1
	ksRhB7VV7NqV+/xmPl1SOC716p2PjnS7Vt6YAvJXbw5RIPgt2SH7HnuL1MMdKBlHP5h8fDPkJRH
	HjvfeJ/dnmLEwgOR0vbUu2q78pvibamj6cwHTvcClhkJHoWoHqwmpEFFCPNuiIGYfJIBWHe2GvY
	ciqf4UHJ+504+kNFJ4X69wBk/senIqiEMdYTolyY7ICL82wbmHY8keLh9DWJz5RXE339P3gh2gk
	pUfXnC8P/O7kg4UsbymFrGIMaw2x0lHD/PJ975+XGXNQq/Mk4rSSxkMCux3QnbouGViihtJy4LE
	0IjuBkQbmoUbKLP+bETkzZmxUBuo8KBe5hiH0C/53AddB0SFilblDi8GHpI9bjhew8iA9oWWuQ+
	LJX0IfHUpXEdHSP7el1baEqzhAemAHxTHBjtss99M89K/dV+HzSGiqHeTL5330fCp0t4eQuYbAZ
	h216MjqfCV2vYimhnFANX7EA+GrkOYBGcv6StD/NC26k5256RjpKu+CyfYZ+i7REi46rLN5k9qn
	MtkKBHQvbFw==
X-Received: by 2002:a05:600d:6405:20b0:493:f807:1a79 with SMTP id 5b1f17b1804b1-49538a0ef82mr16420435e9.27.1784029517982;
        Tue, 14 Jul 2026 04:45:17 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:17 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v17 04/13] fetch-pack: fix hash_algo variable type
Date: Tue, 14 Jul 2026 13:45:00 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-4-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
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
