Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9C29E0E7
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765830234; cv=none; b=Kj8WMwqL2Ozkc9FN+3un3QR1oVU8RYviMvJ7eCOUkQqWqLw1SQWaFQuQLda41jl3uD4DzsSRoBiVrr5QzPcExIM10nYikKjIJypg83Zb0aZ8ryOgvaYiCDZEWfhIiNQAAIipacYytIY1T4Ac/Qy50H28sIrCiA67yz/oPLwD04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765830234; c=relaxed/simple;
	bh=Xr0oratf9/eP3p/QxQ13SyH32LNWkwauqEzrk7XTfBU=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=edrdqYAGVWRJ3IaJjIRko5FXo8dU/yaxcuR+3fI7VvE6AM/db0y50OaHwIYeqIq7e9omovnfIE1BinN9DDUZw21zG+PIqnMHOf03XvLd65JP4tU3nrEAY/EqwYWXOITbHkYr23kir3Vpq1mAMuVeYJLqHHnFK917hzvOwRLKae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbnzkfsd; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbnzkfsd"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88a3b9ddd40so6970546d6.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765830231; x=1766435031; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QTt9OpJty9jmPRD7iOeE5Ko5yTpCKWkmdZH1pQleEJc=;
        b=jbnzkfsdAtgWrCRa3p041eTc3NN889YTEbMxx9B0/AGMYuL7IiBrahTYN/SqA955oK
         P5r0n328jvIX6oINzuddGIkZU0gu1fqITw8wh5oY0UqxSbopShKRdUzESaIaiA3hS7+U
         bIFBQEMr3mRNrQI18kbR9LQ7nECKWUd+0kBJdDVEYXaaZ753aBz0W+B1lxwVAOHATxph
         U4QSj7sfl8gKCQnBiW3dC2++qrn5tyOUJ6Dtstvqpn8tnbZefHbavarQpd35udCs85kS
         AXnvSvIf/Gb6XxWughC+Jx4Vb5rU73lSYXJ+Wy0yb7HN3C3C0f6z/A07yro2Cu8bvfch
         ToDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765830231; x=1766435031;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTt9OpJty9jmPRD7iOeE5Ko5yTpCKWkmdZH1pQleEJc=;
        b=m5NMsVN1IJOQcEpVvRz3liGGNb17BUSYT0nIpWmLhpZcbl+cMzH3F+0/NSaXGms4su
         8U+IAtv6z3ZXiSPI3s5qmWvAptE70SNA2zIkua+oGn7WpGOe/YKMcPDHbrNgRfTj0DeD
         cqaQgJnGg7G1OT3y0UFPVX2ag/g2AzREQzD4JhKfxH4uUo4mLyRVm5Ksmz+aPFl7Ro8B
         clolUyWcojv6X5wrqSqjkvb5dUTYGaRWoxZ8vlP65SVNWu2zNTeXucizNqyvo8a5oo4S
         5Qg6fjGRKgH1xbP97/phjbn9rB7oFp3D5ePW1+dWFMxxBNRjMGONN4xLgHtPHKybJuoF
         +btw==
X-Gm-Message-State: AOJu0Ywsd/fFHkmDPjZ1IfoVuCKa4nrGv5acTgvAaCJzHPVlAt8qUmFC
	bw9SysbgytKQVwDugWS1e7bHUdTsHCkXh4hl0vawW90J6VK8xU9UmjDgFl6z+zefOrI=
X-Gm-Gg: AY/fxX6WVf5LnQ+4H/NqRdFbvYd4UjzMqEPwcL5uktO9gcd7B0S7eyIyylryjv68sug
	QIIm2Mt3grZkLFLtlvPI+9jWAxAF6FpUxq5u44pF2tFWIK4MUwvlpUYUo18WthdRpyZpXb0Mqv4
	s4HWlbr721+1TK9o+/O/w1apQ8/Ue1mXEsdrL4qFkypD5LLY21gzJNj0tZDVWTnbJUbF4YfU7Mo
	pvr+H13AQcd2AAbsY2y1oGD85pyuvZvxa/JEU+5LHCsoRHqjVHCtjFfgRqHAc4N7ykBSPuoADo8
	KkEWSDFpLQBHqjVV21hFJsyDCESdPLRt0+ATDUSqSacdV+nAv5WTy0ZQLlkuamtGzahKXQd+WQl
	xnyGY+FWYRCbcZVbd2aYc8QBZLh2KdG4GVwB0jdJC6nkzRi6ZqMh4e9UTdeHyU4M6X2gAQ3vYJn
	6uhsi4s9TvEvCb
X-Google-Smtp-Source: AGHT+IGCppXz5XphjUMGNbojzjQ6CuPvQ4n4/GptveW9EH1AnsJnIIJCTBjK3VMLctBOyF36OXMHTg==
X-Received: by 2002:a05:6214:448d:b0:88a:2500:7d45 with SMTP id 6a1803df08f44-88a25007f79mr131621126d6.46.1765830231021;
        Mon, 15 Dec 2025 12:23:51 -0800 (PST)
