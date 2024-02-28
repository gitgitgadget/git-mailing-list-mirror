Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC2158D66
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128508; cv=none; b=tBGi705NiymqEbomvqO7o6TVsujmwKBrd9BW4BGhc/oZMaruxhJr9fPm7zIV3i1YQHAc2qlBpJHXwW10sWZ0XrntqDeKCZ+RbSJnIHTyC4/DPebNmNrL27azT1eC2bkcy8LD2QG/WD/4I2tKF48gUcFnt7mYv4i75Hmx4/h/kQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128508; c=relaxed/simple;
	bh=42AK6hl/WACClrSMQONOe4tU4sTh7Q7GZLmaHSNvFaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1GJzzMjtsjhjlRI+4K1bBvQEp3Y3Xo/1VRwJqceh9nVWRj1InR6uCF8bees8omhyyB0EwqkOilELh4hNvEsGFcpkFzrwUOItrxyTwMdV+nY/FoRv8xyZWO+UdnWR24PsVE71YoV3bX5U5NF8erCX1PE0lnB54bb3OZ7RkNkGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVSb3Wt7; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVSb3Wt7"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68f51c5f9baso30660726d6.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 05:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128505; x=1709733305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hsc2hx8vPi4zbZr2MfgSJmjIiKrVi/+W8V1s5lD25M4=;
        b=dVSb3Wt7zqc62MDkO3Bc19P1zD4BvyXzz8hl3b6VNLMMIu+XT50+6XIgFZhUAvl8cb
         iCfivfVcpM4qhYfUYGKBZU7/pZXQ/Scyl0CNJO/DfrlfBqR+GI/eqf4bwtjJxKmbe80h
         uU9ZfuEbQmq5kZZZVKzeG86BOxk4+fSEMMy7ShdmnOyg96hft3iVZQAo8npwANw9OPKA
         BhKRAIcIrQvAFZrsZvm9eL9gaIw05zax0LJ796H2uZr8Bf+HryKMR57NAcBFyVlANx12
         43iRcTyIvCv8wommaccqTYQjVaZ/ehGTTGwENtz7izUopBRb0qkMSsm4BhjldGg4B64r
         um4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128505; x=1709733305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hsc2hx8vPi4zbZr2MfgSJmjIiKrVi/+W8V1s5lD25M4=;
        b=oq/vlff1VEW/hJN+uCAMeDrlTLm7RUiTVSMIvQCn6KFI4Qfq8EhvoM1GH6jt2yfqug
         hzmJtueJQI2ooVGP0eX/DBJv2GPJGQARY8cxvB0YuZE/xKIXYLYtEYsvu9Z0KnUj4U27
         5uKalQXF0VmocG5VI92dmKBdUrMtCMk6cLJJWzxvWx5oByWyGYn5DTh0tM2KQ0APL6h/
         NsaSbvh2McE2FUwg2B+hyI4Hx4PyYGs2qV9Gr0bMk7moFA5AyOgH1p/I0SYlF7+ltyEr
         9qStoPycoC5qhfDMErCQtMtvAFh4ARY2S8Ei5f3wY6PqjYVwHEVjzeGAq3F3XHA0Pwl2
         QNsQ==
X-Gm-Message-State: AOJu0Yx4O+tUoe6nwKUhGK0AgJLRYiM717ndXTXRzKGXLg1z3Zxj4xwg
	WWQ+uBEoUqt7iaDOVuR/yvKeBfWW92CTADhVjXIBQd2IxzfS7X+EUPsD2ny0pFQ=
X-Google-Smtp-Source: AGHT+IHpvlipDHS/1Dn/fYQ/rPWHGWV3sPzaeRR2zvMIuFVQEXnkLOo38cPcMcUXzjW3UXiqqBV/Mg==
X-Received: by 2002:a05:6214:20ec:b0:68f:301b:5482 with SMTP id 12-20020a05621420ec00b0068f301b5482mr6023414qvk.8.1709128505518;
        Wed, 28 Feb 2024 05:55:05 -0800 (PST)
Received: from [127.0.0.1] ([2606:6d00:11:ff90:f134:2d0a:620a:ef80])
        by smtp.gmail.com with ESMTPSA id jh15-20020a0562141fcf00b0068fa78ccef7sm5247839qvb.116.2024.02.28.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:55:05 -0800 (PST)
From: Philippe Blain <levraiphilippeblain@gmail.com>
Date: Wed, 28 Feb 2024 08:54:53 -0500
Subject: [PATCH v6 1/2] revision: ensure MERGE_HEAD is a ref in
 prepare_show_merge
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-1-8ec34c052b39@gmail.com>
References: <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-0-8ec34c052b39@gmail.com>
In-Reply-To: <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-0-8ec34c052b39@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>, 
 Michael Lohmann <mial.lohmann@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Michael Lohmann <mi.al.lohmann@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.14-dev

From: Michael Lohmann <mi.al.lohmann@gmail.com>

This is done to
(1) ensure MERGE_HEAD is a ref,
(2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()
(3) error out when MERGE_HEAD is a symref.

Note that we avoid marking the new error message for translation as it
will be done in the next commit when the message is generalized to other
special refs.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 revision.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..df775f74d0 100644
--- a/revision.c
+++ b/revision.c
@@ -1973,8 +1973,12 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
+	if (read_ref_full("MERGE_HEAD",
+			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+			&oid, NULL))
 		die("--merge without MERGE_HEAD?");
+	if (is_null_oid(&oid))
+		die(_("MERGE_HEAD exists but is a symbolic ref"));
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");

-- 
2.39.1

