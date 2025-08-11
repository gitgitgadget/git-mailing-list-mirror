Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42D2D6608
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945616; cv=none; b=QOiftKJOi2jYdk7/syfEsdgmLXIo7blwZJHtl2e5SEz4uuX6qn/+m+WijfMyhesmAjeA221EMOujrNEcvGTT27i/2O2kffmA0f4MvBRgeeeh30ug9V0bXsxqwtjM8c7iKl4p2hRlFHQazDGr2o594wSkG9XH7HVuv6Lj6MhEgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945616; c=relaxed/simple;
	bh=d9ezMIVIq+R+m8D5+9DdMQTya5EKbzurlEgcOosAoE4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=N556XbzTQqkPhnfyYS2CP4Q23jmgWyuKf3laUJ1K3zVlWaZEQGeR/Sd7RECp2AEWqQH56+wWcrMSG09qMdBSJnMin1UjGY7BStqxA0Hgxcpacn/A/GloEs0QDQwsrWd2me5pWEnO0V6t01cij8HyDgBqd1+v60OOl8PxoiNOV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGwCkKpZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGwCkKpZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso30891975e9.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754945613; x=1755550413; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bV6/C4OMb77RQnDks9xjloZU1Cy/ufUvEVa1Lttyak=;
        b=aGwCkKpZzxudr9ayTED6vlj9v5Fz5dKRI7OaTGHvrjLYNaGBNjWkq3KH5la7RcpSxp
         4gef+bufp5jh7E88SbyUI5aOrIAskEQ3/pctAM/os7GB/v/Gjij7NXxPzHXzHryrwE6S
         ZhM0vi2fuZ3dhhGUerXiiCYOC/4xwGxoUO4bh2vi0aJ4P3STEI1weV0I1a38//7Sktku
         /qu3wSvIeHO5xOt33iPCak/biMg7TMAiA0hNNqvfvslnk0JXRo7ZLlHWwnWFUDHyE17t
         SpU87e9nE1zwPI5n/qN5cOQFVRQrD/bEodOduTM+opCQPlRvg8w32dh5U/QU+1Th7id1
         bpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945613; x=1755550413;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bV6/C4OMb77RQnDks9xjloZU1Cy/ufUvEVa1Lttyak=;
        b=NsnqNGMXGexFYFZCLHG3jsYCUE/fgo+LopNczo9U9vIKb6DZIs6wTbXIGNzhR9eTFM
         XMM6d3DTXprr0vQrtcYvUtFJPYLk+MDLUWHdGA1yPs3hLDcu79TZEtqweu88RLdVOu4R
         XQSr+yglGDfdUVSsATyDloaYrWNpWlvIBS9TM5oEciUx3xZWPezNzPbDTCYoy0L8+I+H
         NsmnWdH2/hINXPqJ5Vqh1dGB+Xy1DmahJ6ZMeHB/0vBgTovs07SSDZq8Rq3h8tzf2tUw
         HbKll7yoy/GyOnMdW+yL8/ce3k/Fd0MN6kkfCQfvgWyyXJFd0CAlSfu4Y5rR0j8OK7Nq
         kRYw==
X-Gm-Message-State: AOJu0Yxh3NvcsSQvReF9jnCsBvWqzSncxLaUyfZUSbO0hhIHEBlDWEUi
	NKBhWVVK+WcdhrCfs4vMHuKN96sl3eI0Px+OE225znS1UB8/icsTgiArU/ooYA==
X-Gm-Gg: ASbGncvcYNCroFto5fjDUww4iv00Hr6gfZ6YR/FOM8cFDT2sce72U21zYX4LYhA69j8
	sZBmWVJdg1ZeEnRQa5a4qSUo3HSxRzNipy8cWFoTOHxJGbIEvNo/jeKoEwOcdZAHZS/YwwT67N0
	AgwnrM0Ks+Mb2JlunvVjH3L78u8BifJFMRBtU9ZQnfUgmgMNIz+/25wpcLNbETnUM8UZzbZZKvY
	NJxNk5nqip3OgpR0YEYpGaLXVqBQW4B33QbuOzGli8GFYYOkEVMZwCT8hLsIRH0FtBZxxbjmpO3
	KGCinwBY9Ok/Ca7tkwTaGlkCQTaIrTgQR8Dv1wZs0MgIYrJ2VcUzIepGa72x8RT4DD9bZYubZs2
	WmaJM0u9O5eZ94YH+0Mn69koOMMAOBeo+2A==
X-Google-Smtp-Source: AGHT+IFwRtk52jDHFUKIdgfCPVH+KgriuRTdMZ2LgYHWXtilsq7fBvxSErGwaRNrDOez+imVIq/2HQ==
X-Received: by 2002:a05:600c:8b04:b0:459:d709:e5c9 with SMTP id 5b1f17b1804b1-45a110d4a3bmr4991725e9.6.1754945612797;
        Mon, 11 Aug 2025 13:53:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0e70218sm296572845e9.20.2025.08.11.13.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:53:31 -0700 (PDT)
Message-Id: <8ec969fe4bd0efde5c8cbb1717c1159e6a51fd78.1754945601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
References: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
	<pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:53:20 +0000
Subject: [PATCH v3 6/6] doc lint: check that synopsis manpages have synopsis
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
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Collin Funk <collin.funk1@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
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
