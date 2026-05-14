Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE573DFC85
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769246; cv=none; b=OmXdZezfb7hmY44jNNjHUeQ4zDSVT9WBvejvALqSvexGP9Ebz8617AeZQkcxmWPpnUDzuZrejIEe5/6C3G8RRnHapI2/6W2Xl0WUtE3crtc030svUFWu4XTPzAFtRFvB9Ujr/MuavANhUjFOAoBdTERvnk8ActCE0QpLVWXeM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769246; c=relaxed/simple;
	bh=frmNlcC4fhVQW+1lXkp3z74CbRClM11wSQOBpiiaAxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJDVMWV6pO9BByrOYvNQ8IaJYoYhiCtd/8Z3hG1Peo+XdmkJhzpfXfuky8e4Sby4eO8NFTX58M9VqhnDtTrPx1lLDNmLs7g6ECuXL8/9gHs1A0kWJ45EewnUYUMzIvKV97qh6d7/z0HgVl3+UtvWovQezcO6hn/VUjLhRqymZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHBmS6y6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHBmS6y6"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-90caad2e944so373501385a.2
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769244; x=1779374044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wcb6nGjOkRh4QbQ3iBa8506EFcfKUKIXQEpD6I3nUYg=;
        b=SHBmS6y6wv5jTphGhTx7AlDKgETqEbANIiP6mehPboHWg4Esib6TiAQKj+Sr7qt0rz
         C3k/GlK1IiUbvIUcItUghu2BtziljShBRzNviBSYvMMRJTpH7CryKUgXnGj3lylICOBq
         wCv+iVdum+gw6z6R6/+xcFoUOOoVf65kNDnbzMkmwyoWhIUv1Jviz3mSHU0hQDvP4a8M
         OiPOZY4+4npjBdYxnhQfd5A12tyojjeoahlu36fFvjHe58cdi2i5rAB2VifkjCnWvsQB
         cu+qdjW4nFcqlhp3R3YcV8wJfThoWWFQaXmhnR3o8H7mnfbM0xio7rYkj9hx0uUAHkhQ
         wpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769244; x=1779374044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wcb6nGjOkRh4QbQ3iBa8506EFcfKUKIXQEpD6I3nUYg=;
        b=rAluAhXmw4LDBDGBbNCirrS2umKu1f4vVAHX3fjd48MRrSybtIEXe5l9F9VAkJ1Cjh
         +9g9q/5X9Ydma6R5+iYwMzAB5V8elyX4vX6MxQXtElFaIhAaq5J+upfNtdol1vdCCpzI
         MziHRD7QNXWGrVlwgsKqyY4nMF1bX7soVGm3CZy/FCfLtVQ+bfzL8SgOL0+FPiQF2wen
         b8fGi75AyA+HHdSlOtDlfR6qrqRfqqBfnl9wctwjTyGnhiwzf0dtUKvnjOjRs2+ueXCa
         8kCsz8uMWHS3xY8tFHPGcfHSS2ojZbbpcr/Z4FXoUcTE7yDn1oJdr9po1QpifRRBAyUH
         mB1Q==
X-Gm-Message-State: AOJu0YyXV35SaJdJ8ujn+YeVy7+Q2yF1Mv6MhVISibbMdGG8WaaMSUAZ
	DHRGWniW2UkO/5BkxU94HCn007i924h0FL4Y7d58nnQidkf8tdjB9LAtA6NdE1sI
X-Gm-Gg: Acq92OGWEzr/AxBQRc0h3NpZMQD8uWBX8j/Zjqq6BBnPO5QVeBMobThSfIxW04I/Iap
	Al2GpolOhxRcDb3pMhL5vjacN1aT8gZaSSQ3R17Ts1cPdowkGyA32v1lDx5k/Y6IVxOv1XddQfy
	m7ZWIi54I4eitgzJTgNVY4sxR1PQGoE3JMR6o7cvtmq4kdgXFKS05py7mZ1QUIihue33rZYULWK
	v7f7mP5xDbRryzeAdnBpPV+yASF4ZWhEv7E/07KoNT2s28aUwlNERki1UQEQYtMOYKO+mkm/q+C
	nlfLfH0Gzvib/HpUT/vDbJihakXB7qcixrGIFXepHYlhzNZzz+kyTHg5dbP7rMl3G62Sz+p0+bK
	w8uOvUXEBoOAmmKkUS2Lc3AVGl+wLKdosNpzUVKS6idJTYchRfvt8v3W6rrDXfPuA9rgR+rALQM
	WmNabcOJo=
X-Received: by 2002:a05:620a:2720:b0:910:48ce:4e63 with SMTP id af79cd13be357-91048ce530cmr881385085a.22.1778769244501;
        Thu, 14 May 2026 07:34:04 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:04 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 01/11] git-gui: allow specifying path '.' to the browser
Date: Thu, 14 May 2026 10:33:12 -0400
Message-ID: <20260514143322.865587-2-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invoking "git-gui browser rev ." should show the file browser for the
commitish rev, starting at the root directory. This errors out in
normalize_relpath because the '.' is removed, yielding an empty list as
argument to [file join ...]. Fix this.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 23fe76e..6048f92 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2965,7 +2965,11 @@ proc normalize_relpath {path} {
 		}
 		lappend elements $item
 	}
-	return [eval file join $elements]
+	if {$elements ne {}} {
+		return [eval file join $elements]
+	} else {
+		return {}
+	}
 }
 
 # -- Not a normal commit type invocation?  Do that instead!
-- 
2.54.0.99.14

