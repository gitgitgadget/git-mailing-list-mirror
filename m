Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8F23FC54
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981581; cv=none; b=kv6faxzaWN7qNuywD13gZ/XXtx+6JGgOVP2UcZLzAMSCy6GoFuzKU9YYzsGjZPnhxPjv42NL6OdJNKZgMh0GaZznkrDtrCjTj+O98FGSIenZpCustyE4TXmYo2oTTgezW/8pl5W6EHuY5Q0VqxBOmkfTgWCvBWQae/czLFi7shY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981581; c=relaxed/simple;
	bh=yVDyX0bffJj4c5QgIt8gY62HSAfad99jUZLamnQwEMg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=qFuAlqg5LCTW3L29WQVpLicdgIZs1GkfIdXD59yQ1uCqoivKIT/JLdcJDP281blLz9d9NkDK2yZBuV7Qx6mhteByZHqFP6AwBnMm+ktXRvNMDwaTs/D+6UPaPKyswl1ZoeZxgP0hAtfffI29d+bihCwx1HasKYVREeo0E+ZDWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwG+6iqk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwG+6iqk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2907948c1d2so49431055ad.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760981579; x=1761586379; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2t+LSe3eULY3+Mpf/Mk4dHcvnsbFKQzNro2HKCoGHU=;
        b=VwG+6iqk2B3LDrvPMw65Om5Ibc6xAl0B8GaHVnG4NkkANrUFfXyFNpOFtPN2Kbn/yE
         x6y0toGVXvyt6L0ATQA8DWeK9Qe5s0Yg9lWidSM2JKDJ74tvqBOBPCHLRgZUytTsVWU2
         eAJNifVQSm/agkq9AUO71uUOV97EJw5UZTVL0CM6fOyno4qQRUk5DU1NWhvxZBS2wc1l
         /3fY+XxbzMY3uxF+goeje7R0GopbzWajwUjfLZJXodxNUyk0R70pIb1EQOZntehQjAK0
         6ZhQwApZBjsJrNSFDVxsHWyFiTpW6B1StH7Re0K4zOh6V9r51I4mhKJyVCHAvzA4dInW
         jOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760981579; x=1761586379;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2t+LSe3eULY3+Mpf/Mk4dHcvnsbFKQzNro2HKCoGHU=;
        b=m2QsBll8IgcEgwA2d8AjgrECcwkR1IikTYd4nIiJhyuQna8Nj0dz2KznQbi1/2Qp0M
         vDkg+i4E5jz8wKvPE1ucUPSk4mqILzG4JzMiRSrQi/8GSMDBt77iaoj2EEioQ74f5plQ
         q3O+94eruEYCKdJRiAdC2EazpXmEVUqEfy+EC1CGtGocgkcKtkEGjuVp49iUw+hO4NMi
         rH2wrTZXLe6P8nx0Zy4xn+RTys0XrLvisR6i6zxrRo4iN3gNZBw65shq4CN4y67rv+Nb
         yhwGsSRCsuORD3ifD/ef762B5MhUKvHFjEDI9Fn6qMHX9aiAeyQaPOLyLHv9hvaDOna3
         z0tA==
X-Gm-Message-State: AOJu0YynZXMBRXXg7VR4ijlwn+b5QQwgHJ/2bMESkhZ5CfJSwRuAlOeX
	VFXFDrdrpVGz5/xm4iTQki37ihmvw+EzeUFZ9RXrb6s/f1m4Bko4GEZdIqp61A==
X-Gm-Gg: ASbGncvPiF8uXaD/jPA/vwxVRc29rXOLAtTB2rdrltrQaYn72EXPXxoTiMaLhJLaaiK
	4YkHIkI4CBEszXtlAF5HuoA3ZCDme3WloXHG6fbvStHvPJhGRoq0D0zyOUYltWLcrB097ZcAMlb
	ghaXXOX/jjxGcmH0NtDMUANq5Q88Ep295M6//vEN4M4iBKXihhzyJcuDqpDVjT0ko1B77tl1grR
	qDEbx01ikHN+qb+dWDEKCCjANx69VQcKnjRyeY0Ue29Xi6NkfXy3aoI3scWFncN3Psi2D6fX8mf
	Zwwl+fvMVUDeN0FnF7oemfSnY3HyKFSJ9B746ayMHlebUbHQgwxh3MP3wHzHE3zwiyhBmA8esx+
	iQh4J5vu/i6OKmFB0i4TAitQYnDCcszl61r66OISUKnpKlcf3DSfPGGQxc/DB335ixIkxagl1dM
	phUb0qTGRQ8tx+9Q==
