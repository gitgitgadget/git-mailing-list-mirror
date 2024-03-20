Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1D8615E
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977958; cv=none; b=CCoXOhPLggyZBL4/DPnnNBTEVx/OVUMNtRb6h0Tl7y7zQFRr8iSbhkJJ8PYEuuEDoprzlUBxhBaqVJg0MfPZY1xjZv1CmG6pDlpLEFKUxyL+p17p5OO8y1aRvk/I5VnpedpIKmxYOnVLO6q6GmRF2MERx6ObkV10BFLbmGwd0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977958; c=relaxed/simple;
	bh=kStL5dchvVaRhLI2j5rvtL321b5d/OQ2h0ZwtPZHLD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYurmjOqr68JR/4c8SSX1BWXtvAXdIE4C6pFz2TF56qNT+Guh0emC6+9dDdstShjEi0P2UwbC4cw6SGsTKz9ciZ+d8yQfq+R7SAUkxQTpSqwW9D6eOqI46+vun3hIF4WLUx1uBXTqco082n47onXJQfRJnjNQ50y+t5gIBKxT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMqAQ3RY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMqAQ3RY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a06e38527so28458185a.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710977954; x=1711582754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPlWsMoiBeRoa6N+S9fF/C4VJbCmKCIQK/8ktmFQ9dU=;
        b=NMqAQ3RYMmTI11Qo36c857N/3BrrnrmXctQy6B1aF/DPqXLF5FeccpGLx8MqAp8Hwf
         NyOlNmoY0AdyO5hmQcxTniSRqqOENgTmTxW1enL7Oi9O1pwyAUdAv44+pqNZ+EOL0VNC
         3I+PLDFOhE1I07zXu23UnxfyX+H1LHgdNzaTzp8grkAVm9yJ6U3eLIr9g0R7seJOOz5A
         r72sR/zBMLxxr3LD7iCOwWlUFq1BwPSFbAX+2ayvl/ED2qN/LIxqcswapPoWUbwzLImh
         5jUKSokpUWVDikhUJaiWTrVZFQzfAaHwxRYPBewDFrxVwvWi5IZnIsmbxxSNHrrksqWf
         9abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977954; x=1711582754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPlWsMoiBeRoa6N+S9fF/C4VJbCmKCIQK/8ktmFQ9dU=;
        b=KuYeLZfTgRJ1ThKPWerhL1YYJVvnN8e5Fx/Olax2916tbf12kl1TMUacKJAr9jam3O
         19oR//ALkmJdt7wwY5waziBpSlBNKqgTXeH7zDE++gJwVgyj51Ul4YFfStc59hpQ+Xhy
         5wAgHOZ/s3Ft1qW1/TX2R9HW35NFlNDPbabsKoUM8fH2bf6SfGQkCsq4dL/wIV2DDzbU
         dbMiRm38ew2LSKlyLDvKjFugTQ/I05u6gTlxdXyUpvrw5hzKibF6/YL2CIvWipM5JDXG
         Y6/wbPIGCfQJXReCtZJakUQsqBTrkV79SZ7twuMUUx5q3wPMRaiI/WFLqBu20khhY0bK
         a/5A==
X-Gm-Message-State: AOJu0YwAz9aHIFzhcpr1kGiFwtoGtDz6zAXRhl+ZCO4W1O+GoJ9iNter
	RDtcuY/iKIDWQsWlpyTZ6+x42RxwG8Ga1JjrlfKFjtNga6ldOB3zHWrit5hrPh4=
X-Google-Smtp-Source: AGHT+IFLyXPKnYwvgKgPTrWZE8bLuiEi/fpCwxUtaKMndRfRbLK7Rrt1BjuYeq4rE9EwZO8/lrNz0w==
X-Received: by 2002:a37:c246:0:b0:789:f8b3:d89d with SMTP id j6-20020a37c246000000b00789f8b3d89dmr7126866qkm.46.1710977954373;
        Wed, 20 Mar 2024 16:39:14 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm2400867qkj.91.2024.03.20.16.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 16:39:13 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 2/7] docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
Date: Wed, 20 Mar 2024 18:36:57 -0500
Message-ID: <20240320233724.214369-3-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both of these pages document very similar `--empty` options, but with
different styles. The exact behavior of these `--empty` options differs
somewhat, but consistent styling in the docs is still beneficial. This
commit aims to make them more consistent.

Break the possible values for `--empty` into separate sections for
readability. Alphabetical order is chosen for consistency.

In a future commit, we'll be documenting a new `--empty` option for
git-cherry-pick(1), making the consistency even more relevant.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-am.txt     | 20 +++++++++++++-------
 Documentation/git-rebase.txt | 25 ++++++++++++++++---------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index e080458d6c..f852e0ba79 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -66,13 +66,19 @@ OPTIONS
 --quoted-cr=<action>::
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
---empty=(stop|drop|keep)::
-	By default, or when the option is set to 'stop', the command
-	errors out on an input e-mail message lacking a patch
-	and stops in the middle of the current am session. When this
-	option is set to 'drop', skip such an e-mail message instead.
-	When this option is set to 'keep', create an empty commit,
-	recording the contents of the e-mail message as its log.
+--empty=(drop|keep|stop)::
+	How to handle an e-mail message lacking a patch:
++
+--
+`drop`;;
+	The e-mail message will be skipped.
+`keep`;;
+	An empty commit will be created, with the contents of the e-mail
+	message as its log.
+`stop`;;
+	The command will fail, stopping in the middle of the current `am`
+	session. This is the default behavior.
+--
 
 -m::
 --message-id::
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3334e85356..0b0d0ccb80 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -289,17 +289,24 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---empty=(drop|keep|ask)::
+--empty=(ask|drop|keep)::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
-	upstream changes).  With drop (the default), commits that
-	become empty are dropped.  With keep, such commits are kept.
-	With ask, the rebase will halt when an empty commit is applied
-	allowing you to choose whether to drop it, edit files more, or just
-	commit the empty changes.
-	When the `-i`/`--interactive` option is used, the default becomes ask.
-	Otherwise, when the `--exec` option is used, the default becomes keep.
+	upstream changes):
++
+--
+`ask`;;
+	The rebase will halt when the commit is applied, allowing you to
+	choose whether to drop it, edit files more, or just commit the empty
+	changes. This option is implied when `-i`/`--interactive` is
+	specified.
+`drop`;;
+	The commit will be dropped. This is the default behavior.
+`keep`;;
+	The commit will be kept. This option is implied when `--exec` is
+	specified unless `-i`/`--interactive` is also specified.
+--
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
@@ -704,7 +711,7 @@ be dropped automatically with `--no-keep-empty`).
 Similar to the apply backend, by default the merge backend drops
 commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an `--empty=(drop|keep|ask)` option for changing the behavior
+also has an `--empty=(ask|drop|keep)` option for changing the behavior
 of handling commits that become empty.
 
 Directory rename detection
-- 
2.43.2

