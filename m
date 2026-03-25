Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25041325D
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468563; cv=pass; b=PVX41Odz/772u1st4DQSXVHBAQjMja6EQJeFAwzBkyWerBv20kI8HBx70mqBK03e9VuwO3SQIm6zahMWntYb0ZZhZxhmngaxsT/z7/0/8Mgni1K7Lia18MnwlrwouMH9QTbBj2KI1mcuDjybdNixGTJKvKcIFVHJf/393nZgvY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468563; c=relaxed/simple;
	bh=HmDdrYayebk6ZZ6STCD6LT7dfhGjay7AgNhE+U01xxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By5q1dmKN3J6CZw93m2ndEqMa8hkWTMRaMK0jfWgKtUAMtwlxHJNexEa5W/pMpMwxWWxx3LFmhP7B6foiCn6poLn17Onj1LjPFXGsFBuq7qg8N3zht8GUlDMjkknU0YI53f//NmieHDDH4GunGpEk++B5taeK48VSbsqwSKa+PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=CbPhvvRL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="CbPhvvRL"
ARC-Seal: i=1; a=rsa-sha256; t=1774468549; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ND4xS1epQjWExyJ/rm/XKXdano2xSXdDZMzIy6VMJa7W98mQ9laiJ0VyKLpg/w5nnstfkOnOy5KduzjYudG3QBbAs1GiQD0MVOJbiLoiv93CyHOxPabe79LUKgbyCMjbS9LnbIIWjkyv3Qc3zALnIrsImicULgkwGewofh1OAuQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468549; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Khav0VaUOlvz+wV0UYuVEhmbdzR8iOul4Clt3whqHzk=; 
	b=OkjmqIVpkPwpr/8z7jcnglu49D72h5Je96/CF4GOTeVViH6CQxxL7cvUYcJFo3ym0sq8369fOZRkc4ubwROupCt8Xqey8q2qZhTnJaBu4jYP75Gp1ZXLKamxPZX52igncBK0spfTipu+RmQEVOP7hyGjL8evCLmaQ6mPBic8yKY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468549;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Khav0VaUOlvz+wV0UYuVEhmbdzR8iOul4Clt3whqHzk=;
	b=CbPhvvRLE6XqT5dJbcnqwXcbHbwGGzrkPJAAiRICAFvyUHXDokDTT26k5FtfEaoV
	jEB1tDG1HqFhrYsh8LEGrVrS0x5Kw4ENShrr1pOPjQpgqicj4ITminhPENpEX7h7UQY
	IHiGQVnm2FYJSk6UbFjOq5UjavSTx724T3i7Vnnc=
Received: by mx.zohomail.com with SMTPS id 1774468548405586.1889106001047;
	Wed, 25 Mar 2026 12:55:48 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 05/12] hook: detect & emit two more bugs
Date: Wed, 25 Mar 2026 21:54:56 +0200
Message-ID: <20260325195503.1139418-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Trigger a bug when an unknown hook type is encountered while
setting up hook execution.

Also issue a bug if a configured hook is enabled without a cmd.

Mostly useful for defensive coding.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hook.c b/hook.c
index 4a0db5cfeb..b0226ed716 100644
--- a/hook.c
+++ b/hook.c
@@ -409,7 +409,11 @@ static int pick_next_hook(struct child_process *cp,
 	} else if (h->kind == HOOK_CONFIGURED) {
 		/* to enable oneliners, let config-specified hooks run in shell. */
 		cp->use_shell = true;
+		if (!h->u.configured.command)
+			BUG("non-disabled HOOK_CONFIGURED hook has no command");
 		strvec_push(&cp->args, h->u.configured.command);
+	} else {
+		BUG("unknown hook kind");
 	}
 
 	if (!cp->args.nr)
-- 
2.52.0.732.gb351b5166d.dirty

