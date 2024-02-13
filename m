Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3562168
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857556; cv=none; b=uvpzzCn9KfTFswJBaIL52hRyTxj3K0mxxGaOK10Y0ndac0xPh7Z+L4S4yFL1rLFgs0vqzgNPKv4J0Emu7k4ZAE8whvrSc/hMAmA9aAO4U6lR+T4D6pv1idw3IX6Du6Qg+n5snkwZrHD/6AcGC2yJ8c9s/HgLq4yV+lLKm6AKLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857556; c=relaxed/simple;
	bh=NdFP1QTEezanFkq27c5nWo5Lbjp8wyBfJVlmAKD4FuY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EbOBwdABK8oETs+Gjrsm4zZOgetyLi9WiwtVOBxrTqRW1W1RNClvmZ5H4QLlVEEbEqZGijOtHnofdcavJ51VSYKWojGKORaQPjRFp06rnznjn3CuMm0K7HjvENNsHm0kEaQBAbgSn4ptSmI3WlziJEqeJatc38zP+GHkL73C51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJ3RNlKI; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ3RNlKI"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0e5212559so43700651fa.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857552; x=1708462352; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdWsX3AXrUdArzaGIsxeDy3c9IdmIlzuNZTcXMGxkAk=;
        b=bJ3RNlKIQhLX0qPnK0h/Z++ubIgj9VPWGoUXVOxDXNIiW3Q4+3lNurH4wZ9dAzOGGa
         hM/9U22joZpU8Eb0MikAC/euBw842qQBzOYXzncE0OnDC78FDZ0KeDNr1iuwHFPqjCQQ
         0Tu5FhN1AW/TpegiQAUpw/3XDV9Yg06Udhxq5jDfoOx6a45lgN7VhppYN/sH0NJT7UuE
         Lw5HpgGW2RVhJmgo07AK5Na6BdtV5HGANPDtIn2QKV8jgh6jOZVrZaaqePcM+Sc5s0vq
         tczdvEGMFn4LDxUGFsF5lsZvOU6+RhZJYlncj3KBiZ5AZZQIginyXBvvAPqTWAB6RhD/
         uuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857552; x=1708462352;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdWsX3AXrUdArzaGIsxeDy3c9IdmIlzuNZTcXMGxkAk=;
        b=J+0DtsUAcmY3czury0hoYDzPxLDydqY0FJyxNgvuZbEHtO6VyAdx06fD78Rh9qSTIz
         JAShRrC2Qb9kNpTZokI6JtWVkyf03mwxuTPCu0EJknrXXf0Gp7d2EJdEf4gMQmrRXQIr
         DbY7NOsA09+91fitjalLL/ko8ZLuP6eOzESY3VJllNfjki9WPqNAbQ1PDerbX+8C+ou3
         +OCnqnwYg1NNCjKOi/PFXDPEmhtmEDtJpTN6A5SDiuzWFbPw8ob/ugNb3jyKxZOv+MAT
         o1UpPxGalz5IHp+CXpCXAKsAnE+8GqFiPgfgRXx8Un/YXMcNdKSWngfyxBRNFBIkKyiP
         Z9TQ==
X-Gm-Message-State: AOJu0Yx+UlyvqazU7xfo4FUM+yBJJKKraAPGDbzok38TsShF4s3spDre
	cpyS3RTZmR1H22+tf7TIrbmjsBMw3kVk7YHtI/IW+S79R9hyLPfEQNycfWdf
X-Google-Smtp-Source: AGHT+IHDnvqIodFqItlvtJ9GP6ehxEbW39k38gXgF71i3TAQIAuOKFKuaZmUPUmzVAAhk3JYQNcPFA==
X-Received: by 2002:a2e:3c12:0:b0:2d0:8f01:f4d8 with SMTP id j18-20020a2e3c12000000b002d08f01f4d8mr497360lja.18.1707857551935;
        Tue, 13 Feb 2024 12:52:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0040f0219c371sm12938987wmq.19.2024.02.13.12.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:31 -0800 (PST)
Message-ID: <bf18401f56c8df0432a1ba52ae79f5e68d81cdb9.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:19 +0000
Subject: [PATCH 10/12] fsmonitor: support case-insensitive non-directory
 events
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index cb27bae8aa8..a7847f07a40 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -336,6 +336,36 @@ static int fsmonitor_refresh_callback_unqualified(
 	}
 }
 
+/*
+ * On a case-insensitive FS, use the name-hash to map the case of
+ * the observed path to the canonical case expected by the index.
+ *
+ * The given pathname DOES NOT include the trailing slash.
+ *
+ * Return the number of cache-entries that we invalidated.
+ */
+static int fsmonitor_refresh_callback_unqualified_icase(
+	struct index_state *istate, const char *name, int len)
+{
+	int nr_in_cone;
+
+	/*
+	 * Look for a case-incorrect match for this non-directory
+	 * pathname.
+	 */
+	nr_in_cone = my_callback_name_hash(istate, name, len);
+	if (nr_in_cone)
+		return nr_in_cone;
+
+	/*
+	 * Try the directory name-hash and see if there is a
+	 * case-incorrect directory with this pathanme.
+	 * (len) because we don't have a trailing slash.
+	 */
+	nr_in_cone = my_callback_dir_name_hash(istate, name, len);
+	return nr_in_cone;
+}
+
 /*
  * The daemon can decorate directory events, such as a move or rename,
  * by adding a trailing slash to the observed name.  Use this to
@@ -434,7 +464,9 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 		if (ignore_case && !nr_in_cone)
 			fsmonitor_refresh_callback_slash_icase(istate, name, len);
 	} else {
-		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
+		nr_in_cone = fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
+		if (ignore_case && !nr_in_cone)
+			fsmonitor_refresh_callback_unqualified_icase(istate, name, len);
 	}
 }
 
-- 
gitgitgadget

