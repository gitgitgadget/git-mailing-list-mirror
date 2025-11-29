Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2D36D50E
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764441193; cv=none; b=MY1Ilr9zWlDfixAS+ablsiJuFRc4u5VjqAoGJexpi8BI7lkhoXxTQUg+PvxM9MF4RzdAcXY0gsuEdtlG8UukNuAcbVYG/Mg1s1MJlmsJLyJ0W6uejQYiHAOFMF5UxWsExhdQVwtA8J2p/qk8vA2l+7QPwygrHjXEblli+4Dhpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764441193; c=relaxed/simple;
	bh=qeh77W5FvtY1H7vNe06MHY21ZdsM2axsorHFNxygkPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCQwyWye2qcksi21o4fLAfV141gmi6OjxUUxC5GYDoEcEwYabuBiInTLS4/e9V9Ov8QkwOvZZwmsn6LuklvxryQqYNQl5iZ6ryzi0pGGwE4uDd6BsB966S+QBF+HmQgo/FItkk+xNC4tq6KrgLJevpRBNqkEZY09/aVXRxFxNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POmmeZLl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POmmeZLl"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2cff817aso206953f8f.0
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764441189; x=1765045989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=328YD6vrrZD1/H0VPAPwIcE+snIo7YymjA9J5ELD/7Q=;
        b=POmmeZLloeVP/x4DR24dCYnbbHgWO5iR4QrAsAB9CRquQr+u/DlbikvpGiZuWMqYQO
         QbB598/bPVWejJTN4umfchGtW9mg+8ZJBzwGd+ybX5j9lpNr2KnOaHston9iLw/ZH9kB
         /MkQrJvNsNh/QGXFWmMQ4u/CopsiH8ZKh5Fr7W6F39SbogQ/RBCEBv8WMFVO+lVETpUe
         dnKtoBKQNQ8Mq5wWawMtKpRel744a0nxGX4UVrA/MeOH8kEk8agT23ziZWCF5u+ldqG8
         DnUxPH9/1pkMpwwGz/DF3Y+rRcNCsZixIta0jAINQyjP3hdmtWTUl2gupCsj6Hf4cBfx
         jxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764441189; x=1765045989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=328YD6vrrZD1/H0VPAPwIcE+snIo7YymjA9J5ELD/7Q=;
        b=bDgfeLSw8hA35BTfr1OKoafUZqnHDgGTsror3gPohIllibU/yAwBw6dfb7v5Q7wgeS
         TyF0AYkCoh9pp1f814Uu4zgmbS6PQ7K4LERoWuy1q4tSH8/qB1lDG6f5k9oUapnGZNax
         W5OswHKxrR34Nx7r86bOKQ5Sbjfp83aeo8eysVeWFH0fpTaHL2pWGWonObyyMYWlWE4D
         oULiTSE3X5UZr1OKm2J+pthO5rq7XB7EREA5CowaNHWl9EcsNiC+WdQCe+V2tAgYW0zF
         QDbcBux41yW4vh0vTv9Ba0F6qBynDBEV9C8JPRKhewBL99HABjAHaVvRs8GJUAoq5uFI
         qBRA==
X-Gm-Message-State: AOJu0Yy/D59gpn/9jydBCFMb816D/iDbucHGmVFInxb6DWRzFPNlZ3aL
	bjGb6Vjf7/cMgxOZgwi5Z1zdAvAl5Ak+EgSRH4XOCUU+iR84ss2rausmBEufKVTt3kmxlA==
X-Gm-Gg: ASbGncvhkog3Hh/NmYL1JlUFud1WjXmllpuQkWQjB6D+KF8IWh4jwFyTiyOg4YzfP1c
	N9ZT1TVtNgY4toVIV1ZOBc3OhARVqmM5ATJHQOK9BxKZGVGbUG+Wz+eMxJ+jewKze64FRBWJIAg
	jxduDNyL2urbG50huxHixfs/pc5cKg72ZzoEFdriANkjAYsirASgdeqM6OFMDZlj5aquweXLxRH
	m1xekf+6pRMllNehTMzL5sHE3ZYOEZ0OZ2xdRo5tu4a5jitbQQ1NzoZySyu18qiICyCgvsFYzHJ
	dufUPewYaZt5wlOIwgnYacbkKZqANMZcKJpOomyR6H1qqUZsAZSkPbeKD9DextI+ndaxHXkW7Fq
	BphtO/V1qySgsSyjdmkbFeT26V6QxPqJwgakB3G+rhgO0QbfG7yi3w0CZUHUGF3JV3jqkn3IyMJ
	6hwYnK5zvFM3dAwwSuOE4yZN2X
X-Google-Smtp-Source: AGHT+IEj0ymvaJLaARW/F4gNK0cG77zbG5K0UWWtq2V9+efK6oVRePpLCq+Id/mibY3dThWUnDpfag==
X-Received: by 2002:a05:600c:3553:b0:477:563a:fc9c with SMTP id 5b1f17b1804b1-477c0169f34mr187561355e9.1.1764441189366;
        Sat, 29 Nov 2025 10:33:09 -0800 (PST)
Received: from desktop ([194.127.199.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052def4bsm115298835e9.13.2025.11.29.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:33:08 -0800 (PST)
Date: Sat, 29 Nov 2025 18:33:07 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 1/2] scalar: add comments when setting config
Message-ID: <20251129183236.52760-2-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.52.0
References: <20251129183236.52760-1-matthewhughes934@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129183236.52760-1-matthewhughes934@gmail.com>

This is to help users understand that a change in the config was made by
`scalar` (and not e.g. manually by themselves at some point in the
past).

As discussed on a thread[1].

Link: https://lore.kernel.org/git/aMkVqNbdgxqBJ9K4@pks.im/ [1]
Co-authored-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
---
 scalar.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scalar.c b/scalar.c
index f754311627..4bdf8cf121 100644
--- a/scalar.c
+++ b/scalar.c
@@ -19,6 +19,7 @@
 #include "help.h"
 #include "setup.h"
 #include "trace2.h"
+#include "path.h"
 
 static void setup_enlistment_directory(int argc, const char **argv,
 				       const char * const *usagestr,
@@ -102,8 +103,11 @@ static int set_scalar_config(const struct scalar_config *config, int reconfigure
 
 	if ((reconfigure && config->overwrite_on_reconfigure) ||
 	    repo_config_get_string(the_repository, config->key, &value)) {
+		char *cfg_file = repo_git_path(the_repository, "config");
+		const char *comment = " # set by git-scalar";
 		trace2_data_string("scalar", the_repository, config->key, "created");
-		res = repo_config_set_gently(the_repository, config->key, config->value);
+		res = repo_config_set_in_file_gently(the_repository, cfg_file, config->key, comment, config->value);
+		free(cfg_file);
 	} else {
 		trace2_data_string("scalar", the_repository, config->key, "exists");
 		res = 0;
-- 
2.52.0

