Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E77140E30
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054901; cv=none; b=EhY3Upj7Y6BxaAtQC1kQBMmNjePzPkqLmpr4FLQGuP6nbXjtTQuGHM8zT6m9QdGV9Q0HsJR33O25yRwDwhJvRHD/461hcywmXM2lnnk8rP9QqoJeM0YTYudk6vskTiVhLy4KtILJoAiJwL7QfTvvqlpQb5N//pfl2eYL+8LYjN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054901; c=relaxed/simple;
	bh=M7IxCcr23SNXCkMkwP25Vfz59X5Ym2BQSFUlzb+uTP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I3M3iUoiFqNgkmj1ievfNZPaWHJooJP6y1Y5JJvrm5McQcKWOx1ehoKFFQZlXoOWKgnNqA6e8YbqBjtAonG3+JvXL0hoVqEZsnJsV3HEzkuglFTU5Y0oHJXQgY8loLZmyd8e/Zd1lE5HReeEsLNbRMJoMRaPAA2P2AdhMCAQAh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zb2jNegs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zb2jNegs"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6698f11853aso2787247b3.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723054899; x=1723659699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQx7JATapEszW9af8iFYmXhJUq7ciAq8MVv7TpxDIqs=;
        b=Zb2jNegswo6Kh+YdXTQ8Vq+D5nTtXifnSpqCO1UMwPDOvp3J/VPxbkTt0q2/q3XbQF
         3vOs6fJ/U295TJMLXSvfsNSCpDZQAtiWUazg/Dz3dUSsPcs703qkMNaX5qaKJYhariEI
         oBFMMuyIWu20mycuGM7eD43Ibv070ig1RFC3uWetVSNT9eMOod/8sRc2hnLQWD3wqSUR
         oT2UJJIM4BkPBRcQswRby2C4mW0Wdk5JVlfyYoeTuAVjpyOUjfYg5gnOvoMdWjLGTRDg
         v+4DidcN2pUuso2H19monlIxd1KTZcHyDzQs9wQOfzF5b5sXryWz1ULPixj6pgN6kvri
         onjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054899; x=1723659699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQx7JATapEszW9af8iFYmXhJUq7ciAq8MVv7TpxDIqs=;
        b=eHn6H3uiyWyZM6wCnNNGW4WzeKIivK6Y+cJIPZ9IqB37yZk4TxRpHo64orV69XMOdf
         IBrXK9rKtHxvsGXRk1jZQdeQZmqxma21QvCmLQiugUwOsbq+mXoyoRn1z0GonlV/a8J7
         9bBCLvRkXqgA0iwcx94hYglHZZPxhAdJpZd3b8W8bLrs+eT1tVCvoOmBRlsG8qAjyZ6L
         rppliIZHdQmcvciuOQFtJeO8f8Eh5lXedCchIQgVhDBayX1qXPyJDfws9JQq7UxMlgqc
         mubRbOtwEhGAeWOmypoK5GBN6TSBJqXU5nbPWchWAXDmw6SGDWxXzcJMzdooHTj55YoH
         zMmQ==
X-Gm-Message-State: AOJu0Yyrp3HasxuKtBGQr+l0bNGeAq4A0lX0QCccl047kusRs2qOtKfz
	llfrEQDg2flr6nkuWpuzOP0B0/4PkuAM01132nHcTk0VPYU30/1xbwXFYqvoKSmwfx8hUCuzq9f
	xElsXcQvZ55cKmfj7bdKpKA96yGmhTyYqeJbJcfjoCy9UpnKi586h0wBDiTcFO8I4F1b3MjWaMY
	2zZ1bTVkzIvRXyccwpk4VJOCJ4sFu/c1WFcj4t4s8=
X-Google-Smtp-Source: AGHT+IHzHPf1a7iIPiDVNJcGawupvpITxoXNsVnHQ+qh3u0CTkjD8NX5RTpTPaDsY7nv74MFeygaokrwyH15IQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
 (user=steadmon job=sendgmr) by 2002:a05:6902:c01:b0:e05:6e45:84b6 with SMTP
 id 3f1490d57ef6-e0bde3eedeemr35208276.8.1723054898497; Wed, 07 Aug 2024
 11:21:38 -0700 (PDT)
Date: Wed,  7 Aug 2024 11:21:27 -0700
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <5f2e816cf6359725f2a86ce1d08e5e272fba4dac.1723054623.git.steadmon@google.com>
Subject: [RFC PATCH 2/6] repository: add initialize_repo wrapper without pointer
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

Non-C external consumers of libgit.a have to redefine the `repository`
object in their own language if they want to call
initialize_repository() to ensure memory for the object is allocated
correctly. This is not ideal for external consumers that have no need
for the entire `the_repository` object but need to call other functions
from an initialized repository. Therefore, add a friendly
initialize_repository() wrapper without a `the_repository` pointer.

Co-authored-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 repository.c | 9 +++++++++
 repository.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/repository.c b/repository.c
index 9825a30899..15cb9ee735 100644
--- a/repository.c
+++ b/repository.c
@@ -81,6 +81,15 @@ void initialize_repository(struct repository *repo)
 		set_default_hash_algo(repo);
 }
 
+/*
+ * For non-C external consumers of libgit.a that do not need access
+ * to the entire `the_repository` object.
+ */
+void initialize_the_repository(void)
+{
+	initialize_repository(the_repository);
+}
+
 static void expand_base_dir(char **out, const char *in,
 			    const char *base_dir, const char *def_in)
 {
diff --git a/repository.h b/repository.h
index af6ea0a62c..65c9158866 100644
--- a/repository.h
+++ b/repository.h
@@ -227,6 +227,7 @@ void repo_set_compat_hash_algo(struct repository *repo, int compat_algo);
 void repo_set_ref_storage_format(struct repository *repo,
 				 enum ref_storage_format format);
 void initialize_repository(struct repository *repo);
+void initialize_the_repository(void);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog

