Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76101E50B
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910512; cv=none; b=XhoJq6JP2HNhXVZBKKawGRYPmuf8E1SMwckOcV6zAij32se0imHQpJoHXZXnYGG6N/49yFLhlkhHjjSjH39CJHCMFBa0hzWyoONXcZ7qNXWQt6zg6/yo8CyiduPZSpaxka0YkE0DMTVoBfrQG5ZeRQwSjSdqCy9997hw0M6X8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910512; c=relaxed/simple;
	bh=RDNGzbCsU3kCNV4aQC3gpVOyZI4Nw4JcEZrsQEskI5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fzk7RkiCSIySTXDyy0OLxEh3WT94CdCz+I2M00XEyQQGP8KDvB6vtv3al3ReENFWZwyesVkojL6YDky+lVoH/fn2x7dEuLnIYT8BdwvNJ8Sgzfj5MsRsYmE8UGoxZMyfDuFz9jyoDVh0b2A1yP6USSwML6tVy9R9MNgxd53jqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM+o8Rys; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM+o8Rys"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2bcc5c887efso1298895fac.2
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741910509; x=1742515309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j143td9iLc7xHjexTds9sz9Dc0acNzIKSmWUTG6dcY=;
        b=iM+o8Rys8n1xf+C3jj0kWabhpcoIFjO7OmibfuqtVFaBs07uMDPd+w7e4wvIw9ZuC2
         dw68xsKoN7N9be3743mIurcu7qnE/HTpeSAIpiOb4LszzLkU/JZOkd5Wntl0FAxLPsLX
         8vyAxUeDbtZTFUJx0lEtn8DUZOmkvaE1Ra4bmbEtNXt7krvQhy6O0zMnEJjy6kLfOoG1
         5RP6zA/67ZFFH39VMtBORc8aq4yjXHHdDHmYPB7L5Oz89AhxIwZ9ZnXAw5Uv9tgISJeB
         Tfih0rJaepHramIKePrLo0wBMUcKmAJnOgv+1pTKXHIjAt9OcbmIWMdZ0ty4kwdR4Uyy
         WsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910509; x=1742515309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j143td9iLc7xHjexTds9sz9Dc0acNzIKSmWUTG6dcY=;
        b=rbzJ0T+E4bYN/MhJsoyy51gZerPTpz7uyWi7eue4S6LNaO9eDqtLu6GkccDvbNmX9j
         4lRn+03Ijh3R+O8GaaGki/pRTHnsCBMNOs0GSyNtseMGRSwmJqDYHBgblyekVVutU2qz
         ipll+8vr8934OGCN8zUVj601ZbWFz1OYhTKEVc0mKAdTIJdaBxrX9W7+nDrBiowFjLc2
         tUc8F3SRwsknpNXNTYI1QHH39VAoLw8RbhIWYI3QqKvj5LQsfmXeIYg/JvFWSkZKws/w
         yTkvXmChKMaeYzGw4o8u7CNE7AFp7c4w8QevGjy0BpEkjDR/ccXpl8ZMoJvlFlwA7emR
         Mcfw==
X-Gm-Message-State: AOJu0Yys2Z2XrdDxs5MyRD2RqutQCfo5fx9PK4sLdQmhXE/MB190xort
	5/Az7jomgVpc55TrrMWtJ9B2zWDgadOvwxzZfFTwxwbi8ZRk/9T75V1yCw==
X-Gm-Gg: ASbGnctdgKrRoH7KzpGmuh2nCK6IyI1rBtIALzCE75XPqy8KwbKB0seQrlJ8FRfL/IN
	gMjBA3rlsK2H46iUrVFiKQT83yQScwdEs6WqqVr+2p8upCUGNHedqWzolldExIejKUzPXRacmOa
	FKAMLUoceSn16xfAv4hjZxQ0wdO8WkISBNL3fB0UDvtusr04xSBVkE0EtQ5sGEgsCZu7infK2KU
	JI5wxg3j2VAhPs5UDOI7wmKlR6FK//oXpPWsgmJEprYT5tuFa9UhwfCcTFwA25pu4ASfCe6cvgq
	dQ3C2EMMUrvs3y+8K5q25HGLxAsuUlPob+H01OabIThK70RDykmN
