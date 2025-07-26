Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA04285CAC
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753548828; cv=none; b=HGDqU9W/nYZbBpv8v7rTM1d2f/aDgp9WMsqkJuhTJsjsF5Z1KcO4dBeLA55EhaPBD3TgBDnjzWfRa+89gKvDRvZUABu+ePPvXGiMxtind0Ca52hXvNuul4h1WkEzyWvoja1dsoORy6bF0+sbJzfxyLzV9vOgntVWHN2ssH+aqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753548828; c=relaxed/simple;
	bh=raqQFt6S4MTj4gbS3HHAqDG/RNCkUike5gPaxED3OmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2s0T/erKLCOOE9cigL1kVay6i3bRgTXPruknXYmuaybS/c3v8DZi4ZsRxOpmCAo3gO2jSO+zdie6f/43zHZrPL0XV3JIzw4V+2Yx3HD+7UqPb6RKsPU8iClyoZtk8dC/E7JtB0SnEc+PAbiZIXK6RLZqg7evDgSaS6QWzf0FtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUvEQ1B4; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUvEQ1B4"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e75f30452so21406817b3.2
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753548826; x=1754153626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjhy9RZARTN0D9DIrWbUxyd0878K1S8RzpreyOQ0ayQ=;
        b=OUvEQ1B4O5ywYEHhd3WfJjTStdCDEt2wwPyPS8qcEsnlFXzv3w0qExzplO/aIhUjYw
         pM76lapUugM/dyNNloniPKUiU+2lauqjA+lsRMIUg5VnGNHeEaxvP5H1xePGzzfGpwga
         eT1LVbtfQ0dNmQSTWcxUbWkzaypAjLit4s+EdvGtMcO2ytxHYPYQKwooOLBpTfcdRvsw
         eeUlCMM4L8OCTcynBEBgklJI1R8+SoqwktQnSQ/HqVcj9oGO3uK0lG7XWcj0NE1SEpN9
         JnbWgWEeOrY95vAdMLAeVII/wZB+6VyCbvE/KuU7CbxzCTV0d7MHJsvQeZ+GLO/T0dNm
         ycMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753548826; x=1754153626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjhy9RZARTN0D9DIrWbUxyd0878K1S8RzpreyOQ0ayQ=;
        b=ezqmMFN9TBY3fOC8gUnrXjHb99ZyW5nkcc1+glJeCbcTuDh9aCdl7xwETLiUnjv/vq
         AjxvvtRbZ3IfVmIVFHJ5+gaB3Kj66Gye3C2rE7ww4cO7Oe3dqwisni0BQHSFu7s2rJYx
         kdhGtaCgTXAIOgUhOnDqElU8KiRnUg4RfG50GpaeaIJp82EpWgg9df6zFYSXwRDtd+xL
         wED2f4vaKgiEh3pcKgH5cO0livkb1kB7/tuNV8mRI1kbIehdpP0SZe9QN/q2lvrgAvsl
         e2i+P1Nf/Vo5P2LyafZM2fEzpODT0x0y2RUmxuVIw1V2h/fLDE85SB3Zia5sFuqJMJUf
         MXDA==
X-Gm-Message-State: AOJu0Yyp/Njs8Dx8q07XbC2oVZJYiucmw7Ue2KXW93VsIUFsqdl2gmuI
	d7HIpmioAnNWmFQxNkrKjMhzoO14+HlQSvB3J+sIvx12nz34+88BTWOHs8dzODfd
X-Gm-Gg: ASbGncsd4QeB8QyuWFKv635Zo6TA+EBVuNVCRC5NKCILxv6e3kspuJ8+7B783U95IQJ
	7HHuB8nTsB11LUJyfpYKFmLfbiqPpikOOZYe7e9r/XI6oZOiBd08TIkJzpecF4/ZjgK487uQmlV
	RMtXECF1IBamEhvcsiWuANRlpHABwR92m1v8WTe5Nj3WxX275wySumyx6km5/83O8AZ2ZYu0+B4
	EtVf1ErGJMcQuZHDJQPQA33Jbg2ILNsmP3xGJJpIEFTKfJXiuHdc/4AA2o0/RWnEatbPUYDV63h
	EEPfwdj8nwUKVB4dkbK7jjzzN4RnRV6YGEZOS9gFnbIFCF38KxrUERI54bqKRl+ESK8R39kThDS
	oZvhqMqSuZZbDcdA4S2HXZ9AP9OwOMB/tKcmqx/6vXP+D/bIq2vwwGqyyw216o0zVzz9sjIIf
X-Google-Smtp-Source: AGHT+IGSJBATYOe7qrrbVl1+jLNeY6XFqmGpjG+YmMs2PgOWjCIE+GKq7ddjktSe9wW2DuewuYC2QA==
X-Received: by 2002:a05:690c:9c05:b0:6ef:5097:5daa with SMTP id 00721157ae682-719e3472b77mr76323197b3.34.1753548825836;
        Sat, 26 Jul 2025 09:53:45 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:2412:fdcb:5dca:324c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f2152de0sm4964067b3.2.2025.07.26.09.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:53:45 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/4] t1517: fixup for ua/t1517-short-help-tests
Date: Sat, 26 Jul 2025 12:53:11 -0400
Message-ID: <20250726165320.4039-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726165320.4039-1-ben.knoble+github@gmail.com>
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- drop spurious message during test
- fix known breakages that actually work
- fix new t5200 test

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

I expect this and other fixes to get squashed into the upstream branch, but I'm
including it here so it's easy to create a clean build.

 t/t1517-outside-repo.sh       | 5 ++---
 t/t5200-update-server-info.sh | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 9443c0284f..e235ecccde 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -115,8 +115,8 @@
 	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
 	http-backend | http-fetch | http-push | init-db | instaweb.sh | \
 	merge-octopus | merge-one-file | merge-resolve | mergetool | \
-	mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
-	remote-http | remote-https | replay | request-pull | send-email | \
+	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
+	remote-http | remote-https | replay | send-email | \
 	sh-i18n--envsubst | shell | show | stage | submodule | svn | \
 	upload-archive--writer | upload-pack | web--browse | whatchanged)
 		expect_outcome=expect_failure ;;
@@ -125,7 +125,6 @@
 	esac
 	test_$expect_outcome "'git $cmd -h' outside a repository" '
 		test_expect_code 129 nongit git $cmd -h >usage &&
-		echo "Hello" &&
 		test_grep "[Uu]sage: git $cmd " usage
 	'
 done
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index a1f129db4e..a551e955b5 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -48,7 +48,7 @@
 
 test_expect_success 'update-server-info does not crash with -h' '
 	test_expect_code 129 git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage &&
+	test_grep "[Uu]sage: git update-server-info " usage
 '
 
 test_done
-- 
2.48.1

