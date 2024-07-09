Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0A189F52
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568337; cv=none; b=Fkk8gC4rXgZdRG0+Fzd4VbLHXJ8s9ogtevKdRGtYj0eIsOTIgUm+DD/OQWTvD4CncVpgqflsOtUbvcPSAfFM2eIwfgWZfFXv6aC7H8Z731FSl1lyFCHF4m8//ekjEUkfbvWpf5JuEMXhQw6g0WLPID+5/mN5WIpgV9wkJzGI9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568337; c=relaxed/simple;
	bh=jGZp7Mb5OBvr6LExuUPybXPNVu1R6EKwPS8jnYgnHa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF81ACeeHea1skMSYzhdiuirMxnx/tgDHbgKbhZCSQUZaYZb6rjIRIqUEBQAJGW5oLNIEwaxCc6JQQ+dbN889jyjdz+5z38Nf1yHCrCDVaFneAbgaT/8H2uB1g7xFDW2Eo7s/nnk95Cd3fjgIE4EMp9e1EEsacfBvBanxCAjsyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OroW1vsd; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OroW1vsd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720568334;
	bh=jGZp7Mb5OBvr6LExuUPybXPNVu1R6EKwPS8jnYgnHa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=OroW1vsdriMQifddz9nIl5enUyq4M5NV10P82ZIsEImsKiPeYxs42j9drSehCcc7t
	 c+mPD037PJwS0UVgjHzDSrp0MuUqj9Nz7vnFoyM68wDWjxTk0yh76lz+kEaBJenzFm
	 VWyxtFQJbSaiS/xdldHm1yMrjxI+r72zb0QcXfoHHa59KsafEB9Z8lKkYG0Ueydqy9
	 INH7H9vpARbaXycjJBEaopWfdhsHlEZZafDmSpL75k9nBSk5nBbnSLaLPZXtmSrQlY
	 Cs5N1Nzf5vyUSvw1Pz2WQ95MSikSVKr8uoZIdN74+qVPa7OOPx5gQC2RzqPnYqTU/I
	 Fbsw1yevV9euOUttSmLS9K1Ep2Ey8zKI8R8CsZ/+6kqcB3A9VVvmhK91ROSngbQ3iM
	 BsDuKrvRb/GZVVgf2XxHV4wt7yXwN52g32urM6ME9/ODP4fpxWdh/dLcNSuGjsKEvS
	 XPyhtqNMot7JbVSxYIJ7ZAJH/1d2popGPgujgGm1FmCYQWTNNDS
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F04BB209AC;
	Tue,  9 Jul 2024 23:38:53 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 3/4] gitfaq: add entry about syncing working trees
Date: Tue,  9 Jul 2024 23:37:45 +0000
Message-ID: <20240709233746.445860-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240709233746.445860-1-sandals@crustytoothpaste.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
 <20240709233746.445860-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users very commonly want to sync their working tree with uncommitted
changes across machines, often to carry across in-progress work or
stashes.  Despite this not being a recommended approach, users want to
do it and are not dissuaded by suggestions not to, so let's recommend a
sensible technique.

The technique that many users are using is their preferred cloud syncing
service, which is a bad idea.  Users have reported problems where they
end up with duplicate files that won't go away (with names like "file.c
2"), broken references, oddly named references that have date stamps
appended to them, missing objects, and general corruption and data loss.
That's because almost all of these tools sync file by file, which is a
great technique if your project is a single word processing document or
spreadsheet, but is utterly abysmal for Git repositories because they
don't necessarily snapshot the entire repository correctly.  They also
tend to sync the files immediately instead of when the repository is
quiescent, so writing multiple files, as occurs during a commit or a gc,
can confuse the tools and lead to corruption.

We know that the old standby, rsync, is up to the task, provided that
the repository is quiescent, so let's suggest that and dissuade people
from using cloud syncing tools.  Let's tell people about common things
they should be aware of before doing this and that this is still
potentially risky.  Additionally, let's tell people that Git's security
model does not permit sharing working trees across users in case they
planned to do that.  While we'd still prefer users didn't try to do
this, hopefully this will lead them in a safer direction.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 058ef32a97..f2917d142c 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -185,6 +185,58 @@ Then, you can adjust your push URL to use `git@example_author` or
 `git@example_committer` instead of `git@example.org` (e.g., `git remote set-url
 git@example_author:org1/project1.git`).
 
+Transfers
+---------
+
+[[sync-working-tree]]
+How do I sync a working tree across systems?::
+	First, decide whether you want to do this at all.  Git works best when you
+	push or pull your work using the typical `git push` and `git fetch` commands
+	and isn't designed to share a working tree across systems.  This is
+	potentially risky and in some cases can cause repository corruption or data
+	loss.
++
+Usually, doing so will cause `git status` to need to re-read every file in the
+working tree.  Additionally, Git's security model does not permit sharing a
+working tree across untrusted users, so it is only safe to sync a working tree
+if it will only be used by a single user across all machines.
++
+It is important not to use a cloud syncing service to sync any portion of a Git
+repository, since this can cause corruption, such as missing objects, changed
+or added files, broken refs, and a wide variety of other problems.  These
+services tend to sync file by file on a continuous basis and don't understand
+the structure of a Git repository.  This is especially bad if they sync the
+repository in the middle of it being updated, since that is very likely to
+cause incomplete or partial updates and therefore data loss.
++
+An example of the kind of corruption that can occur is conflicts over the state
+of refs, such that both sides end up with different commits on a branch that
+the other doesn't have.  This can result in important objects becoming
+unreferenced and possibly pruned by `git gc`, causing data loss.
++
+Therefore, it's better to push your work to either the other system or a central
+server using the normal push and pull mechanism.  However, this doesn't always
+preserve important data, like stashes, so some people prefer to share a working
+tree across systems.
++
+If you do this, the recommended approach is to use `rsync -a --delete-after`
+(ideally with an encrypted connection such as with `ssh`) on the root of
+repository.  You should ensure several things when you do this:
++
+* If you have additional worktrees or a separate Git directory, they must be
+  synced at the same time as the main working tree and repository.
+* You are comfortable with the destination directory being an exact copy of the
+  source directory, _deleting any data that is already there_.
+* The repository (including all worktrees and the Git directory) is in a
+  quiescent state for the duration of the transfer (that is, no operations of
+  any sort are taking place on it, including background operations like `git
+  gc` and operations invoked by your editor).
++
+Be aware that even with these recommendations, syncing in this way has some risk
+since it bypasses Git's normal integrity checking for repositories, so having
+backups is advised.  You may also wish to do a `git fsck` to verify the
+integrity of your data on the destination system after syncing.
+
 Common Issues
 -------------
 
