Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2C161313
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460706; cv=none; b=a+5P5gRfRL2wyUD3IcM0CCBnrdKboxfO7Y7528kiyShlvsQgvaB603GAjfgviZtYxEBCX+JEmh89ei9ATLo+GHZTxloeQ0JAq6U0gbBJkDBXeXrrqlmkaGc27faAkDE7FuqES/0x9UYCUlbR4c04LpegQA4gNbg3N2jSx9JHKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460706; c=relaxed/simple;
	bh=0Ymsu9S+jr3QXkM8pgXBL6GoemalY0hXxXwaMB2zoeY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=APXF9pxdOTjlwUJS6bAdDmywPgirpCY7TmnsU6eactrLD82IHRv7I2Rsyqs8S67H0Cxv9u4RJ6txvkdPLFhK1ai1rvWa9IClFn9dSGp+uKCdLt8z6CFFBWgvXus26L8xiHn9cUx1MIxLAnovZr36uo0Dgm41a+yLG5MQKj1eFAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksRmvdAD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksRmvdAD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so8982173a12.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728460702; x=1729065502; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO37Y9LoIXSdDur2CCkpJyBDBA8Ol87MOgiLtCLaJcE=;
        b=ksRmvdADygcj97RrzsY441FZ7nXmLKSL6c4J4PXriCnfPtNC++AxN0oxthUi3LCHsX
         1HIT453DwrPktveDODGCXPZYgFxHd+uy/hR605F3gQs8lZDw8NSUHsK8cZnT4dF2Zaoj
         Je6gLjiVna/4EitGhkudM2lQXPY46o5RTRJQf5IKpDisJzObzaZaYspnEa3J8nfrXe7O
         OOxUvc9Oc1YI1JvtaM8w7ryo0TgGiEUzYsRAQog3FgfzfNrUbSiAA1Svj5VigpPGHVQX
         0kfGcY9GH+lQHlNSeZOjPgAvX2Lvq9u+LHaiMMLGxef45fQHZrlYJ/94DRYjBjchE52x
         JDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460702; x=1729065502;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lO37Y9LoIXSdDur2CCkpJyBDBA8Ol87MOgiLtCLaJcE=;
        b=UF49zFkTYnh0tcuqfO7ERzDmvrILgLIKee0Rucc+ziualm8+9QUTiyZvfhwd5IBxO3
         Xk8u3wO198f/T4yABD7+ySf8/FIBfac5xk3zCvwi32VZZaXAA1d0DIsPYOK5ZQsWfyLr
         KASH8uD6oZGQOkn2h0PtEZd76ksV0mxjlIRv6T1ZE3+5Hg2Nwwed8XRqrcLSpg34cG4D
         yWji0AHdYT1TP4Pf2knWE0n2Hh1tSjidyI7HrX8eUji3kv9whXcA3U3gTWbRjawVsQ36
         N5yakO0SPp3Ra7UsWBOf2R25/1xYdfbPDZz/slqdEvzNMmrJdueNJR9iDhEYvFRIU+w/
         gudA==
X-Gm-Message-State: AOJu0Ywbz45YtSCGVlywVA8dQM9eVstjHW9ElgZoyZ6LHFQnfC4p7XZT
	HIAD7fFDnjM1IjKEv5XuOqf+yVTO9r873tXq6so5f2WTIUJUhXNnwmrttg==
X-Google-Smtp-Source: AGHT+IGzpUzQ8Yw4VthLseGdyxV8vAAhCoUGRIPodbmIqKpAvBEfFyDL77p+76QOgr/hsSjG75zZqw==
X-Received: by 2002:a17:907:f1da:b0:a8a:822e:44c6 with SMTP id a640c23a62f3a-a998d117e20mr157672266b.4.1728460702196;
        Wed, 09 Oct 2024 00:58:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99414b675esm544723166b.10.2024.10.09.00.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:58:21 -0700 (PDT)
Message-Id: <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
References: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Oct 2024 07:58:17 +0000
Subject: [PATCH v3 0/3] rebase-merges: try and use branch names for labels
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Nicolas Guichard <nicolas@guichard.eu>

