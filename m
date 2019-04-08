Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5763020248
	for <e@80x24.org>; Mon,  8 Apr 2019 04:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfDHEGH (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 00:06:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43995 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDHEGH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 00:06:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so14515329wrx.10
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 21:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bwPX8zIMIsP604hL/3IhG0QTWNCm+mT2eB5gpFdunHc=;
        b=kATc5ifNv9DDqEWezLvy+BDS2Hb5vDAH+jiOYgO/qBKmfTIVROKXiJ57mus1IEHdg3
         tapejEaiako4aFBB7ixYQXOBNxhVCy7PFMLv+sHGyFj6+4PsU8yirSNacjCrB2NICakA
         PQxsSlQuRSMhpGL8ax7+CES7EDNaBAD7TxJ4luWqS469m1ZhrSooQAqe/sY7RvJ9qezC
         G+N0EF2L1B5zV41OcCGWnTCrjYxxU++3qfjoNfNM+dZJ9mcb24VpnFER3XQuJ66l2Dp1
         iGjIhT8hE+dtRMV8d34jHe6eyzAWXiMIjpmEiawZ/64a/rRenq7wyiiFrdY1Fedl2E1K
         TyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bwPX8zIMIsP604hL/3IhG0QTWNCm+mT2eB5gpFdunHc=;
        b=Up2oGxWG/vaWBGiRgcKOSjohUOh4aIuDZX6bn/XUA/6Ai2EwxpbyMQBghFd9J7N2a7
         Qmw3gXINRoU1Co14w5W1GdrKOu2r0oB3Maic82gnr/mOL7a2NLj53XJ049r42GQBtlUG
         1IJFiodKhqJsUHc4rIJX8QgsBM9aEzyh4ekMoVSvkriZ5Ribh3Pg7IDXzO7QOdZEgtYp
         t4EE08Dpi0raqBlmWddmCCMl3x40D7jLCwG+alxpa/5XwBz2NfVl1zPLXDL1/kmOdNhi
         hkx/hgPQMAVktVAMijixucPGpNpiiAdZDWE9beI2BIC43+YAlleY/P7RtpRhauB4cNB7
         Z13A==
X-Gm-Message-State: APjAAAVpX7Uis+iZP4zC0+p8uAnECRbt7hAX3ZHXuYHq0TxkZ9z55P32
        USiVaNJP4nv+PZynfpcbnp8S2Wumalw=
X-Google-Smtp-Source: APXvYqyu9cyJeYRRtzB22zboC29jdXXmxVHW/c65/27NhHxCUWFSgoS08NhDrLa3poA15qBVwa58bg==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr10371828wro.40.1554696364227;
        Sun, 07 Apr 2019 21:06:04 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x205sm11166992wmg.9.2019.04.07.21.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 21:06:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fixup! diff: batch fetching of missing blobs
References: <CACsJy8CgXLZxqab4vcP1jh3OMCGh1i=easb5BpCs1J8Uf_jsxw@mail.gmail.com>
        <20190405170934.20441-1-jonathantanmy@google.com>
        <CACsJy8AjyY1Azbf4VfnJMA3O8NNBV1P16dZRrHOUJdsYQHUu4g@mail.gmail.com>
Date:   Mon, 08 Apr 2019 13:06:03 +0900
In-Reply-To: <CACsJy8AjyY1Azbf4VfnJMA3O8NNBV1P16dZRrHOUJdsYQHUu4g@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 6 Apr 2019 11:17:46 +0700")
Message-ID: <xmqqmul1b0pg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Avoid a usage of the_repository by propagating the configured repository
>> to add_if_missing(). Also, prefetch only if the repository being diffed
>> is the_repository (because we do not support lazy fetching for any other
>> repository anyway).

If we are willing to stay limited to the default repository anyway,
allowing add_if_missing() to take an arbitrary repository does not
really matter, but before the caller of add_if_missing() befcomes
ready to work on an arbitrary repository, this change has to happen.

To update the caller, it seems to me that fetch_objects() must learn
to take an arbitrary repository, but is that the only thing needed?
After that, the function that the caller resides in and callchain
upwards can learn to take a repository instance if we want to be
able to diff inside an arbitrary repository.

But.  Such a change still would not allow us to compare a tree in
one repository against a tree in another repository.  It is likely
that a caller with such a need would simply make sure that objects
in both repositories are available by using the in-core alternate
object store mechanism, making it a more-or-less moot point to be
able to pass a repository instance through the callchain X-<.  We
probably should make it, and spell it out somewhere in a long term
vision shared among the developers, an explicit goal to get rid of
the internal (ab)use of the alternate object store mechanism.

With squashing the fix-up commit in, the 2/2 patch has become like
so.

Thanks, both.

-- >8 --
From: Jonathan Tan <jonathantanmy@google.com>
Date: Fri, 5 Apr 2019 10:09:34 -0700
Subject: [PATCH] diff: batch fetching of missing blobs

When running a command like "git show" or "git diff" in a partial clone,
batch all missing blobs to be fetched as one request.

This is similar to c0c578b33c ("unpack-trees: batch fetching of missing
blobs", 2017-12-08), but for another command.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                        |  33 +++++++++++
 t/t4067-diff-partial-clone.sh | 103 ++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100755 t/t4067-diff-partial-clone.sh

diff --git a/diff.c b/diff.c
index ec5c095199..811afbdfb1 100644
--- a/diff.c
+++ b/diff.c
@@ -25,6 +25,7 @@
 #include "packfile.h"
 #include "parse-options.h"
 #include "help.h"
+#include "fetch-object.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -6366,8 +6367,40 @@ void diffcore_fix_diff_index(void)
 	QSORT(q->queue, q->nr, diffnamecmp);
 }
 
+static void add_if_missing(struct oid_array *to_fetch, struct repository *r,
+			   const struct diff_filespec *filespec)
+{
+	if (filespec && filespec->oid_valid &&
+	    oid_object_info_extended(r, &filespec->oid, NULL,
+				     OBJECT_INFO_FOR_PREFETCH))
+		oid_array_append(to_fetch, &filespec->oid);
+}
+
 void diffcore_std(struct diff_options *options)
 {
+	if (options->repo == the_repository &&
+	    repository_format_partial_clone) {
+		/*
+		 * Prefetch the diff pairs that are about to be flushed.
+		 */
+		int i;
+		struct diff_queue_struct *q = &diff_queued_diff;
+		struct oid_array to_fetch = OID_ARRAY_INIT;
+
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			add_if_missing(&to_fetch, options->repo, p->one);
+			add_if_missing(&to_fetch, options->repo, p->two);
+		}
+		if (to_fetch.nr)
+			/*
+			 * NEEDSWORK: Consider deduplicating the OIDs sent.
+			 */
+			fetch_objects(repository_format_partial_clone,
+				      to_fetch.oid, to_fetch.nr);
+		oid_array_clear(&to_fetch);
+	}
+
 	/* NOTE please keep the following in sync with diff_tree_combined() */
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
new file mode 100755
index 0000000000..90c8fb2901
--- /dev/null
+++ b/t/t4067-diff-partial-clone.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+
+test_description='behavior of diff when reading objects in a partial clone'
+
+. ./test-lib.sh
+
+test_expect_success 'git show batches blobs' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure that there is exactly 1 negotiation by checking that there is
+	# only 1 "done" line sent. ("done" marks the end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client show HEAD &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
+test_expect_success 'diff batches blobs' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	echo c >server/c &&
+	echo d >server/d &&
+	git -C server add c d &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure that there is exactly 1 negotiation by checking that there is
+	# only 1 "done" line sent. ("done" marks the end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
+test_expect_success 'diff skips same-OID blobs' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	echo another-a >server/a &&
+	git -C server add a &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	echo a | git hash-object --stdin >hash-old-a &&
+	echo another-a | git hash-object --stdin >hash-new-a &&
+	echo b | git hash-object --stdin >hash-b &&
+
+	# Ensure that only a and another-a are fetched.
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
+	grep "want $(cat hash-old-a)" trace &&
+	grep "want $(cat hash-new-a)" trace &&
+	! grep "want $(cat hash-b)" trace
+'
+
+test_expect_success 'diff with rename detection batches blobs' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	printf "b\nb\nb\nb\nb\n" >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	rm server/b &&
+	printf "b\nb\nb\nb\nbX\n" >server/c &&
+	git -C server add c &&
+	git -C server commit -a -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure that there is exactly 1 negotiation by checking that there is
+	# only 1 "done" line sent. ("done" marks the end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff -M HEAD^ HEAD >out &&
+	grep "similarity index" out &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
+test_done
-- 
2.21.0-196-g041f5ea1cf

