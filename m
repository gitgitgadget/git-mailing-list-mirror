Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFB3E9586
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203320; cv=none; b=V0isceFGeHlF48RRxQ+LjsG5OjVH0OfE+HQV5+e1mFVURvom0JtieYjGnw2eHGQGJxtY+96PYLdw8Xc5RpL6aHxN1fNCWhKrySOCV7vhAi6PkIDi+vjv+Fmz6W/SvfjkJzJSdkzTxYzMgHbYQw+2z15e4Ff6FSPB8xYfG/owwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203320; c=relaxed/simple;
	bh=pC7WbLy/+DGiU1pfso2UgGJyI1dftOm/L09AUY4A/NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVMjh9dE8bD0bN4yj52ElFm6aN9cOyVZmH/RqBeCH8ZWr/xQ8WttUv7CA9UnxOsY9GyKZ6T1m40PLMeeeY63U6kJ7/vL9YgDQwYUTggYFjjizTIqSFwZ7sf1AwCf6b0rNsOvvm14ieLXWEPuLEX3bBlIIx1xFpF/yobZuly/OcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X21LViPB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X21LViPB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806f80cac9so37624505e9.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203318; x=1770808118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlimeQxAItQ17Cg1pI8CQyVlmox9zXf/NCEDqJrjErM=;
        b=X21LViPBHn2ra+hbz7ouT10IqfKrd1mQV9clSHIij2sMyugu938REzwjT2sImzg0y8
         UwVmRGy9wQKCxHguxdOY7EKULI2aYf967ZWo3F8CVav5/L/PiDD9zc3pi0hhe+MKil0O
         2WHdIXZcq0mLG2ffn5xS7PZzGbqt4s0koQ/0NOaiq9o4lXB2I/MTvnjyADtcVo4CCnJV
         h+hD08Z27moQGVmfMDSzuiGbK4Fi8KMlc57QNvEACcLe0edoksPLlM2izo4Lw/adVtpc
         P/mh/NCDyH5rtvgVVueZ41QYKPVOKsOc/1OIjMkV42S+rCvxPLrjd3nBblorSnrFTNDd
         0D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203318; x=1770808118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VlimeQxAItQ17Cg1pI8CQyVlmox9zXf/NCEDqJrjErM=;
        b=RL/ZH4g9lu4GH3jDEbotcFi4hGBS++cgn35/+SZqjDW5YkGZnc4J9ozJLX9ZaJgqLm
         2g8ZumJ2SgG+Nsh9TeMAr49Wapu/Df8BHX/j4g56R2pApyFaDrEYNSB9zW8vg9E7vl8/
         FngZDK33WAEJeT/bBkvVjNp64C4LcNQAh5+dFizAxriUPBvNk+33yfXC6YdJM8TOAV5w
         TZRJz/OI2Kx5rVQIJO15LGR1ahAdAFJCVUrg3E0vebBk0OgFcmAhUBI79k1IvHhyVR6M
         xi0V1Sq+q97PQ0B7v7WpC8QXhQV7/9kYn5nFm9Wo3ubkQYBoVEATsJ6y7oV/39A33Ks7
         Y7Sg==
X-Gm-Message-State: AOJu0YxfZbyGhKpDFyv/2ET4bfv/yv7iRc7EihXwmJQfyRxFM7bsJ0W/
	loP803Om0yx/lHOa9vdvB5RbuUNqWq7PrhFSTe2/uHNoyksJDHDB4goR2UEwvA==
