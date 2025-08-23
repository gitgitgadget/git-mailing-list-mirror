Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A92F85B
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909789; cv=none; b=KKUzABTZtED8XJx4zlEVwslKUIadknSaU15FfST97cPRjL3G/mNHUEVWuZp/AiCoH23dBtAh5Y49ijXE+bIUnA30bvUwxsXhbJGPML+FXpilNo3/dpXd6CZ2mmVX4g7Tm7Vlhu7LO4UwPb01xMC05fdQe2X5JpiUpTVtBsmcMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909789; c=relaxed/simple;
	bh=sTGy9HEUGbtpjL2Aat0Aq42bqd49b7VKhUDRGtXw9Co=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yl0jvO696mOp19voiJ02InPlEvHvlmVj+AoFARu4I9BeTA3HPPPbzsRUxSmS0NVEcDmyTNkxGyV1/2WSeWRklyDKoXSNjfNfnia/b5epptkDUTiIztssGeaREBSLZvJUI3HMJL8wiQYsvkcjtCSoxJSPpLUy5qAlgviSrCsD8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeyUBr0j; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeyUBr0j"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so14574195e9.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755909785; x=1756514585; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GCij8ZYwJ/DIJ0gBI6p+b940nB/c+ZxqKIRidIAO0E=;
        b=IeyUBr0j7VzZ/rrVlKGQP8zQc2/yw7JopeFg/6MsX6W3z2tteeOOBHU1MkqdHqMki2
         1DLsW6kptYiXOfZQosD5AEs1krVtSCfun15+IIl0mQx3OR8QLmFcI8Qf67haNAZrAjwg
         duRsPOkJW0bgHqAU8iKURyxqXqkLUdXAXOegCKeEAJjafMZ1jxVnpgAxwyp4gmEXD8CM
         5+gdoZ/EyCia/932PArPl6yTkHmdII4sQnD6ksfbWrlZDS1UNS9XRqXoJ6TKsUXPxGEc
         JBqxoWZG/6BEmAgX+Bpe/hiauiQ/vlr8vrEk9px40ATq4EUDjh+zJ6TUfOTOFocCdwh0
         JR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909785; x=1756514585;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GCij8ZYwJ/DIJ0gBI6p+b940nB/c+ZxqKIRidIAO0E=;
        b=wUvu4Wc06cHecD4k+Mki/JGuVPS3e2Gapd3oGWLmhvZnQvwlC1ELzbBiZeMfeITVQl
         NWezbQb6DoSRg3lbRd0yjZE9lmco1Br6akyr6FRgptW5AxOvl/Ij4Oj/hVped/RvWRv7
         yo/MIFxzm5vhbB9k2F4VnMehKv62Sy6P3enGL4TDBDrL1yg2+PVKLoPTcrw/T9hBmR7O
         W67fF8WQdexce3qyJ0HSxhy77k7vWhJq5Ee+kvE1jIK0xEYMjgIEPJWpYCDp85N7iqgt
         q8q/KD7Idxlt+EczKYyjN3GpRZEeda/Za7yLP0l2BMUh5waKJLDFwIgN/81flU/Rg3RS
         nSdQ==
X-Gm-Message-State: AOJu0Yzzf8d+pZhskMkqGXx9hV9ftbs5cuf/wkAsFcFpO0BmD8IQ5EvR
	KvzIAlU1xmUTJXv3Yu6owKTE1CYgJKvyoKRX9LkgYoKwQNaZRdFuZvCO/HLP5Q==
X-Gm-Gg: ASbGncuuMEvzJ5G3T4/taJ90Pfa0XCbJZ8BgPpE2J3sVuFuqM7Kvk0eW5ohqNFtS9l6
	/JPA0NT3ULHtuRp+7eu4AP5nyY6qag7nbtRmgmODw/a9eGBZLl5yLr1MAbIiI1PuWpjrV+YfZi6
	ei5SkGHP1xS/zD5+zKy6BFEMGNFxZoRzl/vAMVv7Maahgay6AmlUWjDohdowS3JEHQMyMY/7t4O
	esG6roCmTU2qCvMVBVxJun3yKYqrFwXdr7EQcil/x/fW39ScnjKmy7b4fiFQINMLHpaz3MUp4Ie
	N72AbpA5pAfmZMP/40FFqmGbXN/i9sqy+wggbkKkasHllsLJ3oq/yPtnmNeg47JVuZYcWDuzyKR
	T1b47AbtEyAmZmZ5HLd7/HrA9k5E=
