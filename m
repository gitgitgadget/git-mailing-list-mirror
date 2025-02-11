Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3A1F0E34
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263863; cv=none; b=DM8oz+lZlih6OnTQFX8tTR4Al3pNM1rRRk/DqShkL095VAH7bAStSWmywrn3OjAztNDlcYnQs5TLpaYBbUknZ3cQoMhui2WFHv4gjLYxACOEmFPM8eN0g8XNKcXXq4YT3KOfTAx5wY27pc62y7ND16U2zDH1EULd3j1b2vLNNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263863; c=relaxed/simple;
	bh=sA2Fl6EaZ/yJyhqVWnSlz2kiXbSnEIokifLfU1UBcuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJ8iAdC9ZTxH3jC9AklHuBhmtIswveYX3jC3gn02iPDTblfR6ZlZu9QxcrIwV2iT5JxQQRnVTXlgpwvt7ZMQ2QU2sox7w74VD0vgcFuLOIO2baImlOFLKadYp8XUhNVsFWqHfGXBdLtwNPilEXrckRyU+SbPg8xAuXtc681gfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNzSE5QE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNzSE5QE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21fa56e1583so25611915ad.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263861; x=1739868661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oShxNFBA2whHNuM0znTUdxztBoBluLeuiQwSYo49ZOQ=;
        b=cNzSE5QE7GYwLKxsSXrFYszbaw2SlmInazC6gfH1wmVyam+enHp8Zo2HleVUuhCJnA
         mZ1ziZBou+3zuxjpuhlrjTno0Sub8CGbl4g2hbXrDEpVWYrQo0czRErIus27twJ0sCe9
         UKbgs8kGkmoHWyd+D+mL5QIbUwv7WcyJ+7JQUJzYs5fbi+LaGdDbul1G/00kO5Yrbk/5
         BV6WpzXPNzI5DTtZSd/SAdyyKsRQ1vc+V6kSUvBNAtAaFNclcV/bCosG/iwqDKFO+3J2
         eG8Rm8PZeqFh7houigIyUzW91mHmLNQEMNlUNhCKe16llXA3HUi+amL1TjQhqZjdeipb
         wuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263861; x=1739868661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oShxNFBA2whHNuM0znTUdxztBoBluLeuiQwSYo49ZOQ=;
        b=HO14niWj/gLaM0HlWC4lTHPJvrT584Nk9GHHMLle8v+gMzi3wiRPZG0p6sslLXOTD+
         7uhlRdGwdYQyqqdicGY7p2tPOfWfhgqe16Lo4PJ18va+qg3CqmMmfeUT+XpEhgfYUqMb
         poF5gbgCnmWz7GgNnesqbGnjpbw2HJtnQ+QUCqQcDS5ejElpCzojd6y+8rCkLQQqNzK5
         M9ZKSCmy6cjkE1kDIRZFywKWj4Ofn6KTH1wfwbZLgVY+Ik1z8Dmz70UmN7dUy+5eq1Rt
         Hbu5NLEIbBRgIEryAmmHEyrl410Dcv4F6N8xGLoHlCSEUJOiEq2DEdNMXW/X3iqUFq9m
         RWkA==
X-Forwarded-Encrypted: i=1; AJvYcCVRQhnEXLC81XPVVlz+9rpGh4mRXBs0+M6twj6g5EzdYHbPBba/gOU8yI2b6uP/3Q0pwiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykO3qikw4O7Ju9zYCRnYHAGjofTNQ5L0Z+SlBf2Lrd8cONdzKp
	qQIRTad/tickmqDAP4KyjgIYHNabUDJU4NezONHaj2/72cQN2HRonBFJ3PIT
X-Gm-Gg: ASbGncumdVy0JOFM2z+JZ6cY/KB5/VhP5XjAPslUL2jWEac2K+SbS5L+cwF/pp9V2JR
	3OGCGQWsFaYFzrOD1PhevZuqiX9xEl+liC7aLNJRAeA5HilxZd0oEZIOjvMAjuQBUgh05a9HEAq
	bjhGpVXiCkAGaGcDPZr5ZZvRcpVNj8OM3s/wnh5wESHNCmG0P9j7bSNWicDdlUQ6ePZl5REKtm9
	h1Xu2Pf60MhVWocOCyEqhlYuUmdt+dUQuL3hxYOBqEx5iG8ynQ/QuznAEgos5Rg+/6ns/LApZKi
	L/g++DfzeVQW/jMV6yXudQJ+uPWdgFGowxBOraU=
X-Google-Smtp-Source: AGHT+IFLMMlRo0GjPxip9xanWxy/ex9ghxi2+9Z23hspX8Nhn7c+DJfbxGnxfzlnpDRPm+6SOsIA+w==
X-Received: by 2002:a17:902:f681:b0:216:2dc4:50ab with SMTP id d9443c01a7336-21f4e1cb849mr284637925ad.2.1739263861396;
        Tue, 11 Feb 2025 00:51:01 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:51:01 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 07/10] completion: Support --patch-{grep,modifies}
Date: Tue, 11 Feb 2025 00:50:19 -0800
Message-ID: <20250211085028.3923875-8-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 contrib/completion/git-completion.bash | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 41391..daf335 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1900,6 +1900,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--output= --output-indicator-context=
 			--output-indicator-new= --output-indicator-old=
 			--ws-error-highlight=
+			--patch-grep= --patch-modifies=
 			--pickaxe-all --pickaxe-regex --patch-with-raw
 "
 
@@ -2216,7 +2217,7 @@ __git_complete_log_opts ()
 		__git_complete_symbol --cur="${cur#:}" --sfx=":"
 		return
 		;;
-	-G,*|-S,*)
+	-G,*|--patch-grep,*|-S,*|--patch-modifies,*)
 		__git_complete_symbol
 		return
 		;;
@@ -2239,6 +2240,14 @@ __git_complete_log_opts ()
 		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
 		return
 		;;
+	--patch-grep=*)
+		__git_complete_symbol --pfx="--patch-grep=" --cur="${cur#--patch-grep=}"
+		return
+		;;
+	--patch-modifies=*)
+		__git_complete_symbol --pfx="--patch-modifies=" --cur="${cur#--patch-modifies=}"
+		return
+		;;
 	--submodule=*)
 		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
 		return
-- 
2.45.2

