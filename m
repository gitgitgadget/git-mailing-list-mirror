Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725AD193402
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275034; cv=none; b=Ijf7I4J49Nvl0GQp9YdKQ5g9Bm57o0hmDTu3RngJnAWOh4Xjy/VWmmynW+WeJh75ChI1vWY/+0FdfHjqGFcuLFsE1lILrJcaiBtleFLVChfu5qJM3XbRDYEQ1k+sttLWQcUVb7WmuBWrV9YcBC3CooALDVPN+IrAXq6iI47kSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275034; c=relaxed/simple;
	bh=STaUOWQ2i/CgD5S7sora6VooYKkahjHGiGPxIVfg+6s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N2FYn4RDH/lQR4xlulHYQDkW+Ul+JpfzcIMjVn/0P0KzWDxpQ2yk9q5JhCmy1smmMZpoAWk8s/V7V3OB6NzorC00beC0EkXtJb9HvSrDrvfHj9s6C0Af//rSYmwGDq5gSSI2bIaymIxVYb6+B+IZ6kHbIc0atGvoIk6BxC2rqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll1p07yE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll1p07yE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e535d16180so1013508a12.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 07:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741275030; x=1741879830; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6a1DZ+FbWOXH4tpunWj51o/sNvmbx2sScxaxmKgG3KM=;
        b=ll1p07yE4QA5+SjVspItgQ6dycSxrJe0HWzq6q0IlgeJg9fJORsx6UV88S6MNF3bFp
         AaW+8u9pArMPByuuOYV2HKgOgMYAviPPI2SWn1fTpziAob4qroqSFOG9RkAQktaLkju+
         1OiHPQhdhk7TYSCz9Tiqz9Jfnh8LAGcypcfvzI33OBeWI4vmTaAKlkwEBr+lMBRpC5nL
         jG78aIKxOhtac5ziLBn4Wzv6fhIOcOFwK1G2zqySASWYMY0Q0FfIluem8/ALSGhUKwJe
         VbqiaUhy97gZ0NHFJKoOPjGK5AiWcYJFoR0c7qrUHIffVWwDPNip/17Aaqgh9QnWSSqa
         M8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275030; x=1741879830;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a1DZ+FbWOXH4tpunWj51o/sNvmbx2sScxaxmKgG3KM=;
        b=jIWp6qEZ+cX18c5gidhpDQz/39DkrNE5in6BIJ34EqT3sd6eUBAMgU9DkRMqNs4ggc
         JFN/T0oCPzUsOYPkDnX5J0trDClUOasPzYeGste8LlIej4uJH732RUYlCkYxdUJwRJ2M
         flTyhq+7Mdqh2sVwq77prmVEFZTJOy4vhH17qZawCzN1qiWeyiozKXJiNQqP1Xv1MKP+
         AkCBQdj5Ck9BKTcmUMxwSUX8JGXqQb8PSk5Canczi1HU92ewbHpp304v0EWagAYnbOXu
         uc0aaFzZTfxxwJ5vj7+puBlIWt4XRcBFEL6OdhpW95tGwHvyj/g8dZS5jXWBbpXJD1Du
         A+iw==
X-Gm-Message-State: AOJu0YwJ9U8lufwh+hU+TPTK5JFNu/arl8DyR9j39iJOIxpEOxz6o5O5
	1CJqk8p7mk9oEudKjrJU519oo3jywbgckyi8fTLVynjs2sEbQzHya0Mwvw==
X-Gm-Gg: ASbGncv7MsagD9mK2f5dNkVdTk8H/GM9lQOi9oKvJE2bgEK8zWSXEiImMuP8hpBhcoM
	XrlOT9XUaC+aTVqxTJS8eKYjE/7dUMisUFMbZeYYxDMSarpLCbd80G6L12Qh6pXiLK3KZhKVOr4
	8jQSwvcPA0t1EAdHmREUBOHCaWtYyQQfI1Vp49XbaIIeW4UnEUVDBwtLDHEvoKfvdJl2V6BcgO3
	6lPjqAMwb1hwo3McUrZgcVo0v9EhBvZWY6rKCkxWJwFdnMiYLQ+ToDSMhOuxoGyHpmxhMSH4YOg
	vb6Ss/im80C5O1/NJWVot9eIjB+gYovrsQYG/8263qKV7g==
X-Google-Smtp-Source: AGHT+IFvoMnSbafMgp45ZkxcnoizgAghMpQ1mcQPgxnYSf1Pmwg1xyuX3atyDO/hxBdFtQa6lOh6zw==
X-Received: by 2002:a05:6402:4409:b0:5e0:8c55:50d with SMTP id 4fb4d7f45d1cf-5e59f3e84f1mr17269749a12.14.1741275030168;
        Thu, 06 Mar 2025 07:30:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239485558sm113682666b.60.2025.03.06.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:30:29 -0800 (PST)
Message-Id: <f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 15:30:27 +0000
Subject: [PATCH 2/2] merge-ort: fix slightly overzealous assertion for
 rename-to-self
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
Cc: Dmitry Goncharov <dgoncharov@users.sf.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

merge-ort has a number of sanity checks on the file it is processing in
process_renames().  One of these sanity checks was slightly overzealous
because it indirectly assumed that a renamed file always ended up at a
different path than where it started.  That is normally an entirely fair
assumption, but directory rename detection can make things interesting.

As a quick refresher, if one side of history renames directory A/ -> B/,
and the other side of history adds new files to A/, then directory
rename detection notices and suggests moving those new files to B/.  A
similar thing is done for paths renamed into A/, causing them to be
transitively renamed into B/.  But, if the file originally came from B/,
then this can end up causing a file to be renamed back to itself.

It turns out the rest of the code following this assertion handled the
case fine; the assertion was just an extra sanity check, not a rigid
precondition.  Therefore, simply adjust the assertion to pass under this
special case as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         | 3 ++-
 t/t6423-merge-rename-directories.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 46e78c3ffa6..b0ff2236af0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3048,7 +3048,8 @@ static int process_renames(struct merge_options *opt,
 			}
 		}
 
-		assert(source_deleted || oldinfo->filemask & old_sidemask);
+		assert(source_deleted || oldinfo->filemask & old_sidemask ||
+		       !strcmp(pair->one->path, pair->two->path));
 
 		/* Need to check for special types of rename conflicts... */
 		if (collision && !source_deleted) {
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 259ee9628e4..9cbd41d3c69 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5388,7 +5388,7 @@ test_setup_12n () {
 	)
 }
 
-test_expect_failure '12n: Directory rename transitively makes rename back to self' '
+test_expect_success '12n: Directory rename transitively makes rename back to self' '
 	test_setup_12n &&
 	(
 		cd 12n &&
-- 
gitgitgadget
