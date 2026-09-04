Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833148B368
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525881; cv=none; b=jfoFMDMb62TsLMft9av6h5hHrKBTfQ7R5k0c+ghluO8NGBPwz+z6BV92oTOWWl5Ia3MjqtTpVsekKt9cEByD/H8shkLCaSl6i4lGrSXXRAzL+k/Rx/Uf78elTgcsdApu62YwGMZHH5vMKyzoNE/un35arHX/Uz7D5Wn/AM685C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525881; c=relaxed/simple;
	bh=WPlGCH64s6FdysP4gx9JcNlQLVxWWnflwY5+cXYiT6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkpjuGLWIG0tYkhYoKCn494jVOVhpLYz7Lb9qPGuhaoOUaQpgAzQCoDDbmuHYCkePw+0NpwACow16jddJOgfcyvmsDhU3qeAcNCsvo+JN8j/YtymMwfshWq/1ZIM93W7Zg8DLgGg2asuDdUWyu4gAwmiJBaImuNvGDuMlRb9q5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=SRa4F6S4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="SRa4F6S4"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48436251906so1052565f8f.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788525877; x=1789130677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0bCHPra0ov4HOGTqoiu0PWRuzy5wYsf4BkMOF/45xC0=;
        b=SRa4F6S40QmFVPHpWoW8AjN7ZVrSmYyKpkfFBNOk9gLR5qjQnvGNWx2OSAN4GLT6BG
         r5EQGc5qDvItA3UeZraHmifd2NjJLOke/Z+8FXc4tuA2ip352Qxj/GgJ+lqz48wqZ9MP
         qpnesmgEiMHmPstWBYlBJSJ/6QIzmMiC7w7hTDwwxoYlDwi3NJKmcDtYUzXZXv6B+Wnw
         qKuqd993HSSeLbhgLmu1xdSsWHGHSI+PPVXkdB5R+W32TSxuyFIpuPZ1EPynB7Ls2Zwl
         cF4nQBqGrI0PLbP/mnTlpcPNIBnMO4tk0UcL7v26QuFLgGRZXjVF64L8fM0GH7YnLN6n
         irmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525877; x=1789130677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0bCHPra0ov4HOGTqoiu0PWRuzy5wYsf4BkMOF/45xC0=;
        b=EyLH86D7Jbb26RDYks3S3cjqJJxdMlBkcpTzi8vPuiJ2OPaO8BC0Gn3dkrisgwxACS
         gTk3TufrIE+8Bx70Tooq4D4SFaPjKz7AmEUP70WTBY24tfiqVkzZ2MX/9irjQYe/qdD+
         inQEHxno6F6iZHrDIIpEqUWj2zm0rW9VtWJ5VVOZXf2laS69TVUPMnOLBnl67B/eH2Yb
         qEOfIx41S1dipVGrFEyN0mcX5+SRlV6ZUdFf27pGu16GxfmwKp/wmQbvkBtU27OP+d9G
         nZqX+uqtKgWTI5dOMl6ADDc/nlg67Sb47WQMcQrRPTaG0BOdw4e+QqauzysvHo6XPlXf
         yrXg==
X-Gm-Message-State: AFuF++kxDFS9UeR6V4JUP5LqjYZS0Bu6+FzeN2+0aowH3Le+EeBEjYMe
	WWNiJvrx1PpUhX3QN2TrxyKSQlz6xbm6GqtwdqxVG8J7jNN5vjhASjkGJs0uO64X9XiRmPbaq+m
	2RE1dW5MGeA==
X-Gm-Gg: AYBFou225UvnO8VFEYKA2fVdZOgatVlavDSGr+duOGfnqZnLXuf67fp8GiCxC8/NdhC
	h0wcfAin+xQP1wq22Kf9i8HBg/x+2hOeOqChD2Lwmheyl4kvyRIQM/N3hwOP7Eu1dR57W5yP/nw
	JK6BYJ/jokl2xV57hrSFJwu7CzVATr3ayW0DVhlsF6nNl1DRTGv60XGbu/1LL8IXW3nFxmzSmTS
	ce6HTZq6q9mad72GMGfCZw971gddrBNvDTkYoFuLvHM04s9L+EU8ctO7+3j0oCcKLonJEQKKP8x
	n1J1AsG5BUQ78IlDhunH9mglaDupyg6a9UgR5St0SdihtD8pbZQRPCa8mr1wqgXtErl0oJWhCuJ
	ADjJK+sqGPcWjRs0BkKAuYFWzDraPVYJSrKbV28RFQEV4RSCbx6XVfHGe8DPwPQ9bCDlV4BW1jr
	WIsawaqpnCDRQ0HgOXDn6h9b9ASDddUBgbfgR7gr2fpOL5p9cs4rLkioUmp/xf4RCM8Sz8
X-Received: by 2002:a05:6000:420b:b0:47d:ee9d:90c8 with SMTP id ffacd0b85a97d-48586e496ccmr10001249f8f.3.1788525877392;
        Fri, 04 Sep 2026 05:44:37 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm5942337f8f.21.2026.09.04.05.44.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 05:44:37 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH v2] doc: cherry-pick: note --no-commit skips CHERRY_PICK_HEAD
Date: Fri,  4 Sep 2026 15:44:35 +0300
Message-ID: <20260904124435.12865-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903125524.67889-1-f@lex.la>
References: <20260903125524.67889-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The list of what happens when a change is hard to apply states without
qualification that CHERRY_PICK_HEAD is set.  Under --no-commit it is
not: d7e5c0cbfb (Introduce CHERRY_PICK_HEAD, 2011-02-19) skips the ref
on purpose there, expecting the user to pick further commits and edit
the result before committing.

The option's own description says nothing about the ref or about
authorship.  "git commit" reads the author of a cherry-pick from
CHERRY_PICK_HEAD, so without it a plain commit records you, not the
original author, as the author.  Picking a single commit this way
still leaves its log message in MERGE_MSG, so the result reads like a
faithful pick apart from the author.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes since v1:
  - dropped the t3507 test patch: the shared !opts->no_commit guard
    is already exercised by the existing clean-pick test, so it added
    no real coverage
  - keep only the doc clarification, and make the --no-commit entry
    self-contained

 Documentation/git-cherry-pick.adoc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index 42b41923d5..24a28d4e65 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -25,7 +25,8 @@ happens:
 1. The current branch and `HEAD` pointer stay at the last commit
    successfully made.
 2. The `CHERRY_PICK_HEAD` ref is set to point at the commit that
-   introduced the change that is difficult to apply.
+   introduced the change that is difficult to apply, unless the
+   `--no-commit` option was given.
 3. Paths in which the change applied cleanly are updated both
    in the index file and in your working tree.
 4. For conflicting paths, the index file records up to three
@@ -101,6 +102,11 @@ OPTIONS
 +
 This is useful when cherry-picking more than one commits'
 effect to your index in a row.
++
+This option does not record `CHERRY_PICK_HEAD`, so a plain `git commit`
+afterwards records you, not the original author, as the author.  When a
+single commit is picked this way, `git commit -c <commit>` keeps the
+original authorship and log message.
 
 -s::
 --signoff::

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