Received: from [127.0.0.1] ([64.236.144.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a85eab16sm58185716d6.39.2025.12.15.12.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:23:50 -0800 (PST)
Message-Id: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Dec 2025 20:23:49 +0000
Subject: [PATCH] doc: flock of small fixes to various documentation files
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

While translating the Git documentation into French, I noticed several small
issues in various files. This commit addresses these issues to improve the
overall quality and consistency of the documentation.

 * enforce consistent imperative mood in option descriptions
 * lighten wording in several places for clarity
 * add missing parameters
 * fix minor asciidoc markup issues

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: flock of small fixes to various documentation files

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2016%2Fjnavila%2Fdoc_small_fixups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2016/jnavila/doc_small_fixups-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2016

 Documentation/git-checkout.adoc   |  2 +-
 Documentation/git-rebase.adoc     |  2 +-
 Documentation/git-repack.adoc     |  6 +++---
 Documentation/git-send-email.adoc | 26 +++++++++++++-------------
 Documentation/git-worktree.adoc   |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 6f281b298e..43ccf47cf6 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -509,7 +509,7 @@ ARGUMENT DISAMBIGUATION
 -----------------------
 
 When you run `git checkout <something>`, Git tries to guess whether
-`<something>` is intended to be a branch, a commit, or a set of file(s),
+_<something>_ is intended to be a branch, a commit, or a set of file(s),
 and then either switches to that branch or commit, or restores the
 specified files.
 
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 9742833ebe..e177808004 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -87,7 +87,7 @@ of the to-be-rebased branch. However, `ORIG_HEAD` is not guaranteed to still
 point to that commit at the end of the rebase if other commands that change
 `ORIG_HEAD` (like `git reset`) are used during the rebase. The previous branch
 tip, however, is accessible using the reflog of the current branch (i.e. `@{1}`,
-see linkgit:gitrevisions[7].
+see linkgit:gitrevisions[7]).
 
 TRANSPLANTING A TOPIC BRANCH WITH --ONTO
 ----------------------------------------
diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index d12c4985f6..673ce91083 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -77,14 +77,14 @@ to the new separate pack will be written.
 	Only useful with `--cruft -d`.
 
 --max-cruft-size=<n>::
-	Overrides `--max-pack-size` for cruft packs. Inherits the value of
+	Override `--max-pack-size` for cruft packs. Inherits the value of
 	`--max-pack-size` (if any) by default. See the documentation for
 	`--max-pack-size` for more details.
 
 --combine-cruft-below-size=<n>::
 	When generating cruft packs without pruning, only repack
-	existing cruft packs whose size is strictly less than `<n>`,
-	where `<n>` represents a number of bytes, which can optionally
+	existing cruft packs whose size is strictly less than `<n>`
+	bytes, which can optionally
 	be suffixed with "k", "m", or "g". Cruft packs whose size is
 	greater than or equal to `<n>` are left as-is and not repacked.
 	Useful when you want to avoid repacking large cruft pack(s) in
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 263b977353..cdaf421cda 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -208,7 +208,7 @@ Sending
 	for your own case. Default is the value of `sendemail.smtpEncryption`.
 
 --smtp-domain=<FQDN>::
-	Specifies the Fully Qualified Domain Name (FQDN) used in the
+	Specify the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
 	FQDN to match your IP address.  If not set, `git send-email` attempts
 	to determine your FQDN automatically.  Default is the value of
@@ -245,7 +245,7 @@ a password is obtained using linkgit:git-credential[1].
 	Disable SMTP authentication. Short hand for `--smtp-auth=none`.
 
 --smtp-server=<host>::
-	If set, specifies the outgoing SMTP server to use (e.g.
+	Specify the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  If unspecified, and if
 	`--sendmail-cmd` is also unspecified, the default is to search
 	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH` if such a
@@ -258,7 +258,7 @@ command names.  For those use cases, consider using `--sendmail-cmd`
 instead.
 
 --smtp-server-port=<port>::
-	Specifies a port different from the default port (SMTP
+	Specify a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
 	submission port 587, or the common SSL smtp port 465);
 	symbolic port names (e.g. `submission` instead of 587)
@@ -266,7 +266,7 @@ instead.
 	`sendemail.smtpServerPort` configuration variable.
 
 --smtp-server-option=<option>::
-	If set, specifies the outgoing SMTP server option to use.
+	Specify the outgoing SMTP server option to use.
 	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
 +
@@ -277,7 +277,7 @@ must be used for each option.
 --smtp-ssl::
 	Legacy alias for `--smtp-encryption ssl`.
 
---smtp-ssl-cert-path::
+--smtp-ssl-cert-path <path>::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
 	by `c_rehash`, or a single file containing one or more PEM format
@@ -347,11 +347,11 @@ Automating
 --no-to::
 --no-cc::
 --no-bcc::
-	Clears any list of `To:`, `Cc:`, `Bcc:` addresses previously
+	Clear any list of `To:`, `Cc:`, `Bcc:` addresses previously
 	set via config.
 
 --no-identity::
-	Clears the previously read value of `sendemail.identity` set
+	Clear the previously read value of `sendemail.identity` set
 	via config, if any.
 
 --to-cmd=<command>::
@@ -510,12 +510,12 @@ have been specified, in which case default to `compose`.
 	Currently, validation means the following:
 +
 --
-		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
-		*	Warn of patches that contain lines longer than
-			998 characters unless a suitable transfer encoding
-			(`auto`, `base64`, or `quoted-printable`) is used;
-			this is due to SMTP limits as described by
-			https://www.ietf.org/rfc/rfc5322.txt.
+* Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
+* Warn of patches that contain lines longer than
+  998 characters unless a suitable transfer encoding
+  (`auto`, `base64`, or `quoted-printable`) is used;
+  this is due to SMTP limits as described by
+  https://www.ietf.org/rfc/rfc5322.txt.
 --
 +
 Default is the value of `sendemail.validate`; if this is not set,
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index f272f79783..d74ad7b0e9 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -104,7 +104,7 @@ associated with a new unborn branch named _<branch>_ (after
 passed to the command. In the event the repository has a remote and
 `--guess-remote` is used, but no remote or local branches exist, then the
 command fails with a warning reminding the user to fetch from their remote
-first (or override by using `-f/--force`).
+first (or override by using `-f`/`--force`).
 
 `list`::
 

base-commit: d8af7cadaa79d5837d73ec949e10b57dedb43e9b
-- 
gitgitgadget
