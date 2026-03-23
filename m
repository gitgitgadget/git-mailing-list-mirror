Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E03BF678
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285083; cv=none; b=FvNbq9Ve/KK748SXJfN96SeWOskJcVYUfy6f7mMVwSUsjvcJE/mdUGTo8H8eegwbl6XolrXJ1Ec4hyd7MRz1FGA3PRahJ0z1+JbE1yc3bgoRcD4fSp5jR1Cjhowh54lAxH4nvuUnI3KIEv6AOoMbnU5+9J/P6Ovk8XsE/oq+mWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285083; c=relaxed/simple;
	bh=Fnjshu5FfuB2b34uqh6iYzhGBi2aSPdK211ZkWw9uJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF9+CcuN5QqxBIAsba18aMtIHSmbOel46LE3/d26csNSfHRjAZSxe5uPhdYAMV9AGb+v2QQzdo41sDqxGwLRWMfQ3AvovFbHKVQl2LMpeaCrEYz8Qewb3JO40rzdgFRo1jSIx1n6Fqy0Nj+30jw02P8wRf0ZoYTTuU/7FP2qHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=OUhTHes+; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="OUhTHes+"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774285078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDshCzZvnV/8yD8aYPEDESnv+1SQebKwzIvCBVc9iRY=;
	b=OUhTHes+H5gaenZ20nbYHpk0f+6e2IlGPFfdhCX4Oe8u9KEyT7zictCzrG7eav8/rJqJ6F
	gZ8RcHlCcmkRV5CANDqwO1UdoAXJnj/aWMlEvdxcFZnMXct0IjauzET21eLNNNnmiA7npf
	bwZm2k8uHyU3JHtxr0GOcsQRY63juEBhEtNCVJ/CdwfqrnJ4YjvOW4CskXRgcmUjrkQKxj
	qWv3C84m1taJdqTo9rcITX5ic4O9k8oAhcxe9luOhncYkS1jU9/VIS9izhjKttc1ZjYRCJ
	iHsqIijROBK7dr1OyQOY95cE6PVV6iKXyswNyQt7gF01X/AqCNMg4OCduV5iEw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 7/8] format-patch: add preset for --commit-list-format
Date: Mon, 23 Mar 2026 17:57:34 +0100
Message-ID: <bdd8f1fb579af60b2c018f463e91c90859bb2daf.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1774284699.git.mroik@delayed.space>
References: <cover.1773959395.git.mroik@delayed.space> <cover.1774284699.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4612; i=mroik@delayed.space; h=from:subject:message-id; bh=Fnjshu5FfuB2b34uqh6iYzhGBi2aSPdK211ZkWw9uJs=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpwXD0KpxVAIbY8ZRi6LR3M95/K16092uJ5i1LU y8VTnpiJLiJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacFw9AAKCRBIeX6hnBm+ 0cj8D/9Gr5iCU1+Mtz4AJa1FtRFovhtJaldN0oWxU5DOTMALJDQ4w54fYCj3/o1uH6OaXBCf8Z/ +JaU6eZthSMsEEO3bUv5PxY04nMkrtuFsygVkmXVIKv37IBJXRVRjXCCBbI4ed6TKgN79SjsxSM UphEwb8tof7xPiyl9D6Vr08mSjZw19T6gI9XzL8udT2ND7GJRdAPWtafPpO28k+8idzKHn9XnQX jQ7icf7wnAqBtt7uy3CqxTntzHR13b8ukOcIszuSEu4yTIxHaRaOeZOuXR0tMmHkQcAoJQN8Edf WUirJWtTXRqrStNzgwyXZyWEFqME+RcsHjDIXUXY1esL4SNgwnaEmIHdbRD3nX+V+9bn/oYyr6F TO71xXVxIA51JN2oze8P/SbuLFew3k1mkrceVHU96OO687JbELng1HykkYBCR5PjksS1ZCGMqXj ULTJLPPDpmPuwabj/zx0kqm+RHzJkdPy9ajLV31sP2WXPKwWmiOFOQ3kixj/CpDHPQdXdeF3a1w Eu+snHW2KJ5U2qTQner5aTZr47wnK4nhPfn1lCPK7k2/quBYEOcPh5yRfv+acxBK6VxmCw0rW5V 2kKjEXhbI/GRb694VZpW917A8aOqPnOwh14KDoxdESiOtOLjdgmKpMYSl+H4wV+wHc5ItVZP5ZU peJv20sWI
 WhZXzQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

"git format-patch --commit-list-format" enables the user to make their
own format for the commit list in the cover letter. It would be nice to
have a ready to use format to replace shortlog.

Teach make_cover_letter() the "modern" format preset.
This new format is the same as: "log:[%(count)/%(total)] %s".

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc |  4 ++--
 builtin/log.c                       |  3 +++
 t/t4014-format-patch.sh             | 20 +++++++++++++++-----
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ea5ec5df7a..ef1ed1d250 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -104,7 +104,7 @@ format.coverLetter::
 format.commitListFormat::
 	When the `--cover-letter-format` option is not given, `format-patch`
 	uses the value of this variable to decide how to format the title of
-	each commit. Default to `shortlog`.
+	each commit. Defaults to `shortlog`.
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 45ca72e670..55cc680685 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -325,8 +325,8 @@ feeding the result to `git send-email`.
 
 --commit-list-format=<format-spec>::
 	Specify the format in which to generate the commit list of the patch
-	series. The accepted values for format-spec are "shortlog" or a format
-	string prefixed with `log:`.
+	series. The accepted values for format-spec are `shortlog`, `modern` or a
+	format string prefixed with `log:`.
 	e.g. `log: %s (%an)`
 	If not given, defaults to the `format.commitListFormat` configuration
 	variable.
diff --git a/builtin/log.c b/builtin/log.c
index d1765ce4ad..c6cf04350a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1445,6 +1445,9 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
 	else if (!strcmp(format, "shortlog"))
 		generate_shortlog_cover_letter(&log, rev, list, nr);
+	else if (!strcmp(format, "modern"))
+		generate_commit_list_cover(rev->diffopt.file, "[%(count)/%(total)] %s",
+					   list, nr);
 	else
 		die(_("'%s' is not a valid format string"), format);
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ca37f40a6a..7571cc582b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -392,18 +392,17 @@ test_expect_success 'cover letter with subject, author and count' '
 	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
-test_expect_success 'cover letter with author and count' '
+test_expect_success 'cover letter modern format' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --commit-list-format="log:[%(count)/%(total)] %an" \
-	-o patches HEAD~1 &&
-	test_grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch
+	git format-patch --commit-list-format="modern" -o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject$" patches/0000-cover-letter.patch
 '
 
-test_expect_success 'cover letter shortlog' '
+test_expect_success 'cover letter shortlog format' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf expect patches result test_file" &&
 	cat >expect <<-"EOF" &&
@@ -451,6 +450,17 @@ test_expect_success 'cover letter config with count and author' '
 	test_line_count = 2 result
 '
 
+test_expect_success 'cover letter config commitlistformat set to modern' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat modern &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*$" patches/0000-cover-letter.patch >result &&
+	test_line_count = 2 result
+'
+
 test_expect_success 'cover letter config commitlistformat set to shortlog' '
 	test_when_finished "rm -rf patches result" &&
 	test_when_finished "git config unset format.coverletter" &&
-- 
2.53.0.1118.gaef5881109

