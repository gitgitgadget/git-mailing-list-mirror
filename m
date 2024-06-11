Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1931E86F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109949; cv=none; b=LxCcP6zVQl1GMIaHc92en534ge+VCKD71QOZyunTYg661DvKx7Racm147UKt8iAgQyzxIo6Py06PLF4hitcAIElm9zFcJiYK5eCnbIQa6iw6I+1BnDZzyHxvpIOi7Ne7hl5P+v1Q+79JuEe/JFerV8rTH9wrYOsjmeWYAkDerwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109949; c=relaxed/simple;
	bh=7rl4HJmuLp1Vju1AlAzMOI5CPVl8/Z78Kxy7T1yRxoc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YTeF+IkMIyMsQZsMhRJjj6TBaO15vatIG9i6G2eN0biIKsDqYC+OzwnxaPoYnNT4t/HiFh4Qiy62uRWzeGH3Ha7rkfA1eF63ofqDcew2lsHlR+5QYBoXuKQI5F0olxDAvoqG7RfA3bd+ApG/Q7cY11v7bL2/E395E/sQtZeTc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSOdBpy5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSOdBpy5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421eab59723so15834635e9.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718109945; x=1718714745; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Sr3ezYoBYCWbRfF/IkcBntOoRAvScDiD9buPXYSl9U=;
        b=VSOdBpy5Zg57oylwpMpg0CtQsYl3/TBk5Viu2gIf0r94Dx6J3Q5CbyIKILZ1Ev5uos
         x17PW5f/cS26x4NBC1zkcujK/F+njbVdpk7PpGqUDgzGh0epSgKWgs2SHbKKGzHgZEMc
         Y54B7QarOnUGS91CRAJ77kyhnw0reQYDGxD5wXfGEXa7xq9TtBZjVbBTvR2NlD6gx7KG
         g5FGERg52ej3EicjJ/Ku1YI89+I7/ITYPt/gM+rFL0n8SZpzH6Ltk+dZGqhSmQ+A4bbi
         mmFc2g1q6RmMIeqLxEMARDUaBXVP0b984P4cG78qjN8Ygty4eo21m84XkwavzIYEUOLK
         toOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718109945; x=1718714745;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Sr3ezYoBYCWbRfF/IkcBntOoRAvScDiD9buPXYSl9U=;
        b=Fsp+Iz4lYGpp6dnVJGPn97m7klpABIOxGlrmjjaoTH2rqhqjWCxmxyjiNK4zXIpQaO
         sK5hMb/0r+mGYeDXgSxPUXxDd8jRQhcgT/1xUQ4DveJJ4ejs7xiaUtc/OIxu2X8loBZi
         C84JTAGFc7xH5Pylu+jy3ALy4GD2HEqJthS0sPyJ1W/HbZXop30S3mheq6iKWmHYcq7I
         VVPYiKMsoGhlL5PgcfTcUuf8b1OsBqlSFXap3mTG5hgTnahGvD2cKvj5P9h8pRNPtxkC
         eubAB2dZvFr/ctLBQ0rIli1MgnbAuKXgmn1thsabjFiiYzEvKZx//P5u7rAQ0gSm7ON3
         pGqw==
X-Gm-Message-State: AOJu0Yxk5+JigYQr9gecjL7eeU1FN9nvh1wS/Wk/n4zpJjA/ModYI030
	+nPLgB/j/HTfZ8dbnHuZ5PS2KvdQls7iFtTdDZ5UqVH5CAn3OgRtmHHanw==
X-Google-Smtp-Source: AGHT+IE7qmX3OvbMUTfK8GA0+zzsZip2fZQxSQZTNLzH66Yn+N0cYwCapPX51umOA6bi81yVcN30Fw==
X-Received: by 2002:a05:600c:4f0c:b0:421:cc89:dd5d with SMTP id 5b1f17b1804b1-421cc89e07emr46164115e9.9.1718109945099;
        Tue, 11 Jun 2024 05:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd18asm178243935e9.39.2024.06.11.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:45:44 -0700 (PDT)
Message-Id: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
References: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 12:45:40 +0000
Subject: [PATCH v6 0/3] object checking related additions and fixes for bundles in fetches
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>

