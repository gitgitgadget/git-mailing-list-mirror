Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0FE1AD9F7
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631498; cv=none; b=iMZuW5ZyqA3vj/a0SRPYhb5W+O5kvCRDBnmi9TIQw2hmNullmWrnNrIIfYEC9pbV9ZYJ0a05KO0haxgIpWlHBf8Rhm8NHbGr5yRb43x5HAchAt8Ai/NWllDZp5BSsgxo7Osmhvz+mmOY/psGmEUwMWGw7czjWlFn53LJN19PhGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631498; c=relaxed/simple;
	bh=FT2/uhpEYMwmDDfjuHR3NT4mNjb7wPRkpBEiyynbYaE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lVKln9ak0yIbPmze4zp8KcxYpdcuH2jKQyduao1RPWhV/SfTFkcDBQTqIlJkkM1e5LVPYCDzI5llPI2d6PSbR+yGPEiXO2Wh51Y6gBE9e/4Y1ZxlMZIa1qweZV7u+mdmowSfrm4OVYWrBY/qdLtNo6RvSd4F+5Q2Jai7HhnFdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7m6MLYe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7m6MLYe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso47806945e9.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723631495; x=1724236295; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgNfecXlJmMbkbyK0ir13V6gfcgRCtINP9xYLrOhzmI=;
        b=a7m6MLYepmdUSwYE2WgcroI5hG5AMRQI3Sn8kl0CFZUwOnz9hPcDYEgplxwutNOAHY
         8HUJSGMi9kCxyRsH39Jjt5rp2qky7B9Xnzj49Dg04uJ71sxRji5anDwI0T+Etv71TTB6
         VVpNAlcx+s1JOPW4Qd1JUz6lnUg0lCHXYcVmigaFwu/JdR0fh0OL9aHWW4F6o7IB0AtS
         nvtIf6vWQK6LX4NpA9IaxaJi/dSEjCVNyZBGfq72MHPOoBkkEbf0FR9qXskeSid/ofMn
         Qe307xZpJqbHjf0O1l0wa4/UinDf35R1rT3zwpGASd+QzHhog+epvtX/BLiWDJy3Urbw
         0+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631495; x=1724236295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgNfecXlJmMbkbyK0ir13V6gfcgRCtINP9xYLrOhzmI=;
        b=YS8ItgRFI7hXcZFvOdJKMs0H1vGeSOzdn+Jt/804I0UHpGc1fGEsDS65uEyOOlrIy4
         EjSgYsloiYKHW2s7kg33kbtTDavmFWiU3VY+BexfuRFLfsrbMX6rYI/n9ya6oFXRbo4O
         wcIsK2MQsM3JHDl0UpjS6Kg7D/6oor+niB1zJAvajTEk82IQ+LKew+e94nZKyOi4kViC
         324koAoshC0XLJ5rf3QF6+IZsGvFpPdvpt3YiAnz09imdgnaJzf14nOgfPcprI5x1ZIo
         qjAxsaxcSW9NsrzyzNu6bWB72CdODHETG4Q4nUk6GwWzfjtgmUCo07mWb5M7Ua218Tda
         ip4w==
X-Gm-Message-State: AOJu0YzjW4Ye17P2EDwMm+fOAWOougKmYkEs/HZuLocr0phszGQayHNk
	nIb+b07DOEgaRTNNwkXOq8nayBh8q+dJCVRIHeU7zYEGYQARdpP5mQrK2Q==
X-Google-Smtp-Source: AGHT+IFvSlzZZGh9GO7VFEO+jOhmOOsPN8cO6FR3bVsOqq/dF4mv8NejK7wSDXQwYtpZPWtxhwxjjw==
X-Received: by 2002:a05:600c:4686:b0:428:e140:88c4 with SMTP id 5b1f17b1804b1-429dd26749dmr13690015e9.33.1723631494203;
        Wed, 14 Aug 2024 03:31:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded36051sm15439515e9.24.2024.08.14.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:31:33 -0700 (PDT)
Message-Id: <5240c2a7b328e3d356574a1ab00e2faa8a71d92a.1723631490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
References: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
	<pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Aug 2024 10:31:28 +0000
Subject: [PATCH v3 2/4] commit: add gentle reference lookup method
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
Cc: gitster@pobox.com,
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

The lookup_commit_reference_by_name() method uses lookup_commit_reference()
without an option to use lookup_commit_reference_gently(). Create a gentle
version of the method so it can be used in locations where non-commits may
be found but error messages should be silenced.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit.c | 8 +++++++-
 commit.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 1a479a997c4..ed49be8dce5 100644
--- a/commit.c
+++ b/commit.c
@@ -82,13 +82,19 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
+{
+	return lookup_commit_reference_by_name_gently(name, 0);
+}
+
+struct commit *lookup_commit_reference_by_name_gently(const char *name,
+						      int quiet)
 {
 	struct object_id oid;
 	struct commit *commit;
 
 	if (repo_get_oid_committish(the_repository, name, &oid))
 		return NULL;
-	commit = lookup_commit_reference(the_repository, &oid);
+	commit = lookup_commit_reference_gently(the_repository, &oid, quiet);
 	if (repo_parse_commit(the_repository, commit))
 		return NULL;
 	return commit;
diff --git a/commit.h b/commit.h
index 62fe0d77a70..ef17668cc69 100644
--- a/commit.h
+++ b/commit.h
@@ -81,6 +81,8 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
 					      const struct object_id *oid,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
+struct commit *lookup_commit_reference_by_name_gently(const char *name,
+						      int quiet);
 
 /*
  * Look up object named by "oid", dereference tag as necessary,
-- 
gitgitgadget