X-Google-Smtp-Source: AGHT+IGtqbIjYLifrGc+fB7pYaRzIsm4ej+ppIdOsWhdMTVwKV9teAmnMz9GN8Se880+Ur5dCvNO0Q==
X-Received: by 2002:a05:6870:eca0:b0:2c2:343d:1368 with SMTP id 586e51a60fabf-2c69114d235mr340754fac.29.1741910509327;
        Thu, 13 Mar 2025 17:01:49 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e973sm423485a34.43.2025.03.13.17.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:01:47 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/6] rev-list: support NUL-delimited --boundary option
Date: Thu, 13 Mar 2025 18:57:46 -0500
Message-ID: <20250313235747.9583-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313235747.9583-1-jltobler@gmail.com>
References: <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313235747.9583-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--boundary` option for git-rev-list(1) prints boundary objects
found while performing the object walk in the form:

        $ git rev-list --boundary <rev>
        -<oid> LF

Add support for printing boundary objects in a NUL-delimited format when
the `-z` option is enabled.

        $ git rev-list -z --boundary <rev>
        <oid> NUL boundary=yes NUL

In this mode, instead of prefixing the boundary OID with '-', a separate
`boundary=yes` token/value pair is appended.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc | 12 +++++++-----
 builtin/rev-list.c                  |  9 +++++++--
 t/t6000-rev-list-misc.sh            | 16 ++++++++++++++++
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 14d82fdfbf..92ac31a8e8 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -373,17 +373,19 @@ ifdef::git-rev-list[]
 <OID> NUL [<token>=<value> NUL]...
 -----------------------------------------------------------------------
 +
-Additional object metadata, such as object paths, is printed using the
-`<token>=<value>` form. Token values are printed as-is without any
-encoding/truncation. An OID entry never contains a '=' character and thus
-is used to signal the start of a new object record. Examples:
+Additional object metadata, such as object paths or boundary objects, is
+printed using the `<token>=<value>` form. Token values are printed as-is
+without any encoding/truncation. An OID entry never contains a '=' character
+and thus is used to signal the start of a new object record. Examples:
 +
 -----------------------------------------------------------------------
 <OID> NUL
 <OID> NUL path=<path> NUL
+<OID> NUL boundary=yes NUL
 -----------------------------------------------------------------------
 +
-This mode is only compatible with the `--objects` output option.
+This mode is only compatible with the `--objects` and `--boundary` output
+options.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f048500679..7c6d4b25b0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -240,13 +240,18 @@ static void show_commit(struct commit *commit, void *data)
 		fputs(info->header_prefix, stdout);
 
 	if (revs->include_header) {
-		if (!revs->graph)
+		if (!revs->graph && line_term)
 			fputs(get_revision_mark(revs, commit), stdout);
 		if (revs->abbrev_commit && revs->abbrev)
 			fputs(repo_find_unique_abbrev(the_repository, &commit->object.oid, revs->abbrev),
 			      stdout);
 		else
 			fputs(oid_to_hex(&commit->object.oid), stdout);
+
+		if (!line_term) {
+			if (commit->object.flags & BOUNDARY)
+				printf("%cboundary=yes", info_term);
+		}
 	}
 	if (revs->print_parents) {
 		struct commit_list *parents = commit->parents;
@@ -779,7 +784,7 @@ int cmd_rev_list(int argc,
 		if (revs.graph || revs.verbose_header || show_disk_usage ||
 		    info.show_timestamp || info.header_prefix || bisect_list ||
 		    use_bitmap_index || revs.edge_hint || revs.left_right ||
-		    revs.cherry_mark || arg_missing_action || revs.boundary)
+		    revs.cherry_mark || arg_missing_action)
 			die(_("-z option used with unsupported option"));
 	}
 
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index dfbbc0aee6..349bf5ec3d 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -217,4 +217,20 @@ test_expect_success 'rev-list -z --objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list -z --boundary' '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+
+	oid1=$(git -C repo rev-parse HEAD) &&
+	oid2=$(git -C repo rev-parse HEAD~) &&
+
+	printf "%s\0%s\0boundary=yes\0" "$oid1" "$oid2" >expect &&
+	git -C repo rev-list -z --boundary HEAD~.. >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.49.0.rc2

