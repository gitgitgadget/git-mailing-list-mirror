Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9342065
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499677; cv=none; b=uP/GV4Hi+4bED245QOZ1eKVMlU5Boh9D0a/FPU16AXZr5YhkJtSzBfxS5xcsvXouRBBerp47BNDEgAonmqNtLz9EsftifxvEOgRhr9OVngGlxBfkt8PJCgJ1gL0k6m3V0hvOvsjxiltLYqKPG9keVIYOkXTcVnUfcg/WnBlVBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499677; c=relaxed/simple;
	bh=MOAB2fmbcTDW+WS9E47cU6WpYAw34qCT6QZcw5tnnAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxPguDz8+H3Od692d6ZGhmMd0nqP9GsUiSoasigXJOef0JDkRbMDiOnyg4WT9xm8CHRkLlwQeYhpLjjLZb5RoXcf/7RJMq8X/dhK0DJSY9miIjN3+KPLThXgwV2wWhooscdLMRWWRzRQdP58v0QqCm5XcFxTzuLtH5py2ReqqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBCHr+3a; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBCHr+3a"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b45edf2303so3730637f8f.2
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752499674; x=1753104474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkODo8EZRh50913qZ/pSoeAguBQ7adLGR0DhHIjUy3I=;
        b=fBCHr+3aqXNTYvsg7EGbOMaLhCijUY+HPqeQ6SgpiAdTNn7O75cQDT+KPfwxTo57qU
         Tzi2hhqSy2CsNURccgC7n1xYM7Uxizlx/pzeCqKdcLQAj50+770zSoX68Ndz1og5gArw
         nDvdkKwa4BkR7EsJ13npPZ/mHL9OrM2pgqHJn1YZvG5I4R/L+q62tVOYaYK7Pl+zRWcb
         h/qsM7bFgq18oMuWSI4NbzkTL1fKmM0eD/QUgkiZU5G8lE6b3FEYWFYGQFtLZbW4uj9l
         JA7kRwaKH3/dFMdabJozYCNdW8mrhi2TrJoCfekSd2VfhHl2MzAcPsWoonHkdlE6IXGR
         xUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499674; x=1753104474;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkODo8EZRh50913qZ/pSoeAguBQ7adLGR0DhHIjUy3I=;
        b=hX3R+9eyFOfPz4mTaNmus0b4OTOp1YxhJ2UOE6z+e2PgJD1WKj1x/Nq7F7vLr9BR5a
         lyaJj0ehJ0+HtsBKgZgKNl6k5cJ7ljiTDUc6UzC4HEDKAthwVDzm06eDqMixrCJIxoTc
         uMqWGuzT5VEMiVHimn4559eVOHtygFfCjgimvoLZ9mmdbWDMF0JwCMSFWRbqKfLClW9U
         C+exdNIfx0N11miEYsd4EgSFgL85eLGWYnOTtGsWo8RKl+cTMNz77L7gz7oXJgUQYkYr
         ozYiMn5oloMwKyXnq61Z6pVwMQIua90yufhnsyHVtmVy8hzJNcSmnwspcEPeysLo749x
         VF2A==
X-Gm-Message-State: AOJu0YzXSRkwMj6rAiqKEKX4VG5ilFbGS9KAvMRRft+mFtCUeOsv2uzF
	dntZ1yfr1A5kfiTCrnxm8X4BOVckZc2rOok6eSN9pyabLOu8HlABZ0IZJmqklw==
