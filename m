Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310C16C687
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748630; cv=none; b=LVVz4ePqeO4nPcUFW8vTAfuStiR7WuivbQDqpn6+JQJkHVNhizMRavln7MsV8aaKvSNUMsvlt4kOLHFV8H6pQLI8z6AciLJZpCnmG1cjv8hzh2mShHzkZIiQ71EDtffuYdjTdtmfAPVzylREzV5GnF4pExZtqUGjvrHRxzS0vg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748630; c=relaxed/simple;
	bh=CtfV6Xclv5+5zHmStoG16z8WCQbm879YW+H2GsW4HTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h08Q6C9yz0uWhfrflqd2lgpXAAzQXOxIZ7vrO57lNbkFfHMjvqbLeflnulyPtYdfE/VjGqQOhQDpXVXt5xSlAz5zHqlFRYAFiFXW40NrND991Iv3ZF2qkuDNy2RBP/pJJLRNNYlORuk6E9olWkPpZ+pIS6PJ1iBUkmg48FoESyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=my4dXyMS; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my4dXyMS"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e619057165so2232678b6e.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730748628; x=1731353428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESlYcF/PMrGPYFsBBlqhDciEpd7YCNQMwcdB+3WulnA=;
        b=my4dXyMSJ+y6Am2FVv/rTizKd1XO/WT/Un4It6Q8VIlLmHYInUPmd4ccQR+gGgYAn6
         otw3+Qo39t6wnRU/yoOzGWXSSA68ImuqgrP2QKBmqFmTcuiWGgOKrXBYqtuUSl1KTRoJ
         qVitKzHuoNxgWbA2+LInYLOHMVoRq4hUOEdSAvtm8vnosUKXvsaUBVXN3YR1Zxb072NF
         hZOotzbhl7ef0aBV7miuNNOSAH4e1dcBkVnOjTTAy758JXZF/q117kgjyaSEiUx/powF
         +aK24yDvd6sh7VEXCSH/riaRnhvulDDohSaifxAlsYcu/v2mCYiLTz3Dl8vL3ootkjik
         AM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730748628; x=1731353428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESlYcF/PMrGPYFsBBlqhDciEpd7YCNQMwcdB+3WulnA=;
        b=wTS+n3ycooqAmxIvvHVXfTF91UG8a7ZEAuQLrD/u7AkmAO4sn/4xFFbd2rQhItW7Vs
         6Ggrt5rolLdkkQ6GjDfeNOKVGQtWgUmrOOSXL7jwnO5nnOCRXA1/YMqcWbt1ASlVOQnz
         j0FbqVqe5JByju5Tdw1/JnPjz07E0+iQ3w7aGVAp6Zz2dTmxbTm67AKZ66AiC8VvDscN
         K8+pqRP3a/HMjYelp8z4kygplSOAhCHyshAveqPyN63a6BceGH4i56QLsUsmMy4XUsmf
         com68jfBNX/wH2zM5wegsi0AFR8lMBeOpoxegPwQHxDEsZthfFyTPSxXZPaXzMSwWvDu
         5FEg==
X-Forwarded-Encrypted: i=1; AJvYcCVIFjxGK1Cu46YR9yGMCNqGDK9VWtwXeyPsv9UU+2Wb5BzeFUtq2H/vGZg/MKbpn7rEN5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKax872XXV050gw4piEmiC8mJZ1QZylHoKWh1ccdTEiq2ymXAi
	6S5Jr1P2LW5DyGstHrOgOVqol3D09vdXGI54EnNd2xFE7GV8dBLw
X-Google-Smtp-Source: AGHT+IHuX+uvw1nqlxCUfjbejx+unbhpNWRjpgYKcS9rvjO01s7Yikf/SO5UYE4RVLiFl75vjA7XRQ==
X-Received: by 2002:a05:6808:14d6:b0:3e5:c7dc:ac60 with SMTP id 5614622812f47-3e6384a1b2dmr29209822b6e.43.1730748628148;
        Mon, 04 Nov 2024 11:30:28 -0800 (PST)
Received: from localhost.localdomain ([2409:40c2:8017:2f6f:26a1:2e1:5d4c:875])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a8b3fsm7570018a12.28.2024.11.04.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:30:27 -0800 (PST)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: gitster@pobox.com
Cc: abhijeet.nkt@gmail.com,
	git@vger.kernel.org,
	me@ttaylorr.com,
	ps@pks.im,
	sandals@crustytoothpaste.net
Subject: [PATCH v5 0/2] show-index: fix uninitialized hash function
Date: Tue,  5 Nov 2024 00:59:56 +0530
Message-ID: <20241104192958.64310-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.47.0.107.g34b6ce9b30
In-Reply-To: <xmqq1pzuylm6.fsf@gitster.g>
References: <xmqq1pzuylm6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this iteration, I have fixed some typos along with a stylistisc issue
that were noted in v4.

I have also added an additional patch that adds a test for --object-format
option in show-index as it was noted we don't already have any.

Abhijeet Sonar (2):
  show-index: fix uninitialized hash function
  t5300: add test for 'show-index --object-format'

 builtin/show-index.c   |  9 +++++++++
 t/t5300-pack-object.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

Range-diff against v4:
1:  c75175ad9b ! 1:  05ee1e2ea5 show-index: fix uninitialized hash function
    @@ Commit message
         In c8aed5e8da (repository: stop setting SHA1 as the default object
         hash), we got rid of the default hash algorithm for the_repository.
         Due to this change, it is now the responsibility of the callers to set
    -    thier own default when this is not present.
    +    their own default when this is not present.
     
         As stated in the docs, show-index should use SHA1 as the default hash
    -    algorithm when ran outsize of a repository. Make sure this promise is
    +    algorithm when run outside a repository. Make sure this promise is
         met by falling back to SHA1 when the_hash_algo is not present (i.e.
    -    when the command is ran outside of a repository). Also add a test that
    -    verifies this behaviour.
    +    when the command is run outside a repository). Also add a test that
    +    verifies this behavior.
     
         Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
     
    @@ builtin/show-index.c: int cmd_show_index(int argc,
      		repo_set_hash_algo(the_repository, hash_algo);
      	}
      
    -+	// Fallback to SHA1 if we are running outside of a repository.
    -+	// TODO: Figure out and implement a way to detect the hash algorithm in use by the
    -+	//       the index file passed in and use that instead.
    ++	/*
    ++	 * Fallback to SHA1 if we are running outside of a repository.
    ++	 *
    ++	 * TODO: Figure out and implement a way to detect the hash algorithm in use by the
    ++	 *       the index file passed in and use that instead.
    ++	 */
     +	if (!the_hash_algo)
     +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
     +
    @@ builtin/show-index.c: int cmd_show_index(int argc,
      
      	if (fread(top_index, 2 * 4, 1, stdin) != 1)
     
    - ## rm (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+echo rm $@
    -
      ## t/t5300-pack-object.sh ##
     @@ t/t5300-pack-object.sh: test_expect_success 'index-pack --strict <pack> works in non-repo' '
      	test_path_is_file foo.idx
-:  ---------- > 2:  c8a28aae55 t5300: add test for 'show-index --object-format'
-- 
2.47.0.107.g34b6ce9b30

