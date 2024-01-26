Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE12261F
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302755; cv=none; b=Pa/SUmqmVToIHFBO7mNPbf40HKMRGEhSn6CUE9fmuWVuhrP+6t0p367uozMJiZgZiDu0z5XkzCyw2nStLWjDLCFtm7H9OXi/UFM67T3Vr7qixFS1JnEErzv0jFndUzNm5WVZ1xPOJ7Z96Y4dgFQM0vM7+mo+B+cFh7qhbyb0reM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302755; c=relaxed/simple;
	bh=voDxSRk81infamLHdLB+hF3DeWKyaPHO712CjYQPV0g=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U9/3JjkFzqusJ4aVeMjbLFjsIzVSB2g19Kl6UaDOTJW0nJzP8OxlAfpvI+5XKXkFrNEuW31YDtdreA6yPNH7HxPI6diPqnaps6G11NdxS1WCjx9hP7COrty9N+wePan7uD0wMF+A7iZLNEGUJjJvuM+LkzGBIVCqptfgJgeeihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvKVb/EW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvKVb/EW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso13466335e9.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706302751; x=1706907551; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96CtjE83fl2ddFk/gH8L9S09t+BP933PnC56OqYM98c=;
        b=HvKVb/EW5kOWtzUrCihie5cYiOlL+GxpKBZNlYs7pP1z6E63EZuiJ/TfMS5BM9u/JM
         USCXeYyrm8XWL2ltatSpGl7bPN4qkKIQdv/4T2OPiWNMkvi2qAQNJaYjdl1S3cZ6qWyE
         dp2JbdbU9SR7UpkpXvbPUkDKc3igGA14x3BioxNQWiMbZInJfoDwsOZgKfnmNkLOeRzW
         lv4bh7xLVZ3ms4eW+Rp726IzdUlMNn7kIJiDI1D0k8x3VkNc9CD3v3tJt8t5+qn6+2kx
         EIGSSHMDCX9N46lSbLod89ts2eLBPUZ2ZcOXUIUhHuZq/nUQzsRtseYNmnw7oPdbwxaK
         jsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706302751; x=1706907551;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96CtjE83fl2ddFk/gH8L9S09t+BP933PnC56OqYM98c=;
        b=X/BGIyZOPI2pmmdSb5yWQZ1GhElFnPJ5AE9dV71pog327FQXZZa7ToJOpF34hdM+OR
         NVG4Qwnf2QGHt+CQ3tehVvAdQYfFs55Hxzl9Aqmjm+iGX91G8Pk6T1zalSMjBxzNqa1t
         lomVJVy6fB2JNcTceHTVy1jio00fQK6U8d3J3+8aSkXae1KFxLFnO61YIQjJ8YMCpHnR
         V8u5OnmcAXUxPa7//IZR9MC87IeB1wzYza3ZJhZnb9Z2kXkNVpoe5rmQo3Oi2UXZ7hDc
         9uipZ4qffLbRaNujX8JOzf/GgEvvXfVcx8v6mzBvk/6abV3lHmsvkJdJyn+sMfUcBhCu
         mNww==
X-Gm-Message-State: AOJu0YyxpHmdW4ElXoPx6BzyIxSkqj4rA979js3JsY1Av2UONopuL9BH
	ulACysDZEHq69arFr8znnRu24iSrOvqd+LVgyFxCxbacqd1rq49vsQWUUA1o
X-Google-Smtp-Source: AGHT+IESgZ3SJVLqMr9Dx8OKMAWvra0lbrNdbfuSCtH6w8LD32te6y/iNtQCU74iHWx/GQNjqzaMSA==
X-Received: by 2002:a05:600c:444c:b0:40e:bece:9a2 with SMTP id v12-20020a05600c444c00b0040ebece09a2mr264541wmn.34.1706302750717;
        Fri, 26 Jan 2024 12:59:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe450000000b00337d603fd01sm1973624wrm.66.2024.01.26.12.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:59:10 -0800 (PST)
Message-ID: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
References: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 20:59:07 +0000
Subject: [PATCH v3 0/2] index-pack: fsck honor checks
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
Cc: John Cai <johncai86@gmail.com>

git-index-pack has a --strict mode that can take an optional argument to
provide a list of fsck issues to change their severity. --fsck-objects does
not have such a utility, which would be useful if one would like to be more
lenient or strict on data integrity in a repository.

Like --strict, Allow --fsck-objects to also take a list of fsck msgs to
change the severity.

Changes since V2:

 * fixed some typos in the documentation
 * added commit trailers

Change since V1:

 * edited commit messages
 * clarified formatting in documentation for --strict= and --fsck-objects=

John Cai (2):
  index-pack: test and document --strict=<msg-id>=<severity>...
  index-pack: --fsck-objects to take an optional argument for fsck msgs

 Documentation/git-index-pack.txt | 26 +++++++++++++-------
 builtin/index-pack.c             |  5 ++--
 t/t5300-pack-object.sh           | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 10 deletions(-)


