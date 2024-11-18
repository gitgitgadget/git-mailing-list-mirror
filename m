Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4661C1F14
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968394; cv=none; b=s07BrzzCFd+9qJUiqgAtjIjUgINapRf/aj8JEIgRybwptuuvfgbzwzsQ8N8g8/1zztf2KqAMM7rNVfvUQFRxxBqtfhjQbuNzPJvureOvZBR17Wljb1fT+aNX0vQbwR4vw3XEtrNXauuHG5qUFOq97BUWPDzsRwTDVEkj1Du05i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968394; c=relaxed/simple;
	bh=eku+acEhoB2wPUJ2okA+/CQva6bFexoSyIgVSOJnE8k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j3nmcvgIRdGlvRRUOQrAH5z98sG4JFOSGeF5OVXIhnNLYNLGJjHCUjpHdlE42MdIoecsDiTH1MYktiJMGICqSHh1Ss7cPDyBoL+GTXVU8bdFFM0WjBPpPqw+PoQXjSD7jYaq4kPoeKMrw3AqKx7jwF0vHD9vU1ZVY6uhbOLe4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPeCKMns; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPeCKMns"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3823eb7ba72so215156f8f.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731968391; x=1732573191; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNxKWetihkmKHvJzOtfWN62NGzcIGzzDh0gs3MdHb9M=;
        b=HPeCKMns+SzKbzX6J6O4amG6YwcrKOnQDv56jF5evJarERllWYb9hYZu62zK/HeyhX
         skW/Yuy4eZikLTClI9eZ2cu4VJryRoltuWHpxHuxwE/vpqYfzmhXfE1cwLbR0VsSdIhO
         7GeVrhsMLrv5IPR5j/G2WRM54ZcEY9wBVt3ohMoivjtxSfgnSy4VxlvsoQ1GFmM5dYbN
         XSdjZwh5Nhg5gRF/yETHZfS7YzzgzP+7zsHrXn3VUh9PW+MxAORVRUc2r0eZGvUksXzO
         HFrGw0sKH/+E5AKPFxgbOmjTydfoPFIRMixMAZhFoikMx/fiHWsSX++T19XUOwz8dmbr
         KbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731968391; x=1732573191;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNxKWetihkmKHvJzOtfWN62NGzcIGzzDh0gs3MdHb9M=;
        b=SkyRlFh/WTO+kZ1yjG0wMrUzxcXr6SJ16FkMpTPjrQOt4iOCPNYCDYVHIOsf9OHQ/L
         8pExD8fXLteC73eqxfQSBW7ZPyVT60heH6ToPcy6kd64ze1DlNZr5pwyuU7tJbzKrM4p
         C5ja3zGwgiWuElRe1Q9EFpKZMYh+ig0whOBfZXGztHvSzmPD9qDqRZoP0aUBNW8VSvF3
         XGwyOBu28fy2dp72a5LfoOZKEkU8n1sfWw4Xq3Yd+yxXs+KousRgpOlrExUgLYPwu0Qw
         yLmIA/fJoKIQa92cyRh0x/PfFYjxyJqc0fVDqW6Fr2alIIm7CD8no94nwzyak8D2UOcV
         IgLg==
X-Gm-Message-State: AOJu0YyUDEXbRKFJBMxA6s+9XzfIgZMwT0i5HCsOPvwtSWA2ldQt7oQT
	l2lpgoGO+Nzya50n9JrAcJJgZBEI6wGRms1x26W70aSMhNIupE7wwh6/DQ==
X-Google-Smtp-Source: AGHT+IGAglDnqOwn/r0wh0jJvM0GARIbNZapoXmDgO1ju9xPv+hajEWr2qRx8ebDUNJ2bS1kezndaQ==
X-Received: by 2002:a05:6000:1549:b0:37d:53dd:4dec with SMTP id ffacd0b85a97d-38225a07c2fmr11600962f8f.15.1731968390864;
        Mon, 18 Nov 2024 14:19:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38240fbfd63sm6205664f8f.63.2024.11.18.14.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 14:19:50 -0800 (PST)
Message-Id: <pull.1824.v2.git.1731968389590.gitgitgadget@gmail.com>
In-Reply-To: <pull.1824.git.1731610074707.gitgitgadget@gmail.com>
References: <pull.1824.git.1731610074707.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Nov 2024 22:19:49 +0000
Subject: [PATCH v2] fast-import: avoid making replace refs point to themselves
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

If someone replaces a commit with a modified version, then builds on
that commit, and then later decides to rewrite history in a format like

    git fast-export --all | CMD_TO_TWEAK_THE_STREAM | git fast-import

and CMD_TO_TWEAK_THE_STREAM undoes the modifications that the
replacement did, then at the end you'd get a replace ref that points to
itself.  For example:

    $ git show-ref | grep replace
    fb92ebc654641b310e7d0360d0a5a49316fd7264 refs/replace/fb92ebc654641b310e7d0360d0a5a49316fd7264

Git commands which pay attention to replace refs will die with an error
when a self-referencing replace ref is present:

    $ git log
    fatal: replace depth too high for object fb92ebc654641b310e7d0360d0a5a49316fd7264

Avoid such problems by deleting replace refs that will simply end up
pointing to themselves at the end of our writing.  Unless users specify
--quiet, warn them when we delete such a replace ref.

