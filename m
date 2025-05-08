Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96E4B1E6D
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711528; cv=none; b=oYTa2pNyflPfyGl8rDmPZL5Y/Y9S83feTaMEcxsk/YqqEEpVDRIqfOuI4wsPm0e7TQao6323hSA/yIx0TD6EoOlJ1/ivpE98BWTViPSkIVMtN4+PFm0H6k5fMiuhKAdeCdqs7IO5TdHi0TEZXb+BouhIjdWzh1rJDpPHan7jgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711528; c=relaxed/simple;
	bh=JaX8RIsrCoenoHpmTNADYjqt5Uv8kP/gZNVOfwUSc8s=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VaVb61Yl9t6HdLj3nOmHYAOT9vDFhhVmzcjlf8k/lUcPf4JxWYwfHckEmWZrDWA9X3X8iD2cmzy89adaux5WAgwpRsqlxKpqHCmeSRoN5OPFfLgPNvk8EcpEG7ZjFad+Dq/2akC5IexYXrYrLls5WbiZSYAwBpYGJ0/csZu3X58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQI4cT0O; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQI4cT0O"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so6729055e9.1
        for <git@vger.kernel.org>; Thu, 08 May 2025 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746711523; x=1747316323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pPqr0WWlAcw7VFfJgxWfX3+lEzVONDk74rTQmqYAlXk=;
        b=MQI4cT0OiunbwWWiv4hfRGkJvmngWrwIydLhsIognSUWZv8p+hImRSgiycUfrlMKdw
         byLMEwwNYYXL0cAmjsp3sd6TA/f9BiEVASdVyqgAWXqJt2/agFiraxDerZFrDmgRvh+3
         OJlssXXVzZzhqDL9SSc1aZe1oRi1TB17KBfMfki0Sw0c77O1Qz80kWl93ixrsNoSB2+Y
         eAT0REw0Xp/SMFocQEgErqNzfFCZBLq0OBjAmTnLscWRNL9VP+jSfuJrYP2nIG8DQkCH
         6XSKyzJx/BOJADkKPTjnHhxBAgf1Wn+Y4oxWV0pUUwwk4Cag6TVcIqKkRFdLCNJrYf9u
         z4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746711523; x=1747316323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPqr0WWlAcw7VFfJgxWfX3+lEzVONDk74rTQmqYAlXk=;
        b=l0lY3QGZqCfwk9r2Uin54OYV6xuwk880O3amuLaI+oXkx/3Hd925pgrfmW0GKWtKfz
         c14wMoZpz2wBjVzDlp4DIMobdiog92tdZD91usNduNMBDIVkpql7iLdqygV9Jd3Q4EvQ
         +LtNDyVAMP09TnmQd6yqZjLEO1gU/FoKK8cPpcAyUR1oKcvXPsDpwRMi8GiVrl5n0uo6
         LpfrPbvI5+d5QeVkTPASo+zkWAFAIZaJUYQm/I6TXIOYp5FOehX0XcPDzdkIuCIBwdhv
         hA/xvZMxmh62EUACEClyUESPiDtwSjSfmAAAxKZe3idvwFLTpsqVIXfaJ6lH6x5sGm51
         WKHg==
X-Gm-Message-State: AOJu0YyOr8G/5hWRlVy8mIks5PWioU8X/W7ptQLU86UyMZoMOYwuIs7c
	loiGv4Ag1WOEyuw7dATcx7eiOEulbz1g1hqY5LRYbiCCFn6+XAEmEHotFQ==
X-Gm-Gg: ASbGncv4gXBZ2wkr+h7xWmWcU2YuDcaMuGbjT+ZLNQe2YybkOc3/vrkRVCnAu4PsrpP
	oqKK628UCZqunVLsg4jnnypeQggC3aK4KOiFX9JrRqoxKGa137npxpATBCggBClnHaFKoYBza0D
	EI8XQNWUYNUFepxRyICRjvZ/Jhu+9su4QNrrpZS7jc4qaqGSbwI3nz1bG9t1Vj0dQLJEPByIlN6
	JC+ZaiMQE7eMrlIVc4YxskTPtVTxC0rt7OtM9RUHxFePfiMs9DTyw5Q/QOc3E3jj4NaYPgfNdMi
	kf0d+YAM2Qktv9R8oy4VhTLYE4IK1qOn2fNcmhiflxMIn+hZ4SSI
X-Google-Smtp-Source: AGHT+IFjelJU7HXLzEWfvse4fCEyZAOAU6yNKe3kAXZjUBNA3Tli0sX6Zw3A8/492MfSh6ioFUIQ7w==
X-Received: by 2002:a05:600c:a06:b0:43d:16a0:d98d with SMTP id 5b1f17b1804b1-442d030d73emr34736215e9.15.1746711522721;
        Thu, 08 May 2025 06:38:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bef4sm38817595e9.24.2025.05.08.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:38:42 -0700 (PDT)
Message-Id: <pull.1956.git.git.1746711521614.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 May 2025 13:38:41 +0000
Subject: [PATCH] decode_header: fix pointential memory leak if decode_header
 failed
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored
in dec will leak. Simply add strbuf_release and free(dec) will solve
this problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    decode_header: fix pointential memory leak if decode_header failed
    
    In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored in
    dec will leak. Simply add strbuf_release and free(dec) will solve this
    problem.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1956%2Fbrandb97%2Ffix-mailinfo-decode-header-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1956/brandb97/fix-mailinfo-decode-header-leak-v1
Pull-Request: https://github.com/git/git/pull/1956

 mailinfo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index 7b001fa5dbd..7a54471a481 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -536,8 +536,11 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 			dec = decode_q_segment(&piecebuf, 1);
 			break;
 		}
-		if (convert_to_utf8(mi, dec, charset_q.buf))
+		if (convert_to_utf8(mi, dec, charset_q.buf)) {
+			strbuf_release(dec);
+			free(dec);
 			goto release_return;
+		}
 
 		strbuf_addbuf(&outbuf, dec);
 		strbuf_release(dec);

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
