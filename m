Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996933B9D90
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293702; cv=none; b=O1Bl3HjLFgAstVVZdSWZgG2NxJfGlkFNtwiJP8a9RR9nk8AhMGFvwPXSeqgVIOO66xE5iYEWOpe8xXp8fzSBKvQuQIc4qG7GWLjVsi661Wcn5I7jKec8xbgTTMqj9Yztn77+CvLIsEOgkQK4BAvZpzRCAZAUwleyBIqeq1qX8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293702; c=relaxed/simple;
	bh=WNr9eEg+IyMpW432/a/jCWYNRbawqgOuUktDN0+2ge0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYp9Z+oSYXjG7JX1IO9bjWJv2C/ccRLVGCu5hROpsiXjivYN6Z+OyFdmBGPMgkjwAO2tl6P9EMM4cIHf6XaoSnXGSy1PE8CDEVfl3go3111NV9llte9e3NSyAZSmvH9l5kqEJtlIIv7hBGLCp4381mmHVeRRnh3j+7LYhmKwOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOjwvWgE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOjwvWgE"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso13887523a12.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293698; x=1777898498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOsBtamN+8zD1DunJ9qxYXVMqWu3fQrhh4brINVJONI=;
        b=KOjwvWgEVvC70A1yVRyiO4YH5i4WAKHRWIL3XfPhONO33rwMuG2pFotQA1UC8lP+Uc
         ZiYEP2vmH2nZ43NPkdepweWeTBTON1NbXB6YILc4sNoIeaF7KubcPTFAFdh9URQcoroz
         TInl0SmPQdb3Ppa47pLtQy3BANHFYMoVBlQdtGyJBh23jopgk3lbByLvrMSvSV/LAoRz
         JWvXSY7D0IeTGzEmZ4lEu51S47KVZLEG4egYUMMpu+agYoO8C/yHPRgjb85Ehsc2A4tF
         8nbbhAMnYUyYtbNrQHIetct5sqj4I6U9y51i820u9vAOyjTrPgu+6U34rxbn06STaY7B
         yvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293698; x=1777898498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xOsBtamN+8zD1DunJ9qxYXVMqWu3fQrhh4brINVJONI=;
        b=a9atli75E+XPRF1bAH3k8r5Sy3J03p5QjiwfmF8LEbdRB/bE/hSxPyfwTgvwO0TK3R
         BOehZE+lxKIgITVRzz+aLSHxVflhIh7qWoLrVvAXVMx0cZCN0dcvLPqzmcQB0NNUFxwF
         WDMeNlmmzBD7DRDYK4teEV+9a6gOBroxR4kyy7BLN7QcfO0n2blTcMAvvwP1cvs8+byI
         wr2OmypCR6+E7t9eDL8lxcG68n90PC1gmPeoKZuLNkMZMV8Rcq3iqgsgZaC4dHoxBUe1
         o4afh4zYMhzXE7l2NKryZJJtSy2Hwef9KLYMZKCdUVwO2+AgOmmIqcvucLBcw5dtpaU6
         LDyw==
X-Gm-Message-State: AOJu0Yy+DkesRE1R6FJmLrE82JXVouQ1qdNTAYb8ntCxcxu0WDvK9d+l
	75twfA833lsJJ7iNYaOG9+YxcCS6FTjLAF3lVekP9N4MEsKP5Afnkww6K8ZHNA==
X-Gm-Gg: AeBDieuBd4i430SW81sMn4UPw1eLH8/9VAz828pj35M5WOqJmTJfnBj5e6yli1P/9K1
	z2Dd8F/Teoy5q+7yWl3172t9ppJkCqjnVzK1xQBXyZE6gvKnOVJOUMKMLLdmhON+UbItfU+6Lu2
	d3qzG2mZK1Den11Bn/HbiUkyncOcJbKlictbSXAe6eFgKpu7/BAT89nPJ3brxnQCNunZ60RrwEA
	WrKRzdVWSmODLd+2LdJ+JEdDrWOe0zzfs7zHUlF9pgzXRLwoy2CbIHVx+apcA1NpW+p3NOD8FIS
	P+Qw8T2VRkKHhN+inkeeKaUA4JqBAv4FjFqf2vnzWwT89TJ+THjIFp0FqU/qe+Jfi1Iw9faxDGw
	CGz3Y/ZuNonelpBoiAAl8+uNh8nhVqCNDlH2RVw4AJRdr4Mge7MqBuC4N24Yg5LxgO138lzu/6E
	dheyRDWW64slBgAUC55wCL6PA+H6XPN6XA28oI0QO267rKMDRoBQKD2OFR7KDrqQ83nuTZVnsJG
	WGZ3x3au7a6IEBMxQ+o5YY7e1LmlsHcEcZ5cRypcbmOrttZk07oAdGXu56E
