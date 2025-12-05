Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036692E229F
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946957; cv=none; b=JXo1eW6LRx+RiUTW1QdK1jOAiMShgIs1OVxqzXXybSUsjgcnhC6JHhyskY0fKae9XG5ej8GJnlCQcevCug6A4q6fd38LZq811lzjhV/k5hbjjvHA8yHykJH736grWs+MWuju+FLVl1oGReDOU5AUABi0Lcn8AhCFU+CvJ/1Y17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946957; c=relaxed/simple;
	bh=TnwZkSxTTNL5cz6TgNMSreKILDUTjWvsn+uUSjaWgUc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=meU2u6S4PUNBGCLnthZVv7aWvAH/dyh0m8p0tZ8MLyq9B3jI/EhZt86ZBe8mK9s+yiMNvNPVGNzobWQ+/8Cbt+AInZml9fztLSq/VDBRrwXDNYvD/OA9xOtmkZpVc2kO9nDr7JqUcQd8B/XrvqZKBK0er2t+ah4em7RKlvOrYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSJK/7uS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSJK/7uS"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2ea2b9631so190635385a.3
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946948; x=1765551748; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+gahIf3OI+po5aM7+4m/0772/i2Gf2zNdbfP4SS9mU=;
        b=YSJK/7uSK13v1EPEwAjZH10J257aNuq7pFbLaTFKfXTKQvsmeSSDnJoCpkOnti7OOo
         NLnnWetf6ehDeKER5bvpAT5XtUdZwflohiK0+bGh/nOXA17u5ICEGWHp5UsQYxr6D7ZK
         6vXsmW03z2HgFjLieZtjByAgISlMCSskpAhDSm3I1xH/e7NL6TW6y8kyqDV0CEJQkGcE
         k4Y8Ct/iB6yZvylmCHaGLpTVvgxQglFjc1VoXQxRAMnTzxhfkMjSS5LK614WCmipQ/hM
         CYDzD1x8wuJYRo6OtlnwANjFHStJYNQL4C6VvMs3X45/Tfiu81Hr4XF323xQrdH/abFH
         EUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946948; x=1765551748;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+gahIf3OI+po5aM7+4m/0772/i2Gf2zNdbfP4SS9mU=;
        b=UcgwpVPacY0PCZZtFd6UPBObRfwne8MFDyMNRVeFSnaulZaSp49m0CjIiq3EDhLyzf
         XbxhwddUW/1EgpMpUZntvVGy03ReUmrC4dZtCvE6w91lJ1cFFlq5VFAAoe0cFYZY6lE0
         wfndD56FlQ7fvkQt68omfyISMrnSs9f0uC8Ie2kVlpsNUTxdHjHVoIVsRBFMQM66nkPn
         XZ2gEa8CRkjuhmtWB992Q6R22cVpA5dmD7hPJkeS3nUAkOrQATg7tDn9cb4umV+e7uOC
         JjFiOnHChSYCto2bcqZ5TJK2WjXlq+QkditeSuTzwAJtCPufMVi5dwcUyL3GjXUPuKGR
         GM7A==
X-Gm-Message-State: AOJu0YzY+ShTX+2k2K+83y7Gj7MeuwfrlBXY9K4hY1BKq248zVowlJ6i
	89B/mNJWqgpMQDrbIEol5snMShurENT9fM0YnNZRvMZmKDGm99HoI0F3WvN2Cg==
X-Gm-Gg: ASbGncs1X38wYwsc5KMkE6GYrc2SgwxscQDEXXzZCUbQ0rnw3DOyOqfpiexE0qqOo7D
	2JBzvDf75/LaEg8Vzr+j8rO4YzYJHtyDI/W/+Db1Xqr1f11Dp+5G6MXbwPFbafxBKeLzTo971mg
	RZK3jI4OCcv7PdLfWz2jrJKPsM/MSELNoKsqZIipgnOmHYB0if+l1+vl2Cr2zT0n+qHFUK3Zqzr
	11k+isRVIkMWQX1vzuXjClMvxhNB8y6qSgXECzm3yDF/EdvG26BwiN+Ohh5YlRdwWt+GQIzujMq
	O40xP95MspJ+MO1HP2vs2nzff9NDil/ztSobLQH1kVo+DtuYclyzj38JcAhD3qo99ei+E5suWO5
	gyaHybfGhg4fSm2tCnGLuluiW1x0c5f36//BBfl6qf1TsTzWbW1exqWJwEVWi0cenOQGBEBDGAw
	WUM5D5c/ighSfhYYL5rELwDh0=
