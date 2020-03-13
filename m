Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737AAC2BB1D
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 18:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A96F2072C
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 18:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N9JZAGS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCMS1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:27:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58182 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgCMS1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 14:27:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8907AE811;
        Fri, 13 Mar 2020 14:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G/nBfoxtkoiU51CNQkTtVqKS4g0=; b=N9JZAG
        S84AQXHBfK+kqLgZXQ+AWRSaxC4bKJ5fX7M6Q1TGPf5bW0dtnw3DKzzSL4kUUtpr
        HvkGNtXlZfcoyBCJP//vJukZ34h0dRrMPpMUX9JXT9gcp/raEvJw5BZX/8ObYcB1
        iZAUObPqqyDT6vFweVc8uPGoIGFkDbEghZshU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tdY7lE6G19Qd++S64WUXVSL5lcpxf17b
        YFgLQgSGpXSSUgaPDhZj99KoE9q4ULAvO04qNQEf7nkYGhJ3R8UsYTWw8bw8VZ1U
        1Pu6PpyJCN65iW5AZpux4Hr6uNvJZuwAF1GB7KLFeFvp/MalWRp73Un53bRMv6ks
        3nI9JwfRJ80=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3C27AE810;
        Fri, 13 Mar 2020 14:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 04F36AE804;
        Fri, 13 Mar 2020 14:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Regression in v2.26.0-rc0 and Magit
References: <3091652.KAqcNXvZJ4@cayenne> <20200312233504.GH120942@google.com>
        <xmqqk13pdsw1.fsf@gitster.c.googlers.com>
Date:   Fri, 13 Mar 2020 11:27:26 -0700
In-Reply-To: <xmqqk13pdsw1.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 12 Mar 2020 17:02:06 -0700")
Message-ID: <xmqq36accdpt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B235466-6558-11EA-8B11-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio, can you fast-track that fix to "master"?  Emily, can you add a
>> test?
>
> Thanks, indeed it has been waiting for tests.  We have a few more
> business days before -rc2, so...
>
> * es/outside-repo-errmsg-hints (2020-03-03) 1 commit
>  - prefix_path: show gitdir if worktree unavailable
>
>  An earlier update to show the location of working tree in the error
>  message did not consider the possibility that a git command may be
>  run in a bare repository, which has been corrected.
>
>  May want a test or two.

If nobody complains in the coming 4 hours or so, I'll squash this in
to e6c57b49 ("prefix_path: show gitdir if worktree unavailable",
2020-03-02) and mark the topic as "ready for 'next'".

Thanks.

 t/t6136-pathspec-in-bare.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t6136-pathspec-in-bare.sh b/t/t6136-pathspec-in-bare.sh
new file mode 100755
index 0000000000..d9e03132b7
--- /dev/null
+++ b/t/t6136-pathspec-in-bare.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='diagnosing out-of-scope pathspec'
+
+. ./test-lib.sh
+
+test_expect_success 'setup a bare and non-bare repository' '
+	test_commit file1 &&
+	git clone --bare . bare
+'
+
+test_expect_success 'log and ls-files in a bare repository' '
+	(
+		cd bare &&
+		test_must_fail git log -- .. &&
+		test_must_fail git ls-files -- ..
+	) >out 2>err &&
+	test_i18ngrep "outside repository" err
+'
+
+test_expect_success 'log and ls-files in .git directory' '
+	(
+		cd .git &&
+		test_must_fail git log -- .. &&
+		test_must_fail git ls-files -- ..
+	) >out 2>err &&
+	test_i18ngrep "outside repository" err
+'
+
+test_done
