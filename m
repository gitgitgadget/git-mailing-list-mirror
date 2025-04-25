Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656F218EB4
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609596; cv=none; b=IPqFSqNU7Cg7eCvygWBhHzFFGst+slCzAPM0dt1edhfIHfrUucCpUjKQo/AdHcL9I3IdAhrVzGkXwJBbzw8YebrF8MN2h82t/0Hs98JYGtyvl3cN0Yvlr9GFMsTTATN3rXdWRRH0yZfGrCW/sieHpl4BY3B9YwIrnnTfTSUXqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609596; c=relaxed/simple;
	bh=rKspNOZGOF6mzjS6qp/ub6nCoTopmkghzR6IP3p6I4I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=akAQZSLD87xpQsELUddrQiZv3fA/njC8jm7dljvUuqH7PmJK3FW1YEWHMY1e/iRfzcv4emmsU/VCs4NiUvi/QBsMnuSPjgb2YLx793dn7LpI4TNQ0T933OoA5GbvCgY1fyKPyC3BwShFPFYIjkb/X7E1mKmtqFkdln3NHgQBllM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJsKSKtr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJsKSKtr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so23631785e9.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609593; x=1746214393; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w9gi8XtIeR1ASKoTPMrWsnh8ZDiItl92o1ibqPDMog=;
        b=kJsKSKtrdETy1jzIJfSYdJf0k0H6koMAsiLo3avEOS2nlBD2CFG5ROvoDKI9A5M3nL
         dmVDXCPZg8e91sYUJGZGg3kFHHLGWMFd+RoaKBm3zd1RWb1EMj9+ZkOTTvzrB6WUMTcF
         RISV5vW/Qqj4Hcj7AbwVjSelDmQIQjqdZbvlS+P5misn6QghO+ZoXOacHut0B0w+WQCS
         2B0nZUksS4rjPmLCgIu+lC2EV6uacV8bapoVGIXaC6y9Rvgl10+B4JlwtuVV+WQC3Dsr
         wpznFpNISXVVfq5FcMIEFg1TP0X42qDHFAxAIFP9pgdm2o2MBQZUdIdAx/X4ACfEtsBZ
         939A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609593; x=1746214393;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w9gi8XtIeR1ASKoTPMrWsnh8ZDiItl92o1ibqPDMog=;
        b=OETtUnIDKk09qVGITyRyq+uJj3QIhqo7QrkoSneGWaCHhmXZQJS68e6gBwqaWY3uQA
         nLS0t1k8pRjY3Nqk1MVuAjMQOAwgJDAId4u49IdiiVddUQJH44JyKg1L2TH1T0jdaJcs
         1zFrn5/UOLqr6bABkCfrwfGnc7/xOUj+E9D8XDi/zSbGAJ/7qAmbehQXbb1uSX18ZEG0
         RWorsdxLmGX6+11S1VkAR8FvXDqXLL1dKh93n5rsKSa2+UAm3sPQU8Ij5r8Yhb/Dnz2N
         Xy31iYo9/fVfdmNVEkMd4C55aWpho9SohZDMUdqItqHGw3lqNn5ZwH5dnmhkal19WrgJ
         46IQ==
X-Gm-Message-State: AOJu0YyZCPhEfIVYhrnv0V+pgFYbRXh+kr0UiKfdnfauO9HLi7RwtB8E
	emPHmX55hOn/E1xI5PQDjmZuxrWWoa/DN8tKZtOuSklai2zHkQqTmmYL+g==
X-Gm-Gg: ASbGncuHIFWyZO/ZA0JPWj1sBj/K8qKHL7kZMHZa9grKnViFxhoHZ/e15JJ8BQiWNrC
	hgNKyEyxOYHR6qwXpjh0RpV9VEQxyI2UmQxCB/QKStQBQfl3aewrhT0EgKygWKNY/KoipVeaiOv
	zXn0qlSgZQcucJhDwWiYCmbM4505P6p5tYGp8FTKyrmYa32m4J7DKgUzzjuYk0tllBYzx22QoLB
	8VBfRcJNuKKbFwqMMtKvZCKSVFgvzXtChfEkK6r9cr8pzq1zSqcOn4C1qSVHdNu2kLevEhiURze
	ENAeIVOoqKavON2mMD6ucOzeyyHnnKjjbtzzGyxk2cBs8H4yiBcw
X-Google-Smtp-Source: AGHT+IFAcfon49HzGyeaVcMRyyUfnSvf7XmjZrZn9AZDTnOc2ORQ+aD+P0mt49q0q5ErdfYxQ5D+Zw==
X-Received: by 2002:a05:600c:a402:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-440a6f184cbmr32297645e9.15.1745609592947;
        Fri, 25 Apr 2025 12:33:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbedf4sm3151672f8f.45.2025.04.25.12.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:33:12 -0700 (PDT)
Message-Id: <7f36484e267021bb6d3b088f3c7c8f97e655c7eb.1745609589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v7.git.git.1745609589.gitgitgadget@gmail.com>
References: <pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
	<pull.1897.v7.git.git.1745609589.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 19:33:09 +0000
Subject: [PATCH v7 2/2] bundle-uri: add test for bundle-uri clones with tags
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Toon Claes <toon@iotcl.com>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

The change to the bundle-uri unbundling refspec now includes tags, so this
adds a very, very simple test to make sure that tags in a bundle are
properly added to the cloned repository and will be included in ref
negotiation with the subsequent fetch.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 t/t5558-clone-bundle-uri.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 33a7009e9a2..9b211a626bd 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -107,6 +107,36 @@ test_expect_success 'clone with file:// bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create bundle with tags' '
+	git init clone-from-tags &&
+	(
+		cd clone-from-tags &&
+		git checkout -b base &&
+		git checkout -b topic &&
+
+		test_commit A &&
+		git tag tag-A &&
+		git checkout -b base &&
+		git branch -d topic &&
+		test_commit B &&
+
+		git bundle create ALL.bundle --all &&
+		git bundle verify ALL.bundle
+	)
+'
+
+test_expect_success 'clone with tags bundle' '
+	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
+		clone-from-tags clone-tags-path &&
+
+	git -C clone-from-tags for-each-ref --format="%(refname:lstrip=1)" \
+		>expect &&
+	git -C clone-tags-path for-each-ref --format="%(refname:lstrip=2)" \
+		refs/bundles >actual &&
+
+	test_cmp expect actual
+'
+
 # To get interesting tests for bundle lists, we need to construct a
 # somewhat-interesting commit history.
 #
-- 
gitgitgadget
