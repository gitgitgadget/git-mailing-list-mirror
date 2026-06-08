Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B506185B48
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922731; cv=none; b=ntj+59bk3XrNWORGr5F1GPobpHMcpqHWztvs7bpe1xmdlpzU6e8EMXiWV8CSnWGU4oprgEkYVzkMdLmdLtllc5/BEL69Ncj6/MLzG7JXBaacabhurjXeJjvbuIf/oc/BwEVjL6FEu5H4n7ZhpNKJKPHwBPJKGcP65HbI1ExC2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922731; c=relaxed/simple;
	bh=ZkKU8UgWUt0Gc4X6y+pre+wkfYvKO/LGUSR0z4ZKl/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUhI+t2Lzcraz2wSpKZQtgGUvWUZzff6ay/bmUVFnHcGGhw81qsy5RTGC5gXuw32wsX3OORD1twkbD5WdVBUukQnw2SBGN2h0nE8hyOwL3p6uXczrchYOvc46zvwVEVkd1wateC4xkAJS7QxTf6VNJjFRKMbF1ue+v+VcknEh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyQnqDs4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyQnqDs4"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8584e80bd9so1573480a12.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780922730; x=1781527530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuiIei5TDuxp9UY9z6rp+6DDAkMIuAnRXeqY3vuc3os=;
        b=pyQnqDs49xStNaH3rzcfolzoDbL4mtjDzQb2eaOFtqJxDis4hqIZR89ulUQFF5BmjE
         yq9mf0/jbiX6ZswbV1fVdAssMEdmkb2AJih1CFp++oJ6p2ZFpZ2vgNQ8jf2olWATkkNb
         7Z/UHT++uLyxxRT+VjWPAAsosMIMhgR2Z9U1jnF+rmDBF6bnbOR6lyCu9gyiMwoynIjc
         GUXwlwG+wboA1EYVb6Y+JGamM5SBVoNincUB+Ookx7Pljq/X4VYaGFgzXBr/jbX8Wh6D
         Dxfj4CdjIrAIp3at5Sugiev02zRn9pSH+b6qMiD1NmNxNMUyz22K9qEaTUEAwZkfmZhR
         9C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922730; x=1781527530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WuiIei5TDuxp9UY9z6rp+6DDAkMIuAnRXeqY3vuc3os=;
        b=JZebJ4fCMyR+bNSJ6PqqhQ2EC2zzL37q7ndVRxSrTiLOI9NxlHIFiXHribpk/3uF2m
         imNRr0vOEJ6ZUCsOhrTdL8gVRcGw4DQj6XekHi6jec9JXJspxaSDM+bdTG7Zpdl5r1d8
         szsPNPbjGtfxZH7FheWsmEEf5oS5wmBT85W1rSLKYTDZpjcSlyFulv0unx/an6XIrbHn
         l3nmbyxvsTaHN9qUNlu0+cPkbaDNrX7q1w6GK/SKEkl0QQ7vp6IiQpcSYUV8amYkix19
         5Eu2SPHNP+FVHIhOg38XUfXfOjzfZ+CUzUYP9Y+cYeRs2cZBIJRcmk0tsXrcJvhvoMAF
         cW5A==
X-Gm-Message-State: AOJu0Yy1Mi5mXWBLP9kw6KeRrnz34QLEGZpphM787Qd/yNShzaU50LvM
	iDYFEJoz5Hp1pNmcEXbdyifx8H4Y3tOBOoyav9+xr+e7yQpmR9bs2fsTYc45Sg==
X-Gm-Gg: Acq92OEOFPnfjMudgHP/ISYe6rrjPgAgAe907DMi8iwG1O92y4UxHxs35ayrbxg6Wf4
	hwwZI3OX6LL/6ZeSHvB8uvm4r/mWIfPlBv0kXi8PwcClJnj9GyR9yly+TJA5jIOv6Z3HP3dAXhy
	E+42d6lzYWwhb2cvtioEohqFfEKmZuH6R4H9pVQ/xXBeSzhUQRXpuX73HaybnJogWPAf7xfBIwD
	ZkpGp1GQxaHyK1QYfvRxpmNWxoTR8NRfFdS6wBvJenVfR+TwsF8oYxq2JaDIR1ZWtGaP43H3lkW
	RCEcs+mUgT9vnBrFDTde6DsVDyPRtFcfgSyZbRQznXMEEdCS+Plww7YJ9i9rtBxZaj3DYpn8Hw0
	wdkBQIafvIV1j+cUb8r6cNJEz66vaetDtAlByNtRmyG6z5bfMhMEaaN1ogP5ttZRukmtfGFTUlX
	HvuNWEgynV+TGhZqmrNgAPFO1b1jPFZz9VYBLwd4WbiYLY94P2Vjpcrdo3i1wOvTVRPuwrbAGEM
	VhiONPlmPVJauk+N9A9SrtbX68cUrcZYEZXYUPz4Iw94ULcPEi/AyhBIIZSGUNL6+xNLEs=
