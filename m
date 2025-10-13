Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB212D46CB
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379951; cv=none; b=mYRQRXFwUIS0sz5mUE2gZHLEjipqeLx5pCWM9syQDx6+kmKsQRoQsVZ/0CtOB+XkLFz0ES7Zm706xXEdFsuH0FVXeROs4s/muI1upOSONI3SuH6uVuyQX0BD7qLkYpH8KwLDPiInpQ5HgSf1FYylsJlXML2eAzpA1j6mUj94VoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379951; c=relaxed/simple;
	bh=V55hLMVPP7bbb+jEOAa6Zr+eIjYLIVy0gaSBOJmavk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNrut7vYakdMMSn36W1Z7kDZDOGE3mu2XtsDpj7X3ZwIelbNdADBrH3W9v3IlEPKjmaxFfwAaUfx8dRlDPuhZ1B4EbcSm8KpbqXbuPg048tO9L+mS8cUuMieywQ9z9n/7duiD1X5r13u2ifgS8m09yNVM70dsQ5otfaAANKmNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ6TGf4t; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ6TGf4t"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5515eaefceso3863417a12.2
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760379949; x=1760984749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLPKM5OL6K06fyN7V+5EbQUDXA8ErWWZxpx+2mpEdG8=;
        b=RZ6TGf4tkN/qGOLEoMh5TdM+4rAL3PqhET9rbrRbmFB6aXgFhWFa60eKGP/55JJdbf
         50jiT8jgbo7WVblRDiwKzLBITodDebtRrd0T9YK1yd6+86sZKzaR98qZCZ2owIGYoM1z
         OPoZdBDuZfchCthp5MWHB6oGSc1PvVyyKSPRdFXrNDfJ3aqnjsGHNU2gk47be5pbAPtd
         RVfbMqrcKwZBTF/O+PWt6rv8zx5lyFu9/3LHC4JNQtq+wjpjI3aORtVyxgDXR2V4+WLZ
         o2y67Cn6CRyFWTUioZjL1/wWZFZl3lHU/JiOedrfviKcYCV86AYsRgAVTClMSyd08aOO
         5frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379949; x=1760984749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLPKM5OL6K06fyN7V+5EbQUDXA8ErWWZxpx+2mpEdG8=;
        b=e5rQd/xN1lUjGICkrSFP0LfRs0+s3saxAJhVdeDryhXdfR449piIQn03HTZ2FZAJ84
         ICjdVki3wWbTERV9F1rrsZElQPxi94GIQEwqtyfGkL9qmlixyQbEKXpv4hBAA7fa6j8m
         Gmc2mk+eU4yE+4jaMj0h8n7uyMdIbZ/tOrfVvptow65pHZ1kSGZoJ04jFCvu7cLlns1o
         RidnTRhY7Q5H95jxypI7MZNc/tRjYPjrzqVqoyFLMnvdh6nnaJbMr04q4jbp4Elx/6pO
         pr20PGAHPOE5SB6FsdBP7Nh61YqimhMkVy6fczq26oPhP+QLqfbmS8umQPtwcszz5KdM
         0gGw==
X-Gm-Message-State: AOJu0YwzfrLM5FNuLS5FMDTp4+KOWbaDaVwJ2SIIVJJR1bbsPttStKTy
	T0iV1/sZfYpMAQQvSwB/ufEauv3EKH2z+k4vGO7lyIvkL858Vyy/MTMwU49MX0qD5A0=
X-Gm-Gg: ASbGncteKAwNMi+lZj8q346JOhxcI/9hw6EoCvw4qzdtBL40dwtP4FFpYWSB/211uJ+
	Jqve8WpxAZ0RHmbkffs56Opxsift3XZZTbB75JMOUKKYWgGOP8AGbVpI2zE7/z+ycCbMLBXJa0u
	qTDVXbzPrk0GlWV+tORsIVXnlqnqpjpqCNpB6d6ET745gcB0bmS8PEvwnFaTKo4YQzofHy5fhfT
	2ED8Xz2u8gczjb7vTd7NOiA85eiSDBKHg+riTdzsy2YJrrygzzo6pHqdXignqtLovck9t/UFp9U
	bOhkx8M/NSBfUfA2Sa4E3ooOXxy92sgvuJL3ZvXiSolaQ8XC8uOAHlU2/wTfT4pAk9S/ObE4UCE
	lXUrtWgE/RAFOd+WpDVfig5xL5Jj0pikduHySwlk2OHH4uCw8QMKYjF7ebbrEepVgU/1B86srPP
	7h2cHYA32CJnKMCdK0QMZJA0Bi/4KFv+KkvtyOD2ZEZ/dfuV8s33UAkMDW56kAe3Z9nsgj/K6Y5
	tfYJPED
X-Google-Smtp-Source: AGHT+IHWYv2rLcncTpPWj7KuPFZ91FMN95lSiunKttSt1EpRI6PHWz0ZSsQsUnNm7OkeV7IafSSS/Q==
X-Received: by 2002:a17:903:8cc:b0:267:9c2f:4655 with SMTP id d9443c01a7336-290273ffcf6mr280656795ad.41.1760379949267;
        Mon, 13 Oct 2025 11:25:49 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:dc83:edd1:7853:510f:d37e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62657166sm12913501a91.11.2025.10.13.11.25.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 11:25:48 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 1/3] replay: use die_for_incompatible_opt2() for option validation
Date: Mon, 13 Oct 2025 23:55:28 +0530
Message-ID: <20251013182530.33041-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013182530.33041-1-siddharthasthana31@gmail.com>
References: <20251013182530.33041-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding the --update-refs option, convert option
validation to use die_for_incompatible_opt2(). This helper provides
standardized error messages for mutually exclusive options.

The following commit introduces --update-refs which will be incompatible
with certain other options. Using die_for_incompatible_opt2() now means
that commit can cleanly add its validation using the same pattern,
keeping the validation logic consistent and maintainable.

This also aligns git-replay's option handling with how other Git commands
manage option conflicts, using the established die_for_incompatible_opt*()
helper family.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 builtin/replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc..b64fc72063 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -330,9 +330,9 @@ int cmd_replay(int argc,
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (advance_name_opt && contained)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--advance", "--contained");
+	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
+				  contained, "--contained");
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
-- 
2.51.0