Two notes about this patch:
  * We are not ignoring the problematic update of the replace ref
    (turning it into a no-op), we are replacing the update with a delete.
    The logic here is that if the repository had a value for the replace
    ref before fast-import was run, and the replace ref was explicitly
    named in the fast-import stream, we don't want the replace ref to be
    left with a pre-fast-import value.
  * While loops with more than one element (e.g. refs/replace/A points
    to B, and refs/replace/B points to A) are possible, they seem much
    less plausible.  It is pretty easy to create a sequence of
    git-filter-repo commands that will trigger a self-referencing replace
    ref, but I do not know how to trigger a scenario with a cycle length
    greater than 1.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fast-import: avoid making replace refs point to themselves
    
    Changes since v1: Clarified wording in the commit message, and added a
    little more text at the end of the commit message to address questions
    that came up in review.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1824%2Fnewren%2Ffast-import-self-pointing-replace-ref-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1824/newren/fast-import-self-pointing-replace-ref-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1824

Range-diff vs v1:

 1:  7402518e806 ! 1:  cc77a004cea fast-import: avoid making replace refs point to themselves
     @@ Commit message
              $ git show-ref | grep replace
              fb92ebc654641b310e7d0360d0a5a49316fd7264 refs/replace/fb92ebc654641b310e7d0360d0a5a49316fd7264
      
     -    Most git commands that you try to run in such a repository with a
     -    self-pointing replace object will result in an error:
     +    Git commands which pay attention to replace refs will die with an error
     +    when a self-referencing replace ref is present:
      
              $ git log
              fatal: replace depth too high for object fb92ebc654641b310e7d0360d0a5a49316fd7264
      
          Avoid such problems by deleting replace refs that will simply end up
     -    pointing to themselves at the end of our writing.  Warn the users when
     -    we do so, unless they specify --quiet.
     +    pointing to themselves at the end of our writing.  Unless users specify
     +    --quiet, warn them when we delete such a replace ref.
     +
     +    Two notes about this patch:
     +      * We are not ignoring the problematic update of the replace ref
     +        (turning it into a no-op), we are replacing the update with a delete.
     +        The logic here is that if the repository had a value for the replace
     +        ref before fast-import was run, and the replace ref was explicitly
     +        named in the fast-import stream, we don't want the replace ref to be
     +        left with a pre-fast-import value.
     +      * While loops with more than one element (e.g. refs/replace/A points
     +        to B, and refs/replace/B points to A) are possible, they seem much
     +        less plausible.  It is pretty easy to create a sequence of
     +        git-filter-repo commands that will trigger a self-referencing replace
     +        ref, but I do not know how to trigger a scenario with a cycle length
     +        greater than 1.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      


 builtin/fast-import.c  | 16 +++++++++++++++-
 t/t9300-fast-import.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 76d5c20f141..51c8228cb7b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -179,6 +179,7 @@ static unsigned long branch_load_count;
 static int failure;
 static FILE *pack_edges;
 static unsigned int show_stats = 1;
+static unsigned int quiet;
 static int global_argc;
 static const char **global_argv;
 static const char *global_prefix;
@@ -1602,7 +1603,19 @@ static int update_branch(struct branch *b)
 	struct ref_transaction *transaction;
 	struct object_id old_oid;
 	struct strbuf err = STRBUF_INIT;
-
+	static const char *replace_prefix = "refs/replace/";
+
+	if (starts_with(b->name, replace_prefix) &&
+	    !strcmp(b->name + strlen(replace_prefix),
+		    oid_to_hex(&b->oid))) {
+		if (!quiet)
+			warning("Dropping %s since it would point to "
+				"itself (i.e. to %s)",
+				b->name, oid_to_hex(&b->oid));
+		refs_delete_ref(get_main_ref_store(the_repository),
+				NULL, b->name, NULL, 0);
+		return 0;
+	}
 	if (is_null_oid(&b->oid)) {
 		if (b->delete)
 			refs_delete_ref(get_main_ref_store(the_repository),
@@ -3388,6 +3401,7 @@ static int parse_one_option(const char *option)
 		option_export_pack_edges(option);
 	} else if (!strcmp(option, "quiet")) {
 		show_stats = 0;
+		quiet = 1;
 	} else if (!strcmp(option, "stats")) {
 		show_stats = 1;
 	} else if (!strcmp(option, "allow-unsafe-features")) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6224f54d4d2..425a261c161 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3692,6 +3692,34 @@ test_expect_success ICONV 'X: handling encoding' '
 	git log -1 --format=%B encoding | grep $(printf "\317\200")
 '
 
+test_expect_success 'X: replace ref that becomes useless is removed' '
+	git init -qb main testrepo &&
+	cd testrepo &&
+	(
+		test_commit test &&
+
+		test_commit msg somename content &&
+
+		git mv somename othername &&
+		NEW_TREE=$(git write-tree) &&
+		MSG="$(git log -1 --format=%B HEAD)" &&
+		NEW_COMMIT=$(git commit-tree -p HEAD^1 -m "$MSG" $NEW_TREE) &&
+		git replace main $NEW_COMMIT &&
+
+		echo more >>othername &&
+		git add othername &&
+		git commit -qm more &&
+
+		git fast-export --all >tmp &&
+		sed -e s/othername/somename/ tmp >tmp2 &&
+		git fast-import --force <tmp2 2>msgs &&
+
+		grep "Dropping.*since it would point to itself" msgs &&
+		git show-ref >refs &&
+		! grep refs/replace refs
+	)
+'
+
 ###
 ### series Y (submodules and hash algorithms)
 ###

base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
-- 
gitgitgadget
