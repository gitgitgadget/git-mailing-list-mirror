Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8451217F3B
	for <git@vger.kernel.org>; Sat, 26 Oct 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729944600; cv=none; b=gYlt3eNbaTwTlpPYUEIH0BHX62kS+X/eCa1ifubUaW7P1AS24wkNaLFdBLHGsH+sVYYLgFhTXK+BBZcHn4PDkkncAWSnV3SGb+DGmTbPV6kwFq3IHEYN18TW1NYOf/+XTt5uxi3LJG1//hmt0xPkV1A1vV9s9w8jR4Rnw8JARUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729944600; c=relaxed/simple;
	bh=2d6AGL4hlOgjryKEqjrnq6s3MxmrazM7x915r0CH0rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFd88G+/WxWFRoC56TxxvzGV4WTmRLowZXgLgIPv9RvHjf/9Rw39M5VlLWM0yZroaqBk7IjsrwAqXdHwitg1OMgwrYvF+6u2jVUiJJNy7VS4x8A9oEK4oAcYo0zxWcpHPG/Skk+W8CEADWTOZ7P+sMUwaYjnkGCuvKSs0RabE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCMwd+d3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCMwd+d3"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so2657562b3a.1
        for <git@vger.kernel.org>; Sat, 26 Oct 2024 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729944598; x=1730549398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+/LM9nE84hGYHBl0ix1MxajFrZkgJVIEW0gd+QoO6Y=;
        b=RCMwd+d3HRsHL8uF0Q5NV3uybFlhQY9Nm1ZvqWMuAcvZpvClmx+ZutXiWqg8bClzJ5
         rBy5DtX89N9Tz1Jtb+GPvMTknATSJK15tGUeKeTcJs22FN53DB3c6i37j7LNc0oKhj5P
         kaSPJgpcnKkNQ24AJqublhLsG3hZGMQkJ8HGe1LkyGLwaHcwe4O2Pj5QFxnIcMR+WKzi
         nJY5f/NZYNlCiuI9FoNDs5IoeWZ+qaaw0RCP10gFtHkhhcGjl5TLyC/Q1v1iKHMvNL5H
         xpkNQ9wdEOW1yxHkhjPyhnI/jfttaFeDe9SDkTWBkpNxkqQnv0nYayadKasSNGgFtHWX
         5+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729944598; x=1730549398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+/LM9nE84hGYHBl0ix1MxajFrZkgJVIEW0gd+QoO6Y=;
        b=QrDN0Y72agnSHV9AIWZNiPH35Muho4UkKm4I53qdhHHqp6YzqpMDucg/K3c892fez/
         ritnAi7KeoVlLqn70Bx1CcJ8Azu/k38qMc+TZvMWNX097WWsvNNKRX6EIUsY8Fl3/0Xl
         3r3OUeb/S7iXRSGyOlOknXJOERZ487IRr314sMhYj5Ad8JA9GlvoINabKPxRtrbSoWsC
         1MRQLTXxcr0wPUQ1pw8pQUgkk4mpHz9nqsxRr9bxn+vChwEpQoqNYwGs3ZNQs1Z7Fl5Y
         0bNKTjT7JS/eHx/EBjhZf8Zu1mtzmuqddJg6MCuemwoLzQx3LElw5D++6Os3r+AkCwws
         zHEA==
X-Forwarded-Encrypted: i=1; AJvYcCV2n0VozYgYJCBOySZ2VhARESRI2X8FVv52zX+VqfwhlY4LnN4pmuWde4sMOb55zDxPZPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJd1GtAcbmIXesNmZbQaowmpXUu815xz1TFwBIbkaVQim0M2Ck
	BO1qv1cu2+z8BYC2hOEi4It8XzW/PT3ODGxtVkDlqK0dW9xR9teSs1aqAYwl
X-Google-Smtp-Source: AGHT+IFou6Fd4f6kGJJxqYCdOXEbFMs0/8hk71fJy8CUZ4zEA3I32QGsXS6mhkzWyygmEZiFf/gASA==
X-Received: by 2002:a05:6a20:a121:b0:1d9:25e2:d908 with SMTP id adf61e73a8af0-1d9889cb97cmr13198059637.25.1729944597981;
        Sat, 26 Oct 2024 05:09:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1008:2f66:58f8:4a21:44e9:ec8d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc86a8b37sm2666284a12.56.2024.10.26.05.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:09:57 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: gitster@pobox.com
Cc: abhijeet.nkt@gmail.com,
	git@vger.kernel.org,
	sandals@crustytoothpaste.net
Subject: [PATCH v3] show-index: fix uninitialized hash function
Date: Sat, 26 Oct 2024 17:39:50 +0530
Message-ID: <20241026120950.72727-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.47.0.107.g34b6ce9b30
In-Reply-To: <xmqqzfqi4oc6.fsf_-_@gitster.g>
References: <xmqqzfqi4oc6.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As stated in the docs, show-index should use SHA1 as the default hash algorithm
when run outsize of a repository.  However, 'the_hash_algo' is currently left
uninitialized if we are not in a repository and no explicit hash function is
specified, causing a crash.  Fix it by falling back to SHA1 when it is found
uninitialized. Also add test that verifies this behaviour.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/show-index.c   | 3 +++
 t/t5300-pack-object.sh | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index f164c01bbe..978ae70470 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -38,6 +38,9 @@ int cmd_show_index(int argc,
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
 
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a..51fed26cc4 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -523,6 +523,10 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+test_expect_success SHA1 'show-index works OK outside a repository' '
+	nongit git show-index <foo.idx
+'
+
 test_expect_success !PTHREADS,!FAIL_PREREQS \
 	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
-- 
2.47.0.107.g34b6ce9b30

