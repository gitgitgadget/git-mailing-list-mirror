Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242831A81
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610623; cv=none; b=HGYofWNb9SMi+OZaLS6BYAJcWu4XrNc+ckum5WDWyYfhVVHfwOEiUIdYHMvRbakHxD3uUq+MD61zr6Syr6HHtVcZPRIaqiVP2v2h8VhYhAh3Po+DgmEt84pIar5WQUVUwNX1ytoil3WKi90dH+6PoOLMPQyis3S+gruO0t6zQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610623; c=relaxed/simple;
	bh=Y0LqsRZe9AddaLl2Hx+ssJN+9u0l6PXT9I9qEqi4epg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWlyfAHOCoCYZPXF5jcvHRX7Dpu8zD9MpCmAaI4KjMUdwvep7zL7j1GjrERdDBq33FxHljXP+E3xbXtvc3PtW0prd5Vc+NG0GE0sRb+Jt4octxRuldOUQWB2LRaBIFDCu4Bdu+YAe3A2dgXfKLgGa4Xgz32RCcUtOMXkhr96F4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnEVOcEP; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnEVOcEP"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59883168a83so29877eaf.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 12:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610621; x=1706215421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKgabg0f16EawRXq+one6wT4dEB3ongXPjWj2/hAruY=;
        b=RnEVOcEPcD4pT53fePTTTTwvC1qAGdJ1nnjV5rBpHnOFTGN7f5h+1hlhv1ESGsbZ87
         nwAPu1Our653iITOCPRESktRXe8BWds4kFRrK3ch6F3+CBFi3iQXM5lzpZm4Na/omsKK
         fvZEzeYa+aL/I8OkAse9W8Wm57EhIGYsLLpOQMb3HWgi4zem3U5IFNSHjs6nrZrfkh1h
         bwlYB6ikWYL33Y6kF51v3+Jhz0EokNVhPtPuZM+TsiX0gBQhnb0JSUSZ9fNUwhRgfKQo
         S8QaA43zl39CsBceAACVif/ivDEVtwQfmM7VgABkCooEFiSRIhUUhpdnwlmsYdJj+1+1
         FgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610621; x=1706215421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKgabg0f16EawRXq+one6wT4dEB3ongXPjWj2/hAruY=;
        b=h4D85XHiuR6puRwNICaejbQu1hCTc8xlOXP5zDdOPSNle63CkI7sFnGP8agM5mCbQe
         aUcByg2gety6g7LA0zfw4Sf5wkCz8hn2O1cPKI3gDjzXw9CnpoRoZgFf2az6RSbdhx4z
         qHhdl/ayRt6oB1jxpduuevSOSKL0wNz/s/tFuXaJ2vS3OmfQidd9vCYQnvsb9yflPqSJ
         GCwRJJCgUcLDI7mp7HubXRN3CPm2zrXLbwp1L9sRWOw2IdowUl99yj09qSMva8mneOt+
         FVeIyOFAfp9k1ySkIB87KMo9ZtXdO6r74OxoTIzZAzptcKFj1GGdseI/Tyyt0ReXc5f0
         qClQ==
X-Gm-Message-State: AOJu0YzMU5jzMyd5vrFP2sLvC90OfZ9ormBow+JomxtdlWX1PZim1c4g
	g4hryDR2yAmMMxwJ+A2/xXSfXmBP473z/VeJzx5K9w1ijTMaS4fI
X-Google-Smtp-Source: AGHT+IGeKoIL0vYmxYZ+CwsN2L4uKkMHrsGejLmmh11p8FOrvpEE7aV42sRT4z56BGXFGdd1n6ZvWg==
X-Received: by 2002:a05:6358:8808:b0:175:4f3e:bd4d with SMTP id hv8-20020a056358880800b001754f3ebd4dmr1261580rwb.49.1705610620406;
        Thu, 18 Jan 2024 12:43:40 -0800 (PST)
Received: from brittons-large-Vivobook ([2600:380:7029:85ba:9b09:b597:4ed2:ccfb])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm2014699pgc.29.2024.01.18.12.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 12:43:39 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 20FFC520278; Thu, 18 Jan 2024 11:43:33 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v3 5/5] completion: git-bisect view recognized but not completed
Date: Thu, 18 Jan 2024 11:43:23 -0900
Message-ID: <20240118204323.1113859-6-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118204323.1113859-1-britton.kerin@gmail.com>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the git-log options to be completed but avoids completion
ambiguity between visualize and view.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ad80df6630..87cf7b2561 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1591,13 +1591,22 @@ _git_bisect ()
 		term_good=`__git bisect terms --term-good`
 	fi
 
-	local subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
+	# We will complete any custom terms, but still always complete the
+	# more usual bad/new/good/old because git bisect gives a good error
+	# message if these are given when not in use and that's better than
+	# silent refusal to complete if the user is confused.
+	#
+	# We want to recognize 'view' but not complete it, because it overlaps
+	# with 'visualize' too much and is just an alias for it.
+	#
+	local completable_subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
+	local all_subcommands="$completable_subcommands view"
 
-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	local subcommand="$(__git_find_on_cmdline "$all_subcommands")"
 
 	if [ -z "$subcommand" ]; then
 		if [ -f "$__git_repo_path"/BISECT_START ]; then
-			__gitcomp "$subcommands"
+			__gitcomp "$completable_subcommands"
 		else
 			__gitcomp "replay start"
 		fi
@@ -1615,7 +1624,7 @@ _git_bisect ()
 			;;
 		esac
 		;;
-	visualize)
+	visualize|view)
 		case "$cur" in
 		-*)
 			__git_complete_log_opts
-- 
2.43.0