X-Received: by 2002:a05:6a21:685:b0:3a8:7fb:ca0e with SMTP id adf61e73a8af0-3b4ccf91e30mr19510046637.23.1780922729489;
        Mon, 08 Jun 2026 05:45:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88f9:fb64:9dbf:bc7c:5ff5:b244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a505fsm15932056a12.20.2026.06.08.05.45.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 05:45:28 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	toon@iotcl.com,
	jn.avila@free.fr,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2] parse-options: introduce die_for_missing_opt()
Date: Mon,  8 Jun 2026 18:14:38 +0530
Message-ID: <20260608124438.42922-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
References: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce die_for_missing_opt() to check if a dependent option is
present without its required prerequisite. This provides a centralized
API for simple option dependencies (X requires Y), inspired by and
matching the style of die_for_incompatible_opt{2,3,4}().

Use the new helper in builtin/add.c to replace the manual prerequisite
check for '--pathspec-file-nul' (requires '--pathspec-from-file'). This
case is already exercised by existing tests in t3704-add-pathspec-file.sh
and several other pathspec-file test scripts, ensuring the new helper is
verified without additional test code.

Suggested-by: Christian Couder <christian.couder@gmail.com>
Suggested-by: Jean-Noël AVILA <jn.avila@free.fr>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Changes since v1:
  - Squashed the implementation patch and the caller patch into a single,
    unified patch as suggested by Christian.
  - Renamed the helper function from die_for_require_opt() to
    die_for_missing_opt() to improve clarity.
  - Updated the argument names and logic order to better match the style of
    die_for_incompatible_opt*().
  - Dropped the conversion of the '--ignore-missing' check in builtin/add.c
    to keep this initial iteration strictly focused on a single, clean
    example ('--pathspec-file-nul').

 builtin/add.c   | 4 ++--
 parse-options.c | 7 +++++++
 parse-options.h | 3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c859f66519..505834ad3f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -462,6 +462,8 @@ int cmd_add(int argc,
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
 
+	die_for_missing_opt(pathspec_file_nul, "--pathspec-file-nul",
+			    !!pathspec_from_file, "--pathspec-from-file");
 	if (pathspec_from_file) {
 		if (pathspec.nr)
 			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
@@ -470,8 +472,6 @@ int cmd_add(int argc,
 				    PATHSPEC_PREFER_FULL |
 				    PATHSPEC_SYMLINK_LEADING_PATH,
 				    prefix, pathspec_from_file, pathspec_file_nul);
-	} else if (pathspec_file_nul) {
-		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (require_pathspec && pathspec.nr == 0) {
diff --git a/parse-options.c b/parse-options.c
index a676da86f5..11e40669eb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1558,3 +1558,10 @@ void die_for_incompatible_opt4(int opt1, const char *opt1_name,
 		break;
 	}
 }
+
+void die_for_missing_opt(int dependent_opt, const char *dependent_opt_name,
+			 int required_opt, const char *required_opt_name)
+{
+	if (dependent_opt && !required_opt)
+		die(_("the option '%s' requires '%s'"), dependent_opt_name, required_opt_name);
+}
diff --git a/parse-options.h b/parse-options.h
index 0d1f738f8d..5b41d2fd39 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -460,6 +460,9 @@ static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
 				  0, "");
 }
 
+void die_for_missing_opt(int dependent_opt, const char *dependent_opt_name,
+			 int required_opt, const char *required_opt_name);
+
 /*
  * Use these assertions for callbacks that expect to be called with NONEG and
  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
-- 
2.54.0

