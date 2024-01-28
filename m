Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2821446C3
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481295; cv=none; b=Cvv9Qr04AFg5a8JAkGy8btcN1LSn75ooLtiEX6YbGKMqlau8I8oXgknWd0Z6nk3OootOikVtDmsd4fR+yrcXgOqj2HxJgrDzlzDeD2X2AWBvqF8Mi31qX02duxbz8Tjwh0xtOdYgMHGbDuhRmSczzp3bddhAU6+/1seYheZgdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481295; c=relaxed/simple;
	bh=AiVe7XYbFn176gBtgBBvJ8zVjrsqpNydpAm8IZoC27k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzfnVb7q1c7LwCg6xIPfHNClVk5scDpp5PbalgFuLTOfbU6Z6Y3DX7RDBde9jybeyE8GDg0HOAVS3zEnYJrr1VzzHJRoQ+4CFQD5fTgBY/KEfue5gmD+rZxtrwVp7rrWNxOoQwwgdIEpOw23BoxjCk6oBjPqrEDoKPFmeuTokDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb6xfy95; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb6xfy95"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-595aa5b1fe0so1493228eaf.2
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706481293; x=1707086093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNULBkTf8dpbUhhPjhIKAtXvrswxNBtLwua0PFRGYq0=;
        b=Qb6xfy950nEjN63bvdszVVzo0Dt5pfaroSupFOJ54nABX3bxivRH9DV0ezgOV9wVlf
         U6MbsIFxlFKbrs3H+B/SzKG/pt0FfsKX9lpn5heZmPzrdCnzg3m4NOWetpOhPlRRU+I5
         tUuJ55tg3ePNx06TRrZPb4UbTNWG/JcSsSy2kLstgWCXv7KO/PfaysC09OofxNe4+slf
         WX0Hv+mb5FzkwvCwSj0uhIyJmss+Rjfv8rwXBA24CvhiOcl/x8OBf31vQBtP+8068miL
         Ix5Crz8hZltZjXg9X64+L1NnIERtf5GkrdBFRBqdjZNjwR4PiP+Px10mVIWzOgd+Mu9z
         suNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481293; x=1707086093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNULBkTf8dpbUhhPjhIKAtXvrswxNBtLwua0PFRGYq0=;
        b=mXYSmUniVpZVvOHwizgTYUPtF3DfQk0vou0fYdSJ4VWkQT2pF2cZZb3/j5cP4pRuza
         /t2ecsQW1W3xUkloiD2SsV5PV8ILBPLzCj6PfjZauRwgHFWmScYGdsReF78sQGhrPzZp
         He4VMpRHXF0Yrd84cjtFNprhXHn/ndfss8wDkB11lXM6dmrfxOurCxP72wW/EoWhSBm/
         80bqZSYQh3vXAVMr8zUq+FdD5/P+aX3BehhfMI9eyCQ4QNtF1+m4gBANnNFIF3ySrONS
         iaEBp4iSZqfT6K85l6ecxcKRFLvW3nWoDqJN0eTmTGQbH83fqC+MYrEbGk3Z/P3i7sHZ
         eAKw==
X-Gm-Message-State: AOJu0Yy6igABJfELAk1vjuR2s6zBStqvWljtq73qdIGxhw4ki0M+vl5F
	ugnDJD03afxeRR81P/pt8Nh1Bs2GCloG38ZP8gEMwmSm1DXUMFdY
X-Google-Smtp-Source: AGHT+IHtfv21T0Z6N+zKzw08DTgU8hkWitGEYq/bByFwqhKhr+q1NL4kIMNspDhaUHx+ffl8X9X4Og==
X-Received: by 2002:a05:6359:459c:b0:176:d0a8:8df with SMTP id no28-20020a056359459c00b00176d0a808dfmr6131819rwb.8.1706481292788;
        Sun, 28 Jan 2024 14:34:52 -0800 (PST)
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id nm13-20020a17090b19cd00b0029061498a18sm6896825pjb.24.2024.01.28.14.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:34:52 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 6A5F052027C; Sun, 28 Jan 2024 13:34:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v4 2/8] completion: bisect: complete custom terms and related options
Date: Sun, 28 Jan 2024 13:34:41 -0900
Message-ID: <20240128223447.342493-3-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128223447.342493-1-britton.kerin@gmail.com>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git bisect supports the use of custom terms via the --term-(new|bad) and
--term-(old|good) options, but the completion code doesn't know about
these options or the new subcommands they define.

Add support for these options and the custom subcommands by checking for
them if a bisection is in progress and adding them to the list of
subcommands.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 06d0b156e7..8baf330824 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1449,7 +1449,20 @@ _git_bisect ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="start bad new good old skip reset visualize replay log run help"
+	__git_find_repo_path
+
+	# If a bisection is in progress get the terms being used.
+	local term_bad term_good
+	if [ -f "$__git_repo_path"/BISECT_START ]; then
+		term_bad=$(__git bisect terms --term-bad)
+		term_good=$(__git bisect terms --term-good)
+	fi
+
+	# We will complete any custom terms, but still always complete the
+	# more usual bad/new/good/old because git bisect gives a good error
+	# message if these are given when not in use, and that's better than
+	# silent refusal to complete if the user is confused.
+	local subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__git_find_repo_path
@@ -1462,7 +1475,22 @@ _git_bisect ()
 	fi
 
 	case "$subcommand" in
-	bad|new|good|old|reset|skip|start)
+	start)
+		case "$cur" in
+		--*)
+			__gitcomp "--term-new --term-bad --term-old --term-good"
+			return
+			;;
+		*)
+			__git_complete_refs
+			;;
+		esac
+		;;
+	terms)
+		__gitcomp "--term-good --term-old --term-bad --term-new"
+		return
+		;;
+	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip)
 		__git_complete_refs
 		;;
 	*)
-- 
2.43.0

