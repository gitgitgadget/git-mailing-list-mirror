Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C213CCE1
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhKLaL9C"
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA01E8
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:52 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9c687f83a2so62357276.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697744391; x=1698349191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rup1w+DXVFmdQqXBRU+RjsWXvyUo9UCqcLXgchIh6KQ=;
        b=HhKLaL9C/TdOfPmzzC4tnohapLyLugj/b9b60tTnI9ZmsRNdQATVVYNVi5QksxZI9Z
         MhlMZYrUjSQVieMwH4r9NWKpb/pYAzvrRdmwkE2nmTM+OJ1uAoBgyAUtlBYhR3CPQVji
         obq+wOfYvaL3mQm+kBg6FiVlvU1fv+dOW5jyDJp0ALXiIGOiPBHtBIwqsz3ViQbOx8jE
         BzSiGTgfgL12SRAII2T5Rhdd76c8K93EruFCXQtquF9QlG7UQs4JhUhMzVaPCSCoFxah
         vY3hWcupQiRPzj97gZGo0HGFXaLSfQyH7ABgX8qjtSlgE6QSo5soJC7my9L8WiXCz9Hd
         //TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744391; x=1698349191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rup1w+DXVFmdQqXBRU+RjsWXvyUo9UCqcLXgchIh6KQ=;
        b=H0gp3o6P/WscmgMHa+S7MSMBi4hV42GiZoEUE/FYnnnUm/8L9GK6Be/IJgj3mvu8OO
         JgrCXS+tUgD6m7ZT2Nt5JJOq6pPGiYT3eyk7e3yuEsdEdKnCtyD4jyYsTEpPcZxuH8Aw
         KFeTr91Pdzmcc7G6eVRYz2kps5MMD5RTUTHLZXHyivCnlOiL9/Gt3lpQIJ/DDN793/NC
         ShQmAYRDK6Cc4rm6lwtyYafrjgyHwZMSpsoUi/O8ZlBVJ8RJaExDEU5JJrEO+03T7IYc
         8L3cMBTqAOsQ7nABTmbYIDekgUQbfZsbGz8jrIF/ixJlokSC2AF03cBPIGrLjt4Gg+xK
         SyOw==
X-Gm-Message-State: AOJu0Yy8G93OwvSd47N42kNEi3wWwi62yHIKnko280h9OipB6ooQw6kH
	dfnWx4ubveCbZtUnvzVVAdzDIXpr3vM=
X-Google-Smtp-Source: AGHT+IEI4KAzofRFXU1YgNt5IvQ/u5lND4ME0M3blq4I6f5ycoaRoAbz1KH8oHEOkqfvsgR+Uw+odg==
X-Received: by 2002:a05:6902:ca:b0:d9a:da03:e72a with SMTP id i10-20020a05690200ca00b00d9ada03e72amr3242733ybs.18.1697744391696;
        Thu, 19 Oct 2023 12:39:51 -0700 (PDT)
Received: from u.ad.analog.com (cpc99472-lich12-2-0-cust1752.3-2.cable.virginm.net. [80.2.214.217])
        by smtp.gmail.com with ESMTPSA id ph5-20020a0562144a4500b0066d0ab215b5sm99940qvb.13.2023.10.19.12.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:39:51 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 6/7] refs: exempt pseudoref patterns from prefixing
Date: Thu, 19 Oct 2023 20:39:10 +0100
Message-ID: <20231019193911.1669705-7-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231003205442.22963-1-andy.koppe@gmail.com>
References: <20231003205442.22963-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In normalize_glob_ref(), don't prefix patterns that look like pseudorefs
with "refs/". This is in preparation for showing pseudorefs such as
ORIG_HEAD in log decorations, as they are not matched as intended in
decoration filters otherwise.

Use existing function is_pseudoref_syntax() to do this, declaring it in
refs.h to make it available to normalize_glob_ref() and anything else
that might need it. As the function returns true for HEAD as well, the
special case for that is no longer needed.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 refs.c | 8 ++------
 refs.h | 2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index b03cccab909..492b9f7d4e5 100644
--- a/refs.c
+++ b/refs.c
@@ -564,12 +564,8 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	if (prefix)
 		strbuf_addstr(&normalized_pattern, prefix);
 	else if (!starts_with(pattern, "refs/") &&
-		   strcmp(pattern, "HEAD"))
+		 !is_pseudoref_syntax(pattern))
 		strbuf_addstr(&normalized_pattern, "refs/");
-	/*
-	 * NEEDSWORK: Special case other symrefs such as REBASE_HEAD,
-	 * MERGE_HEAD, etc.
-	 */
 
 	strbuf_addstr(&normalized_pattern, pattern);
 	strbuf_strip_suffix(&normalized_pattern, "/");
@@ -840,7 +836,7 @@ int is_per_worktree_ref(const char *refname)
 	       starts_with(refname, "refs/rewritten/");
 }
 
-static int is_pseudoref_syntax(const char *refname)
+int is_pseudoref_syntax(const char *refname)
 {
 	const char *c;
 
diff --git a/refs.h b/refs.h
index 82aecd37a2b..b77691d787a 100644
--- a/refs.h
+++ b/refs.h
@@ -123,6 +123,8 @@ int should_autocreate_reflog(const char *refname);
 
 int is_branch(const char *refname);
 
+int is_pseudoref_syntax(const char *refname);
+
 int refs_init_db(struct strbuf *err);
 
 /*
-- 
2.42.GIT

