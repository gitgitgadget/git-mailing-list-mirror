Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA484125C3
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658318; cv=none; b=rvUqh75AZDDp+FO9a9TSETCqJjmYoPRtKnTbQEY/2l80C8CmnWfgDV1FRkiqg+zdZKS+tBUxjRkK6duQRCSJhI90gVUytcul+zg0yr+tJsuTpree+z7r5lovXEHJHo34dvYbwhoBf+DDE+WzVvnzWbaXjVOmRxgpZiQ/Quciwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658318; c=relaxed/simple;
	bh=5Lgbhcoa1/4GEjM3CIAFFdfrePzVAkkf5qUOn7ky13U=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CLknXMq+yaOyZY77dMyc4idpYvwPmCnfkgxagwCPH8JIHjtj/5DluIyJSHypzG3r42+U27b0HqBgOyjruqKqS6tTmfNYk4CLDyFPz+V8eDMBmK4wn/6ibPOMbMoEWNrXcHSi6GDslxeiofiIQnc3gQKjGVedPDlFJhrcbjUTN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q26/Ai+l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q26/Ai+l"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41276a43dc3so2999145e9.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658315; x=1709263115; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J06St+xabqDt0N/pFzzEVUlB6jdopGfNE6G3xY7sB7U=;
        b=Q26/Ai+lEv4Pn63BsmFJb6oKUHuFHOaj4hmMw0RrQc26m7kKJAkFKnTfH1gHbaK/B+
         mHICd7Bx9V0HIu6d6sjHIZpnDZ4ONekXO5Jy1umouHZ4ozdzdBtVsO4cN86ZiP99RHMt
         teb+Hhld8QaCHoxX3HvJkQT+8W/wv7rhswt775NHi8QARW/2/BEkKAZDXL1anYp9G9HF
         XNe9en6ZFZuRVyrpUcVbvg9oAFKOnmZ7u4Bv99P2cOuFrFa6qWfhiK+dJHW1uPQuabsv
         KxGmDGLtKqYMz3DixLqVlzO9TJs67Nt5KkksI+EVy5/JDknEIk92sRMHvr+UhqMi8L5h
         HHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658315; x=1709263115;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J06St+xabqDt0N/pFzzEVUlB6jdopGfNE6G3xY7sB7U=;
        b=JcCgseQqgmvr1sEG2tr1+dAdyIluMUq3FRhG5nzXPgZr4PQbOkY9fQ4t9y95/lx8dG
         7owoURRL4AX++uedaeVrn2tfUrrMWgqsElsbRl6Qy8xgCbvHIJ367lk+LYz2YHsEyx0k
         NQ0r08rZn/LmZQrrFq1y/jQFYFgfm9Rj+03Otd+GTGlB2geHeJVHJz2ZgrFH4Y8uCjAo
         0xJqReSMQR9C4EaRePzSya0jCBJHxb/DLObGdIdhdQM2StAlzwuxtNB8SuXqbzxsHYt7
         75xplHO/tLkAmL/jqFav6RfPjr7DGn4jhjsjXU6MaLO442evfFQSRYEfOVdjr26/Tqt4
         aPOg==
X-Gm-Message-State: AOJu0YwaYI51GcgMUOT7B3vOf0zHvIY2pBJB4+IHsCoC0Wa6t3P6MsTu
	cNX406TduoS1mjiXS+hK5oeuQSh8CdGecHu8D5RPIER7SUR/mO9O7OMlefVD
X-Google-Smtp-Source: AGHT+IFPJytXS/CWek43jy51fgrfI0lyMkdIMGSaJpyzwnNM5uu+D+daGJJuIewLcu2++EDKTov3Gg==
X-Received: by 2002:a5d:6288:0:b0:33d:9ee9:3c15 with SMTP id k8-20020a5d6288000000b0033d9ee93c15mr528927wru.1.1708658315018;
        Thu, 22 Feb 2024 19:18:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020adfe6c6000000b0033d06dfcf84sm979858wrm.100.2024.02.22.19.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:34 -0800 (PST)
Message-ID: <58b36673e151ad15eb44c9ca1c03cfef51657d11.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:17 +0000
Subject: [PATCH v2 13/16] fsmonitor: trace the new invalidated cache-entry
 count
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Consolidate the directory/non-directory calls to the refresh handler
code.  Log the resulting count of invalidated cache-entries.

The nr_in_cone value will be used in a later commit to decide if
we also need to try to do case-insensitive lookups.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index c16ed5d8758..739ddbf7aca 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -308,16 +308,21 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int len = strlen(name);
 	int pos = index_name_pos(istate, name, len);
+	size_t nr_in_cone;
 
 	trace_printf_key(&trace_fsmonitor,
 			 "fsmonitor_refresh_callback '%s' (pos %d)",
 			 name, pos);
 
-	if (name[len - 1] == '/') {
-		handle_path_with_trailing_slash(istate, name, pos);
-	} else {
-		handle_path_without_trailing_slash(istate, name, pos);
-	}
+	if (name[len - 1] == '/')
+		nr_in_cone = handle_path_with_trailing_slash(istate, name, pos);
+	else
+		nr_in_cone = handle_path_without_trailing_slash(istate, name, pos);
+
+	if (nr_in_cone)
+		trace_printf_key(&trace_fsmonitor,
+				 "fsmonitor_refresh_callback CNT: %d",
+				 (int)nr_in_cone);
 }
 
 /*
-- 
gitgitgadget

