Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8122A1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 01:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfJJB7G (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 21:59:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61714 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfJJB5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 21:57:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B75E8F5EE;
        Wed,  9 Oct 2019 21:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u/PqMRoaTOhbuRPWlIQd/uWPCNY=; b=taafAz
        EPM12EerRkOz+Ab3qcAHXVtQdKNjHYQ2BWiuAZfa/ya3Hl/DHTsXF6C9PPUPVvlv
        Y2GHFFsA8fCoh3CgmaPeozQoMgVvTofXvSPlwopUlES7+vDcwITlDcFRPwSOeG48
        6fVMUSVwtBwsY1+G3TF/AAdipOUXmGIYkGiRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nmdKovzs86iCmM2lcgxAqe72MRyhC1Nb
        ZIih0N6D+E1n4ewG3ZLwZeN9gMW7EpKDhJ8D2aAb+ekV0r+whNAm9P67hSAKoCNH
        +y0gRqDBNUBQYjXaOSKd0ELZtx6ESi9DsQCvMspmUxYIy2k0TRdw5BDy1BasVMkB
        yLUxPnxMitM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22ABE8F5ED;
        Wed,  9 Oct 2019 21:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 530908F5EC;
        Wed,  9 Oct 2019 21:56:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, Johannes.Schindelin@gmx.de,
        jeffhost@microsoft.com
Subject: Re: [PATCH v2 0/1] fsmonitor: don't fill bitmap with entries to be removed
References: <pull.372.git.gitgitgadget@gmail.com>
        <pull.372.v2.git.gitgitgadget@gmail.com>
Date:   Thu, 10 Oct 2019 10:56:55 +0900
In-Reply-To: <pull.372.v2.git.gitgitgadget@gmail.com> (William Baker via
        GitGitGadget's message of "Wed, 09 Oct 2019 14:00:11 -0700 (PDT)")
Message-ID: <xmqq1rvll5w8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DA9C77E-EB01-11E9-AC0F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is the second iteration of changes to fix the segfault that I
> encountered while testing fsmonitor. This iteration includes the following
> updates for feedback I received on v1:
>
>  * Use %u instead of %"PRIuMAX" for unsigned ints in BUG format strings
>  * Updated the new test's comment to be more descriptive
>
> Thanks,
>
> William
>
> William Baker (1):
>   fsmonitor: don't fill bitmap with entries to be removed

Thanks.  Dscho, is this still Reviewed-by: you?

>
>  fsmonitor.c                 | 29 ++++++++++++++++++++++++-----
>  t/t7519-status-fsmonitor.sh | 13 +++++++++++++
>  t/t7519/fsmonitor-env       | 24 ++++++++++++++++++++++++
>  3 files changed, 61 insertions(+), 5 deletions(-)
>  create mode 100755 t/t7519/fsmonitor-env
>
>
> base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-372%2Fwilbaker%2Ffix_git_fsmonitor_crash-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-372/wilbaker/fix_git_fsmonitor_crash-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/372
>
> Range-diff vs v1:
>
>  1:  ce9bf4237e ! 1:  08741d986c fsmonitor: don't fill bitmap with entries to be removed
>      @@ -44,8 +44,8 @@
>       +	struct cache_entry *ce;
>       +	
>       +	if (pos >= istate->cache_nr)
>      -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %"PRIuMAX")",
>      -+		    (uintmax_t)pos, (uintmax_t)istate->cache_nr);
>      ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
>      ++		    (uintmax_t)pos, istate->cache_nr);
>        
>       +	ce = istate->cache[pos];
>        	ce->ce_flags &= ~CE_FSMONITOR_VALID;
>      @@ -56,8 +56,8 @@
>        	istate->fsmonitor_dirty = fsmonitor_dirty;
>        
>       +	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
>      -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
>      -+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
>      ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
>      ++		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
>       +
>        	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
>        	return 0;
>      @@ -85,8 +85,8 @@
>        	int fixup = 0;
>        
>       +	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
>      -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
>      -+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
>      ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
>      ++		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
>       +
>        	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
>        	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
>      @@ -96,8 +96,8 @@
>        
>        			/* Mark all previously saved entries as dirty */
>       +			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
>      -+				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
>      -+				    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
>      ++				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
>      ++				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
>        			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
>        
>        			/* Now mark the untracked cache for fsmonitor usage */
>      @@ -109,8 +109,9 @@
>        	test_cmp expect actual
>        '
>        
>      -+# Use test files that start with 'z' so that the entries being added
>      -+# and removed appear at the end of the index.
>      ++# This test covers staging/unstaging files that appear at the end of the index.
>      ++# Test files with names beginning with 'z' are used under the assumption that
>      ++# earlier tests do not add/leave index entries that sort below them. 
>       +test_expect_success 'status succeeds after staging/unstaging ' '
>       +	test_commit initial &&
>       +	removed=$(test_seq 1 100 | sed "s/^/z/") &&
