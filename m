Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8682192F4
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 04:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783225686; cv=none; b=EpUgmae3FEI1Kzx6ydhUMO3dM98isbs+6BzzvC6HrqU4GNMOj78BvtTMPu96datOfZXXCh9yUxRyorV7vkgGKNa8W81GZNA6Qu0TJX76G8tj8wrmBkSlVz/lT/dFQAGn8Nd/QupClg0J7N8uqYtuPxxwzQUEcp2Eu7FJMpbf33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783225686; c=relaxed/simple;
	bh=OpNNgFFw2EF6zu0KYYAKymrU8Fswt5mdJ4LAOR9wU/4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VI2KE+rJovgL0SoyK5H0mwpSew6CEgU28AfrNZvK5tluZw5xovbXP+pP+R5Zj+rMbspeuk8cgY7RMkvavvHUDh3uWvmjME0gN3KWXp1UaC1lwk63xmK1kbCWJpza4vTGaZFRfbdFAqQidxDeZsn9jIi2NJnWAJvXzlb3gJ2U/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GbHANayk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WjWKkA07; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GbHANayk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjWKkA07"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F03451D00085;
	Sun,  5 Jul 2026 00:28:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 00:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1783225683; x=1783312083; bh=YX5GjXWJe4WMi6jweeeI2zucwr3K3YXh
	8cCexQkTztI=; b=GbHANaykUknWLAEX+sg6GsnzGn7FZ2b67QxYzTduspAHYWCW
	wH7xCfMH7PBBLxLG4adRvsiQFsd8HP1tJXSj2II+z6WwmC3+W0+446CraxKLV8xx
	n5rMrFgHBN8HGEfadZ56pMNeXCBfzG7qbWRkrK1n2D0kKEonjjIIVOUpsEjJXk9X
	ZQa73A3iasCStD/eZoEoY9zdyRUqR7BwNNF0C99mKCWQGQtJMfFhAzSfzBdTnAb9
	TzqpsnIKNBgzeuCcdU2jUeD64gMz2UodcSmtOG3zdXKAiFcSu9aOGTcoYoLNJJez
	r++JQhCamxsTwFYsZgRfPQ6PimG8dd7hyLWKwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783225683; x=
	1783312083; bh=YX5GjXWJe4WMi6jweeeI2zucwr3K3YXh8cCexQkTztI=; b=W
	jWKkA07lelAJTnvNftzdtoUBXlMo2BNBJWatZlgS4SQZOs0R926Q9WefrlVFgvOy
	ONfr4Rd0FT0YBnRKOTGGJvp6EENJB3z4Ub6H8REZQMEsEyiSRR4xN+r616NaxXJ2
	7J5N6VRcMmxB9mOOsQJBA0YRs4sZxN/1VgOhpt23zs1vVFWv0cnslnLqEepUafFw
	VfAhvmLBfR/RCkft9ZecLLjJzJnDnBPz3PWHOE8uX+6TajXiXub9Z/fatwoMZmhA
	58ezNy6hpS2rQ/65qbJsqig41wIyONGmKFe+MfdQyv5mXvUBksOZDlx8VjA/LSQC
	Fc9iF8cjbPzF6LMPHHsAw==
X-ME-Sender: <xms:U91Jah0qBWThBxuKSLqMpZJNmYA555bka6due9b0vFdqXaZLPj50aw>
    <xme:U91JauGbWAuA7IxLDjRcTHd4-zNUSiSDHBswAnjwPxaXy_PTzZCUGOz5ZD2-iYiA6
    sP7aV7wBpbZ1JAsVZ8eKtcYdrUVFIhCG5kVsqtUSlojaDqtjTi-_w>
X-ME-Received: <xmr:U91Javh6e3a4FQkl5L7MwSPRQfHlIhmLKkMs8YUzo035mkiWPPSt-4LYdwljewnfaIBecjwVsSqwAoCHlJtMmo2XgB_VV32RJV3qhOI>
X-ME-Proxy-Cause: dmFkZTE4gJ6YuGdp6bBPx9FA9C5mEN4wMi7Z1D0PVD8lFrIvfjRTZE5xINcTEKzGQARbmW
    etOyO6dNGdi1atNv1/vZyj/X2A33/r+By5mHeGZ5RJyhoga6C/fXGXOerZ+eeSBnHuRGum
    eVmBm4qQamaPmeRtrqR+pCIJEQdxBIxFnYjru7JzV4ucB2ZhG7Y8P7LV3A/WJOgw+ygUpm
    fUbR00Hh6pfiDF6CMK9nzBi9IpHwAHhWa+XH2fr2+KAi0YH3eZ5TanKX8swb7+3Tpp2B4L
    kmj+bQruDznAeudQzvtSHP5VTGg2yhsrAji9FyrIw7yIqJ/F+/yXUcARnY1QB/EjaKXsMN
    xTCSeQlGXUt0Cz2heRUosgMixoTi3gAovcnePVriTU1TE3P88IN7yjana8M1rYaODBj+kS
    98S4SlokGZ/uX9cQ0xRqx6afARmEl2RLAzY3Ct3Cjsbg8ng39eLtyA2dRK2H7yNMz+iFwp
    1aVeqoCfnFN3zS/mMT4HJrbAyj4sUClcmzFhn1otO0mdP1aJMjxFrzCMCInsdvUzGGSIvE
    /JW1Bbwi4jHYUSWgv+KjdnLaHwtsuTFxAsgKG/IuqzGNfJqT0XxApjN3RpLE5lIh9QF2OC
    LKqhztUDCLt+8F4e1rxJEsfPJyZaSQ27ZGBQuTvJ4/l3YJv1hODKLVq5jbxA
