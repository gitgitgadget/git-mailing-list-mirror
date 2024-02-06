Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45511CD13
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256259; cv=none; b=bQIoJMm1OkphWW5PQQfdKd0v4xVZJ9XpqzZB5uwcx5X5TF8tUMgLD/E8EEKYfHEWapyQypUYLHt0Fw2y2w2qdjWYLw0nu2EGcejhhP/5OtOzLxrULW+Jqeu+k416IGdQG1kpiBprUgDLLOJq2c8Y7eAMPUWXIhgwS1rRWEuiX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256259; c=relaxed/simple;
	bh=G5akGKTKknNmJ+zrE9HVQYXcYA5L3tIi8BwfKaJGjPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlTYvTD5m0fxztJBIbXnF92kA8mYrr9EAsm/G5Kzlhde8OOi0Cs4tFeWnGDbyDlDh5y4wJcwhj00y90Jmzj4qk4AWCHOCQ08HzxNU5vLC8hOMuqOJuVbYZ1eMGcKr23/RRYs4ShGxtj/QGERnzIsYredogK1gch+3kI0YFc37Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTxQCwp+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTxQCwp+"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso5449074a12.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 13:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707256257; x=1707861057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX75AupbzdtffGjjfQ6zY6ZcGUePQxGLafYHPAWcbDg=;
        b=NTxQCwp+Io9J8Qbg5tB0AR7A/uWhOsbTzqYWxCz7U1yqKOs9+PYbLPV70oArimtmgp
         wyBNiB7vSvPXvSQ+XwVgFXt1/5ZcPzX943fpIbDwtYub/gSAar4eDA0goivn88vvvkOu
         xka/+aaI6fzJUEZyH8jtaQ6HBo/V6EizJximsPUrPtpQiln9eD37wkHojgmdoSmurmgr
         VVxiB4iDor27DL4V1MzohDUedgOKgDYTdWCjSok7apT3lTnGKszv5zWJ7dYzsU0Il83+
         i8QQ3SZvAJtXaesnKlu+truLnIchOHmsTyv8FMzh5QSuDkfRF5IIsiZwXuzDUKItgPsy
         It5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256257; x=1707861057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX75AupbzdtffGjjfQ6zY6ZcGUePQxGLafYHPAWcbDg=;
        b=kp0MNiVR7byIjh9W2W4L3/ho4cyfUV+DR8wE0TrKj3sMxSL8PuBD+jKNUSQcw02U1H
         L2CF9+9vAj5KiCU+qIrxIeiIsDjOvEaUfRB09nEfRiini5H29V+DMwblCzI6en4F8ULR
         kBy4Ub1BCtHrqVIBOMN6c5LUxMm9GKj8ssFSEWwFF8d2XsocxCdEq+CasCLnOgYyqqsm
         aLaeEHRGn4PB91oAvNwi74Cm2P4gwncWsztbL2NXMV3gkx55O77ufw788/1BXPb59mCN
         b/b3JbKRW/Ww+LGLHnDUbb3s4KVPx9UDB01IHGpVY3o1/gD29SkZ8LbmCiTwxba0vN+C
         NqaQ==
X-Gm-Message-State: AOJu0YyaSFw3VymqhcKXUWsX4zDH6meavO4CTHCD2E8ssq9I+cJhtQkz
	tksXPTjMV5m/7Hf0eJaJ6Iij1huaKddhqayfMevVkJU0lVXLMkmndnEPQxkV
X-Google-Smtp-Source: AGHT+IEuNKjuUHvWHGrjlhcjTMyijYWw435D2KNQLIjlKVdSSRcJGP6zJYaVMDhpojC7JiKRcnukhw==
X-Received: by 2002:a05:6a20:3c87:b0:19e:4a98:ba84 with SMTP id b7-20020a056a203c8700b0019e4a98ba84mr3206537pzj.22.1707256257083;
        Tue, 06 Feb 2024 13:50:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWfp0GepxMzQj82t5JPNHh9Iazov3uGSNZ192PeKUGmBgGnLPXePu+tc+G0Vooi1o+elSXoEnc84OrRbQdgo2vC4dMahSBrFpp2ZvPPlzYEA3GG
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id z30-20020aa79e5e000000b006ddb0b0ff0dsm2458938pfq.34.2024.02.06.13.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:50:54 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 504845202A5; Tue,  6 Feb 2024 12:50:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v6 6/7] completion: bisect: complete log opts for visualize subcommand
Date: Tue,  6 Feb 2024 12:50:47 -0900
Message-ID: <20240206215048.488344-7-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206215048.488344-1-britton.kerin@gmail.com>
References: <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206215048.488344-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arguments passed to the "visualize" subcommand of git-bisect(1) get
forwarded to git-log(1). It thus supports the same options as git-log(1)
would, but our Bash completion script does not know to handle this.

Make completion of porcelain git-log options and option arguments to the
visualize subcommand work by calling __git_complete_log_opts when the
start of an option to the subcommand is seen (visualize doesn't support
any options besides the git-log options).  Add test.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash |  4 ++++
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b9ebd5e409..5337ae4ce2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1490,6 +1490,10 @@ _git_bisect ()
 		__gitcomp "--term-good --term-old --term-bad --term-new"
 		return
 		;;
+	visualize)
+		__git_complete_log_opts
+		return
+		;;
 	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip)
 		__git_complete_refs
 		;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8fcd1cfa7e..b989388e7e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1361,6 +1361,21 @@ test_expect_success 'git-bisect - options to terms subcommand are candidates' '
 	)
 '
 
+test_expect_success 'git-bisect - git-log options to visualize subcommand are candidates' '
+	(
+		cd git-bisect &&
+		# The completion used for git-log and here does not complete
+		# every git-log option, so rather than hope to stay in sync
+		# with exactly what it does we will just spot-test here.
+		test_completion "git bisect visualize --sta" <<-\EOF &&
+		--stat Z
+		EOF
+		test_completion "git bisect visualize --summar" <<-\EOF
+		--summary Z
+		EOF
+	)
+'
+
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-- 
2.43.0

