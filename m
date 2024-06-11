Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190136D
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088132; cv=none; b=dFymhK7M17ZeaUPcBEHED8qGig9AqtCtKmNBmBuLrJh4c7EdFv/P457EAi9QL8LwpXmQzVVlPOwyibORWwYhUhjlEs4FP04naMUU8CPaF5B/cNXas8Vv7ol1h+3tmYFgt5EMhmHGr5p8YF0QqG2OKU1RRTmbeTJrMXE8Ogoo/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088132; c=relaxed/simple;
	bh=RQg1C0tQ+/3i+6Tagk2+VcZ+sEBLHfBqHY9tMoYLwhU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JryCoA7QmkqQWFVs+ENrW7k0Lt6jXpIkX3JTLrVPdY5B1LufHHsstfhc4JvArcrWcpK6MRFrpDv7xAV65YgEFlEfA8g1eTqiRu9qMilb5CtZXBuGec1RxPWJFawM+FIN1BdfYMvuCD6jNzz+Mrv1jzym1NxaFLp1/xYSddKgYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz1peLMB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz1peLMB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42172ed3597so21997325e9.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718088129; x=1718692929; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ukol/ME5rhzpN86cGSlY3ZeSu2XUOzgkAQoPmPN5t9Y=;
        b=Mz1peLMB9iqGdNsaDsukXOAJG2gSCeuXADjhgZfE9J9e1z376adxAwdJ+79+YXdkHE
         VV8TQx/NbIEbIDb5Zqg7gWJhwrhq9U7JV9woOW+VraKdkUh9/l5mgWh4ICnXhitFdtMP
         SmaRcQSROapI0tW4WQ1gSCZGk7KCfLcF6KEFhpfBAsfhscWG71iBBnNNecyfmmVvfMWU
         f9LVuyeEDU8NU+9xhApNS+eIHVdzooZSpwM0F+uVsEZBap0l1AoV4Ti3srABBhbKvcPw
         SADFtpZB7qi2idlm5j90r9d0aH5qbhpS1h875dmC8h2ZCfcL/ot8oEyhMl3VNw/0iFLP
         GZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088129; x=1718692929;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ukol/ME5rhzpN86cGSlY3ZeSu2XUOzgkAQoPmPN5t9Y=;
        b=JBkujNVlJOxpHJX+8ZeqYKRi9two6FIlSIzefHlO+OGxRzgRZBWdc9AYa92Nkac+Tb
         BiIKf5rCkp0e7DuZzpzYrVPFGi3+bSSiqQKvIy2N8VFOZVAP+G+yJmsjflYo7sc3to6V
         zo7Ezu2M6GZJ6Gu9Ow5xTW+Yb5WbHQ2PhYwNsyCdEyPBjzMKg9o5MJYdqSg4KgiVHq4o
         1DSImCn4k/4mCPjIAXtUA++DTPL1oUZ1Rq3DiXmoivHZyE/wJY1h5Ivj2xg/aqlXGwZh
         P/7CS6C9yA6rGKrLgmyNw7yjZoByvMQApwjt4HLnPhZIXM8ZxMSpUK8gQkDOehDLgYIz
         gBwg==
X-Gm-Message-State: AOJu0YxlhDgZWx1t2mgji7u1ae0YIDpQl5LMaezN80YWQSd9+WgtY+G3
	oSsW9Qtf3IRn7avD0SrZb1aCxJk8FrpHJNk9ye0LFzkm6jWNP4BxfethKA==
X-Google-Smtp-Source: AGHT+IFSSRgkzwggcY3PLeP84znYl1PWrV9M15tAPbRfheExftOZ7t3AFeQBl2yLbPeG/NDjg6fpQA==
X-Received: by 2002:a05:600c:46cf:b0:421:83fd:900f with SMTP id 5b1f17b1804b1-4223c527fcemr15148885e9.5.1718088128760;
        Mon, 10 Jun 2024 23:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a6130sm165589975e9.26.2024.06.10.23.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 23:42:08 -0700 (PDT)
Message-Id: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
References: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 06:42:02 +0000
Subject: [PATCH v5 0/4] object checking related additions and fixes for bundles in fetches
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

Patches 2 through 4 extend verify_bundle_flags for bundle.c:unbundle to add
support for object validation (fsck) in different scenarios, mainly
following the suggestions from Junio on the mailing list.

