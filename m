Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6064CF5
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534889; cv=none; b=nSBynh/g1YJWndKf1bmDRK4vdB0FLllwR2iCAq/cJJBUqgBglFPZ5b98HFGhxPnpSWBkTUlYJ8xEoP5EcjTj6EjQP4fadbrkdvuJ6hdUd/Cs1pQbFKpb7WEELeqzftc1WcJx6IGQZUunii6yQANKQLJckh8iWSFjMkAIoVnOXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534889; c=relaxed/simple;
	bh=NJ7EfKMPw7p7pie7Luy2Gunpy4YTA3WctlBUTJwjwB4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e6IVuIFaa7z71z5t2U6VXFIfXXbHyP3rmc+8f2CqCV6XKTaA2GffGbhgLIeOt743swN6YRZ1bWU5buakZ3MT8ws2rdt92G83KyJUXLRU6m9N0eBlyQ67lkNcoKelAkoClQkHLdDs0+BoBqXRGns6D5AE+rCaVfprE4q9V7liA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HltqOJbb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HltqOJbb"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33af4b34e2cso277050f8f.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706534884; x=1707139684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEW5FFJmSym+dBGzrMen0xCyW3bGwpQfsoLaATumYJE=;
        b=HltqOJbbhUckCadawzMW+k9co2wf9lV/12UXkApcp11UwtZ1Z+6C11lyhW0Hyp6KHs
         6AFcnugfHKFH6Rw25/4R+BHEzNCdKRGZU6Nio/mNw7aNkVEjXOOT0X7sR1jk5J/xR9CI
         aF4O9H1NSgP0Eo/kKqQxmklVPWj+Ul5W2ksRQKiE3SCsAbs9L6qLKH4fKQCczkIbce2q
         f/7mABJ+qGiYcfmQ522oWnhAl65RIyyNsuY6DFWTQO10ykaRez7lR9RkikwnnvcOiNdF
         z7d/rWPy53/CN15FUTvPTPkalyIveoZk7ir8xEyAXyTxpI9tLJPwEw6x5/5wAfiT2y3X
         rDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534884; x=1707139684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEW5FFJmSym+dBGzrMen0xCyW3bGwpQfsoLaATumYJE=;
        b=DKH/4bwCezIVhlbOzLO+wByGOdqA4QCY+Exns+gRtBUJo9VjR9dj39VSfj+ABfQ5R/
         ArP20eqNgmPEx5/xOyAwM3j2ohCGCKrsweDPC4tG/27QP7Z3heBQEBs4pZsPHICKuJ7J
         AkfSnNg7xfd3dcxSa5DGlrRA74S2yUIclGKumaYL0b/KrVz3Qzi7x/AzYt8R1RhWY061
         /IfcFGBqmLf8+c04JfMRw8YRraZ8m0D4vwF3V8KAEf3Em05G9DQn1InGsgpYTN5Ne6Cd
         C7r5UpbM7abjwPO08VAmN5PKIIf9ssXRroPXT49hk/WCsm18hnJAag+Yh3zz7WaxgA5V
         xYqA==
X-Gm-Message-State: AOJu0YwZyac5pRmWO5YcVWaNdCT3RARbPzxr0Gg/6Nd/LwLyQlY5hEm2
	s1Douww1PDhbVv/LUQ8OeSru5NQqA9ThxrCIWEJBOkcEhPCIi/KvOl9R1e+5
X-Google-Smtp-Source: AGHT+IHQVDolaz+ffC6XiNrT4BeaNr88NXOtb3duEA/A+VZYN26KAYDkaRoAxW8iptbY8Bz1wmyxow==
X-Received: by 2002:adf:ef90:0:b0:33a:ded0:c309 with SMTP id d16-20020adfef90000000b0033aded0c309mr4390143wro.13.1706534884624;
        Mon, 29 Jan 2024 05:28:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4c44000000b0033aeda49732sm2734130wrt.33.2024.01.29.05.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:28:04 -0800 (PST)
Message-ID: <426374ff9b3820512f73ef094f9533e6a1ea5cad.1706534882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
	<pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jan 2024 13:27:58 +0000
Subject: [PATCH v2 2/5] completion: complete 'submodule.*' config variables
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In the Bash completion script, function
__git_complete_config_variable_name completes config variables and has
special logic to deal with config variables involving user-defined
names, like branch.<name>.* and remote.<name>.*.

This special logic is missing for submodule-related config variables.
Add the appropriate branches to the case statement, making use of the
in-tree '.gitmodules' to list relevant submodules.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 159a4fd8add..8af9bc3f4e1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2803,6 +2803,19 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
+	submodule.*.*)
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
+		__gitcomp "url update branch fetchRecurseSubmodules ignore active" "$pfx" "$cur_" "$sfx"
+		return
+		;;
+	submodule.*)
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
+		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.gitmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" "$cur_" "."
+		__gitcomp_nl_append $'alternateErrorStrategy\nfetchJobs\nactive\nalternateLocation\nrecurse\npropagateBranches' "$pfx" "$cur_" "${sfx:- }"
+		return
+		;;
 	url.*.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_##*.}"
-- 
gitgitgadget

