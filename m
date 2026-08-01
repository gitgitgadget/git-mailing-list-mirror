Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497593B9D9D
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606132; cv=none; b=dbjhuTSUsEMDQx0bNbC+53MG/d6BrJxNS7AQZEZlbpvgc+H1Td9QW+JEQN2LJqsEi3DCYEc0pulRFpCFFFtnB/9l5IxgtZ9o3aa7MHgnj7JYQ6fdwtOUAAQDVnZlP2HQFLqLX4N/Fq9nchCu/TYlGrKB/1oJbFW/mF0GwrEHX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606132; c=relaxed/simple;
	bh=qT9uZ9bIg2CvQ+iwyXGM70W5MJU6uZyEKYxMsRtBstE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6UythlmdajDu6Ps9XVVLeeL1CSZInCnnC7vmbGqeaWYU11CmvjKMG2/wyX1IxnsFxgoa9nFqftQYxzMrfGOTcogzjwxLC7z+ziqktar7b/DpjYcCGkkdxAG0pRe4Q4ClOCBgrQ8Z9YxCwfBYi76CqlbPhlJh5IIXBkRVyPY0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+m9bktp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+m9bktp"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1818684a91.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606131; x=1786210931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QcYJLAAB+eRQU9gsLZEC5WopdoQWDYVSBFp84QoAX6I=;
        b=G+m9bktpXMDP8DTmNuYeL68C9CL5iba/eU2hiy3LURX0nksp3c7ixLup8i2/MSky1N
         ELlW2oNgaACgg1Thue7SS/b0rQMGsooWxpJolOc0rzvnZ+DZ9zLEd/55oq2PxBmms+tE
         QWrzv8u5VG3Gb+J120HlkkZY9awzOUnlK8rjb2gPYwuLx9mr+w5zZv7Y+uS64NAnpIuS
         sebjMA5S3Itw97FknIW8aBHsrc6RmjIH4kERZGLbRSqqyPcbQDUIk+Z+D+FB63wMedbj
         oAw63K9NAJAzx2Huq7/0JK8Jvm4SOZ0No0QQcUrXkoep/1ly/KXZkV1dI0j7xBSK9FzV
         xsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606131; x=1786210931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QcYJLAAB+eRQU9gsLZEC5WopdoQWDYVSBFp84QoAX6I=;
        b=R1mWusqxtic+8Ic+sywFL8C5OuRshiINitJJDwzkwH3sYZ0hZPkWy9RUE/B+/QGBcn
         k/px+6Qiusy2fCzmDbG0oMBTF6kvVmwPo+lQcdPNQFFNDqQOrTb38SSACWamszuRpKHY
         4QDSCa01HfCMYqHFz3VmwAEDON/ZKPptinUACY4D4zYhxN8nC47mWNU8XDFVlGigxzQb
         Q58Q5o3aztungH7Ra6ftXVV8K1ZxOI3wn6kDnAgHBAs6mmCAB+rMSfi3hTvWo5ouMQi1
         umKEExM/ceZ4/zsztI897BjEdWSnTalUmwRW1gX3jGTyrjlyq7kvc/Wc2GAXh0y4BV3P
         KAyg==
X-Gm-Message-State: AOJu0YwZkt7uOwOI9ChyQUY+A+9nDcaTSDMImLqE/sWAJriCcSFUX5NC
	d+7yKE0yEXC8+gu+pWI4tKRBJsC9L9OQMIACzBFO+7gRjOHHZztDHRmCHfo+Cg==
X-Gm-Gg: AR+sD12HbCL26viEDHTNK8KRnLvwu/IlQafhGpM86sFwBF/sbjiBX2S8YDa3UcoukY1
	didyWbjcDP4R217DwofUS8coGCvN+kiEve5DTLomlsIgTsHsxC7Q1Ioj/lmm/HfFm7M37O+Vj9M
	+rn7xei/fa75sRUURfFSMQMy1bNPBmuWIvh1yZVopcZXvhfftg4cAWXL7PilkX+3TTDrRY0Qkus
	dkcRq1kjPVd1BgkBl4lKvgkdPSA2rzd19xlBpO8O2UGSQI05GblThEy/ma3BwcNt4TIMCmNsvzN
	y8SRuoK0bbiTjHNttkfoORcXnNrVH1yfOskg7F+iZjKflmH5HJwH4dZ0r54oaj//ikRpFSNetGF
	hKfhY6m1iNuQUj4fwQyADqn4fk0lKW7jALxEtlrnJ5I/ZNiagzyVlZoA65y0mh34QYBWVbR6HRw
	r66UtBlIU1leDL96Mey8JZWHcpeiU3z4pzSv/ECRsqdsF5AAyUeWh7e9oeQ4bto/W6VCaT66It9
	0dSFJTx43ZV+EaWkeEy+GuJZCw/ga1hGFaHigYVkEgiRpfg3psT7N7n72W/9VjV+bNFFoPb0lTS
	eEUiE/Uw7j1mwK2FPWHMPwWUIQa8SQQqq9JVoihQtmoLKw==
X-Received: by 2002:a17:90b:54c6:b0:38e:9784:dd47 with SMTP id 98e67ed59e1d1-38fb2409b72mr6412821a91.1.1785606130575;
        Sat, 01 Aug 2026 10:42:10 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e70esm34191280eec.29.2026.08.01.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:42:09 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 09/10] userdiff: add diff.<driver>.process config
Date: Sat,  1 Aug 2026 10:41:52 -0700
Message-ID: <20260801174156.2998808-10-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801174156.2998808-1-mmontalbo@gmail.com>
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the process field to struct userdiff_driver and teach the
config parser to populate it from diff.<driver>.process.

The field names a long-running hunk provider process.  Nothing
reads it yet: the consult, the protocol, and the documentation
arrive with the next commit, which starts and pools processes keyed
by this field's command string.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 userdiff.c | 7 +++++++
 userdiff.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index b5412e6bc3..7547874aa2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -509,6 +509,13 @@ int userdiff_config(const char *k, const char *v)
 		drv->algorithm = drv->algorithm_owned;
 		return ret;
 	}
+	if (!strcmp(type, "process")) {
+		int ret;
+		FREE_AND_NULL(drv->process_owned);
+		ret = git_config_string(&drv->process_owned, k, v);
+		drv->process = drv->process_owned;
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 827361b0bc..51c26e0d41 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -31,6 +31,8 @@ struct userdiff_driver {
 	char *textconv_owned;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
+	const char *process;
+	char *process_owned;
 };
 enum userdiff_driver_type {
 	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
-- 
2.54.0