Xing Xin (4):
  bundle-uri: verify oid before writing refs
  fetch-pack: expose fsckObjects configuration logic
  unbundle: extend options to support object verification
  unbundle: use VERIFY_BUNDLE_FSCK_FOLLOW_FETCH for fetches

 bundle-uri.c                |   5 +-
 bundle.c                    |  10 ++
 bundle.h                    |   2 +
 fetch-pack.c                |  17 ++--
 fetch-pack.h                |   5 +
 t/t5558-clone-bundle-uri.sh | 186 +++++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     |  33 +++++++
 transport.c                 |   2 +-
 8 files changed, 246 insertions(+), 14 deletions(-)


base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2Fblanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blanet/xx/bundle-uri-bug-using-bundle-list-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1730

Range-diff vs v4:

 1:  e958a3ab20c = 1:  e958a3ab20c bundle-uri: verify oid before writing refs
 3:  5ddc894c2c1 = 2:  d21c236b8de fetch-pack: expose fsckObjects configuration logic
 2:  beb70735811 ! 3:  0a18d7839be unbundle: extend verify_bundle_flags to support fsck-objects
     @@ Metadata
      Author: Xing Xin <xingxin.xx@bytedance.com>
      
       ## Commit message ##
     -    unbundle: extend verify_bundle_flags to support fsck-objects
     +    unbundle: extend options to support object verification
      
     -    This commit extends `verify_bundle_flags` by adding a new option
     -    `VERIFY_BUNDLE_FSCK_ALWAYS`, which enables checks for broken objects in
     -    `bundle.c:unbundle`. This option is now used as the default for fetches
     -    involving bundles, specifically by `transport.c:fetch_refs_from_bundle`
     -    for direct bundle fetches and by `bundle-uri.c:unbundle_from_file` for
     -    _bundle-uri_ enabled fetches.
     +    This commit extends object verification support in `bundle.c:unbundle`
     +    by adding two new options to `verify_bundle_flags`:
      
     -    Upcoming commits will introduce another option as a replacement that
     -    fits better with fetch operations. `VERIFY_BUNDLE_FSCK_ALWAYS` will be
     -    further used to add "--fsck-objects" support for "git bundle unbundle"
     -    and "git bundle verify".
     +    - `VERIFY_BUNDLE_FSCK_ALWAYS` explicitly enables checks for broken
     +      objects. It will be used to add "--fsck-objects" support for "git
     +      bundle unbundle" in a separate series.
     +    - `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` is designed to be used during fetch
     +      operations, specifically for direct bundle fetches and _bundle-uri_
     +      enabled fetches. When enabled, `bundle.c:unbundle` invokes
     +      `fetch-pack.c:fetch_pack_fsck_objects` to determine whether to enable
     +      checks for broken objects. Passing this flag during fetching will be
     +      implemented in a subsequent commit.
     +
     +    Note that the option `VERIFY_BUNDLE_FSCK_ALWAYS` takes precedence over
     +    `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`.
      
          Reviewed-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
     - ## bundle-uri.c ##
     -@@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *file)
     - 	 * the prerequisite commits.
     - 	 */
     - 	if ((result = unbundle(r, &header, bundle_fd, NULL,
     --			       VERIFY_BUNDLE_QUIET)))
     -+			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_ALWAYS)))
     - 		return 1;
     - 
     - 	/*
     -
       ## bundle.c ##
     +@@
     + #include "list-objects-filter-options.h"
     + #include "connected.h"
     + #include "write-or-die.h"
     ++#include "fetch-pack.h"
     + 
     + static const char v2_bundle_signature[] = "# v2 git bundle\n";
     + static const char v3_bundle_signature[] = "# v3 git bundle\n";
     +@@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
     + 	     enum verify_bundle_flags flags)
     + {
     + 	struct child_process ip = CHILD_PROCESS_INIT;
     ++	int fsck_objects = 0;
     + 
     + 	if (verify_bundle(r, header, flags))
     + 		return -1;
      @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
       	if (header->filter.choice)
       		strvec_push(&ip.args, "--promisor=from-bundle");
       
      +	if (flags & VERIFY_BUNDLE_FSCK_ALWAYS)
     ++		fsck_objects = 1;
     ++	else if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
     ++		fsck_objects = fetch_pack_fsck_objects();
     ++
     ++	if (fsck_objects)
      +		strvec_push(&ip.args, "--fsck-objects");
      +
       	if (extra_index_pack_args) {
     @@ bundle.h: int create_bundle(struct repository *r, const char *path,
       	VERIFY_BUNDLE_VERBOSE = (1 << 0),
       	VERIFY_BUNDLE_QUIET = (1 << 1),
      +	VERIFY_BUNDLE_FSCK_ALWAYS = (1 << 2),
     ++	VERIFY_BUNDLE_FSCK_FOLLOW_FETCH = (1 << 3),
       };
       
       int verify_bundle(struct repository *r, struct bundle_header *header,
     -
     - ## transport.c ##
     -@@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
     - 	if (!data->get_refs_from_bundle_called)
     - 		get_refs_from_bundle_inner(transport);
     - 	ret = unbundle(the_repository, &data->header, data->fd,
     --		       &extra_index_pack_args, 0);
     -+		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_ALWAYS);
     - 	transport->hash_algo = data->header.hash_algo;
     - 	return ret;
     - }
 4:  68b9bca9f8b ! 4:  eb9f21f16b5 unbundle: introduce option VERIFY_BUNDLE_FSCK_FOLLOW_FETCH
     @@ Metadata
      Author: Xing Xin <xingxin.xx@bytedance.com>
      
       ## Commit message ##
     -    unbundle: introduce option VERIFY_BUNDLE_FSCK_FOLLOW_FETCH
     +    unbundle: use VERIFY_BUNDLE_FSCK_FOLLOW_FETCH for fetches
      
     -    This commit introduces a new option `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` to
     -    `verify_bundle_flags`. In `bundle.c:unbundle`, this new option controls
     -    whether broken object checks should be enabled by invoking
     -    `fetch-pack.c:fetch_pack_fsck_objects`. Note that the option
     -    `VERIFY_BUNDLE_FSCK_ALWAYS` takes precedence over
     -    `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`.
     -
     -    This flag is now used in the fetching process by:
     +    This commit passes `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` to `unbundle` in
     +    the fetching process, including:
      
          - `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
          - `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.
     @@ Commit message
          fetch operations. Tests have been added to confirm functionality in the
          scenarios mentioned above.
      
     +    Reviewed-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
       ## bundle-uri.c ##
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
       	 * the prerequisite commits.
       	 */
       	if ((result = unbundle(r, &header, bundle_fd, NULL,
     --			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_ALWAYS)))
     +-			       VERIFY_BUNDLE_QUIET)))
      +			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)))
       		return 1;
       
       	/*
      
     - ## bundle.c ##
     -@@
     - #include "list-objects-filter-options.h"
     - #include "connected.h"
     - #include "write-or-die.h"
     -+#include "fetch-pack.h"
     - 
     - static const char v2_bundle_signature[] = "# v2 git bundle\n";
     - static const char v3_bundle_signature[] = "# v3 git bundle\n";
     -@@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
     - 	     enum verify_bundle_flags flags)
     - {
     - 	struct child_process ip = CHILD_PROCESS_INIT;
     -+	int fsck_objects = 0;
     - 
     - 	if (verify_bundle(r, header, flags))
     - 		return -1;
     -@@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
     - 		strvec_push(&ip.args, "--promisor=from-bundle");
     - 
     - 	if (flags & VERIFY_BUNDLE_FSCK_ALWAYS)
     -+		fsck_objects = 1;
     -+	else if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
     -+		fsck_objects = fetch_pack_fsck_objects();
     -+
     -+	if (fsck_objects)
     - 		strvec_push(&ip.args, "--fsck-objects");
     - 
     - 	if (extra_index_pack_args) {
     -
     - ## bundle.h ##
     -@@ bundle.h: enum verify_bundle_flags {
     - 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
     - 	VERIFY_BUNDLE_QUIET = (1 << 1),
     - 	VERIFY_BUNDLE_FSCK_ALWAYS = (1 << 2),
     -+	VERIFY_BUNDLE_FSCK_FOLLOW_FETCH = (1 << 3),
     - };
     - 
     - int verify_bundle(struct repository *r, struct bundle_header *header,
     -
       ## t/t5558-clone-bundle-uri.sh ##
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'create bundle' '
       		git bundle create B.bundle topic &&
     @@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
       	if (!data->get_refs_from_bundle_called)
       		get_refs_from_bundle_inner(transport);
       	ret = unbundle(the_repository, &data->header, data->fd,
     --		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_ALWAYS);
     +-		       &extra_index_pack_args, 0);
      +		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_FOLLOW_FETCH);
       	transport->hash_algo = data->header.hash_algo;
       	return ret;

-- 
gitgitgadget
