Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC615821E
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528496; cv=none; b=XIrj9H9HjcDZw3mFhTmVbXzBc7OiytE57JV+IBm7tis60jeb3b9GCG2o306nWBnMcTw9rK/KfEcrtTJQaj+PlVbMKy3wQbqWDtEazH8N3h7cC0lZq2+12bcb5yY1P5fN2iSdILc+QXUkBMMjTFMjYrv+/t4FrKk902d0zQbixos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528496; c=relaxed/simple;
	bh=4S/eeYa3WSAOASAvQOCp2KZZaz7om+5BeG3DmzjcW/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoGLZYO4tc1jvU4cZYHRK9zyTrLvdjOKFytQ2RcBJjR1Vj0McTO6/5k3Uezx5SYSXa4B+VR1SsPA5W3aFa5+YAoA0RVakHRUoZgQs4KV1av5lLkIbQ7ArZflPJTMTp1AvxCrh90OTVhtXSgI1rMy0tDyCgyp5bMuiXqB4tQME+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBSOTdWs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBSOTdWs"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so2922567a91.3
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720528493; x=1721133293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=PBSOTdWs2yID73egAnIW4/lX7PQpt+YpxMqeiF8uwon4iuszxMBsigwj89vH8cvh80
         CBFqdlZ4e+y4TUH6Y0O8TEKmRJyC9Ldrk0Z7EhZCdGhsDf49NrfVGdA99osr4N48whXV
         K7n1nOb4Nkspz7yeQ13l7tRRQgwvDXzfwM6cOQgmmrh54li6DZENb43xNeSW7/vlfgyp
         OBU8vGy7VV/ENdckzmcDGwZV7R64Tp7gmKZ9nzT/BxYQR4899BEYvksGqR8KpqrKfDCn
         18WmPMVkYJFTRjzEIDt4jkzd6VVX4gcW+du9GM2dGCHjxE0vYjptkgzRgQr3kucMng+I
         XNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528493; x=1721133293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=wsRfTGS4DYOlPMavHLb/uzhW8ijfZbfktCnoY3n6IVRKX+oVeo75wQV2bGgNKeLPKS
         CZe6r5oRB/OF8+j402iaWvvw2cdsdG1WO8TvAG2zDPE98uMN8vzpD8OHtN73K6w1WclK
         iyYdJRltpH4i22IFsOqzVFutDo1jH1JWxUE+MuNiRu+2AQQ9HOU5E8yI+nlbUc4Zjl/C
         Sk1ElOS4FecSO1pzni8u45/mAVdjE2okL+PWnUei0jHe5BsvYA7DSES4hBzoXd9eLksW
         x+cEe32ee4V+S52s6vuHSNl1GnaYA2lpck++Y4MVDRk3+pIIy8Eo6aDrgwnRJ17njI7R
         +Sgw==
X-Gm-Message-State: AOJu0Yx79BX0UV4aGXte+3V0XO2EIr9LxO0+OYg36xI0+xfzl5upYgHy
	ji4UOuQQQpAmPPxByoRffG9+uTLSlBJRX+TrXy2e6BhW+ytBc6gSjGOsWfl+
X-Google-Smtp-Source: AGHT+IFR6gkw6EQeGXn6iI2eyiLCgnGJj4Ki3hJEHAJbUqPsU0JQXMQDrjJZPPIVMCjyP5KzpFxuIQ==
X-Received: by 2002:a05:6a21:680d:b0:1c2:8fd1:a47d with SMTP id adf61e73a8af0-1c29820396amr2528675637.6.1720528493591;
        Tue, 09 Jul 2024 05:34:53 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a122acsm15140035ad.13.2024.07.09.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:34:53 -0700 (PDT)
Date: Tue, 9 Jul 2024 20:34:52 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v9 1/9] fsck: rename "skiplist" to "skip_oids"
Message-ID: <Zo0ubAe__yLH4O3r@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0sQCBqyxX8dJ-f@ArchLinux>

The "skiplist" field in "fsck_options" is related to objects. Because we
are going to introduce ref consistency check, the "skiplist" name is too
general which will make the caller think "skiplist" is related to both
the refs and objects.

It may seem that for both refs and objects, we should provide a general
"skiplist" here. However, the type for "skiplist" is `struct oidset`
which is totally unsuitable for refs.

To avoid above ambiguity, rename "skiplist" to "skip_oids".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 4 ++--
 fsck.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index eea7145470..3f32441492 100644
--- a/fsck.c
+++ b/fsck.c
@@ -205,7 +205,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1,
+			oidset_parse_file(&options->skip_oids, buf + equal + 1,
 					  the_repository->hash_algo);
 			buf += len + 1;
 			continue;
@@ -223,7 +223,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && oid && oidset_contains(&opts->skip_oids, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
diff --git a/fsck.h b/fsck.h
index 6085a384f6..bcfb2e34cd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -136,7 +136,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
+	struct oidset skip_oids;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
@@ -145,7 +145,7 @@ struct fsck_options {
 };
 
 #define FSCK_OPTIONS_DEFAULT { \
-	.skiplist = OIDSET_INIT, \
+	.skip_oids = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
-- 
2.45.2