When interactively rebasing merge commits, the commit message is parsed to
extract a probably meaningful label name. For instance if the merge commit
is “Merge branch 'feature0'”, then the rebase script will have thes lines:

label feature0
merge -C $sha feature0 # “Merge branch 'feature0'


This heuristic fails in the case of octopus merges or when the merge commit
message is actually unrelated to the parent commits.

An example that combines both is:

*---.   967bfa4 (HEAD -> integration) Integration
|\ \ \
| | | * 2135be1 (feature2, feat2) Feature 2
| |_|/
|/| |
| | * c88b01a Feature 1
| |/
|/|
| * 75f3139 (feat0) Feature 0
|/
* `25c86d0` (main) Initial commit


which yields the labels Integration, Integration-2 and Integration-3.

Fix this by using a branch name for each merge commit's parent that is the
tip of at least one branch, and falling back to a label derived from the
merge commit message otherwise. In the example above, the labels become
feat0, Integration and feature2.

Changes since v1:

 * moved load_branch_decorations to re-use the decoration_loaded guard and
   avoid pointlessly appending "refs/heads/" to a static string_list, as
   pointed out by Junio C Hamano (thanks!)
 * fixed a leak in load_branch_decorations found by making the filter
   string_lists non-static

Changes since v2:

 * style changes (true/false -> 1/0 and // -> /* */)

Nicolas Guichard (3):
  load_branch_decorations: fix memory leak with non-static filters
  rebase-update-refs: extract load_branch_decorations
  rebase-merges: try and use branch names as labels

 log-tree.c                    | 26 +++++++++++++++++++++++++
 log-tree.h                    |  1 +
 sequencer.c                   | 36 +++++++++++++++++------------------
 t/t3404-rebase-interactive.sh |  4 ++--
 t/t3430-rebase-merges.sh      | 12 ++++++------
 5 files changed, 53 insertions(+), 26 deletions(-)


base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1784%2Fnicolas-guichard%2Fuse-branch-names-for-rebase-merges-labels-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1784/nicolas-guichard/use-branch-names-for-rebase-merges-labels-v3
Pull-Request: https://github.com/git/git/pull/1784

Range-diff vs v2:

 1:  6250a7f6d6c ! 1:  e030ddd91f3 load_branch_decorations: fix memory leak with non-static filters
     @@ log-tree.c: void load_ref_decorations(struct decoration_filter *filter, int flag
       				normalize_glob_ref(item, NULL, item->string);
       			}
      +
     -+			// normalize_glob_ref duplicates the strings
     -+			filter->exclude_ref_pattern->strdup_strings = true;
     -+			filter->include_ref_pattern->strdup_strings = true;
     -+			filter->exclude_ref_config_pattern->strdup_strings = true;
     ++			/* normalize_glob_ref duplicates the strings */
     ++			filter->exclude_ref_pattern->strdup_strings = 1;
     ++			filter->include_ref_pattern->strdup_strings = 1;
     ++			filter->exclude_ref_config_pattern->strdup_strings = 1;
       		}
       		decoration_loaded = 1;
       		decoration_flags = flags;
 2:  167418d10d1 ! 2:  1dad6096eb7 rebase-update-refs: extract load_branch_decorations
     @@ log-tree.c: void load_ref_decorations(struct decoration_filter *filter, int flag
      +		string_list_append(&decorate_refs_include, "refs/heads/");
      +		load_ref_decorations(&decoration_filter, 0);
      +
     -+		string_list_clear(&decorate_refs_exclude, false);
     -+		string_list_clear(&decorate_refs_exclude_config, false);
     -+		string_list_clear(&decorate_refs_include, false);
     ++		string_list_clear(&decorate_refs_exclude, 0);
     ++		string_list_clear(&decorate_refs_exclude_config, 0);
     ++		string_list_clear(&decorate_refs_include, 0);
      +	}
      +}
      +
 3:  dfa1f0a7648 = 3:  19d8253da07 rebase-merges: try and use branch names as labels

-- 
gitgitgadget