base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1658%2Fjohn-cai%2Fjc%2Findex-pack-fsck-honor-checks-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1658/john-cai/jc/index-pack-fsck-honor-checks-v3
Pull-Request: https://github.com/git/git/pull/1658

Range-diff vs v2:

 1:  b3b3e8bd0bf ! 1:  cdf7fc7fe8a index-pack: test and document --strict=<msg>
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    index-pack: test and document --strict=<msg>
     +    index-pack: test and document --strict=<msg-id>=<severity>...
      
          5d477a334a (fsck (receive-pack): allow demoting errors to warnings,
          2015-06-22) allowed a list of fsck msg to downgrade to be passed to
     @@ Commit message
          directly, (nor use index-pack for that matter) it is still useful to
          document and test this feature.
      
     +    Reviewed-by: Christian Couder <christian.couder@gmail.com>
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## Documentation/git-index-pack.txt ##
     @@ Documentation/git-index-pack.txt: OPTIONS
      ---strict::
      -	Die, if the pack contains broken objects or links.
      +--strict[=<msg-id>=<severity>...]::
     -+	Die, if the pack contains broken objects or links. If `<msg-ids>` is passed,
     -+	it should be a comma-separated list of `<msg-id>=<severity>` elements where
     -+	`<msg-id>` and `<severity>` are used to change the severity of some possible
     -+	issues, e.g., `--strict="missingEmail=ignore,badTagName=error"`. See the entry
     -+	for the `fsck.<msg-id>` configuration options in `linkgit:git-fsck[1] for
     -+	more information on the possible values of `<msg-id>` and `<severity>`.
     ++	Die, if the pack contains broken objects or links. An optional
     ++	comma-separated list of `<msg-id>=<severity>` can be passed to change
     ++	the severity of some possible issues, e.g.,
     ++	 `--strict="missingEmail=ignore,badTagName=error"`. See the entry for the
     ++	`fsck.<msg-id>` configuration options in linkgit:git-fsck[1] for more
     ++	information on the possible values of `<msg-id>` and `<severity>`.
       
       --progress-title::
       	For internal use only.
     @@ builtin/index-pack.c
       
       static const char index_pack_usage[] =
      -"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
     -+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
     ++"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
       
       struct object_entry {
       	struct pack_idx_entry idx;
 2:  cce63c6465f ! 2:  a2b9adb93d8 index-pack: --fsck-objects to take an optional argument for fsck msgs
     @@ Commit message
          the option. This won't often be used by the normal end user, but it
          turns out it is useful for Git forges like GitLab.
      
     +    Reviewed-by: Christian Couder <christian.couder@gmail.com>
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## Documentation/git-index-pack.txt ##
     @@ Documentation/git-index-pack.txt: default and "Indexing objects" when `--stdin`
       
      ---fsck-objects::
      -	For internal use only.
     -+--fsck-objects[=<msg-ids>=<severity>...]::
     -+	Instructs index-pack to check for broken objects, but unlike `--strict`,
     -+	does not choke on broken links. If `<msg-ids>` is passed, it should be
     -+	a comma-separated list of `<msg-id>=<severity>` where `<msg-id>` and
     -+	`<severity>` are used to change the severity of `fsck` errors e.g.,
     -+	`--strict="missingEmail=ignore,badTagName=ignore"`. See the entry for
     -+	the `fsck.<msg-id>` configuration options in `linkgit:git-fsck[1] for
     -+	more information on the possible values of `<msg-id>` and `<severity>`.
     ++--fsck-objects[=<msg-id>=<severity>...]::
     ++	Die if the pack contains broken objects. If the pack contains a tree
     ++	pointing to a .gitmodules blob that does not exist, prints the hash of
     ++	that blob (for the caller to check) after the hash that goes into the
     ++	name of the pack/idx file (see "Notes").
       +
     - Die if the pack contains broken objects. If the pack contains a tree
     - pointing to a .gitmodules blob that does not exist, prints the hash of
     +-Die if the pack contains broken objects. If the pack contains a tree
     +-pointing to a .gitmodules blob that does not exist, prints the hash of
     +-that blob (for the caller to check) after the hash that goes into the
     +-name of the pack/idx file (see "Notes").
     ++Unlike `--strict` however, don't choke on broken links. An optional
     ++comma-separated list of `<msg-id>=<severity>` can be passed to change the
     ++severity of some possible issues, e.g.,
     ++`--fsck-objects="missingEmail=ignore,badTagName=ignore"`. See the entry for the
     ++`fsck.<msg-id>` configuration options in linkgit:git-fsck[1] for more
     ++information on the possible values of `<msg-id>` and `<severity>`.
     + 
     + --threads=<n>::
     + 	Specifies the number of threads to spawn when resolving
      
       ## builtin/index-pack.c ##
      @@
       #include "setup.h"
       
       static const char index_pack_usage[] =
     --"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
     -+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] [--fsck-objects[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
     +-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
     ++"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] [--fsck-objects[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
       
       struct object_entry {
       	struct pack_idx_entry idx;

-- 
gitgitgadget
