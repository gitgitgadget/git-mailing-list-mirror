Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC203358AE
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109026; cv=none; b=aeaLvMuQ/6uedzjcBCCeULzx+EY/VeiAuCFDx4VWWukf9522eN1qD8KfUncpUJ2aHqfBrMAIzdUm+uKff3hkkwLEUO0nXgVCH03yO6aykupfVzjAJ3h0Bgb38NaXtJ0/c6nOOiDL1C6jnVmebZljpZQ69ZsUAqiIfueLgmhrvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109026; c=relaxed/simple;
	bh=ghxX0B+xOCNfwfhW7er1yPCTWcwX0scA79qUXyUEY3U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QbMG0pmhKgkwXmX16ACy91vY1TuJpvfWD57p4ElFYogdJrrlRT3pCAwJDYle3uVj7jp4ZFJL2vnMgMHLzV2HMUSKsyTLFgvir4rS/s0eopEOnW8AW8HRiBWSjIP1vXmYCjYBxcmjPwjia2r10t7T3DUpLOR7kMZxLSIPwfYGVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGHWIApt; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGHWIApt"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d743ba241aso1210209a34.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 19:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773109024; x=1773713824; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvMkMMgeNyey+a5AkbQS3657OzHDAXuLsOim2UZPRGo=;
        b=MGHWIAptPQvbZVCHMGoLk1pPgDSfu61qeF11eKmvgSGe1l6L3a39oVptw3jLJqmNlF
         j/9GpQ6PLEk+tOkj9SGU7HxvhnTnE5iinvkjqTlaluSFDjhmPuTSp5Cd9jjNtLfZgBtq
         kvNCwKVsdMJ6mSPoTYv0n1f3mrpksq6zN1sO/NufxArYjWYhPBKOlwyafB4Ru5tPXeWh
         wf6CyysaT943f4QA3PxgW146H5a3TjLET76Gouq5ylVvwK2W6TNiT3FuvTkj9JIsZt2o
         e2J4ymG96Po6I+lq/KUJ/nRv4gcp84ZAb3xVLVnhnlkiUe+f+1aeSPQEg0hq33kTDTOE
         TTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773109024; x=1773713824;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jvMkMMgeNyey+a5AkbQS3657OzHDAXuLsOim2UZPRGo=;
        b=pD8NkPyZFetfbOfMyGIlbwSXMRHrTEYiOQ9dXt0Ox0vdrXdJYNrCniYQZfs0kibg0b
         wToOpebhGUGZMaPKri5pyUC16VZDPA18BURxZYZwPM8F/t2iuXjDcvyh7Ck9zX8uCPIy
         0HJBrhKBM4B2uNiqq70yI9bp1rie73sxqIl0ZLhypea4g1kQt7qKbyTE4rwGeBHjPurI
         CCaeIOrbH/OWkRLjzWxUcgHFn5CxUA0h+7OJSz0Qz4jQ06u4HpqQbaJkclV/uPCl8hza
         HOVesXyWTfG0/7HQw1VJp9ZwfUveLAxIA3ll2B+tS7MGlPbDCF6kYl8IJSLHba4jySZ2
         S7nw==
X-Gm-Message-State: AOJu0YykOvlBJw7BqNR/2e1tev6b9ggscbB/BoG/WWTpZ5TcGSFbbFFT
	jy6a6MkwgrAO3t3Q4hQSvMR6wFUw9HT4YI3PMd1RRK2hTvXGpoRgstBD7OqtzEyv
X-Gm-Gg: ATEYQzwAvqd2QuiPPZyWRLSS8Na5gO5tXVCQHAdQUD+PkJdPz2UN4TDxlRJGwsqn5cV
	naOEfqMWh5SB61CByoLrhoI8fpSFJkoRsEtEkUHeOQ2nM98dDAmFCo4tSpmHRYbfbEOHe0Rm+5w
	lTdh7E6ft84cNFCB3w9wtjUorMPAeNhaSm3Lco+7UiMh6FUKODYPRi/NmaMfg4QJyV3PpM+XqkD
	X2q6QA6osqc2k4IRqeAl/rUY/MMLCWe7WozDpgLpVgezyEJiV3zcbBvgoSjUiMk7e0q9jlPrA+h
	uJGdf15Oc0OLwQz17Wcbf8VjO2CisQnqo/0WSd/zO4/J1RvJaNWdk8J7+7+g57vOe3eiBp4Ni4H
	HyowoUmmghJSD3S8tCcOOqQOMNXTOIrxuXBIZdrSUVmPT0Kv8WPBkaj8TcHF+WqLu/XyQxGo2Cg
	Klqx1W6QqfkNhdQhbBdWGiH9HX
X-Received: by 2002:a05:6830:6a13:b0:7d7:5b78:ef31 with SMTP id 46e09a7af769-7d75b78fba4mr1008587a34.12.1773109023881;
        Mon, 09 Mar 2026 19:17:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.230.164.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d738e3f421sm5978621a34.25.2026.03.09.19.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:17:03 -0700 (PDT)
Message-Id: <4adf6d4dca90e2c7f780d594a533c21247c459b8.1773109018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2062.git.1773109018.gitgitgadget@gmail.com>
References: <pull.2062.git.1773109018.gitgitgadget@gmail.com>
From: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 02:16:58 +0000
Subject: [PATCH 2/2] repo: remove redundant variable shadow in
 stats_table_print_structure
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
Cc: Mansi Singh <mansimaanu8627@gmail.com>,
    Mansi Singh <mansimaanu8627@gmail.com>

From: Mansi Singh <mansimaanu8627@gmail.com>

In stats_table_print_structure(), the variable 'entry' is declared
at the top of the loop body and assigned from item->util. Inside
the 'if (entry)' block, the same variable is redeclared and assigned
identically, shadowing the outer declaration unnecessarily.

Remove the inner redeclaration since the outer 'entry' is already
available and non-NULL at that point.

Signed-off-by: Mansi Singh <mansimaanu8627@gmail.com>
---
 builtin/repo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..5540bd25d2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -412,7 +412,6 @@ static void stats_table_print_structure(const struct stats_table *table)
 		const char *unit = "";
 
 		if (entry) {
-			struct stats_table_entry *entry = item->util;
 			value = entry->value;
 			if (entry->unit)
 				unit = entry->unit;
-- 
gitgitgadget
