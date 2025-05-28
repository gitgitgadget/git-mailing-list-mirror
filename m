Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193338B
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453366; cv=none; b=rHXka9cqXyVeg31WW6GaqiWk6tMbIUVdOZGn3TZ57bwXrt0612FegeA90T4ftP2FQ8H1ov4wej99A9YV4pZdorQjWpMi2xzuCVESW74R50HXJpqXEIf6MlwEHrBMn8LZZjLtuAr6AjylA+GWukHTxauNc+qxSkAU3f6Usdt1rIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453366; c=relaxed/simple;
	bh=rth7KoZnFzQtbD7kFgQ3FT9ttkkYgVtQr5lgSPjVZ1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DB8RXm1i5caV/pCFGED5HDTvJfkWuNjs9hMzw1QX8A96DzsqeUsaaaXw7Tan6LLo0WZVmXVEpWYFMnRWDkLAhSmOzj8os+apLzUp/CfkRtVS3ZaSg+j/PPlwDK0fvKPR2NHorNOMW5bycBw/rc/w9uysFg3M+3YbQWP9SZE8tE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FU0KlePo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=me+EdgnB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FU0KlePo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="me+EdgnB"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C65E1140144;
	Wed, 28 May 2025 13:29:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 28 May 2025 13:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748453362; x=1748539762; bh=JNjwtDNXW5
	1Z6ezXfn5so5k/2YXE9BsesnjIx4xjxds=; b=FU0KlePoUCvZFjHxs4M89EDsPJ
	JDWkS3svThSqrUJ9UjLlzJx7261KXQFn0CCZZsY2/A3AMJKiuflvtzFpBcGkA+Fc
	MvmmW8aAtzwq29mjlR1FfhZJRhUUWxYG2RR6KNe416FBSJnO+6sV7pBcYt635lsn
	TjyEksRrp2boILqfyFI5ixukKptm7MW/m9rfELmTWbfBHaddqrW2WN8igvfgOJiV
	0K6o/UwikaGMNDbVo44+YPVZaRcxold9iKvrElZe/EMmx6Gr/IzmcJhwmcwFxSPL
	B8bm1/P1EcW4LN04hlE/12p03RSFwQ1pkz47MKrFM8H4/KUKDlLcjBgZkgUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748453362; x=1748539762; bh=JNjwtDNXW51Z6ezXfn5so5k/2YXE9Bsesnj
	Ix4xjxds=; b=me+EdgnB7cZkxHDoZCVAr+pOgalabWKjEVxscfgb0JOuUWWYUVw
	v3tyhU06d2ob94BfnzIhB1qJkxNJQmJikqoYiEzjNEpJzyl4e67BYjdZxDGc1nRN
	+VdOEkEN7UZTodsoRB4lSEBhVVqOn4pRJN3OJsqkZPULNSKK3XUZtprM5UQZp3uK
	GsGx2L6bPxOVU3sMy2p9OhrUb0gb0ZOsqPoYF0aBpkVSnaGXD40n+ELGSeIBdkOj
	+/yQaQ75Hjb6yh7Mhxo+ZrVVdG8haOEWh+oX25VfpRrGd334E8po40cqYXStq0+X
	S4Dqh21pR9AvNcbEugj2baeXWxTIzmoPbDg==
X-ME-Sender: <xms:8Uc3aMAMRxkHoh7ld1M9CCEoa-ieEXjB3t0DTE-ZrsEgmPsmtn-ehg>
    <xme:8Uc3aOgJqyHl3iv0QoX3xKpub7skdT_6ZAPPOzzdnhJTZiQvMQ-iLWCC8tS0qk0t8
    Ye-jKKA9R-f0zeBlA>
X-ME-Received: <xmr:8Uc3aPn_-UlWhkEOoKzlsEmofoQXDC3PbfTFSD7Ft1TBU6S3SV6N1v74qyJeqZ06jWeEaQX7L7noB21PJoe5uvctZeYlsaWqprxCWdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeekjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehluhhkvghshhhusegurghtrgifihhrvgdrihhopdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8Uc3aCwf20fFb_pPGV_Wzd5awVBAEGtjFdw323gJBPmYZaGUXHhTGg>
    <xmx:8Uc3aBSSIZdACdBvnEg_I0ubQubaV4DTAPEg_KdxWZtoM0xRChP-QQ>
    <xmx:8Uc3aNbG3wW1jHnd45I0UDFjmmVvu2aSGPhy_MLvnPjOTr-DRTpaiA>
    <xmx:8Uc3aKR-0eBzq5pG6srvYGv-Fp_gI6BN4jMZCsc6tAYkgO8xrGiNUQ>
    <xmx:8kc3aMcoklDoV-YaQ8gcRB79Ao5a10e4SgfffTHmubiTK3l1a_95om5l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 13:29:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>, Luke Shumaker
 <lukeshu@datawire.io>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-(import|export): improve on the signature
 algorithm name
In-Reply-To: <xmqqzfeyqdye.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	27 May 2025 08:18:49 -0700")
References: <20250424203904.909777-1-christian.couder@gmail.com>
	<xmqqselxtfyf.fsf@gitster.g>
	<CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
	<xmqq1pthtbdg.fsf@gitster.g>
	<CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
	<xmqqzfeyqdye.fsf@gitster.g>
Date: Wed, 28 May 2025 10:29:19 -0700
Message-ID: <xmqq8qmgsky8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> I agree that we should have at least said in big letters that the
>> improved support for signed commits in fast-export/import is very
>> experimental and very likely to change in the future.
>>
>> We could still do so. This could give us a bit of time and flexibility
>> until we agree on and implement something better and backward
>> compatible. (Hopefully the v2 will help us move forward.)
>
> OK, as the next release is approaching, perhaps we do a bit of
> documentation update to address that "we are experimenting" and
> nothing else, and leave the v2 updates for the next cycle?