X-Google-Smtp-Source: AGHT+IFmXW3vV6z+PNGwJzXOsBCMXaGc2DTBqIJID4sEI+cRtcihLCBz/BsZ5jR9LYIhcBsbtXIP0A==
X-Received: by 2002:a05:600c:350c:b0:45b:47e1:f5fc with SMTP id 5b1f17b1804b1-45b517d91bcmr36848315e9.37.1755909784585;
        Fri, 22 Aug 2025 17:43:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57589e49sm14903885e9.18.2025.08.22.17.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 17:43:03 -0700 (PDT)
Message-Id: <pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
References: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 00:42:57 +0000
Subject: [PATCH v9 0/5] doc: git-rebase: clarify DESCRIPTION section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>

Move the "TRANSPLANTING A TOPIC BRANCH WITH --ONTO" back up: now it's in the
exact same place it was before, just now with a section heading.

Julia Evans (5):
  doc: git-rebase: start with an example
  doc: git rebase: dedup merge conflict discussion
  doc: git rebase: clarify arguments syntax
  doc: git-rebase: move --onto explanation down
  doc: git-rebase: update discussion of internals

 Documentation/git-rebase.adoc | 149 +++++++++++++---------------------
 1 file changed, 58 insertions(+), 91 deletions(-)


base-commit: 64cbe5e2e8a7b0f92c780b210e602496bd5cad0f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/1949

