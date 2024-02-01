Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719F4403
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751488; cv=none; b=PG36NyI8wniH16cYpWuT8tDpQs96ko3QlMfDGdiIMvhu5rmR95gF8v38/Bq1v56+/xzzQZtLCGleTXvjkAftxYpfdf5MN7AVI6Rxhcb1DVt//0oEYKwUyvyHIBfWyAV2d8P0zzGmmH8LWHcAFXfceD0LcAasX5ROT5oAGweWZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751488; c=relaxed/simple;
	bh=JqPj9ctKuZlAbKvM+/Xo76fC8HjQwJoT8GhmSOHOHsQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mFXPeQ8oZq0VcNT4/1YTYjKaWm0tMGjAX4gWRGWFpqKQ037R1VfwDVX+cZb8Uh3JKFJgROPoRRGKlyZAuWSKBUS0N53vxBdEjkeqR5BdugHGZADz20xIi/XDb6vX4Q/YVqQlEsZ478kTqtuI70xd6CFsMxI4YysiHFd8Gw15p9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmYojSvv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmYojSvv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb804e330so3728005e9.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751484; x=1707356284; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSlvFLYe2ZdobF5IVqqCPP81Aw4/gSrlCNjyjUz8FB4=;
        b=QmYojSvvCUpPqzp9e0RY+hP3yzYYcAoMyew2M2M4hE4eFWXs2F4N6iaLqJVqGEAqU1
         4aEMYAzYydC2syUxVssUYqURjwp7iFipzbubJgs9RxexnAo7PVUAOviPCuer3URqfoho
         /4QnQmuEQQyV4KyAFKetTK+N8BQnTz/EY0n6JN3ExYnopHTGfH1hM3JXXE4uNdB258x3
         Da1+3FNk1nq2ocrWrkN0w7XAepraxMCrTWZkObS4MESaTBcx8mE4gjZmgWxuXy4NqWt6
         H/wQHbPH439/cJW5g6hXRWIR+BV/UK4mx4Cnv4Gy/KS+fh+ulkAPfTyozUdf6I1f2UQ3
         rjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751484; x=1707356284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSlvFLYe2ZdobF5IVqqCPP81Aw4/gSrlCNjyjUz8FB4=;
        b=NH5JhaFXau8iwQfLeMWDktq93/Qc+79BXR/Nz46NpVq4TXy6QES/rwVy3fTChg8mwf
         wGJ5IFjqI4C8oMQOI7UcgTZfVYzgrtquVkT3Al/vvXVLGB2Pw14SbUgyZyVQ07kcaOEb
         DuLutW+s0AboYudHuaPaWZ4h7ujbsD3QHzP0/wWuZt+ksqfHWSpy2w8z2hQ3kUExZUWK
         VezX7N6YGKokGgnoksGCk0I7rMka6FHoeiJqaJ5sI4v6jdAi1WQ60Y3CQKJ4d1JytcXM
         PpFA8tNNsYKp3zCL+dtERjvKfcVLGxHuxwMqBBuBbVt2sIHPKDkl4OaoDXir3hxzzuay
         wZOQ==
X-Gm-Message-State: AOJu0YzrMDIGAWDM4V+Ltl26KUV8sLfCHZeNx1nDEdwxghcsXdtGPR7U
	nZ71uubBuVmX/IHXXQUmOk2uywJ2aCzUN63RwzAP0z/qtbDWEctzfnskFKzg
X-Google-Smtp-Source: AGHT+IHSQsQPLcetQuMYAhvJM0DgZg0ZKLKPeYBPOj3Kb/ydz01topDrB//fhd3rBJgH3Qc1oXXAJw==
X-Received: by 2002:a05:600c:41d2:b0:40f:afdc:7477 with SMTP id t18-20020a05600c41d200b0040fafdc7477mr3095910wmh.20.1706751484280;
        Wed, 31 Jan 2024 17:38:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWfZJoplV4nO9zBHCROom/iuwdgIIVUQdAokYtzM4W7yQaketnsRA5woVd/i9QHYDhXQd0Gl3MGQV1HD32SKeW7bDcog4E7TrNRrT1YAs8=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ci7-20020a5d5d87000000b0033b07f428b6sm2093919wrb.0.2024.01.31.17.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:38:04 -0800 (PST)
Message-ID: <pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
References: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Feb 2024 01:38:00 +0000
Subject: [PATCH v4 0/2] index-pack: fsck honor checks
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
Cc: Jonathan Tan <jonathantanmy@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>

git-index-pack has a --strict mode that can take an optional argument to
provide a list of fsck issues to change their severity. --fsck-objects does
not have such a utility, which would be useful if one would like to be more
lenient or strict on data integrity in a repository.

Like --strict, Allow --fsck-objects to also take a list of fsck msgs to
change the severity.

Changes since V3:

 * clarification of --fsck-objects documentation wording

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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1658%2Fjohn-cai%2Fjc%2Findex-pack-fsck-honor-checks-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1658/john-cai/jc/index-pack-fsck-honor-checks-v4
Pull-Request: https://github.com/git/git/pull/1658

Range-diff vs v3:

 1:  cdf7fc7fe8a = 1:  cdf7fc7fe8a index-pack: test and document --strict=<msg-id>=<severity>...
 2:  a2b9adb93d8 ! 2:  f29ab9136fb index-pack: --fsck-objects to take an optional argument for fsck msgs
     @@ Documentation/git-index-pack.txt: default and "Indexing objects" when `--stdin`
      ---fsck-objects::
      -	For internal use only.
      +--fsck-objects[=<msg-id>=<severity>...]::
     -+	Die if the pack contains broken objects. If the pack contains a tree
     -+	pointing to a .gitmodules blob that does not exist, prints the hash of
     -+	that blob (for the caller to check) after the hash that goes into the
     -+	name of the pack/idx file (see "Notes").
     ++	Die if the pack contains broken objects, but unlike `--strict`, don't
     ++	choke on broken links. If the pack contains a tree pointing to a
     ++	.gitmodules blob that does not exist, prints the hash of that blob
     ++	(for the caller to check) after the hash that goes into the name of the
     ++	pack/idx file (see "Notes").
       +
      -Die if the pack contains broken objects. If the pack contains a tree
      -pointing to a .gitmodules blob that does not exist, prints the hash of
      -that blob (for the caller to check) after the hash that goes into the
      -name of the pack/idx file (see "Notes").
     -+Unlike `--strict` however, don't choke on broken links. An optional
     -+comma-separated list of `<msg-id>=<severity>` can be passed to change the
     -+severity of some possible issues, e.g.,
     ++An optional comma-separated list of `<msg-id>=<severity>` can be passed to
     ++change the severity of some possible issues, e.g.,
      +`--fsck-objects="missingEmail=ignore,badTagName=ignore"`. See the entry for the
      +`fsck.<msg-id>` configuration options in linkgit:git-fsck[1] for more
      +information on the possible values of `<msg-id>` and `<severity>`.

-- 
gitgitgadget
