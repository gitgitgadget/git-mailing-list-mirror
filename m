Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B331326A
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213877; cv=none; b=smfPA5IcFShfIMhWoUQ7ZEE+tLtvqSJp6lOz73HvDpRpKube19tCPEIDXt1Lh4hDxCWMlbMtuBaJytrMO5xec1C4obk8psr0fZyD5dUtBKgTRcJaUGC18l8zzgNtwz0QcozDZQtnWx8aYFIPdqhtlm2/5n7Ho2YCcdBn2zxvZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213877; c=relaxed/simple;
	bh=gjQZVRfLwWR+HBjpP5pYqg+Hb1DsKonwG4ZuflO0ad8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JB9RTrhjbMs/Z82mcmD8yYqdSf1GSpNLxj07CyBjbBiSwNo+XcxdBndsnrWLu41/xIKLiQHq6SfegJiFma8ws3lhRAbG41FJE4hoJdO02VFq5Htirrk8C0mney0JfVr3PcoHqgGqo01lk+QDEIcRfSJC9YEKEgnim+8ic/IWCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iZjay6Hh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKMcN5x3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZjay6Hh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKMcN5x3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4FBB0140009C;
	Thu, 11 Jun 2026 17:37:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 17:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781213875; x=1781300275; bh=NCgRLr/74d
	9k4Ewcw27xJDPAQsuk6ju3VKyFjRwGFn0=; b=iZjay6HhI6Ep9T26mKcUTQQHkO
	bB9WcnPR6v9Z7tEqzSzB7uWbPTccZrgaB2hJKoDgCLJJ0Q1mrnqzpTr3QTOAEf2k
	F2uGDEsGhK0l0CO2A5qv72T5B3tp2y/AGs//TnNoXg82OvUqz0r97tHUZm34+I6y
	kIo1/7RUGFHvgCHjhtYncDFLNH8I4zvq53row01gwUjq8n4qwChYDpj2/pXtMV6j
	NSYK/2XKSQOMzUEkEpykbqp3PadBaHuzLmBo/xcdUczTAcnDe2m0KdtUaLaPHlFC
	/C40ggrA9TPqXIl10noaVit874St74U1+VMY4XUhcNBVrwlAbKmCD6nRFgUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781213875; x=1781300275; bh=NCgRLr/74d9k4Ewcw27xJDPAQsuk6ju3VKy
	FjRwGFn0=; b=dKMcN5x3hLleXGefeImbnO4v9Mp/7rMYTzZ7mGITQmrNmORhVLp
	BXkTSpZeNgC9fqj42Qizgejo8+32pyHsKf5m4qVtocp2UzRMSz1sDm5kZLMSaDBA
	9eRV8EfqB9BqNgV2BjWgmGVjjNVULeXuhzux+3nzzpGmpKARhEbygKcAY/Dm8AZo
	LYg2z1oUsf33etVhnXRKCh+sCP3v0jAlA1K8C7VfamEMlt8bMpiCZlL+o+DcSN8x
	/9pi5U/OJpZIQGVc0Oso3Et9fUjAH8t9T3a8Fgwi96svnj4BuVIdvU3xR5XMRaXw
	t1X1RtfRihKNBdpO3Q2IBvpS4EW8dF1/ryQ==
X-ME-Sender: <xms:syoran3-8ynuItv-2uDnDC24kZ7oo1665cFVzlXuhcvRERMP4EodZw>
    <xme:syoratiglcbM39-55e3LejO0ui2Omv1gYMC6ZwC-rxuB7Oax73BfzORRnodjWeCzr
    GvxcFkjGZmTDesE6FZcm3dqQzMMhrCpn2dNPqE9VdHaMSVFDSXAhDU>
X-ME-Received: <xmr:syoralSU1ce6qqd94JBjnFpOUWKu5KLat0JIodv-_k5BL-Vz7iDcIkATn5KMKCf1wKYkAmQ7PKJgWhfj_ek3VsQehSMqQYYYDax3>
X-ME-Proxy-Cause: dmFkZTEeazPmbqkR1UyNSprRck5wcGIDEcByrGMoqrY2o9mrKyEKA61UUB1C9yG15MON+T
    Kckv228KcRUuvOtnEA9nz1oLONUvr3af0hj38xkmvA3Bw1+i//jEvM1MGE9/Ef5+xOre8U
    6NDqv9ARW4sy0YvEVYfApNzcqUy7SSflVdpfxBXDdhw1SqXe7wTFoe1x0Sboly8dUpK8KQ
    9b6OVT/D5WlHhWyYr9EqXHIVbqUHFA5DS8w+rK/EBPEFHzYx5r4WnQmFLKwAskNd8djtIZ
    L0aJC5oYf5lNcAAr+61jm7JlEQz14PL+Oa9YfWn97gMwgEaAnDjqGEV+y556w7uNYyYGLj
    5CIlBA/7yQQMQVgE8+tkPZQ08JOgHajwGPubqq3BT4YNMiV4j4L3NyEMHNBRK5aScz1i4q
    QlEwYql+srJKQyr0ZXDQKdYF7XruVEaghpS1XHU4mPUK4vsozj4T6WEeMucOo9mOiaJL4z
    huCWijWRZvTS6PoaMze0KyQe1rqZMrBS3F5C3dGP3MxpMNb++i7uILis9iXnuBP66RmCxh
    oaszyj8sMIHObF+WmZlixs1jZyo6XBoEZ6haQvwqga3D2L8jo/zVGtBVWvioS7ofuXzYAM
    Ncoj2XXYvZuW+CXpydm+cS1u0NRtYYgPCZ0LwaKlg2b7txq2G4aB3aLre46w
