Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5CE14291
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Tnt0uADi"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D80AA2
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 12:24:27 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 790F25B0C3;
	Wed,  1 Nov 2023 19:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698866666;
	bh=d7/SsawHBEyrHUH3HyGorZ8rM/63WQ2gGLvrMBhSTLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=Tnt0uADizzP33BCz9nN+HVExNLjqaYnrY9l/BqdzRy4R2uMGnw+9WMLohsBZ8Q02f
	 PTiM/H9dQoicSw5c16UcGEfn7PahmsTcMehSBDFJ2Gec/rmnDKSxVWo0yf5amAtPjq
	 mEsFe8Ejld+mmzkCp5IUnUKBerJ9oaOOKeiNwrpNQ6DkCEcgx+Ab9q0e0OkRkJYvP6
	 CLw4TBQD2Wg/gOMB7IkDCguBUVaOe0o6y/vK6DFtJjQouB3ArY9tz8ZPnLYHG2dwV8
	 rF5gVGuvZkdXOyghxFUFeWcku40SUZ1MQVftc9XC4NnhrGgmemmdszbwhTc6liWdLP
	 IgesieZTdRIBXYHKP60kcyB3OZrz6nEr+Ol/AF5rRVPwj8SoRrKGmHGmygDYE6ClMu
	 TlkAN7obJInfK1gxiD+Y4heqKe30hJsSlOMHMBDl5dkrSdhBD+F+WuZcvGsnQB3P5q
	 WDTURKtHBfkaTzA4FK7bAevc0V0r5lF0DD1QT+PW06x2NhSJYbn
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 1/2] git-merge-file doc: drop "-file" from argument placeholders
Date: Wed,  1 Nov 2023 19:24:18 +0000
Message-ID: <20231101192419.794162-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101192419.794162-1-sandals@crustytoothpaste.net>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231101192419.794162-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Ågren <martin.agren@gmail.com>

`git merge-file` takes three positional arguments. Each of them is
documented as `<foo-file>`. In preparation for teaching this command to
alternatively take three object IDs, make these placeholders a bit more
generic by dropping the "-file" parts. Instead, clarify early that the
three arguments are filenames. Even after the next commit, we can afford
to present this file-centric view up front and in the general
discussion, since it will remain the default one.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: brian m. carlson <bk2204@github.com>
---
 Documentation/git-merge-file.txt | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 7e9093fab6..bf0a18cf02 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -11,19 +11,20 @@ SYNOPSIS
 [verse]
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
 	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
-	[--[no-]diff3] <current-file> <base-file> <other-file>
+	[--[no-]diff3] <current> <base> <other>
 
 
 DESCRIPTION
 -----------
-'git merge-file' incorporates all changes that lead from the `<base-file>`
-to `<other-file>` into `<current-file>`. The result ordinarily goes into
-`<current-file>`. 'git merge-file' is useful for combining separate changes
-to an original. Suppose `<base-file>` is the original, and both
-`<current-file>` and `<other-file>` are modifications of `<base-file>`,
+Given three files `<current>`, `<base>` and `<other>`,
+'git merge-file' incorporates all changes that lead from `<base>`
+to `<other>` into `<current>`. The result ordinarily goes into
+`<current>`. 'git merge-file' is useful for combining separate changes
+to an original. Suppose `<base>` is the original, and both
+`<current>` and `<other>` are modifications of `<base>`,
 then 'git merge-file' combines both changes.
 
-A conflict occurs if both `<current-file>` and `<other-file>` have changes
+A conflict occurs if both `<current>` and `<other>` have changes
 in a common segment of lines. If a conflict is found, 'git merge-file'
 normally outputs a warning and brackets the conflict with lines containing
 <<<<<<< and >>>>>>> markers. A typical conflict will look like this:
@@ -36,8 +37,8 @@ normally outputs a warning and brackets the conflict with lines containing
 
 If there are conflicts, the user should edit the result and delete one of
 the alternatives.  When `--ours`, `--theirs`, or `--union` option is in effect,
-however, these conflicts are resolved favouring lines from `<current-file>`,
-lines from `<other-file>`, or lines from both respectively.  The length of the
+however, these conflicts are resolved favouring lines from `<current>`,
+lines from `<other>`, or lines from both respectively.  The length of the
 conflict markers can be given with the `--marker-size` option.
 
 The exit value of this program is negative on error, and the number of
@@ -62,7 +63,7 @@ OPTIONS
 
 -p::
 	Send results to standard output instead of overwriting
-	`<current-file>`.
+	`<current>`.
 
 -q::
 	Quiet; do not warn about conflicts.
