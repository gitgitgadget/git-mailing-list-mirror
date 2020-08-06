Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4833C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E181221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n2pCexqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgHFVHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:07:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55435 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgHFVHg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 17:07:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F56B7F91F;
        Thu,  6 Aug 2020 17:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IDlnjJl9CwiU0FkkzfTsxIoAPXU=; b=n2pCex
        qsvWJVc/k1prVXgqxNA5Ymho56/LBeKz7YkPovG9PFZpybvKK7xX97BN4krypCRt
        lHpiZZ5BmxFBea1qSv/eHXFWgx6sDSBHUCi+JRnYO6rHdTuwudP1PV6bYCKqAXEm
        UN61uJIY2TiKGhr2YQKOvx+L2yuUFsQgvmdEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kaOdqnfyWvOq5ixTOnEMEHbsbj9mmf+i
        2Ak0nWKh3hCI+JuMuvQ4HLWgO5GogsfjFxZX5r0ZDYUnQ/Jr4DJD2D9daW/FWS4o
        LXy0jBp2W/RQ5OXz0AiZ3EDPDO0/Irwr30t51Tl8McQ6gsfsQdCENe+6MstUh0f/
        jqii4z4izxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77D857F91E;
        Thu,  6 Aug 2020 17:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02AB37F91D;
        Thu,  6 Aug 2020 17:07:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] t4140: test apply with i-t-a paths
References: <C4ON23BIKMVK.2ZESQJ1FB5PVA@ziyou.local>
        <20200806060119.74587-1-ray@ameretat.dev>
        <20200806060119.74587-4-ray@ameretat.dev>
Date:   Thu, 06 Aug 2020 14:07:31 -0700
In-Reply-To: <20200806060119.74587-4-ray@ameretat.dev> (Raymond E. Pasco's
        message of "Thu, 6 Aug 2020 02:01:19 -0400")
Message-ID: <xmqqeeojjxf0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7DF6546-D828-11EA-BCBF-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> apply --cached (as used by add -p) should accept creation and deletion
> patches to intent-to-add paths in the index. apply --index, however,
> should always fail because an intent-to-add path never matches the
> worktree (by definition).
>
> Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>  t/t4140-apply-ita.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 t/t4140-apply-ita.sh

chmod +x

> diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
> new file mode 100644
> index 0000000000..c614eaf04c
> --- /dev/null
> +++ b/t/t4140-apply-ita.sh
> @@ -0,0 +1,56 @@
> +#!/bin/sh
> +
> +test_description='git apply of i-t-a file'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	test_write_lines 1 2 3 4 5 >blueprint &&
> +
> +	cat blueprint >test-file &&
> +	git add -N test-file &&
> +	git diff >creation-patch &&
> +	grep "new file mode 100644" creation-patch &&
> +
> +	rm -f test-file &&
> +	git diff >deletion-patch &&
> +	grep "deleted file mode 100644" deletion-patch
> +'
> +
> +test_expect_success 'apply creation patch to ita path (--cached)' '
> +	git rm -f test-file &&
> +	cat blueprint >test-file &&
> +	git add -N test-file &&
> +
> +	git apply --cached creation-patch &&
> +	git cat-file blob :test-file >actual &&
> +	test_cmp blueprint actual
> +'

OK, this is a good positive test case.

> +test_expect_success 'apply creation patch to ita path (--index)' '
> +	git rm -f test-file &&
> +	cat blueprint >test-file &&
> +	git add -N test-file &&
> +	rm -f test-file &&
> +
> +	test_must_fail git apply --index creation-patch
> +'

"--index" (not "--cached") notices that test-file does not match
between the index and the working tree, and fails.  OK.

> +test_expect_success 'apply deletion patch to ita path (--cached)' '
> +	git rm -f test-file &&
> +	cat blueprint >test-file &&
> +	git add -N test-file &&
> +
> +	git apply --cached deletion-patch &&
> +	test_must_fail git ls-files --stage --error-unmatch test-file
> +'

We can delete an I-T-A entry.  I wonder if

	git apply --cached -R creation-patch

also serves as a way to remove the path?  It should succeed, right?

> +test_expect_success 'apply deletion patch to ita path (--index)' '
> +	cat blueprint >test-file &&
> +	git add -N test-file &&
> +
> +	test_must_fail git apply --index deletion-patch &&
> +	git ls-files --stage --error-unmatch test-file
> +'

Again "--index" notices that the path has ITA bit on, and refuses to
remove it.

OK, looking good so far.

Thanks.