X-ME-Proxy: <xmx:syoramgjbndSrd9JEhMQbdGROsZZjW9bKMjtvz1wTw205-CH0gPOWw>
    <xmx:syorat7-9QuFoWojgNecy1sRCnarVdiAhMGwX7mBlMEMZ9rouLle5A>
    <xmx:syorarB58p3S23xe0mM2zlhTswT5m_9i16EBa_HGVxrOawTr9lMUOw>
    <xmx:syorasb5pFXtQt-WFa0-pou21G2f0-d6lRdpPZpcITDjg4CQz4xNeA>
    <xmx:syoratpaKr7est49W1JL1-wsJGPastA_8f9rx5ttAqH4Xy2E0j8FouCh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 17:37:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3] update-ref: add --rename option
In-Reply-To: <xmqqv7brz9ba.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	09 Jun 2026 14:35:21 -0700")
References: <xmqqv7brz9ba.fsf@gitster.g>
Date: Thu, 11 Jun 2026 14:37:53 -0700
Message-ID: <xmqq7bo4n4ge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add a "--rename" option to "git update-ref" with the syntax:

 $ git update-ref --rename <old-refname> <new-refname>

It renames <old-refname> together with its reflog to <new-refname>;
even when used on a local branch ref, the current value and the
reflog of the ref are the only things that are renamed.  Document it
and redirect casual users to "git branch -m" if that is what they
wanted to do.

Because the "--stdin" mode wants to operate on its refs in a
reference transaction, and the API function refs_rename_ref() does
not work well as part of a transaction, it is currently not possible
to add a corresponding "rename" verb to the "--stdin" mode before
the underlying API learns to rename refs atomically inside a
transaction.  It hence is left for a future refactoring.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As a single patch topic, the range-diff relative to v2 is at the
   end of the message.

   - Simplified the proposed commit log message a bit.
   - Dropped mention of --[no-]deref from the synopsis section.
   - Reworded documentation with help from Patrick.

 Documentation/git-update-ref.adoc |  9 +++++++++
 builtin/update-ref.c              | 32 +++++++++++++++++++++++++++++--
 t/t1400-update-ref.sh             | 24 +++++++++++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 37a5019a8b..3b4df23a86 100644