X-Google-Smtp-Source: AGHT+IFPY2fyhKFO2i3hLdu+2pZv44k7UyhtAQMCQ6nIgJqlFCzM9YTsfLDLIFPiKIPffcdGHTUB/Q==
X-Received: by 2002:a05:620a:4011:b0:89e:67a9:fcf1 with SMTP id af79cd13be357-8b6181bd1c4mr1062878585a.52.1764946947840;
        Fri, 05 Dec 2025 07:02:27 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b6252a04d3sm411036985a.2.2025.12.05.07.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:27 -0800 (PST)
Message-Id: <2d329837e34a88cfe28be728fe24bb5a2c6a9752.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:16 +0000
Subject: [PATCH v2 01/10] t9700: accommodate for Windows paths
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Ever since fe53bbc9beb (Git.pm: Always set Repository to absolute path
if autodetecting, 2009-05-07), the t9700 test _must_ fail on Windows
because of that age-old Unix paths vs Windows paths problem.

The underlying root cause is that Git cannot run with a regular Win32
variant of Perl, the assumption that every path is a Unix path is just
too strong in Git's Perl code.

As a consequence, Git for Windows is basically stuck with using the
MSYS2 variant of Perl which uses a POSIX emulation layer (which is a
friendly fork of Cygwin) _and_ a best-effort Unix <-> Windows paths
conversion whenever crossing the boundary between MSYS2 and regular
Win32 processes. It is best effort only, though, using heuristics to
automagically convert correctly in most cases, but not in all cases.

In the context of this here patch, this means that asking `git.exe` for
the absolute path of the `.git/` directory will return a Win32 path
because `git.exe` is a regular Win32 executable that has no idea about
Unix-ish paths. But above-mentioned commit introduced a test that wants
to verify that this path is identical to the one that the Git Perl
module reports (which refuses to use Win32 paths and uses Unix-ish paths
instead). Obviously, this must fail because no heuristics can kick in at
that layer.

This test failure has not even been caught when Git introduced Windows
support in its CI definition in 2e90484eb4a (ci: add a Windows job to
the Azure Pipelines definition, 2019-01-29), as all tests relying on
Perl had to be disabled even from the start (because the CI runs would
otherwise have resulted in prohibitively long runtimes, not because
Windows is super slow per se, but because Git's test suite keeps
insisting on using technology that requires a POSIX emulation layer,
which _is_ super slow on Windows).

To work around this failure, let's use the `cygpath` utility to convert
the absolute `gitdir` path into the form that the Perl code expects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9700/test.pl | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 58a9b328d5..570b0c5680 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -117,7 +117,12 @@ close TEMPFILE;
 unlink $tmpfile;
 
 # paths
-is($r->repo_path, $abs_repo_dir . "/.git", "repo_path");
+my $abs_git_dir = $abs_repo_dir . "/.git";
+if ($^O eq 'msys' or $^O eq 'cygwin') {
+  $abs_git_dir = `cygpath -am "$abs_repo_dir/.git"`;
+  $abs_git_dir =~ s/\r?\n?$//;
+}
+is($r->repo_path, $abs_git_dir, "repo_path");
 is($r->wc_path, $abs_repo_dir . "/", "wc_path");
 is($r->wc_subdir, "", "wc_subdir initial");
 $r->wc_chdir("directory1");
@@ -127,7 +132,7 @@ is($r->config("test.string"), "value", "config after wc_chdir");
 # Object generation in sub directory
 chdir("directory2");
 my $r2 = Git->repository();
-is($r2->repo_path, $abs_repo_dir . "/.git", "repo_path (2)");
+is($r2->repo_path, $abs_git_dir, "repo_path (2)");
 is($r2->wc_path, $abs_repo_dir . "/", "wc_path (2)");
 is($r2->wc_subdir, "directory2/", "wc_subdir initial (2)");
 
-- 
gitgitgadget

