Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7B30AD0B
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248223; cv=none; b=nfreFHfvJALTWDLqs1XO1rFtfwxG5njagYGvu4FzFEeFEVGlmYSqhgM7NmhMUmaIYhWEN7+houNVsX1WehHI7rUkKIX1u+WZFc1//hnqyCIl8H9iyDSsflP8m1Nx0wpQD/+ydmzJsgar+WyT5B0cSP9Wn6R1yq1idqnWen7Sxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248223; c=relaxed/simple;
	bh=WJmIuVDINaPVXRqB4TzDafsJMOZig0gWUFnRWSj548M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zi9X9w6ExYKWruiaqzHVagK1OECdUgyvxzLqN1rw6QTf8inS/1p9elK7VGY/Z2fR05AuIeVTjxlQ+kBwFRusade/NhXm/leAN5VPfqLV4RULY/bBdMNKffC37MXWmgj6WDsngFUjEB6o4U5qk89b8bLAKcGK2QEAzKjtsPUadds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI59STeC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI59STeC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483487335c2so29858605e9.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248220; x=1771853020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts6Hu99xK6KdIX3MQGGFZbI1C9y61oqSnvkAcccyefk=;
        b=cI59STeCP8b5xBhtyEDL0FFFp9V1qdOQ4E6sUGg7kdEe7MofcKN3wC+d9rUWmzb+3t
         d6FMAO+vm6bERy49tV6XthLnK+mt+jOz51rxbP/q9c/TOf7oH9Dibn7326mKTeX79m4g
         soEzC/PvO924EGdU0LsJeJJ6HziU6WMU83OXu25hOtU8g5w8tRXFTZoPedSyhshU6L47
         oqenu0wjSyWeVjEyNkFB1NpmzneOs7NpZ6KTK9DxXjyo7obG2T8zZMU6xxwafG5akv98
         jMVyifA9iRX9jYRvkguYd69n71hCpX2SqK6Clm9q/2a3h4mVVVwI/jXm5Fghf+UQmFkk
         SJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248220; x=1771853020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ts6Hu99xK6KdIX3MQGGFZbI1C9y61oqSnvkAcccyefk=;
        b=Jh8u6fCXr1W94yMo6+43LU11jIo4TJb14mwhh+UYV/50P9tu3+PJ7C+u8e7iz9MDRF
         kPfHrZ2RuHar+UaU+eE+Jidl+BvNtSP+y7pT+iuBRhdOrTGIxR9Cp3U/NRZfkG2fcj08
         ECFdjpZb97fLihLGiPUl4p2z8HRjjxEyiDJDbdZmRia7A0dfMLjjhDeFeIFpvTjShS0E
         ncs173QcPffGC85UJweYqgBlDtX4aCgxth7uegR65qIMi1Z9Hi3zTEYQo4+XMMcN/4C5
         KFAOhJIZgV+9iJ3ITLcRz4CMmCt3/ekXJxFefTb2puZMwrUKgCH5+tYp0SeL1+wHPvJT
         1oQw==
X-Gm-Message-State: AOJu0YwOGLPjOOIl1xYuCOIk1yw6OEECZslDXP+urZDtm8eyhRtRZlgg
	F+LZwaTR0aR3/jxFz3oKKeSdrebd9CVaMhoVgjbjqKVI0HUu8h3mwlQXM1eo3g==
X-Gm-Gg: AZuq6aL3N8K9lCM8xZg5Gvcv1WCcPHtxP4uX5bcDoNrwsGTMHE/IaD+gjjtYSX7xTH4
	NwZkf/VSrLIsd6OZWEbPnV6qLL1UzKmmgL7ei+9EBgqgbsWkJa31COtO/Nt9hGWVkdRLnfUpYHz
	IBSXx5rpakdNb6BVdtlvMgqWg5QXZY0TXtit5Oi2I0H3sbfzkc1qTaI0EG2cKazVsORNzHNhoxr
	XBkHnLVaNQQXdNNqodPfr69UY4R2+KOZpNFKAIzcdp4stN8PX7zGmSiyBcKPMlG5au9kPAA1jSp
	TV9QEVVBII00HmYwNXcKtc6OOb6VC4TuxZLqmpr+Rwxl4oQuo7zeeJx0WHFg7fp7BN7WqbktRd3
	aVpJb1em3BZ0oGcVKLmjY2Va2GmmY61aNJ4v99ANevcg1Gn9fcny5GG550hVRAaZwqXUIAV2ZRv
	x4I9F2/KO988Q+W3Y6fQHDVOOYu7uUcbFOv06atZi8kI4XDbCWu7VlLhZd+Tbq5W+12XWNJXYP+
	p4JpvKCkJLv74lLZUCjsSfpvXVcLY1EzBHk8yE=
X-Received: by 2002:a05:600c:1f91:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-48373a383fcmr163917495e9.23.1771248219926;
        Mon, 16 Feb 2026 05:23:39 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm235688025e9.5.2026.02.16.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:23:39 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/9] clone: make filter_options local to cmd_clone()
Date: Mon, 16 Feb 2026 14:23:09 +0100
Message-ID: <20260216132317.15894-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260216132317.15894-1-christian.couder@gmail.com>
References: <20260212100843.883623-1-christian.couder@gmail.com>
 <20260216132317.15894-1-christian.couder@gmail.com>
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
index b14a39a687..bb27472020 100644
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
@@ -1624,9 +1626,13 @@ int cmd_clone(int argc,
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
2.53.0.77.g4627d513d6