Range-diff vs v8:

 1:  e7a8fbbe53c = 1:  ea1438e094e doc: git-rebase: start with an example
 2:  ad63f69918d = 2:  339b7a1bc5b doc: git rebase: dedup merge conflict discussion
 3:  7ee6b0afe88 = 3:  f42c2c794a9 doc: git rebase: clarify arguments syntax
 4:  4686417b28e ! 4:  9c2a54ab9fa doc: git-rebase: move --onto explanation down
     @@ Documentation/git-rebase.adoc: will result in:
           D---E---A'---F master
       ------------
       
     --Here is how you would transplant a topic branch based on one
     --branch to another, to pretend that you forked the topic branch
     --from the latter branch, using `rebase --onto`.
     --
     --First let's assume your 'topic' is based on branch 'next'.
     --For example, a feature developed in 'topic' depends on some
     --functionality which is found in 'next'.
     --
     --------------
     --    o---o---o---o---o  master
     --         \
     --          o---o---o---o---o  next
     --                           \
     --                            o---o---o  topic
     --------------
     --
     --We want to make 'topic' forked from branch 'master'; for example,
     --because the functionality on which 'topic' depends was merged into the
     --more stable 'master' branch. We want our tree to look like this:
     --
     --------------
     --    o---o---o---o---o  master
     --        |            \
     --        |             o'--o'--o'  topic
     --         \
     --          o---o---o---o---o  next
     --------------
     --
     --We can get this using the following command:
     --
     --    git rebase --onto master next topic
     --
     --
     --Another example of --onto option is to rebase part of a
     --branch.  If we have the following situation:
     --
     --------------
     --                            H---I---J topicB
     --                           /
     --                  E---F---G  topicA
     --                 /
     --    A---B---C---D  master
     --------------
     --
     --then the command
     --
     --    git rebase --onto master topicA topicB
     --
     --would result in:
     --
     --------------
     --                 H'--I'--J'  topicB
     --                /
     --                | E---F---G  topicA
     --                |/
     --    A---B---C---D  master
     --------------
     --
     --This is useful when topicB does not depend on topicA.
     --
     --A range of commits could also be removed with rebase.  If we have
     --the following situation:
     --
     --------------
     --    E---F---G---H---I---J  topicA
     --------------
     --
     --then the command
     --
     --    git rebase --onto topicA~5 topicA~3 topicA
     --
     --would result in the removal of commits F and G:
     --
     --------------
     --    E---H'---I'---J'  topicA
     --------------
     --
     --This is useful if F and G were flawed in some way, or should not be
     --part of topicA.  Note that the argument to `--onto` and the `<upstream>`
     --parameter can be any valid commit-ish.
     --
     - MODE OPTIONS
     - ------------
     - 
     ++TRANSPLANTING A TOPIC BRANCH WITH --ONTO
     ++----------------------------------------
     ++
     + Here is how you would transplant a topic branch based on one
     + branch to another, to pretend that you forked the topic branch
     + from the latter branch, using `rebase --onto`.
      @@ Documentation/git-rebase.adoc: As a special case, you may use "A\...B" as a shortcut for the
       merge base of A and B if there is exactly one merge base. You can
       leave out at most one of A and B, in which case it defaults to HEAD.
       
     -+See TRANSPLANTING A TOPIC BRANCH WITH --ONTO below for examples.
     ++See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
      +
       --keep-base::
       	Set the starting point at which to create the new commits to the
       	merge base of `<upstream>` and `<branch>`. Running
     -@@ Documentation/git-rebase.adoc: consistent (they compile, pass the testsuite, etc.) you should use
     - after each commit, test, and amend the commit if fixes are necessary.
     - 
     - 
     -+TRANSPLANTING A TOPIC BRANCH WITH --ONTO
     -+----------------------------------------
     -+
     -+Here is how you would transplant a topic branch based on one
     -+branch to another, to pretend that you forked the topic branch
     -+from the latter branch, using `rebase --onto`.
     -+
     -+First let's assume your 'topic' is based on branch 'next'.
     -+For example, a feature developed in 'topic' depends on some
     -+functionality which is found in 'next'.
     -+
     -+------------
     -+    o---o---o---o---o  master
     -+         \
     -+          o---o---o---o---o  next
     -+                           \
     -+                            o---o---o  topic
     -+------------
     -+
     -+We want to make 'topic' forked from branch 'master'; for example,
     -+because the functionality on which 'topic' depends was merged into the
     -+more stable 'master' branch. We want our tree to look like this:
     -+
     -+------------
     -+    o---o---o---o---o  master
     -+        |            \
     -+        |             o'--o'--o'  topic
     -+         \
     -+          o---o---o---o---o  next
     -+------------
     -+
     -+We can get this using the following command:
     -+
     -+    git rebase --onto master next topic
     -+
     -+
     -+Another example of --onto option is to rebase part of a
     -+branch.  If we have the following situation:
     -+
     -+------------
     -+                            H---I---J topicB
     -+                           /
     -+                  E---F---G  topicA
     -+                 /
     -+    A---B---C---D  master
     -+------------
     -+
     -+then the command
     -+
     -+    git rebase --onto master topicA topicB
     -+
     -+would result in:
     -+
     -+------------
     -+                 H'--I'--J'  topicB
     -+                /
     -+                | E---F---G  topicA
     -+                |/
     -+    A---B---C---D  master
     -+------------
     -+
     -+This is useful when topicB does not depend on topicA.
     -+
     -+A range of commits could also be removed with rebase.  If we have
     -+the following situation:
     -+
     -+------------
     -+    E---F---G---H---I---J  topicA
     -+------------
     -+
     -+then the command
     -+
     -+    git rebase --onto topicA~5 topicA~3 topicA
     -+
     -+would result in the removal of commits F and G:
     -+
     -+------------
     -+    E---H'---I'---J'  topicA
     -+------------
     -+
     -+This is useful if F and G were flawed in some way, or should not be
     -+part of topicA.  Note that the argument to `--onto` and the `<upstream>`
     -+parameter can be any valid commit-ish.
     -+
     -+
     - RECOVERING FROM UPSTREAM REBASE
     - -------------------------------
     - 
 5:  cb85642bb9d ! 5:  5a1dd8df29b doc: git-rebase: update discussion of internals
     @@ Documentation/git-rebase.adoc: linkgit:git-config[1] for details) and the `--for
      +tip, however, is accessible using the reflog of the current branch (i.e. `@{1}`,
      +see linkgit:gitrevisions[7].
       
     - MODE OPTIONS
     - ------------
     + TRANSPLANTING A TOPIC BRANCH WITH --ONTO
     + ----------------------------------------

-- 
gitgitgadget