While attempting to fix a reference negotiation bug in bundle-uri, we
identified that the fetch process lacks some crucial object validation
checks when processing bundles. The primary issues are:

 1. In the bundle-uri scenario, object IDs were not validated before writing
    bundle references. This was the root cause of the original negotiation
    bug in bundle-uri and could lead to potential repository corruption.
 2. The existing "fetch.fsckObjects" and "transfer.fsckObjects"
    configurations were not applied when directly fetching bundles or
    fetching with bundle-uri enabled. In fact, there were no object
    validation supports for unbundle.

The first patch addresses the bundle-uri negotiation issue by removing the
REF_SKIP_OID_VERIFICATION flag when writing bundle references.

Patches 2 through 3 extend verify_bundle_flags for bundle.c:unbundle to add
support for object validation (fsck) in fetch scenarios, mainly following
the suggestions from Junio and Patrick on the mailing list.

Xing Xin (3):
  bundle-uri: verify oid before writing refs
  fetch-pack: expose fsckObjects configuration logic
  unbundle: support object verification for fetches

 bundle-uri.c                |   5 +-
 bundle.c                    |   5 +
 bundle.h                    |   1 +
 fetch-pack.c                |  17 ++--
 fetch-pack.h                |   5 +
 t/t5558-clone-bundle-uri.sh | 186 +++++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     |  33 +++++++
 transport.c                 |   2 +-
 8 files changed, 240 insertions(+), 14 deletions(-)


base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2Fblanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blanet/xx/bundle-uri-bug-using-bundle-list-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1730

Range-diff vs v5:

 1:  e958a3ab20c = 1:  e958a3ab20c bundle-uri: verify oid before writing refs
 2:  d21c236b8de = 2:  d21c236b8de fetch-pack: expose fsckObjects configuration logic
 3:  0a18d7839be < -:  ----------- unbundle: extend options to support object verification
 4:  eb9f21f16b5 ! 3:  53395e8c08a unbundle: use VERIFY_BUNDLE_FSCK_FOLLOW_FETCH for fetches
     @@ Metadata
      Author: Xing Xin <xingxin.xx@bytedance.com>
      
       ## Commit message ##
     -    unbundle: use VERIFY_BUNDLE_FSCK_FOLLOW_FETCH for fetches
     +    unbundle: support object verification for fetches
      
     -    This commit passes `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` to `unbundle` in
     -    the fetching process, including:
     +    This commit extends object verification support for fetches in
     +    `bundle.c:unbundle` by adding the `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`
     +    option to `verify_bundle_flags`. When this option is enabled,
     +    `bundle.c:unbundle` invokes `fetch-pack.c:fetch_pack_fsck_objects` to
     +    determine whether to append the "--fsck-objects" flag to
     +    "git-index-pack".
     +
     +    `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` is now passed to `unbundle` in the
     +    fetching process, including:
      
          - `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
          - `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
       
       	/*
      
     + ## bundle.c ##
     +@@
     + #include "list-objects-filter-options.h"
     + #include "connected.h"
     + #include "write-or-die.h"
     ++#include "fetch-pack.h"
     + 
     + static const char v2_bundle_signature[] = "# v2 git bundle\n";
     + static const char v3_bundle_signature[] = "# v3 git bundle\n";
     +@@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
     + 	if (header->filter.choice)
     + 		strvec_push(&ip.args, "--promisor=from-bundle");
     + 
     ++	if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
     ++		if (fetch_pack_fsck_objects())
     ++			strvec_push(&ip.args, "--fsck-objects");
     ++
     + 	if (extra_index_pack_args) {
     + 		strvec_pushv(&ip.args, extra_index_pack_args->v);
     + 		strvec_clear(extra_index_pack_args);
     +
     + ## bundle.h ##
     +@@ bundle.h: int create_bundle(struct repository *r, const char *path,
     + enum verify_bundle_flags {
     + 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
     + 	VERIFY_BUNDLE_QUIET = (1 << 1),
     ++	VERIFY_BUNDLE_FSCK_FOLLOW_FETCH = (1 << 2),
     + };
     + 
     + int verify_bundle(struct repository *r, struct bundle_header *header,
     +
       ## t/t5558-clone-bundle-uri.sh ##
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'create bundle' '
       		git bundle create B.bundle topic &&

-- 
gitgitgadget
