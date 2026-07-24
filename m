Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5F3D3CEB
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927197; cv=none; b=JqI25L/R61UU7qFiOclxyMphKCXNHVF+S5ZS/QlC6EZobuVskfDZPOvWcQ+jeASIiEvRzJ6+zK4ubO8iwQGOdILPdyo8pTpDgHE7+EgI49wryvH6s6NbljY5NBdusJJ4Igh2mHF+vyZmppPYEo2dMjpDmFfDCTsgl3ERvPB0XEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927197; c=relaxed/simple;
	bh=Quya4JeAR3Nl1p/VSiH0T9fuhnJdYKvksUbnD6/5ZO4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2RajqgsrFoV9AVAaoHt+EqRp1Qneee/9DYFWMfiNxzW0/IgQGzoiSmMl5gt7O6+Mg4N9aaZuEcfs/jlA8N0114Ew6kyvSksgDr9X/77mnDyh/n7trLXR1tekEFoaTfRY/6ebYtzH61nmoT091A0/gNib16towWjiKZ8ScebGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=H88gJL6p; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="H88gJL6p"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e86df8987so8632107b3.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784927183; x=1785531983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ggNWjDHVnfJbIqtVzykYihRgLEmdh1f9gCxFHklpCw=;
        b=H88gJL6pZE7oXMwB8NyTaFwv/G7e0noaZ/bAx5XtA3HiNvW7K0t/2KfJ5AnoQuyivY
         vZPOw4IgZo3iOIOn0kuJLPpBfHVEDDbGIi7s8KJYfGSuM79EmRnosgxU4bRJ26YyXFwL
         5FV2zVj3LygzuMolPDgl2FolI/4f4J5yK0GnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927183; x=1785531983;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ggNWjDHVnfJbIqtVzykYihRgLEmdh1f9gCxFHklpCw=;
        b=Uou33huFPRh6vN8ayiwVM2WVAJjGpOdR8oXEcBlftTEMEwlingdVz2GTVge/Ikfgti
         9/K9N9wX8hwlaswgKuawKWc3zzLiBHd6kuIXfB0LX4ZNRzWLa6AaMTxdZcL2D9cztkSP
         Ghjj2liFaNvHVSG1OFXGK3Hzy/EvrF3Jq7tGLXGSQed0NQwRoXMhlu/AwF2u265nFbEW
         gEtT6Qn+lll7vf7QYz5+IRiOO+Sv5tp3sIeakD4MHg9tWmFoFImtCzqTEY3N5zNcHVnM
         5nDnQCdCgpXz3tH4rJEThbRlpcCJ4kFRNnsCletuZt1HN0rSkaanseWjsRqyiYq1VJ4V
         rbug==
X-Gm-Message-State: AOJu0Yz0xMGCqw0OXlmJ/OXmUJFYxSk3JdDWGTId+HwS5T+NPMZfjDVH
	KYdnt/TYSNQrZJ/R/i7nLQYE/rtkyUXV1MBNZxqwXcRP4KesGnjJ8Bx8FO8GOP7qCR3ZTzai/hS
	4Pst2g60=
X-Gm-Gg: AR+sD13USMCQUBFqFJibc0QOz2PxuaWTTHVhiiJZZzfI5bzQ4E8poRePUIEhq0pFmyV
	nJj+IIJGK6/vOAhXVUKmPsVvMa9UWvz/YlAE6e4h8OnXzL0y8Us+IGTlsAaIkzkHz91ZJwDnU8T
	N2RI+sbwnGGFL8iu5WUE+U+S2V9eCoADiUyFBvSzVYZJ7awXN/ZUOaIUvbXiTs1Fj0yzu4G7/mJ
	ykWxgSvByPxK7dbLLBWPAMt5ENKSr9gbjspNrCVOcpmU9TVoAJXPgdGp5lkzJ/NSeLMjqAXRALy
	ZplvGlEdl6pFZJZ49D9gIm2z3d/IQjztCzRC4u16U4Jn20l7nZeMHx3EJPDgxLZYgwT+i8SexZo
	7XRYYoOW2cGp6EV4xeG0q1Xjt6Alz4oAYK4bZb1EJlX2OnTPc1q0ajK0CguO85x7/T+q04WpMZk
	s5LyiOCvbG4gnjgyEdICpH5iTowqbu4vVOSKJhhdTJhWQyCLjaiyF2ZME3Hb9/+yj/v+r2+Nai/
	2DkOIvjEcH3guv6V1Gq5M+xR7yClxZAhk3D2N84ODIu
X-Received: by 2002:a05:690c:63c6:b0:81d:4174:6818 with SMTP id 00721157ae682-81f69cd3959mr412157b3.13.1784927182735;
        Fri, 24 Jul 2026 14:06:22 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65774b0dsm6081337b3.1.2026.07.24.14.06.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:06:22 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:06:20 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [PATCH 4/5] test-tool bitmap: reject packs with duplicate objects
Message-ID: <355a9f849c1a98f47dad3edfc8251e28ee179272.1784927134.git.ttaylorr@openai.com>
References: <cover.1784927134.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1784927134.git.ttaylorr@openai.com>

The bitmap writer builds its object-to-position map in packing_data,
whose hash table permits one entry per OID. The bitmap test helper
accepts an arbitrary existing pack, so a pack with duplicate entries
calls packlist_alloc() twice for the same OID and trips its internal
BUG().

Detect duplicate OIDs while ingesting the pack and die before calling
packlist_alloc(). This preserves the internal uniqueness check for
other callers while making unsupported helper input fail gracefully.

Reuse t5308's existing duplicate pack to exercise the fatal
diagnostic.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 t/helper/test-bitmap.c            | 3 +++
 t/t5308-pack-detect-duplicates.sh | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 8547ef67e2..6f851e0421 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -50,6 +50,9 @@ static int add_packed_object(const struct object_id *oid,
 
 	oi.typep = &type;
 
+	if (packlist_find(packed, oid))
+		die("pack contains duplicate object %s", oid_to_hex(oid));
+
 	entry = packlist_alloc(packed, oid);
 	entry->idx.offset = nth_packed_object_offset(pack, pos);
 	if (packed_object_info(NULL, pack, entry->idx.offset, &oi) < 0)
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 493ebbc4af..c6273a1aeb 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -59,6 +59,13 @@ test_expect_success 'index-pack will allow duplicate objects by default' '
 	git index-pack --stdin <dups.pack
 '
 
+test_expect_success 'bitmap writer rejects duplicate objects' '
+	pack=$(ls .git/objects/pack/pack-*.pack) &&
+	test_must_fail test-tool bitmap write "$(basename "$pack")" \
+		</dev/null 2>err &&
+	test_grep "fatal: pack contains duplicate object" err
+'
+
 test_expect_success 'create batch-check test vectors' '
 	cat >input <<-EOF &&
 	$LO_SHA1
-- 
2.55.0.383.gde07827a19