X-Gm-Gg: ASbGncsEFKu/D7Z6CJGqdkyo7FVHTy8wGSYv+c69hNF09nKaMIAGxdmGSpjX/TZ/l7S
	lazBr3ylH/64FCtQ2YyRoJLgvJb2aIDNkrjAejPUAjSoG0rfLFYU0sC5Gnm1lYiKV/3mHfLOckC
	1Tyoj43d2aqelnbY+68awRTRihrfXPoQhppLCTF1ZQ/Y2VbmuhT5g2OX6HR/4v9olSH/ql5SaPS
	lMcri2N1jQ9x1svGeUNPm2FvjIZ+6HKsyYCJ7DXT6m6DMyleRScKf1THJZRQ1q6UXMM09uWrtn5
	BeRp3BjeDWuhfBDPhOJE57wvTc2xZLPu9m/8oMYt2Nwhjzve098UrUn2iKGDLrPzFYER08MAnPT
	8Xnly+GPEFbqg1VePzOwDMGH1Rhf8uFuiNvwm+cPjTi2f
X-Google-Smtp-Source: AGHT+IECK7ljYB60oj9MjL1ZdOyMrLlbuvnvWNoiGh5X7dVlkAis5mRDmzyWvoIRJEEcd21/QyawyQ==
X-Received: by 2002:a05:6000:4186:b0:3a5:527b:64c6 with SMTP id ffacd0b85a97d-3b5f18565fcmr11359230f8f.1.1752499673567;
        Mon, 14 Jul 2025 06:27:53 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1784sm12331706f8f.5.2025.07.14.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:27:53 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] strbuf: add compound literal test balloon
Date: Mon, 14 Jul 2025 14:27:37 +0100
Message-ID: <7ac55a5096c261b706f47ca239c381f71db2b67a.1752499653.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

A C99 compound literal creates an unnamed object whose value is given by
an initializer list. This allows us to simplify code where we cannot use
a designated initalizer because the values of some members of the object
need to be calculated first. For example this code from builtin/rebase.c

	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
	struct reset_head_opts ropts = { 0 };
	int ret;

	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
		    opts->reflog_action,
		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
		    opts->reflog_action, opts->head_name);
	ropts.branch = opts->head_name;
	ropts.flags = RESET_HEAD_REFS_ONLY;
	ropts.branch_msg = branch_reflog.buf;
	ropts.head_msg = head_reflog.buf;
	ret = reset_head(the_repository, &ropts);

can be be simplified to

	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
	int ret;

	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
		    opts->reflog_action,
		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
		    opts->reflog_action, opts->head_name);
        ret = reset_head(the_repository, &(struct reset_head_opts) {
                .branch = opts->head_name,
        	.flags = RESET_HEAD_REFS_ONLY,
        	.branch_msg = branch_reflog.buf,
        	.head_msg = head_reflog.buf,
        });

The result is more readable as one can see the value of each member
of the object being passed to the function at the call site rather
than building the object piecemeal in the preceding lines.

A common pattern in our code base is to define a struct together
with an initializer macro to initialize automatic variables and an
initializer function to initialize dynamically allocated instances
of the struct. Typically the initializer function for "struct foo"
looks like

        void foo_init(struct foo *f)
        {
                struct foo blank = FOO_INIT;
                memcpy(f, &blank, sizeof(*f));
        }

which enables us to reuse the initializer macro FOO_INIT to initalize
dynamically allocated objects. By using a compound literal we can
simplify this to

        void foo_init(struct foo *f)
        {
                *f = (struct foo) FOO_INIT;
        }

Let's add a test balloon to check for compiler support by changing
strbuf_init() to use a compound literal in the hope of using this
feature more widely in the future.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Base-Commit: a30f80fde927d70950b3b4d1820813480968fb0d
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fcompound-literal-test-balloon%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/a30f80fde...7ac55a509
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/compound-literal-test-balloon/v1

 strbuf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index f30fdc69843..c93c1208c93 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -68,8 +68,7 @@ char strbuf_slopbuf[1];
 
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
-	struct strbuf blank = STRBUF_INIT;
-	memcpy(sb, &blank, sizeof(*sb));
+	*sb = (struct strbuf) STRBUF_INIT;
 	if (hint)
 		strbuf_grow(sb, hint);
 }
-- 
2.49.0.897.gfad3eb7d210

