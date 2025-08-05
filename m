Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E952737E7
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399046; cv=none; b=K+l9D8tzWdPC81l4APvlvMZ+k2tyYIjezgSinXht9Befi+4glz0X0AVpPCSIx6SS8WZRhydyhyBoK/73/gsDov3t0jWtn1jXjo2H7wexORHT1REh6MpHbsxYs6LPztuP9hWiJBakBI+8i+u+OxKoXga1vZzcir1whY6uTs+aXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399046; c=relaxed/simple;
	bh=Uw1g4sc9E/rV9BcHoQlsrwjXOaET2ROH7P1tRG8lb/I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Sfk711VKLh0hStzk/4nOZFfAX6w+JfdJJ8ODrnp3jnxouTGXGi6OGpguQfSmqYS4IUSBL9EzRFWu9mhlP0De3Bw5VxUSdOiHh/K8NSa6DNWiqr9RV4G2UmEGwU9aBbT6bp1aRaWsXF7BZA27D9zKmnbLk9NZVRWEF4tvdT2j1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ09lzur; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ09lzur"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78315ff04so4447443f8f.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399042; x=1755003842; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAbLky1DQLcXN3pta+nCkoANogRKxUJqQ4FmDc2igYs=;
        b=mZ09lzurCEk2XkiiUAAKtTB2TXQ/R1VfG1bzUfD2pVgPcrh9lbtvkOVhdfXCIw9vaC
         Fa9J7KDsHO5k7KxZxo1NFrLdfYv1xS83wN7I8xyz+9YYfES+7c1P/fkSG2P8i/Z3ba3e
         wv5N0O7tsRsOBGLA8LsllGVXbhwIr851CThypbzwOSjQeBDxfQpPS7y/YIw52QE2BBDj
         EXcvDlt6nWGKiqS2K+xkaVVyilP4JCUNbq8wq8Cghv9YvC36W6Gn+kK57WZSbyiSDUDE
         KCo/Sb9XVIAa2A74tjBaWDJud9zSX3gO6BBPuzAV2r31vzFmG0hphbp+8gzsz23ju/Bp
         ui7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399042; x=1755003842;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAbLky1DQLcXN3pta+nCkoANogRKxUJqQ4FmDc2igYs=;
        b=DMzRRNgZXkCgS1rQvTTpi+KJTNPD4j+wyrt3DYWPpw/m11WBRbyEWQYcY1jnUnSh3F
         VdW529GCyMItdyOO4Rmh3SVSZzoadWV66ERF3i5IVkYpbDXqxiCp+GvVyvm33pvKcTJh
         WALnTt7tXDCDdBBN531iIrGg9aFxw0UimJOusSQHu4/pGR5HjagXVX9cnDK44fwZCUlB
         JKAVXemLZRDH74JRxT2j91jCFxpub2EUEE5LAeVUdVwUje683ILQEmuUiV9cdFDqbtRi
         2oKdbIQVIobdQgKIWn9lXHqEU/uPBbt3RPUZ7TEaVI5VGRhc4sLl6scj347GAYSG1VLx
         wfXA==
X-Gm-Message-State: AOJu0YzAl8tM68X9UN2eChcYAadReohflkFi7bKUHKFZvVQiKNoqA39x
	pl2v+/jUVe609wanftXfU6yjS9sVFmssjA37NAcCoSvg8nWjpM4vf/KXZHFYEA==
X-Gm-Gg: ASbGncuT+39WpfhrZgN4wGYPo0mqnucaaYVMyCDKiPtHEtP8ME7+xi5du32XQLP+Kgv
	OWpJj00+vpqZ/9szXtuYk+GCr3AJ67RtaCdeuboBuJiLXJe3L3dyV+Cx2ib8KwVzeh60k6DI0Rw
	XwtFA3k0x+DIIuYiL86XIJ6pfMRaA0pKx0Azo8nmQ5V2hs7cfE9547AlZ+8i5H/Q/tM5TVrcCQl
	H21YqN6o/Trk9u9Ca5M6MKY8lzChiBzQTod8K/en8pecaQ8JR5RuW42IfW0UvUxGQlsCcAFC62e
	oYIEohBzmEVaRi29YGOZpjBPaFSRTAU4ztfOq4bAn5YbRtjaJWiVYYcPGsnwH3asoMN49GpQkJU
	nBoHTXjtebko1qSX2wONCfMdBXr+BhZdZTw==
X-Google-Smtp-Source: AGHT+IFqYeTjW+TguMjBMxHKaVL1EVlcUmMgDNs1ze3OY0KgJUHuTICLZ3pAU4VxF68l/oas/mP0Hw==
X-Received: by 2002:a5d:5f8b:0:b0:3a3:6e85:a529 with SMTP id ffacd0b85a97d-3b8d94ce6ccmr9037728f8f.51.1754399042192;
        Tue, 05 Aug 2025 06:04:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abec8sm19893935f8f.8.2025.08.05.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:04:01 -0700 (PDT)
Message-Id: <e03f3f5c55a336bdea841ad91e8bafc9dd0aa534.1754399033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 13:03:53 +0000
Subject: [PATCH 6/6] doc lint: check that synopsis manpages have synopsis
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
 Documentation/git-refs.adoc                 | 20 ++++++++++----------
 Documentation/lint-documentation-style.perl |  6 ++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

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
index 11321a151bca..f9f1da20b7ad 100755
--- a/Documentation/lint-documentation-style.perl
+++ b/Documentation/lint-documentation-style.perl
@@ -21,6 +21,12 @@ while (my $line = <>) {
 	if ($line =~ /^`?--\[no-\][a-z0-9-]+.*(::|;;)$/) {
 		report($line, "definition list item with a `--[no-]` parameter");
 	}
+	if ($line =~ /^\[synopsis\]$/) {
+		$synopsis_style = 1;
+	}
+	if (($line =~ /^-[-a-z].*(::|;;)$/) && ($synopsis_style)) {
+			report($line, "synopsis style and definition list item not backquoted");
+	}
 }
 
 
-- 
gitgitgadget
