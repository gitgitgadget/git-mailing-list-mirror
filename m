Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8838553B
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113602; cv=none; b=mz5HKXN8RUt0ooRMvE1kwjv2k2Lf4Sapi/F3ecYmDYhdy3CbZUkDRfu2k/MdNX6ZNX7UlK3/AXxFGorf21ZNU6X53XfSbxjBNl2lZZ3akKWgfZ6pjfS2PrhljL5CXIobrl2IHLPbHGazYNxf19Sh+OlqiqApuAi3VOOc/SiYiXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113602; c=relaxed/simple;
	bh=ZapA/F4yymKNn1yIKvyPZXfgpaQ5dzf1EVL4WmFrWXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmuIrV7ULXEQJAkb4rmgdtN60pCEG6Qcbs9NGU0xw42HT8o/GYUWAXPOT9mU+hluNW18lWuKYRUhY5X2MfXQFRA4U0Ihi8nkVpAwvq6BpxvUHMp5kPb5TYVIHoychX5rg5BzWNg3We9mnQI6OwKlEx6Hitdr76sL22aSQqTC8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZcK9Pfj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZcK9Pfj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so4109145e9.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113598; x=1775718398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXSvUJxaCrGr5Cq30px6c0VX8WrlozKsmoUAUqtImOo=;
        b=fZcK9PfjS4gJXbR6wdruEst1kHfdJrRRTjf32LKzjHxfEyMec6MER3kXta2rklmQBW
         e1sR69yBRqAvo4oXnrxrrz71YQs749DaUJGdovwTFLrFQtrbfPnrYQ57z3xADlQz39di
         1tmcnxcPgolm4drutek6R+tVAWrywGCXn1pGewi/R4Nd1dr+/ykfsPlKOC4qTfL/mWgG
         ZK4Ve4SXN7ngUpf+tnMVmX3uObHML1GHg9daKI7LO4KiGS8r2hP7CkB3hJIuxizRt6bG
         blOtfNhzhpUxkuXTfpQfRl7HWDf1JnIeSSwU+l936rQmhQOM9HexE/ZyLYL8jgxfDP2m
         Y35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113598; x=1775718398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXSvUJxaCrGr5Cq30px6c0VX8WrlozKsmoUAUqtImOo=;
        b=eZ7gJPNyacQ6Xtq72Ygh8alrjOxHUTzB1vqcU60JjC7VOLDkpWcJQMbJ7mlylmkfOf
         7If8NN3MZDDS/aEAg4skEVZUieZ4ty+SCGbInogyknYGUqcIZZ/VlQZcyHtQjo+N3k3L
         zwjm2vVbknRG2G8bHccRc4lI70taRgsiwELWp8SmyDoL6WUO3hXuByzusymkasrj8PwT
         ZuZB7IHNgAwTYrEMLyHDiz6gBrxYTLXXhq0v1vMOhJa6WjQN1Tfdgsor6AxPm6hYwjQR
         Rbvv934umvcPFRzA4UkP21N/UPfrzC1sN7X1oS8PApCk8CDxE8zzfIANJ0yfl4/ooR+C
         2IGQ==
X-Gm-Message-State: AOJu0YzfZukBddOl40Yi9D8hJFNWGErmPSjzYexUgGf8lxsZV6/hwXqQ
	LhxjblEVnv8yAlBoI7ECHCq5PVAJxjgqmPSMFIL1Vmr9QEtfmauEcBX6nKK3ow==
X-Gm-Gg: ATEYQzxLMKbD1qwZuPibGLiElOUBl9k8iykVW/8oha1B6piGPAkH6KCq6Xa97Mc41Ht
	D4Ec5uhM+wfLB45PyQuBd4wB+uSHX8vIoK5IWtbMXL5QH99tJGXWl0hA+yLb2FuYPRFaufKS4jI
	oOUd2hXvY0rdKJNXGjbz975dGg1gaCwpWfS1kV82VxbakET36vITCzcqltnOhC8Kb46+WYcGwE+
	clLxFUT/BSgFOtjF0abbdVmpwN1Q9vTlXd6oY8NO7v8gRuuX3NtjzOMTjpaIRXC/XkfsXy/Vr70
	SZx/znl2u/AuRGWML7FfDh0kdqT1Nke70yNHyOqmS6Q7fggNQlkHx1R0DA/hihVHIbu5aFobE+V
	Ge9Lkw5os41DqKc/KhkEDCvusZygDgN+k7G3VTshHAnFHMJ8FFexu00MEhzdxDjqovNYCVJyP0/
	BTM+8JiSbI4o8t9oM3A8jamdWdc1SvX1MMdJ7J/tnnzdikbkuRA4APJH9H6oYu7dRZePCNFWxzo
	fh+BXj4GXlblooSFaclHFcRB1kUktdoowpx8UQ=
X-Received: by 2002:a05:600c:8b61:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-488835888b5mr110127715e9.13.1775113598301;
        Thu, 02 Apr 2026 00:06:38 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:37 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/10] promisor-remote: clarify that a remote is ignored
Date: Thu,  2 Apr 2026 09:06:06 +0200
Message-ID: <20260402070613.85934-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In should_accept_remote() and parse_one_advertised_remote(), when a
remote is ignored, we tell users why it is ignored in a warning, but we
don't tell them that the remote is actually ignored.

Let's clarify that, so users have a better idea of what's actually
happening.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 6c935f855a..8e062ec160 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -670,15 +670,16 @@ static int should_accept_remote(enum accept_promisor accept,
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
 	if (!remote_url || !*remote_url) {
-		warning(_("no or empty URL advertised for remote '%s'"), remote_name);
+		warning(_("no or empty URL advertised for remote '%s', "
+			  "ignoring this remote"), remote_name);
 		return 0;
 	}
 
 	if (!strcmp(p->url, remote_url))
 		return all_fields_match(advertised, config_info, p);
 
-	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
-		remote_name, p->url, remote_url);
+	warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
+		  "ignoring this remote"), remote_name, p->url, remote_url);
 
 	return 0;
 }
@@ -722,8 +723,8 @@ static struct promisor_info *parse_one_advertised_remote(const char *remote_info
 	string_list_clear(&elem_list, 0);
 
 	if (!info->name || !info->url) {
-		warning(_("server advertised a promisor remote without a name or URL: %s"),
-			remote_info);
+		warning(_("server advertised a promisor remote without a name or URL: '%s', "
+			  "ignoring this remote"), remote_info);
 		promisor_info_free(info);
 		return NULL;
 	}
-- 
2.53.0.765.g57b94de1f0.dirty