X-Gm-Gg: AZuq6aIlvVaW6JKaz12EOMMKuUXLBL1fDXdT/GU34Ix/28CopRGFMAsyNwut9eoZn+J
	oHnDJkdA/MIRyr02//4eIvLh1NYUgi5OlDPF9jgLlp/uPly6bifx96SMQ9GiI/uuW8HaeIj6POm
	mvDL4AmIskRPRv/+WzOEfz4GIJTDITerkCNjuBS0TmEBj+t8aNj76BZN5oeOdYlnuLEUiDHEOuV
	Y2a5g4DYH87WfByZ2S4ZhqxZ3KH46LDD9PHQez6ZGO+aP+u9xa3J3vPy/QUCsMnJbeMOElsboHI
	NGCxLj0mv9DBk0cIbkFeNYGJDo7CWxEYO4JRmmdYuHMgOsV3WOV7Vkk/CQ5Z38a+g/lXljk+XG1
	W04JPaMcr43XTOmWR5yXyi+/h+GkBBhWOiM28yOhY0p+si+VwKTULRJxNU2qgFgFdzEqSyDjj92
	SwrVvArkXM3V1AeAWMDrlw64Jgx1P0rvUMwbfCfnmIIkJoLqunrUCH7A1KaIlbfYVtm0phSfgr9
	uXsXjjfcVl25EFhHGmcfihMF6w=
X-Received: by 2002:a05:600c:c177:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-4830e93c02emr33897995e9.16.1770203318159;
        Wed, 04 Feb 2026 03:08:38 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640f2sm5340096f8f.39.2026.02.04.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:08:37 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/8] clone: make filter_options local to cmd_clone()
Date: Wed,  4 Feb 2026 12:08:08 +0100
Message-ID: <20260204110818.2919273-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.10.g12663a1c75.dirty
In-Reply-To: <20260204110818.2919273-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `struct list_objects_filter_options filter_options` variable used
in "builtin/clone.c" to store the parsed filters specified by
`--filter=<filterspec>` is currently a static variable global to the
file.

As we are going to use it more in a following commit, it could become
a bit less easy to understand how it's managed.

To avoid that, let's make it clear that it's owned by cmd_clone() by
moving its definition into that function and making it non-static.

The only additional change to make this work is to pass it as an
argument to checkout(). So it's a small quite cheap cleanup anyway.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b40cee5968..51f4b5809d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -77,7 +77,6 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
-static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 static int config_filter_submodules = -1;    /* unspecified */
 static int option_remote_submodules;
 
@@ -634,7 +633,9 @@ static int git_sparse_checkout_init(const char *repo)
 	return result;
 }
 
-static int checkout(int submodule_progress, int filter_submodules,
+static int checkout(int submodule_progress,
+		    struct list_objects_filter_options *filter_options,
+		    int filter_submodules,
 		    enum ref_storage_format ref_storage_format)
 {
 	struct object_id oid;
@@ -723,9 +724,9 @@ static int checkout(int submodule_progress, int filter_submodules,
 			strvec_pushf(&cmd.args, "--ref-format=%s",
 				     ref_storage_format_to_name(ref_storage_format));
 
-		if (filter_submodules && filter_options.choice)
+		if (filter_submodules && filter_options->choice)
 			strvec_pushf(&cmd.args, "--filter=%s",
-				     expand_list_objects_filter_spec(&filter_options));
+				     expand_list_objects_filter_spec(filter_options));
 
 		if (option_single_branch >= 0)
 			strvec_push(&cmd.args, option_single_branch ?
@@ -903,6 +904,7 @@ int cmd_clone(int argc,
 	enum transport_family family = TRANSPORT_FAMILY_ALL;
 	struct string_list option_config = STRING_LIST_INIT_DUP;
 	int option_dissociate = 0;
+	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 	int option_filter_submodules = -1; /* unspecified */
 	struct string_list server_options = STRING_LIST_INIT_NODUP;
 	const char *bundle_uri = NULL;
@@ -1625,9 +1627,13 @@ int cmd_clone(int argc,
 		return 1;
 
 	junk_mode = JUNK_LEAVE_REPO;
-	err = checkout(submodule_progress, filter_submodules,
+	err = checkout(submodule_progress,
+		       &filter_options,
+		       filter_submodules,
 		       ref_storage_format);
 
+	list_objects_filter_release(&filter_options);
+
 	string_list_clear(&option_not, 0);
 	string_list_clear(&option_config, 0);
 	string_list_clear(&server_options, 0);
-- 
2.53.0.rc2.10.g12663a1c75.dirty

