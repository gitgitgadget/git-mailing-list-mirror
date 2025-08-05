Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918829B22A
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421057; cv=none; b=gaNO/nMVXk04Eo5xSADbNJIaI4sAAuClPI9hIvOtGT2Fe3vf9r4LJhvpMxVjWWnuxhmfPJparzM0JGX9UIILo4TWHt82R9ZsYzjnMweKYS7CXCJdFSLD0k9VYXEmUhNtcwbS+OdLMyDLmmkdlIZnh0mBKOvzrmNiCbdz/cLH4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421057; c=relaxed/simple;
	bh=d9ezMIVIq+R+m8D5+9DdMQTya5EKbzurlEgcOosAoE4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=hBzkX6Kv6GL56ZV355heIA35fntFWUnW0yuQk9uR72N6odVBk3qt8mHndn157svQWn9gimcQlFJdswUTVSea9X+knBD9xr4U557E4SKrjeAqoMpy4k/II+nscncaicpLkriVG1KbFHLSH1f+0hU1GR54Owd4gcMyflmxq6yR9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2gzmZ/M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2gzmZ/M"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b00339c8so38147475e9.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754421053; x=1755025853; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bV6/C4OMb77RQnDks9xjloZU1Cy/ufUvEVa1Lttyak=;
        b=X2gzmZ/MiC13C4VyC6FFYk3jxQExbKEHhloW7l01UfRHnzNLaXYn0oEtGjizKwvHhY
         oM1Hg+kP4rmMz7jiqeJtfdxgyD571noXhIr/cVPhsWSHmOtFwYxk1vQJQ/I2T+CMa2I+
         apIfJAY1V2MJjQWEiYpSb98pb5gdSZV5igUgV27CGhoED8SLFcjjwkcAFaoA7RWdNivQ
         zC+9VUy9a3TMJCWCqWB3ctKsw1k4b4AEVZD9QpQXaKfCdorT1VYpY0neKHSCXc3KzjZq
         dOiDNw482aLYDCF87i9TPijl5/iWzotGABBDvM7P+xkBFJ8Dc6zlJOcQeE2vZBEOlH1K
         xCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421053; x=1755025853;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bV6/C4OMb77RQnDks9xjloZU1Cy/ufUvEVa1Lttyak=;
        b=R7YAoT4oThLEPop5QIxkOZ8EuXpN/ve9oGMVe/eH2HCJtZfoDKBFl0vqdjs8MNV6Fx
         6JpbDmUBeCcHd6babZ86p+y4wc7qW/n9UDQLsxa39h70xzkETRvT1dK9DExm7+/x+iH6
         W7lqEcsqpBTJPCfX+QJXmw0ITKrUZyPuXk1lybtTzvfyplhHNpYCYoQfVRdOc+gbY8H9
         RHlOsE68MUmUBRLxv8F4+HVIa8JRoXstLfFxVntFPt2mUSasAk2Q99ieZtnhxltES9Pk
         tRXSq2eRM0zG3t6yA06mxTuyseFpwrUj/9V7SRYf1TuyikvD75+hx88vbEgHlq45Z4gS
         3apQ==
X-Gm-Message-State: AOJu0YwweHQkHV+4LquSNwk9rUJKhj3U5BelPQwB35wGw/abzMT+ELT3
	jKJLW5A+lxgUk/XDRRPtQAALdid8SdZWbiiFOdxyivVg0ZwK8eXVaW2JPwlU7w==
X-Gm-Gg: ASbGnct2h+3A4XRamucQfS2eiqkLBmQifKFMZLJEYxW6UkG2ZSNhEIfNde8oZxlh30+
	p7Dbt9nPIgh74aw+w5jYYBLvX33nDadEFiDQQfrgGEodcSetLShTQ2C/P67ukO64HHAiTthtwRj
	ka18dDoaGIeue21Lx07JMHk95ZZmAfIaUOFZikRPLgZ7uHeMohllYJ+YehE9rRUvlU4jAcL/Obn
	WhU4Xo4jf05qXk+H8SHVBUDruvQEb1ehLVw/NWNLHbXoRjVI1EqgvaxjiYigBVViHvTxkCAOBdw
	KG6q9KnkRqs8OfgcAhX+9ZTOvSYD8f64oBmapVet4MmMzvmMpQfFfP/3DkUgL4QoUlVMKgbtQAM
	xn2iq4w2blGO6IJqWv7/vga8=
