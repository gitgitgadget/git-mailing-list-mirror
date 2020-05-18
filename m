Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39362C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E5B207ED
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EA8sVljq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgERRNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:13:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61427 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRNA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:13:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB0DC49C0F;
        Mon, 18 May 2020 13:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MLjXNV1Kt4JUaesReROcBRYD3vc=; b=EA8sVl
        jqdSD46nBeToPu95MJIue2vXtKayYQOZB+E6AXPyZ0SZdkf/fQH0Q5pi/Fia+eKE
        JIxbu1QnyFg9+PSHADtX4oH+Xk2o2wzrSy3SyfFw+LDQR1+pqd4unHJMWB6liBMh
        BUMSGjvxrqi3mNeAbCr1l94fJqcDi3EFLhC8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TxlPs4xRehL/wSUIevWXdIyo6kurbHpY
        osfA8IResWFdXdXxdi4w6TLpeBN+j59zTShDGekekDMmfo7L5YOXfxNUz6M0+djM
        2Bx1jlahymgODaW+1MgMmoFLXtqEAE5BVV3qtZY0/M+Vtrp7/Alee2Djl6ZAprqG
        6cKV+InH2sE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D23D249C0D;
        Mon, 18 May 2020 13:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5614849C0C;
        Mon, 18 May 2020 13:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] commit-slab-decl.h: fix define guards
References: <20200516172837.2872-1-abhishekkumar8222@gmail.com>
        <20200518143023.14217-1-abhishekkumar8222@gmail.com>
Date:   Mon, 18 May 2020 10:12:56 -0700
In-Reply-To: <20200518143023.14217-1-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Mon, 18 May 2020 20:00:23 +0530")
Message-ID: <xmqqsgfx415z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1AD3438-992A-11EA-B2E3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> a9f1f1f9f8 ("commit-slab.h: code split", 2018-05-19) split commit-slab
> ...

I've rephrased the log message a bit more before queuing, since I
did not find many hits for "define guards" but the search engine
found quite a common use of "include guard".

Thanks.


-- >8 --
From: Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: [PATCH] commit-slab-decl.h: update include guard

When a9f1f1f9f8 ("commit-slab.h: code split", 2018-05-19) split
commit-slab.h into commit-slab-decl.h and commit-slab-impl.h header
files, commit-slab-decl.h were left use "COMMIT_SLAB_HDR_H", while
commit-slab-impl.h gained its own macro, "COMMIT_SLAB_IMPL_H".

As these two files use different include guards, there is nothing
broken, but let's update commit-slab-decl.h to match the convention
to name the include guard after the filename.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-slab-decl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-slab-decl.h b/commit-slab-decl.h
index adc7b46c83..bfbed1516a 100644
--- a/commit-slab-decl.h
+++ b/commit-slab-decl.h
@@ -1,5 +1,5 @@
-#ifndef COMMIT_SLAB_HDR_H
-#define COMMIT_SLAB_HDR_H
+#ifndef COMMIT_SLAB_DECL_H
+#define COMMIT_SLAB_DECL_H
 
 /* allocate ~512kB at once, allowing for malloc overhead */
 #ifndef COMMIT_SLAB_SIZE
@@ -40,4 +40,4 @@ elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
 	declare_commit_slab(slabname, elemtype); \
 	declare_commit_slab_prototypes(slabname, elemtype)
 
-#endif /* COMMIT_SLAB_HDR_H */
+#endif /* COMMIT_SLAB_DECL_H */
-- 
2.27.0-rc0

