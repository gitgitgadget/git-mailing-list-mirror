Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EE184558
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481916; cv=none; b=lhAxBj2dKs/nh5rlPUt2XpbJ/Pz37y3hmvm0W7sr6TuJXRQ4+IPQfFXIVdSkhXS9silRgnJNev81UbuC16DzeYoo22BV+ZJakf3E2EyCev+NG22BYy5r5A49+d1avorjqIuzNfy9AcA7lmD8cGyb2iNOpy+jADTU9/jvGjFP13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481916; c=relaxed/simple;
	bh=X8PlQH51CUNSBUn18mYQWo5vOapRlvy3QxNZylIBUP4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q20McrKUkVprFh6RAEMSEueAFkyPasZstUzLcweJAtKk+Va0KFuyBycOBY2cOFcuTMk27aBhIRjm64VMuCSXRakC3lZrzf+f8GM0FZdOkemTKZd9cLGC4ygERUhotrWXTAXYLaZy2kyA3VWOv3SGRNcVDcLxHtfbjmWKnBuEcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPU617BI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPU617BI"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so5307109a12.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723481912; x=1724086712; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9pB+QVMAAEuBBMangAPii+XS71mbisuR4fxXFJpA6Q=;
        b=SPU617BIdmiW/+5E9qulFu7tNidgei0jQe9BQtPife4q4rggcB1bDeo4kFFAPIDMCU
         N3laAw63cKaZN+eX9YHO7xrDgHV1QugWJN3+fOUQrGNkSAsJhapQ+KKGAkAora8pVR4/
         Om5QCGwY/CsExAc5X2JJvIZbsCku0EqeV1TiHglfBcQ4+rmuf2FzX+shUlnxpUuK4BgE
         7wFFLzPnXBTKX72zyhfLaI9Pqoda5P0sV4tsN/IfTkKDgnT36kv6dU42gqGZaBFNKEGx
         ehYJkVBAr4Rb7q0Sewsv2wm2VmzfF6ETXcVEz5qNnwNuXKoHm3dU/8siH1q/ERhFZYIq
         HDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481912; x=1724086712;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9pB+QVMAAEuBBMangAPii+XS71mbisuR4fxXFJpA6Q=;
        b=GOKrviOW474TIq93XL9Oj+MXxNQ9te/FjPzfKnMQBRJaWI4MACSykYFiPHBwPSoPma
         WoTCgOVJ3CjLTpPd5f4qiLuUeEn06K21NJjwnaPgrlRf0HpAmc0Y9Zwy+3VgRIpOBwc8
         Hylkum1Fc2KGKB/adK6IuguPDBSKJk3dKxFsHfhwDP0lPu3jNeuiZrILF83ZlyV1Y2ra
         VJYlYcIWVg1dNIgTs0nRIJI80zdD0cveEy0g6N9r9HqzGsnGSUAYhOJeo0yl8lDvcXzK
         933Kb6lxXvTQ2LViO0l9lzbCrPfDEo9yEih+aYS3GTmVgbyh8xVINzQ0hEzYY+7VsRg4
         H6Og==
X-Gm-Message-State: AOJu0YyI7Jgxvp8JLmGwx0VKzunbLdbPTq2AZh5UW5ZZzrub1tnRnAly
	HCnhtH20jlAB4FfxLu946NXhZY2b6zyNNr9hZaqM69dGMWyiFGTgXA9tew==
X-Google-Smtp-Source: AGHT+IEyyCwqwpXLxAn/V0tSjQB01CYgH8IWvsMOcCCBUGuAgCb+5sXYahBaY41uH1hKMJx/3ccOIw==
X-Received: by 2002:a17:906:6a10:b0:a7a:9a78:4b5a with SMTP id a640c23a62f3a-a80ed2c87e9mr54766866b.52.1723481911678;
        Mon, 12 Aug 2024 09:58:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e045asm241831566b.52.2024.08.12.09.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:58:31 -0700 (PDT)
Message-Id: <7735afb32afd601e8306635e1cb3767f3f923f43.1723481908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1747.v3.git.git.1723481908.gitgitgadget@gmail.com>
References: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
	<pull.1747.v3.git.git.1723481908.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Aug 2024 16:58:27 +0000
Subject: [PATCH v3 2/3] git-svn: use `svn:global-ignores` to create .gitignore
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
Cc: Alex Galvin <agalvin@comqi.com>,
    Alex Galvin <agalvin@comqi.com>

From: Alex Galvin <agalvin@comqi.com>

`svn:global-ignores` contains a list of file patterns that should
not be tracked in version control. The syntax of these patterns is
the same as `svn:ignore`. Their semantics differ: patterns in
`svn:global-ignores` apply to all paths under the directory where
they apply, while `svn:ignore` only applies to the directory's
immediate children.

Signed-off-by: Alex Galvin <agalvin@comqi.com>
---
 git-svn.perl | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b0d0a50984b..a2a46608c9b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1279,12 +1279,20 @@ sub cmd_show_ignore {
 	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		print STDOUT "\n# $path\n";
-		my $s = $props->{'svn:ignore'} or return;
-		$s =~ s/[\r\n]+/\n/g;
-		$s =~ s/^\n+//;
-		chomp $s;
-		$s =~ s#^#$path#gm;
-		print STDOUT "$s\n";
+		if (my $s = $props->{'svn:ignore'}) {
+			$s =~ s/[\r\n]+/\n/g;
+			$s =~ s/^\n+//;
+			chomp $s;
+			$s =~ s#^#$path#gm;
+			print STDOUT "$s\n";
+		}
+		if (my $s = $props->{'svn:global-ignores'}) {
+			$s =~ s/[\r\n]+/\n/g;
+			$s =~ s/^\n+//;
+			chomp $s;
+			$s =~ s#^#$path**/#gm;
+			print STDOUT "$s\n";
+		}
 	});
 }
 
@@ -1315,16 +1323,25 @@ sub cmd_create_ignore {
 		# which git won't track
 		mkpath([$path]) unless -d $path;
 		my $ignore = $path . '.gitignore';
-		my $s = $props->{'svn:ignore'} or return;
 		open(GITIGNORE, '>', $ignore)
 		  or fatal("Failed to open `$ignore' for writing: $!");
-		$s =~ s/[\r\n]+/\n/g;
-		$s =~ s/^\n+//;
-		chomp $s;
-		# Prefix all patterns so that the ignore doesn't apply
-		# to sub-directories.
-		$s =~ s#^#/#gm;
-		print GITIGNORE "$s\n";
+		if (my $s = $props->{'svn:ignore'}) {
+			$s =~ s/[\r\n]+/\n/g;
+			$s =~ s/^\n+//;
+			chomp $s;
+			# Prefix all patterns so that the ignore doesn't apply
+			# to sub-directories.
+			$s =~ s#^#/#gm;
+			print GITIGNORE "$s\n";
+		}
+		if (my $s = $props->{'svn:global-ignores'}) {
+			$s =~ s/[\r\n]+/\n/g;
+			$s =~ s/^\n+//;
+			chomp $s;
+			# Global ignores apply to sub-directories, so they are
+			# not prefixed.
+			print GITIGNORE "$s\n";
+		}
 		close(GITIGNORE)
 		  or fatal("Failed to close `$ignore': $!");
 		command_noisy('add', '-f', $ignore);
-- 
gitgitgadget