X-Google-Smtp-Source: AGHT+IHR4lwk0fDKlCs2V7QbyoLuBsVt9Y+Hnz/5Tg32iYGO9K8LAQi5jxoXUeimOus6kFQikfbw7g==
X-Received: by 2002:a05:600c:45d1:b0:456:8eb:a35c with SMTP id 5b1f17b1804b1-459e7122a05mr443725e9.31.1754421053133;
        Tue, 05 Aug 2025 12:10:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed0ecsm59951465e9.4.2025.08.05.12.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:10:52 -0700 (PDT)
Message-Id: <d57478ea5cd8fb6166dddcea30e72a42df79ba2a.1754421046.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
	<pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:10:45 +0000
Subject: [PATCH v2 6/6] doc lint: check that synopsis manpages have synopsis
 inlines
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

When switching manpages to the synopsis style, the description lists of
options need to be switched to inline synopsis for proper formatting. This
is done by enclosing the option name in double backticks, e.g. `--option`.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-checkout.adoc             |  2 +-
 Documentation/git-refs.adoc                 | 20 ++++++++++----------
 Documentation/lint-documentation-style.perl |  6 ++++++
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 40e02cfd6562..ff1cb29bc1f8 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -334,7 +334,7 @@ include::diff-context-options.adoc[]
 	separated with _NUL_ character and all other characters are taken
 	literally (including newlines and quotes).
 
-<branch>::
+`<branch>`::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
 	branch is checked out. Otherwise, if it refers to a valid
diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 4d6dc994f92e..5d26de8acb22 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -20,41 +20,41 @@ This command provides low-level access to refs.
 COMMANDS
 --------
 
-migrate::
+`migrate`::
 	Migrate ref store between different formats.
 
-verify::
+`verify`::
 	Verify reference database consistency.
 
 OPTIONS
 -------
 
-The following options are specific to 'git refs migrate':
+The following options are specific to `git refs migrate`:
 
---ref-format=<format>::
+`--ref-format=<format>`::
 	The ref format to migrate the ref store to. Can be one of:
 +
 include::ref-storage-format.adoc[]
 
---dry-run::
+`--dry-run`::
 	Perform the migration, but do not modify the repository. The migrated
 	refs will be written into a separate directory that can be inspected
 	separately. The name of the directory will be reported on stdout. This
 	can be used to double check that the migration works as expected before
 	performing the actual migration.
 
---reflog::
---no-reflog::
+`--reflog`::
+`--no-reflog`::
 	Choose between migrating the reflog data to the new backend,
 	and discarding them.  The default is "--reflog", to migrate.
 
-The following options are specific to 'git refs verify':
+The following options are specific to `git refs verify`:
 
---strict::
+`--strict`::
 	Enable stricter error checking. This will cause warnings to be
 	reported as errors. See linkgit:git-fsck[1].
 
---verbose::
+`--verbose`::
 	When verifying the reference database consistency, be chatty.
 
 KNOWN LIMITATIONS
diff --git a/Documentation/lint-documentation-style.perl b/Documentation/lint-documentation-style.perl
index 11321a151bca..d7ab7322939e 100755
--- a/Documentation/lint-documentation-style.perl
+++ b/Documentation/lint-documentation-style.perl
@@ -21,6 +21,12 @@ while (my $line = <>) {
 	if ($line =~ /^`?--\[no-\][a-z0-9-]+.*(::|;;)$/) {
 		report($line, "definition list item with a `--[no-]` parameter");
 	}
+	if ($line =~ /^\[synopsis\]$/) {
+		$synopsis_style = 1;
+	}
+	if (($line =~ /^(-[-a-z].*|<[-a-z0-9]+>(\.{3})?)(::|;;)$/) && ($synopsis_style)) {
+			report($line, "synopsis style and definition list item not backquoted");
+	}
 }
 
 
-- 
gitgitgadget