X-Google-Smtp-Source: AGHT+IGHujfvDroIOSJ5byPX4P2XbZ64I0oXNEj4z+3F3Le0ZZzGhDNfRaTiH+sGe6FtMcmC+nIkgA==
X-Received: by 2002:a17:902:d50a:b0:27e:f16f:61a3 with SMTP id d9443c01a7336-290c9ce166amr178430525ad.23.1760981578757;
        Mon, 20 Oct 2025 10:32:58 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472193c2sm85769805ad.104.2025.10.20.10.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:32:58 -0700 (PDT)
Message-Id: <pull.2073.v2.git.git.1760981577441.gitgitgadget@gmail.com>
In-Reply-To: <pull.2073.git.git.1760878666840.gitgitgadget@gmail.com>
References: <pull.2073.git.git.1760878666840.gitgitgadget@gmail.com>
From: "KIYOTA Fumiya via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Oct 2025 17:32:57 +0000
Subject: [PATCH v2] completion: complete some 'git log' options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Revi Ewer <revi.ewer@example.com>,
    Ill Takalook <ill.takalook@example.net>,
    KIYOTA Fumiya <kiyota-f@asahi.com>,
    KIYOTA Fumiya <aimluck.kiyota@gmail.com>

From: KIYOTA Fumiya <aimluck.kiyota@gmail.com>

1. '--exclude=' option to 'git log' and 'git shortlog' are missing. Add the
option to __git_log_shortlog_options.

2. The `--committer` option in `git log` requires a pattern, such as
`--committer=ba`, but in `git shortlog`, specifying a pattern results in
an error: “error: option `committer' takes no value.” Handle them as
separate options for completion rather than a shared one.

Signed-off-by: KIYOTA Fumiya <aimluck.kiyota@gmail.com>
---
    completion: complete some 'git log' options
    
    Change since v1:
    
     * Make the commit message follow the Git project’s style.
    
    v1:
    
     1. '--exclude=' option to 'git log' and 'git shortlog' are missing. Add
        the option to __git_log_shortlog_options.
    
     2. The --committer option in git log requires a pattern, such as
        --committer=ba, but in git shortlog, specifying a pattern results in
        an error: “error: option `committer' takes no value.” Therefore,
        I’ll handle them as separate options for completion rather than a
        shared one.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2073%2FFKbelm%2FlogCompletion-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2073/FKbelm/logCompletion-v2
Pull-Request: https://github.com/git/git/pull/2073

Range-diff vs v1:

 1:  2887b0e6c9 ! 1:  d8edd3653a completion: complete some 'git log' options
     @@ Commit message
      
          2. The `--committer` option in `git log` requires a pattern, such as
          `--committer=ba`, but in `git shortlog`, specifying a pattern results in
     -    an error: “error: option `committer' takes no value.” Therefore, I’ll
     -    handle them as separate options for completion rather than a shared one.
     +    an error: “error: option `committer' takes no value.” Handle them as
     +    separate options for completion rather than a shared one.
      
          Signed-off-by: KIYOTA Fumiya <aimluck.kiyota@gmail.com>
      


 contrib/completion/git-completion.bash | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3d88b0672..73abea31b4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2218,7 +2218,7 @@ __git_log_gitk_options="
 "
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
-	--author= --committer= --grep=
+	--author= --grep= --exclude=
 	--all-match --invert-grep
 "
 # Options accepted by log and show
@@ -2296,6 +2296,7 @@ __git_complete_log_opts ()
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
 			$__git_log_show_options
+			--committer=
 			--root --topo-order --date-order --reverse
 			--follow --full-diff
 			--abbrev-commit --no-abbrev-commit --abbrev=
@@ -3229,7 +3230,7 @@ _git_shortlog ()
 		__gitcomp "
 			$__git_log_common_options
 			$__git_log_shortlog_options
-			--numbered --summary --email
+			--committer --numbered --summary --email
 			"
 		return
 		;;

base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
-- 
gitgitgadget
