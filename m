Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0DEC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684AD6108E
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbhI1Rf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:35:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55942 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbhI1Rf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:35:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47201DFF4B;
        Tue, 28 Sep 2021 13:33:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Q6ssvzXN+oBTdsD9pqdaPv3ztp5DY4vALVlrg
        lZIXA=; b=s4OEa9zRt8OWbpkKjOSfW0uoyBeWWo6rFSqyzFStJjo0A4TokMGYoV
        3KhSr/Kt0xhn+A2RsWnRB0qY7p9N8tlbsmoh0KRDkXV3wo/kKNm17jYi5WgA1LaW
        OxVA0G6AWmEI1t8041Bz/AYdE4WsbtYJDXIp2LiRfcl+h4hSa8WlQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C510DFF4A;
        Tue, 28 Sep 2021 13:33:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95285DFF46;
        Tue, 28 Sep 2021 13:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
        <97eb5075-2ef3-8891-138a-44a035437404@gmail.com>
Date:   Tue, 28 Sep 2021 10:33:44 -0700
In-Reply-To: <97eb5075-2ef3-8891-138a-44a035437404@gmail.com> (Derrick
        Stolee's message of "Tue, 28 Sep 2021 09:31:28 -0400")
Message-ID: <xmqq7df0li4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B6A448A-2082-11EC-A74D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Yes, I agree. I was waiting to see if more comments trickled in, but
> it seems stable now. Do you want me to re-roll the whole series, or
> do you want to apply the fixup below?

Let us wait for a bit more trickling in, but in the meantime, here
is what I'd keep.  Thanks.

[ds/add-rm-with-sparse-index] $ git range-diff @{1}...
 1:  f1309dd7be !  1:  edd2cd345f t1092: behavior for adding sparse files
    @@ t/t1092-sparse-checkout-compatibility.sh: test_sparse_match () {
     +	for repo in sparse-checkout sparse-index
     +	do
     +		# Skip "unmerged" paths
    -+		git -C $repo diff --staged --diff-filter=ACDMRTXB -- "$file" >diff &&
    ++		git -C $repo diff --staged --diff-filter=u -- "$file" >diff &&
     +		test_must_be_empty diff || return 1
     +	done
     +}
 2:  9a8c340809 =  2:  f6526728f9 dir: select directories correctly
 3:  2a4e495cd4 =  3:  ed4958477b dir: fix pattern matching on dirs
 ...

