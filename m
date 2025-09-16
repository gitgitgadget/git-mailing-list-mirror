Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDC1D7984
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983079; cv=none; b=Bf2NFZQNJwmIP8DCDPHaHkAkPe9g7stp8WtK8p0j+dB2C+gG/LEM5/3ywEcWttPPaADkuVs+Lnup6qfHbQkQ7P0C+no9fvVeMQusUWj27AFHy9Z/H80ogDda1Uco+YFu+JDPkIzu+fEBjvqAhRmjmDeK6TZf7+CRtDbHuhA1gWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983079; c=relaxed/simple;
	bh=234h0ekugCcjHqY/oFb94Mj5SDWh5XuDMorwRd9Guv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3/2YYNPugPdcb7ydxtqhApgBiHmOeB/2gN0Ub/ECdf18RtYWcVGCQqnRVhRF+Q6qjMmDduHmrwwkfv+rPMtFFF/rV/QGIIn653cY6pneQeYJlaraVHTKSJ9/dP1+/iBP1xfDnlGJYX3ZWI6OwPHN6axhRkPy0CuL22QTliFM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOobbbSX; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOobbbSX"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ea3f9e9f782so2349017276.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 17:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757983077; x=1758587877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs5ZJvGcBUz2B0iF/IXbnMLMofxHS4FPokW5oz8j9gk=;
        b=hOobbbSXbUOHfZQu7RUaz2iD5doPwAKP9rvePQuTL32Len2RrmseKw6pIc8ohbq2pB
         RfdBDWC+bdkfZ3f5HSCV5eHeGyoTYPOVAR2lutXi0vNMPk+vdauak02N+T3QQKK/3pMb
         +fjF5ZHW27+R3LOH5Bq/eunohAzZavt+FgziDJjKujb99GKS3jTpos30TMJM1BJIr0wT
         kBdkrFgBSWBp9ScAKHjluRHKpjRDejkmhj+tKzltvREOYJMPI5E1vUYx7mOVYs6mLw2j
         ti0ChwMIiEzrINtj0gj8OYy5sudMPzqJ6aOwCJz/gwPrSvSGkPsAn5tbpEKeovRLFYBt
         vZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757983077; x=1758587877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cs5ZJvGcBUz2B0iF/IXbnMLMofxHS4FPokW5oz8j9gk=;
        b=CSLvhBpjtLK2AhXemrZSCYajNkOpk/GawYhKI5BfzBi/oXWcicfb6wsBUG6y5L4XsX
         fD1QT+OYzRzGgKg6Mi5OszZBNVZhXU4ZSNafXToNrCaegt63uscj6RwvNDtftVuOuJ8u
         qqInIYzvHE2RiOTsWWZtAkmMlaeRMCDfF/TW7DvbK1l+7/wOFkfw5aN8EJA5VyzBfHhF
         wgZ/Dh/wbIZ72kBNrTQi8X3fOvdeSDBEi4TNieXIxJBesIx988ycO/vfE0jfnYfrj9zv
         7HPZ/4nhn3EFJPW+1Xy4DezvBlzFXeWFK7l1zb7jXSNYdqevIoAzFYM98sZFRE8t366a
         hsKg==
X-Gm-Message-State: AOJu0YzTHTbTNpIt7eRbry+BhfqSZoc7DWNKs+YKmUH2qqnRmiDl0XPc
	TeiKFttJ1naWbzjolTqF6vuL9v3uICSQt8hO4a0s1PFJrvWl5dxYxfo2Y7fzZACR
X-Gm-Gg: ASbGncvD1JBWX1ZCz3MjupTY7nVLirv+6rEsPWJqQuwl7ZvEka3TPUMJr/8lh9drBpq
	a9DXqZy5JrvMSKrDauumQfbjBBejY1Gg0rQujVlNPvPXEZwXb3CmR+3GxyLAf2Lvne1szEVKfdB
	H27YtzGm9u3tNaQVxC6uo34jqcaCr8c1Gym3ZKxGDKJ5zaCnXDftpLnODmru5MOZC2j9ScK8UKh
	ctaNslBdKsqWCpIYqLIOymkTo0SVbf9ZMyFrmtgzQw8ovVsQHna5C1S0/MHev3Gb3ODxh4J+jNc
	HeBtaDR9jkMu6G43ADkVPKk4jOZzFtoP2yiR/YarVF2m4xsl+dsjv8RbLCwrr8v0fGEQM99iaSf
	5bLvbz8Oq6Jf19M67L/95hKlYgM+qUDr/9hd0TB6xjARJrL23dHQVwMocnibI6PUCUsX3c4L5vY
	ea
X-Google-Smtp-Source: AGHT+IF982Fp7GsCvWFXilZ4PT9R7Dm02eZ+fYHEM3DKuK1aepYdxNqqlUJeA8boiiSsAF6eyK3dXA==
X-Received: by 2002:a05:6902:300b:b0:ea4:24b1:bd56 with SMTP id 3f1490d57ef6-ea424b1c114mr2688922276.21.1757983076491;
        Mon, 15 Sep 2025 17:37:56 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:6545:4857:11f:cd8a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3feaeeab8sm2333167276.5.2025.09.15.17.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:37:56 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Denton Liu <liu.denton@gmail.com>,
	Glen Choo <glencbz@gmail.com>
Subject: [PATCH v2 3/4] stash: refactor private config globals
Date: Mon, 15 Sep 2025 20:37:36 -0400
Message-ID: <bf0a561ce36afe14b6bc03bf851d19b30ef491ad.1757982870.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757982870.git.ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com> <cover.1757982870.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subsequent commit will access a new config variable in the stash
subcommand implementations, which requires the variables to be declared
before the relevant functions. Prep with a pure refactoring change to
consolidate config-related globals with the rest of the globals.

Best-viewed-with: --color-moved
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 builtin/stash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a..d9b478d1d1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -127,6 +127,10 @@ static const char * const git_stash_save_usage[] = {
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
+static int show_stat = 1;
+static int show_patch;
+static int show_include_untracked;
+
 /*
  * w_commit is set to the commit containing the working tree
  * b_commit is set to the base commit
@@ -845,10 +849,6 @@ static int list_stash(int argc, const char **argv, const char *prefix,
 	return run_command(&cp);
 }
 
-static int show_stat = 1;
-static int show_patch;
-static int show_include_untracked;
-
 static int git_stash_config(const char *var, const char *value,
 			    const struct config_context *ctx, void *cb)
 {
-- 
2.48.1

