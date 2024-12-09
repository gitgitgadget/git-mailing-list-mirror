Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD6150980
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763085; cv=none; b=Ov4Wsy+6RnHqD5AnR78pSh0VimvmrHc3aWvWTwIGZTvD/V5P8EBrz6c5wL/M+78HyBvxT8fGwPQAfT7ugWrfmneUYZ5hY3isbl24EpOWDA0dyRV4eP52/ro/dzFUosNcRTNyOCzAkas6k1auEA9gjH5ukzo1+fiZcGJoFqMM19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763085; c=relaxed/simple;
	bh=pzDeZ3DSmvYGy3VbHSeHsAPU+GWiOiAb//hKYq4y66g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOrAK3q6A2aiB1jyvq1dJpsIFiIR6lp7RWYqCsUsFQ2bttKnv/KdeqBr0DkPfZcnV7kVH3ok9Wj7Q8BzNsWHrCLKYual7a8d78eYnJcTYnxmR5X5kdPu4Qwl0VEP+12Inf5B6/QZo+jm6aohjXLu5+5kXgrsJmMF8GX3VT2cuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDRd/4Xv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDRd/4Xv"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa680fafb3eso16885366b.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763082; x=1734367882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVfWyFkCjAPIQl2JhELKMRT25GIIVVZLVGqa0/iWq8Y=;
        b=nDRd/4Xv8JfcbdIxiqVxMTPyijB55skM/LDOclutoNkaw0oQQTpSuNtIqyHxfdMRJ2
         Se/XqeRznE75/WEVl83LmCMrW/xFL13UwK4TL7YuEBzfT+XQ+sll4+HrLt3pel5X4VaR
         BrAFnSua5mzVNF7m5mR2OJkRUYc7tic+yWOkgeRgCrgU06FZTyb78LJ1fssKQuMP2rX9
         hFfFnTvcPEWfgJKcG4Y5wnwiLZoDd4XM6bajV4FKyMeGEfqnKNd7Sr9cbLMYoJ1SLOhJ
         spHeOj6wjady11vx6rO+ljs8A7KT90e9PScpMA+GWcHalWuQuHzagIP+R4i13RCzGs5D
         b+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763082; x=1734367882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVfWyFkCjAPIQl2JhELKMRT25GIIVVZLVGqa0/iWq8Y=;
        b=uR+T6ORUjqFR3V8ouY6ZIszEQD+SaIHx7nlG6bI3gm3NAgP4zGsd3ZhEWtvhZOBp33
         P3WpEgiLO0NhFtW67Lt/thO0UhB5f61CpN36tn8GUqyaCL7a/vQfCUDshbs/YDWq5sn9
         ocplKg0t5pdBfwKMC9KQsNIs8Ou2YQEJtKEI9zI1QSVbE9pYwsUzkYK2a0TA+JbmULPS
         OxjMzjJlrc9p6ZtopOxHVTUeiN+HTK4cjw1CWa4GmAOu0Q4wd+6PoT/FoQnRetHEYy9i
         Ve1E5PUfAS5JSV28ptZ51Jrr3DnFPc+N94//LAJNwvQAgr4A5knKG9EmVi5km3qy2e2+
         laoQ==
X-Gm-Message-State: AOJu0YxkjfXEaReoVFqFz4LCgCD7bPqJQ5WWDEwuHQkvf+z5eHAyZEgN
	fU0KWP4b7QQPLSq69vr9eXOFHl63oR4ZIxc5CFdUmk0B5RfYDdMFDhXae/gO
X-Gm-Gg: ASbGnctD8HzBfkcwvexBxs74X3IR96EK9HJvN+z+mScszgHkgG7mxIT60OfA13ANhYl
	Di3yuI3td2PX9Ann/NGowwdDuchoByi7jzTxpE/HUGYKrviTbQy2Q+Xe2ThycUgHAQhOs+u7lwy
	W6eNILk02JZLgEOGuyhb0fj9a+RTMDa4XJ+QC6pRPaGAJpyjfRkvmWT2OODZjEc2QwcS9/JcOLa
	M2bUJIqP8mhPYhfIQta9oB5OwIoSSJVBXvSX+ReGs9KDsJp8ZwTK2eD4H8=
X-Google-Smtp-Source: AGHT+IEjMtTvHtZPkU2PnyLWZVrRHT13Yy4Bj6WhOaCMEBDCcq2Y2s0GDFHbG6ueRvwtdYCxQNG39g==
X-Received: by 2002:a17:907:7285:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-aa69f13df7bmr15636666b.3.1733763081948;
        Mon, 09 Dec 2024 08:51:21 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm300539766b.102.2024.12.09.08.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:51:21 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v2 2/8] git-submodule.sh: improve parsing of some long options
Date: Mon,  9 Dec 2024 18:50:03 +0200
Message-Id: <20241209165009.40653-3-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241209165009.40653-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
 <20241209165009.40653-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some command-line options have a long form which takes an argument. In
this case, the argument can be given right after `='; for example,
"--depth" takes a numerical argument, which can be given as "--depth=X".

Support the case where the argument is given right after `=' for all
long options, in order to improve consistency throughout the script.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 107011f613..a47d2a89f3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -77,6 +77,9 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		--branch=*)
+			branch="${1#--branch=}"
+			;;
 		-f | --force)
 			force=1
 			;;
@@ -110,6 +113,9 @@ cmd_add()
 			custom_name=$2
 			shift
 			;;
+		--name=*)
+			custom_name="${1#--name=}"
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth="--depth=$2"
@@ -425,6 +431,9 @@ cmd_set_branch() {
 			branch=$2
 			shift
 			;;
+		--branch=*)
+			branch="${1#--branch=}"
+			;;
 		--)
 			shift
 			break
-- 
2.30.2