X-Received: by 2002:a05:6402:2b98:b0:672:a20b:3781 with SMTP id 4fb4d7f45d1cf-672bfc12952mr18150433a12.0.1777293698363;
        Mon, 27 Apr 2026 05:41:38 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm6760446a12.30.2026.04.27.05.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:41:37 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 8/8] doc: promisor: improve acceptFromServer entry
Date: Mon, 27 Apr 2026 14:41:08 +0200
Message-ID: <20260427124108.3524129-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.19.gb68b9497aa
In-Reply-To: <20260427124108.3524129-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The entry for the `promisor.acceptFromServer` in
"Documentation/config/promisor.adoc" has a number of issues:

- it's not clear if new remotes and URLs can be created,
- it looks like a big block of text,
- it's not easy to see all the options,
- it's not easy to see which option is the default one,
- for "knownName", it says "advertised by the client" instead of
  "advertised by the server",
- it doesn't refer to the new related `acceptFromServerUrl`
  option.

Let's address all these issues by rewording large parts of it
and using bullet points for the different options.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc | 53 ++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index ae1686a6e0..095c1693ac 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -32,24 +32,41 @@ variable is set to "true", and the "name" and "url" fields are always
 advertised regardless of this setting.
 
 promisor.acceptFromServer::
-	If set to "all", a client will accept all the promisor remotes
-	a server might advertise using the "promisor-remote"
-	capability. If set to "knownName" the client will accept
-	promisor remotes which are already configured on the client
-	and have the same name as those advertised by the client. This
-	is not very secure, but could be used in a corporate setup
-	where servers and clients are trusted to not switch name and
-	URLs. If set to "knownUrl", the client will accept promisor
-	remotes which have both the same name and the same URL
-	configured on the client as the name and URL advertised by the
-	server. This is more secure than "all" or "knownName", so it
-	should be used if possible instead of those options. Default
-	is "none", which means no promisor remote advertised by a
-	server will be accepted. By accepting a promisor remote, the
-	client agrees that the server might omit objects that are
-	lazily fetchable from this promisor remote from its responses
-	to "fetch" and "clone" requests from the client. Name and URL
-	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
+	Controls which promisor remotes advertised by a server (using the
+	"promisor-remote" protocol capability) a client will accept. By
+	accepting a promisor remote, the client agrees that the server
+	might omit objects that are lazily fetchable from this promisor
+	remote from its responses to "fetch" and "clone" requests.
++
+Note that this option does not cause new remotes to be automatically
+created in the client's configuration. It only allows remotes which
+are somehow already configured to be trusted for the current
+operation, or their fields to be updated (if `promisor.storeFields` is
+set and the remote already exists locally). To allow Git to
+automatically create and persist new remotes from server
+advertisements, use `promisor.acceptFromServerUrl`.
++
+The available options are:
++
+* `none` (default): No promisor remote advertised by a server will be
+  accepted.
++
+* `knownUrl`: The client will accept promisor remotes that are already
+  configured on the client and have both the same name and the same URL
+  as advertised by the server. This is more secure than `all` or
+  `knownName`, and should be used if possible instead of those options.
++
+* `knownName`: The client will accept promisor remotes that are already
+  configured on the client and have the same name as those advertised
+  by the server. This is not very secure, but could be used in a corporate
+  setup where servers and clients are trusted to not switch names and URLs.
++
+* `all`: The client will accept all the promisor remotes a server might
+  advertise. This is the least secure option and should only be used in
+  fully trusted environments.
++
+Name and URL comparisons are case-sensitive. See linkgit:gitprotocol-v2[5]
+for protocol details.
 
 promisor.acceptFromServerUrl::
 	A glob pattern to specify which server-advertised URLs a
-- 
2.54.0.19.gb68b9497aa

