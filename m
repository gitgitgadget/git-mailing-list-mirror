Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27EF38DE4
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040564; cv=none; b=Q2spfsbOaES8hHmGUHjqRwg72/IPnGPCc+ptIQooRYrU36v6lzZCA2EFCAjCMPVZmOj+pyzopJfzFC1LU9QqSvXye+3+WjBZKFPMSdQthU11AydCT8vRzyepVD+iMGJFenPaYraGRQJauqX95Irppy6dAwhmoZq5H0TiSkuYqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040564; c=relaxed/simple;
	bh=53vEoIpGL//F3Kpsdo4YaRhmKY17vMioQPw66ojePrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbXtkyAComwdGLuqw/3HFoTk3lh/YiifxPGhzokH2NSeGsBTX3Mxmu5Adkrav5O5Iwx/GJXbGOFlqMnQACCvXOPZ/XQ0io8BWPcFX08A7PvcCY+wK7UWBs4lugKIvbw06zYOiiewFn4+PStX9wSeUsTMAAZDhUvPv1f9DSooUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnfONFvh; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnfONFvh"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so6856932a12.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 23:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712040561; x=1712645361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dShN5lbVlcmIi5FTCG5ExaQwq40xl/azZIHKDfczko4=;
        b=RnfONFvhiuLjbdHTfBgDzub9YMb+Rp6S28OoGB3CeAcz4qunB5zd/FZwIQdwcIK+l6
         IGpyFh/Ilmd086p72gMbDAR2AIg1IGdCZOQc2t6/FykSRrEDcU/h30J+tYiH286z3wiL
         jbEYUyZyrk1xxyxREUnVU3lq8BFA+Erx0bZhrQLjrbzl5fB/n6q/d+3UamTuvjNH0bVI
         Na7PQMeCzR9oefxH+ZG4S9ZqyYG++jbBUeiFdaFaq2+Q7N74NB7vnvQfbYpAFwTinZbf
         EzivNLjG477vOk+b6bn+XMXOQakPsO0ryA+i7QEbOD1g6gGPxFr+vw3wjbDOSrUrmvqR
         My/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040561; x=1712645361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dShN5lbVlcmIi5FTCG5ExaQwq40xl/azZIHKDfczko4=;
        b=TCiYHvB3TURC5dJfhdSXWEzmd1Jl4EnL7i1V/53C6DrwVNxNJoqjTC48ThjPVsff/+
         jhL1XhDpREXeJiuzH0AA0WPkWbgUBjbiOm9WElSsO67jgnVFeP94G6feG7edmGUQqpX7
         bHiRI2NEXZzDaoj0dEUCEhsSWl4lr5zeeXqbgQE+r7htZUdGW1ACVLbsrNlcMQxfXvc3
         DBM3vBE7CoqDyJljXlMnGxEauVihN4CITcbY0up9OQ25XsC+eq5QFPgYvPQ05hPoj/r1
         /6V/F30hqWrzkMeyQrI5mRIQpacfzlVedszBKkkFLpChD1zKfbv5S+0zax1PD9UBb5Z/
         YJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3c0Ate16qvyUNEInH5yLLsQfAdnHd3n3Hza9LXwcxyGn4qdgI+OClACl7ex3BENIpglUnp1IEgV1QBUwlPVIxJIQ4
X-Gm-Message-State: AOJu0Yxx7vBOEwQfH/ENTUCfPkx9Xy7txgGpIVnJXNj21gJlF0gEILzF
	tl4uuOFyqrVREYfVGM78wY30cIaXUOMxbBDR1vofxVwG+tEnNFCe
X-Google-Smtp-Source: AGHT+IEnO7C69WHy86hKDlE9WUnKDoTxZN4SEAV+9jEi2aPXMNJNetwCXsuChuNl+nA/bNYj+2ttsQ==
X-Received: by 2002:a50:935a:0:b0:568:d729:a41a with SMTP id n26-20020a50935a000000b00568d729a41amr7792471eda.9.1712040561085;
        Mon, 01 Apr 2024 23:49:21 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:c3e0:2f8a:1ead:1494])
        by smtp.gmail.com with ESMTPSA id n7-20020a509347000000b0056c24df7a78sm6582774eda.5.2024.04.01.23.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 23:49:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v2 2/2] githooks: use {old,new}-oid instead of {old,new}-value
Date: Tue,  2 Apr 2024 08:49:15 +0200
Message-ID: <20240402064915.191104-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402064915.191104-1-knayak@gitlab.com>
References: <20240401144542.88027-1-knayak@gitlab.com>
 <20240402064915.191104-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Similar to the previous commit, rename {old,new}-value in the 'githooks'
documentation to {old,new}-oid. This improves clarity and also ensures
consistency within the document.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/githooks.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 37f91d5b50..ee9b92c90d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -275,12 +275,12 @@ This hook executes once for the receive operation. It takes no
 arguments, but for each ref to be updated it receives on standard
 input a line of the format:
 
-  <old-value> SP <new-value> SP <ref-name> LF
+  <old-oid> SP <new-oid> SP <ref-name> LF
 
-where `<old-value>` is the old object name stored in the ref,
-`<new-value>` is the new object name to be stored in the ref and
+where `<old-oid>` is the old object name stored in the ref,
+`<new-oid>` is the new object name to be stored in the ref and
 `<ref-name>` is the full name of the ref.
-When creating a new ref, `<old-value>` is the all-zeroes object name.
+When creating a new ref, `<old-oid>` is the all-zeroes object name.
 
 If the hook exits with non-zero status, none of the refs will be
 updated. If the hook exits with zero, updating of individual refs can
@@ -503,13 +503,13 @@ given reference transaction is in:
 For each reference update that was added to the transaction, the hook
 receives on standard input a line of the format:
 
-  <old-value> SP <new-value> SP <ref-name> LF
+  <old-oid> SP <new-oid> SP <ref-name> LF
 
-where `<old-value>` is the old object name passed into the reference
-transaction, `<new-value>` is the new object name to be stored in the
+where `<old-oid>` is the old object name passed into the reference
+transaction, `<new-oid>` is the new object name to be stored in the
 ref and `<ref-name>` is the full name of the ref. When force updating
 the reference regardless of its current value or when the reference is
-to be created anew, `<old-value>` is the all-zeroes object name. To
+to be created anew, `<old-oid>` is the all-zeroes object name. To
 distinguish these cases, you can inspect the current value of
 `<ref-name>` via `git rev-parse`.
 
-- 
2.43.GIT