---- >8 ----
Subject: [PATCH] fast-export: --signed-commits is experimental

As the design of signature handling is still being discussed, it is
likely that the data stream produced by the code in Git 2.50 would
have to be changed in such a way that is not backward compatible.

Mark the feature as experimental and discourge its use for now.

Also flip the default on the generation side to "strip"; users of
existing versions would not have passed --signed-commits=strip and
will be broken by this change if the default is made to abort, and
will be encouraged by the error message to produce data stream with
future breakage guarantees by passing --signed-commits option.

As we tone down the default behaviour, we no longer need the
FAST_EXPORT_SIGNED_COMMITS_NOABORT environment variable, which was
not discoverable enough.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.50.0.adoc |  4 +++-
 Documentation/git-fast-export.adoc | 12 +++++-------
 Documentation/git-fast-import.adoc |  3 +++
 builtin/fast-export.c              |  7 +------
 t/t9350-fast-export.sh             | 20 ++++----------------
 5 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/Documentation/RelNotes/2.50.0.adoc b/Documentation/RelNotes/2.50.0.adoc
index c6c34d1a1d..9a1cdf0dc0 100644
--- a/Documentation/RelNotes/2.50.0.adoc
+++ b/Documentation/RelNotes/2.50.0.adoc
@@ -100,7 +100,9 @@ Performance, Internal Implementation, Development Support etc.
  * "git fsck" becomes more careful when checking the refs.
 
  * "git fast-export | git fast-import" learns to deal with commit and
-   tag objects with embedded signatures a bit better.
+   tag objects with embedded signatures a bit better.  This is highly
+   experimental and the format of the data stream may change in the
+   future without compatibility guarantees.
 
  * The code paths to check whether a refname X is available (by seeing
    if another ref X/Y exists, etc.) have been optimized.
diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 413a527496..43bbb4f63c 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -46,14 +46,12 @@ resulting tag will have an invalid signature.
 
 --signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
 	Specify how to handle signed commits.  Behaves exactly as
-	'--signed-tags', but for commits.  Default is 'abort'.
+	'--signed-tags', but for commits.  Default is 'strip', which
+	is the same as how earlier versions of this command without
+	this option behaved.
 +
-Earlier versions this command that did not have '--signed-commits'
-behaved as if '--signed-commits=strip'.  As an escape hatch for users
-of tools that call 'git fast-export' but do not yet support
-'--signed-commits', you may set the environment variable
-'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' in order to change the default
-from 'abort' to 'warn-strip'.
+NOTE: This is highly experimental and the format of the data stream may
+change in the future without compatibility guarantees.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 7b107f5e8e..250d866652 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -523,6 +523,9 @@ that signs the commit data.
 Here <alg> specifies which hashing algorithm is used for this
 signature, either `sha1` or `sha256`.
 
+NOTE: This is highly experimental and the format of the data stream may
+change in the future without compatibility guarantees.
+
 `encoding`
 ^^^^^^^^^^
 The optional `encoding` command indicates the encoding of the commit
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 37c01d6c6f..fcf6b00d5f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -39,7 +39,7 @@ enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_WARN_VERBATIM, SIGN
 
 static int progress;
 static enum sign_mode signed_tag_mode = SIGN_ABORT;
-static enum sign_mode signed_commit_mode = SIGN_ABORT;
+static enum sign_mode signed_commit_mode = SIGN_STRIP;
 static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
 static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
 static int fake_missing_tagger;
@@ -1269,7 +1269,6 @@ int cmd_fast_export(int argc,
 		    const char *prefix,
 		    struct repository *repo UNUSED)
 {
-	const char *env_signed_commits_noabort;
 	struct rev_info revs;
 	struct commit *commit;
 	char *export_filename = NULL,
@@ -1327,10 +1326,6 @@ int cmd_fast_export(int argc,
 	if (argc == 1)
 		usage_with_options (fast_export_usage, options);
 
-	env_signed_commits_noabort = getenv("FAST_EXPORT_SIGNED_COMMITS_NOABORT");
-	if (env_signed_commits_noabort && *env_signed_commits_noabort)
-		signed_commit_mode = SIGN_WARN_STRIP;
-
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index dda9e7c3e7..76619765fc 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -299,22 +299,10 @@ test_expect_success GPG 'set up signed commit' '
 
 '
 
-test_expect_success GPG 'signed-commits default' '
-
-	sane_unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
-	test_must_fail git fast-export --reencode=no commit-signing &&
-
-	FAST_EXPORT_SIGNED_COMMITS_NOABORT=1 git fast-export --reencode=no commit-signing >output 2>err &&
-	! grep ^gpgsig output &&
-	grep "^encoding ISO-8859-1" output &&
-	test -s err &&
-	sed "s/commit-signing/commit-strip-signing/" output | (
-		cd new &&
-		git fast-import &&
-		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
-		test $COMMIT_SIGNING != $STRIPPED
-	)
-
+test_expect_success GPG 'signed-commits default is same as strip' '
+	git fast-export --reencode=no commit-signing >out1 2>err &&
+	git fast-export --reencode=no --signed-commits=strip commit-signing >out2 &&
+	test_cmp out1 out2
 '
 
 test_expect_success GPG 'signed-commits=abort' '
-- 
2.50.0-rc0-134-gb29a910c2a

