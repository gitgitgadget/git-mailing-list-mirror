Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6BF21CC7F
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281076; cv=none; b=D3+2ODTQXWQyd2hSrzPFMyFTC8b01ujXq94wkuqhFd2GBaEXYgpKQAzzrz9USJFxi+tCUIrB59BJPYvqFuVScx2sq63QOWydVzoq0gAMwfd3HBvh/K68czYwN1zOBqHs6k5krDE1GdFw0psf6CAO9PS14B5zxE+8JyiG9UDPHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281076; c=relaxed/simple;
	bh=lukt03tgqcsAIqc8qbM9N7tTFo3XDJBseTsdOBie/hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcF6vdlSGaD2l/4qfd5LljIz5ag3z4zDzYYmE4aIO+fkfs1hDRarp3esUnAltvobbX7lOwqRu95rnOOX2sFxsyV0OrIcw9V3xmJRLoDj7AGtm+GHf4OsGEgDJoqirQaKLZnrhg1LOs7+IPHZ/i/dQVObfEG7PdVjUrHUXUct9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ63xc70; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ63xc70"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so65500b3a.0
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750281074; x=1750885874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXuJKrhj+r5w8CeHkFZfD6quDD+UWBx+d7uTSwQqSFg=;
        b=kJ63xc70UPf5n35hxN50BQW+VCxOVz64E+BKfVA/vd+OiCxfRKQMV/UQLA3kfAzrkV
         5ttaC/dzZksCE1zOLdJ7/isToKS9DKwNugjNXL8Tlm/bmChPSCBGClRGlR5AmGC2htoD
         fqNGbHqyn2z3bYcUmdIckQ+7JlK8NdaiqWMy1kmGMlNQDFBZzl4IZWzsLIRPepsJzxwH
         4miVYPBxQOIdRQSaEpX0IWdH+exqgnhSbP/l+TRLBsRQ0PLj33wse3opP2Kikvh5oXve
         CuAkPgNtX4igOnPOpSOYzwXoGaTB9/iXtNzFxmGc1bd5rGDZMHveSKnoH5BeaaXFHHwI
         uq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750281074; x=1750885874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXuJKrhj+r5w8CeHkFZfD6quDD+UWBx+d7uTSwQqSFg=;
        b=cY/YvTMnmtmLQfuZXXYZvjulIWbuVejdsbJF2t+ucnkN4PFU4eDEJ7qMZbJGdNrIyw
         d3E4vEbEqLMdgJA1NlTqOmbQdxKN11T382ZEfBbjrbvyQslcdzXiPPMs/mJm/qPJLp+5
         K22Tut7/ImlepYCfxRBpI1liawehQSygz+vWqaeC3v9mZ0WFGja7LUj7IOLp3NoVHaTn
         FGZvH2CbUB4dB/7mUGgls3xHHs94pltK2KhMb+Z6nQxJLIhIXWQ7p4d9jS3m5nWbYuyW
         ahugirmbqoy0S1bY4DlvB0DZvqnB+ocJVJ6PGT8ayWrNemOTOmXOOLWG1u8+19EtBK8r
         dnGA==
X-Gm-Message-State: AOJu0Yx3e27kupUCYHR8DiVwKibz/aPOjruIJcJMDRS+FVoOQUBao90I
	qSlddS8etipJ3dnLiEoDFUSZqzkQCSz1syW6ip6uEKVnYH2gyQpABTN5FKhklw==
X-Gm-Gg: ASbGncv52CoFvMumc54gHU4iZ1GMiDnB6JfI5bI6AqlRZ8w5kZUboIV/O+jkryletr1
	g54rYy3ZcoDa/VPyFzEvgeYWCUeZwf8HzHbGjmVbppkiBoQhJhMb0C3ezl7rizRWXt0PL20av4Y
	4avU9JxHqbMAxfDJ1BGUy96wje38noDXS20+nx8cMUf8MP78IhiMfS7mhC0vKC598wSdGlh4ghj
	tn6Twg69LfasChPLcDNTYgL7L43CltiWusXawvRnbNhu3gDYQDslKW3V16ch4CgVDQaqAmSoZiR
	9ftokxhcA1ndVOwnu/xaK+Ibf9GxD1DiZFLw84qwX9rT+j3bkflyyMDXclk=
X-Google-Smtp-Source: AGHT+IERLzBhx0V6GuBHDnfSOzGUFy2WND0khIRUQj91xXQBJcsDhJ5oa34+jh+fmyR2xM0b6dtXYQ==
X-Received: by 2002:a05:6a21:b8b:b0:21a:de8e:5cc3 with SMTP id adf61e73a8af0-21fbd511ccdmr25782400637.4.1750281073854;
        Wed, 18 Jun 2025 14:11:13 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680448sm9696731a12.45.2025.06.18.14.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 14:11:13 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: git@vger.kernel.org
Cc: Phil Hord <phil.hord@gmail.com>
Subject: [RFC PATCH 2/2] refs: remove old refs_warn_dangling_symref
Date: Wed, 18 Jun 2025 14:08:40 -0700
Message-ID: <20250618211024.2332525-3-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.1.gf2ab606906.dirty
In-Reply-To: <20250618211024.2332525-1-phil.hord@gmail.com>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

The dangling warning function that takes a single ref to search for
is no longer used.  Remove it.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 refs.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index dce5c49ca2ba..0669d8e07072 100644
--- a/refs.c
+++ b/refs.c
@@ -438,7 +438,6 @@ static int for_each_filter_refs(const char *refname, const char *referent,
 struct warn_if_dangling_data {
 	struct ref_store *refs;
 	FILE *fp;
-	const char *refname;
 	const struct string_list *refnames;
 	const char *msg_fmt;
 };
@@ -455,9 +454,7 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 
 	resolves_to = refs_resolve_ref_unsafe(d->refs, refname, 0, NULL, NULL);
 	if (!resolves_to
-	    || (d->refname
-		? strcmp(resolves_to, d->refname)
-		: !string_list_has_string(d->refnames, resolves_to))) {
+	    || !string_list_has_string(d->refnames, resolves_to)) {
 		return 0;
 	}
 
@@ -466,18 +463,6 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 	return 0;
 }
 
-void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
-			       const char *msg_fmt, const char *refname)
-{
-	struct warn_if_dangling_data data = {
-		.refs = refs,
-		.fp = fp,
-		.refname = refname,
-		.msg_fmt = msg_fmt,
-	};
-	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
-}
-
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 				const char *msg_fmt, const struct string_list *refnames)
 {
-- 
2.50.0.1.gf2ab606906.dirty