--- a/Documentation/git-update-ref.adoc
+++ b/Documentation/git-update-ref.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
+git update-ref [-m <reason>] --rename <old-refname> <new-refname>
 git update-ref [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
 git update-ref [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
 
@@ -39,6 +40,14 @@ the result of following the symbolic pointers.
 With `-d`, it deletes the named <ref> after verifying that it
 still contains <old-oid>.
 
+With `--rename`, it renames <old-refname> together with its reflog to
+<new-refname>.  The command fails if <old-refname> does not exist, or
+if <new-refname> already exists.  The command does not update any
+symbolic references pointing to the renamed reference, and neither
+does it update `.git/config` tracking settings. It is thus not
+recommended to use it for renaming local branches. Use `git branch -m`
+instead.
+
 With `--stdin`, update-ref reads instructions from standard input and
 performs all modifications together.  Specify commands of the form:
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d68c40ecb..65ee8af08c 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -15,6 +15,7 @@
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [<options>] -d <refname> [<old-oid>]"),
 	N_("git update-ref [<options>]    <refname> <new-oid> [<old-oid>]"),
+	N_("git update-ref [<options>] --rename <old-refname> <new-refname>"),
 	N_("git update-ref [<options>] --stdin [-z] [--batch-updates]"),
 	NULL
 };
@@ -756,13 +757,14 @@ int cmd_update_ref(int argc,
 {
 	const char *refname, *oldval;
 	struct object_id oid, oldoid;
-	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
+	int delete = 0, rename = 0, no_deref = 0, read_stdin = 0, end_null = 0;
 	int create_reflog = 0;
 	unsigned int flags = 0;
 
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
+		OPT_BOOL( 0 , "rename", &rename, N_("rename the reference")),
 		OPT_BOOL( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
@@ -787,7 +789,7 @@ int cmd_update_ref(int argc,
 	}
 
 	if (read_stdin) {
-		if (delete || argc > 0)
+		if (delete || rename || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
@@ -800,6 +802,32 @@ int cmd_update_ref(int argc,
 	if (end_null)
 		usage_with_options(git_update_ref_usage, options);
 
+	if (rename) {
+		const char *oldref, *newref;
+
+		if (delete || argc != 2)
+			usage_with_options(git_update_ref_usage, options);
+
+		oldref = argv[0];
+		newref = argv[1];
+
+		if (check_refname_format(oldref, 0))
+			die("invalid ref format: %s", oldref);
+		if (check_refname_format(newref, 0))
+			die("invalid ref format: %s", newref);
+
+		if (!refs_ref_exists(get_main_ref_store(the_repository), oldref))
+			die("no ref named '%s'", oldref);
+
+		if (refs_ref_exists(get_main_ref_store(the_repository), newref))
+			die("ref '%s' already exists", newref);
+
+		if (refs_rename_ref(get_main_ref_store(the_repository),
+				    oldref, newref, msg))
+			die("rename failed");
+		return 0;
+	}
+
 	if (delete) {
 		if (argc < 1 || argc > 2)
 			usage_with_options(git_update_ref_usage, options);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b2858a9061..4330cad282 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2455,4 +2455,28 @@ test_expect_success 'dangling symref overwritten without old oid' '
 	test_must_fail git rev-parse --verify refs/heads/does-not-exist
 '
 
+test_expect_success '--rename fails if old-refname does not exist' '
+	test_must_fail git update-ref --rename refs/tags/no-such-ref refs/tags/new-ref 2>err &&
+	test_grep "no ref named .refs/tags/no-such-ref." err
+'
+
+test_expect_success '--rename fails if new-refname does exist' '
+	git update-ref refs/tags/existing HEAD &&
+	git update-ref refs/tags/old-ref HEAD &&
+	test_must_fail git update-ref --rename refs/tags/old-ref refs/tags/existing 2>err &&
+	test_grep "ref .refs/tags/existing. already exists" err
+'
+
+test_expect_success '--rename moves old-refname and its reflog to new-refname' '
+	test_config core.logallrefupdates always &&
+	git update-ref -m "old tag" refs/tags/old-tag HEAD &&
+	git update-ref -m "to new" --rename refs/tags/old-tag refs/tags/new-tag 2>err &&
+	test_must_be_empty err &&
+	git show-ref --exists refs/tags/new-tag &&
+	test_must_fail git show-ref --exists refs/tags/old-tag &&
+	git log -g refs/tags/new-tag >output &&
+	test_grep "old tag" output &&
+	test_grep "to new" output
+'
+
 test_done

Range-diff against v2:
1:  00cd13fda7 ! 1:  a54c2d4d68 update-ref: add --rename option
    @@ Commit message
     
          $ git update-ref --rename <old-refname> <new-refname>
     
    -    It renames <old-refname> together with its reflog to <new-refname>
    -    (even when used on a local branch ref, the current value and the
    -    reflog of the ref are the only things that are renamed).  As the
    -    command is a low-level plumbing command, attempts to rename branches
    -    are not warned, but we document it to draw attention of unsuspecting
    -    users and protect them from burning themselves.
    +    It renames <old-refname> together with its reflog to <new-refname>;
    +    even when used on a local branch ref, the current value and the
    +    reflog of the ref are the only things that are renamed.  Document it
    +    and redirect casual users to "git branch -m" if that is what they
    +    wanted to do.
     
         Because the "--stdin" mode wants to operate on its refs in a
         reference transaction, and the API function refs_rename_ref() does
    @@ Documentation/git-update-ref.adoc: SYNOPSIS
      --------
      [synopsis]
      git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
    -+git update-ref [-m <reason>] [--no-deref] --rename <old-refname> <new-refname>
    ++git update-ref [-m <reason>] --rename <old-refname> <new-refname>
      git update-ref [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
      git update-ref [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
      
    @@ Documentation/git-update-ref.adoc: the result of following the symbolic pointers
      
     +With `--rename`, it renames <old-refname> together with its reflog to
     +<new-refname>.  The command fails if <old-refname> does not exist, or
    -+if <new-refname> already exists.  Because `git update-ref` does not
    -+update active worktree `HEAD` symbolic references or `.git/config`
    -+tracking settings when you rename a local branch in the `refs/heads/`
    -+hierarchy, think twice before using this command to rename a local
    -+branch (use `git branch -m` instead).
    ++if <new-refname> already exists.  The command does not update any
    ++symbolic references pointing to the renamed reference, and neither
    ++does it update `.git/config` tracking settings. It is thus not
    ++recommended to use it for renaming local branches. Use `git branch -m`
    ++instead.
     +
      With `--stdin`, update-ref reads instructions from standard input and
      performs all modifications together.  Specify commands of the form:
-- 
2.55.0-rc0-119-ga57a595f62