X-ME-Proxy: <xmx:U91Jap90iPfUMe8Ckx8YxkcDJYVvlTbCJEJjeSwbDZPo-YJTtnicqw>
    <xmx:U91Jamr_OkyYlCB4olckwj4amdPbzra7AHVioUi2PCkiIAaTMY2pYg>
    <xmx:U91Jao_n53W48EZIMpTdRohX7AaII1nByi_EscAZM5pwqi24M1Sd8g>
    <xmx:U91JaqXEMONs_S2pDj2FTTuZ4_A3kY4SK0ezk1IrtLulmcAeCMB6lg>
    <xmx:U91JatOKElOQbZa5fwRGqNOiDWhcsYVBGWeHH2GNW9_z0tElP2YyLlIo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 00:28:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] diff: give --compact-summary a short synonym --sstat
Date: Sat, 04 Jul 2026 21:28:01 -0700
Message-ID: <xmqqldbqdpri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

These days I find myself using '--compact-summary' very often, which
I consider is a strict superset of '--stat' (or '--stat --summary').
Promote its use by giving it a short synonym '--sstat' (stands for
summary+stat).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The `format-patch` output still uses --stat --summary, which
   looks like so:

 Documentation/diff-options.adoc                      |  1 +
 diff.c                                               |  3 +++
 t/t4000-diff-format.sh                               |  2 +-
 t/t4013-diff-various.sh                              |  2 ++
 .../diff.diff-tree_--pretty_--root_--sstat_initial   | 12 ++++++++++++
 t/t4013/diff.diff-tree_-R_--sstat_initial_mode       |  4 ++++
 6 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial
 create mode 100644 t/t4013/diff.diff-tree_-R_--sstat_initial_mode

   but if we change it to use --compact-summary (aka --sstat), it
   would instead look like this:

 Documentation/diff-options.adoc                              |  1 +
 diff.c                                                       |  3 +++
 t/t4000-diff-format.sh                                       |  2 +-
 t/t4013-diff-various.sh                                      |  2 ++
 t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial (new) | 12 ++++++++++++
 t/t4013/diff.diff-tree_-R_--sstat_initial_mode (new)         |  4 ++++
 6 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index c8242e2462..b2b755fd3d 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -221,6 +221,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
 `--stat-name-width=<name-width>` and `--stat-count=<count>`.
 
 `--compact-summary`::
+`--sstat`::
 	Output a condensed summary of extended header information such
 	as file creations or deletions ("new" or "gone", optionally `+l`
 	if it's a symlink) and mode changes (`+x` or `-x` for adding
diff --git a/diff.c b/diff.c
index 2a9d0d8687..284d391c47 100644
--- a/diff.c
+++ b/diff.c
@@ -6112,6 +6112,9 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
 			       N_("generate compact summary in diffstat"),
 			       PARSE_OPT_NOARG, diff_opt_compact_summary),
+		OPT_CALLBACK_F(0, "sstat", options, NULL,
+			       N_("generate compact summary in diffstat"),
+			       PARSE_OPT_NOARG|PARSE_OPT_HIDDEN, diff_opt_compact_summary),
 		OPT_CALLBACK_F(0, "binary", options, NULL,
 			       N_("output a binary diff that can be applied"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 32b14e3a71..cc5c62fdbc 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -101,7 +101,7 @@ date >path2/path3
 
 for format in stat raw numstat shortstat summary \
 	dirstat cumulative dirstat-by-file \
-	patch-with-raw patch-with-stat compact-summary
+	patch-with-raw patch-with-stat compact-summary sstat
 do
 	test_expect_success "--no-patch in 'git diff-files --no-patch --$format' is a no-op" '
 		git diff-files --no-patch "--$format" >actual &&
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index d35695f5b0..a42dca8a0b 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -474,6 +474,8 @@ diff-tree --pretty --notes note
 diff-tree --format=%N note
 diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
+diff-tree --pretty --root --sstat initial
+diff-tree -R --sstat initial mode
 EOF
 
 test_expect_success !WITH_BREAKING_CHANGES 'whatchanged needs --i-still-use-this' '
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial b/t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial
new file mode 100644
index 0000000000..b5c9d7693a
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial
@@ -0,0 +1,12 @@
+$ git diff-tree --pretty --root --sstat initial
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
+ 3 files changed, 8 insertions(+)
+$
diff --git a/t/t4013/diff.diff-tree_-R_--sstat_initial_mode b/t/t4013/diff.diff-tree_-R_--sstat_initial_mode
new file mode 100644
index 0000000000..51b1aa7d71
--- /dev/null
+++ b/t/t4013/diff.diff-tree_-R_--sstat_initial_mode
@@ -0,0 +1,4 @@
+$ git diff-tree -R --sstat initial mode
+ file0 (mode -x) | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+$
-- 
2.55.0-236-g7bd4d671b1

