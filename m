Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8864BCAC0
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593324; cv=none; b=AW7c5b8JCjRaG0KRt4fsepnNhscvfwfs32tgDnKB0lk/nvHcG4sb5C7Z88/8tOhz4IipkURygEACqOxk7K0uHJbFwaoJ7uJuCCcltnF8mEQ7iUV6V3SXBgr8OwFCHDVTd74eeNVn9MQNRaKemjm3aGZ4F3dOO6aWZx07jDqcdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593324; c=relaxed/simple;
	bh=elBQurlBzwIKRSJaRn7klJLuDA0WgxFs8k+vgfzD41g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oFFkpG75sPmVFNhqwnFQ0EGXYhvhcZ4GanzxITZqB2GK95cDmsTrwFddm6+YKUCQ6gp4s6hXtMRDEkebFh2m1dCrue/28GOx5Ood+m5uy3RBuwfeqS3XCXu2B1xciv8vpupiMBy2rcbZDW2d+m5ehkWP7rg7OwUkLdng9ktYkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQP4VW1B; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQP4VW1B"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137dd51129bso1634685c88.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593321; x=1781198121; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdRL7fDKwcLg5aM07dCj4pxlHnvAk9TkisA0lU5V7wk=;
        b=GQP4VW1Bm3oDCy2yWDPhUF7sqcCkx1ZiUEjAjDY9DbBmRZ9zZ5Zek3iyLMZqTtNlnE
         KVUa4x0ruSI5EbNiaOBMmVJlab7IjfkEnK/3rZ5B0EuGoza0FpsC98+jO8NEwkbtpO5x
         oqo6lvdbIs9r6MxtuMLVFMq/5FfCT71Oh5dc0Q4HVkY/q2hm+RTvbormi0Qa0AtSmtCc
         gtmPG12hBRbD45BxnlYC+boEdIO8+I3rcney+a0mKNysF8zgPVdFMMYenEtEt4ct945s
         A5Cc26aHDrWFMLbeTjLJ8YcVs6BNrh5fJyQOPGk7bYq154phAsqTgwr7rHoU9JAf/ea2
         lpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593321; x=1781198121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tdRL7fDKwcLg5aM07dCj4pxlHnvAk9TkisA0lU5V7wk=;
        b=mVeijOLqtYNuE+sWYA/PDv+I5QdbC/u+4S1b3nblv27E7ZKAiUERyAHYKhbxGuf/hD
         QHyMCWdI//mrf+dkMqR793pfhgFS6e838OD9QszEyPAJ+E9lspPSTv4znYdwTjxf8GFe
         k9vnyjzxKWYJb8m0JGYJGezrC3F6ciM3WC2OOs20mMe9UN/je3+dMqCPrSJEmbWvg1eZ
         e2rDipQd9JBDAC8MMYraC8QaLmUco49dW8+opJoAfVw03vM2oss5moDxTyeJM0ciiBTp
         IqcMRM1I3S08gW8ZEdOi0VKUI/xuXZYgX8KsNv1zVpowA8QMEgZmQ1l9z8MFt3joXbj9
         UIGg==
X-Gm-Message-State: AOJu0YxXBbNp4RQnKz8OVQepyW2RSKYvEYRpil64jx6m4YvgSX1CSyS0
	K/tU6RCqGFkmo2viKeIBqV9Z2gzHV2T0bzw1zLMtSm4hS6HjJ4saDDkuw6D9Qw==
X-Gm-Gg: Acq92OHg+uTs64EG5pLP4L3+BWsxURlHGMe/erD6Qz7qo+/JmQt0kHIlWZc4S/zH2if
	z5dwlTaf/JZjoC4Hi1h1UNh56B4YJaxkLP5SsT03QH0UKIK1vER7jTw4Bbg63MGR1q3R7foa9oS
	JktAJgeeMmKZENDSDpCGyO4NThbcGVpPIoVI+26A2X/fhZ3Pr+EJyP8mKsYj+ok9v8q/Ga69vsO
	yQOUv2j1pCHRDktRFqowrn4aQTQwa747M3q29W/YiiV5irucSizqUUwdjoN5RNUGFLZbsI173yC
	UupE9cXYHKjt6AYAAwTWg3YIIxKoG2IC7oyNEDPdwmaaj5a1rlq752vD2XGKUw6p+28E91ADVFZ
	fVtnGCPUTbRIct13MuXePX6ST61oNdcpiUVFFu3oeJqUyx5Q1MkT9mUlfv0tbbXVYfKDsXMvbo1
	DNAKZa9Pp3fv3Eso+9XIZ8GBUQdNMbEYjEzLjrfA==
X-Received: by 2002:a05:7300:8622:b0:2c0:c5e4:605f with SMTP id 5a478bee46e88-3074fbd5514mr4139499eec.24.1780593320515;
        Thu, 04 Jun 2026 10:15:20 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm6547414eec.3.2026.06.04.10.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:15:19 -0700 (PDT)
Message-Id: <ba629a3f03d59b6d20f1199ec86c140b0db63308.1780593313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 17:15:10 +0000
Subject: [PATCH 4/6] hash-object --stdin: verify that it works with >4GB/LLP64
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

Just like the `hash-object --literally` code path, the `--stdin` code
path also needs to use `size_t` instead of `unsigned long` to represent
memory sizes, otherwise it would cause problems on platforms using the
LLP64 data model (such as Windows).

To limit the scope of the test case, the object is explicitly not
written to the object store, nor are any filters applied.

The `big` file from the previous test case is reused to save setup time;
To avoid relying on that side effect, it is generated if it does not
exist (e.g. when running via `sh t1007-*.sh --long --run=1,41`).

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1007-hash-object.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 10382a815e..59efee3aff 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -269,4 +269,12 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 	test_cmp expect actual
 '
 
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+		'files over 4GB hash correctly via --stdin' '
+	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	test_oid large5GB >expect &&
+	git hash-object --stdin <big >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

