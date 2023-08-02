Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6724FC001DF
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjHBTU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjHBTU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 15:20:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF17DA
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 12:20:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BF8B19FE6C;
        Wed,  2 Aug 2023 15:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a/9VcHBiPun3ztoqCsyOF3rASFXyucd3K0ya6f
        219EE=; b=M8W02BuoyNsquerwH1WgomqzQTmpkSzllwy4wDzqr/gjOeCSxF+UNO
        aQd7XLlygU+y41Fp/oDsBI/Xi86pOWldy6MYEP8TRzTozk+kDpY7qINbeoikPi7+
        Ac7bsV5Pm8js86uG6ymzEsv8hZvq/Dc/EEyr+j7gbkgTR5iACbp24=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04AC119FE6A;
        Wed,  2 Aug 2023 15:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DE2619FE69;
        Wed,  2 Aug 2023 15:20:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: jt/path-filter-fix
References: <xmqqfs518gdh.fsf@gitster.g> <ZMqp6K2iXixWH/zT@nand.local>
Date:   Wed, 02 Aug 2023 12:20:25 -0700
In-Reply-To: <ZMqp6K2iXixWH/zT@nand.local> (Taylor Blau's message of "Wed, 2
        Aug 2023 15:09:28 -0400")
Message-ID: <xmqqy1it6ykm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A29D6890-3169-11EE-9573-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Aug 02, 2023 at 11:10:34AM -0700, Junio C Hamano wrote:
>> * jt/path-filter-fix (2023-08-01) 7 commits
>>  - commit-graph: new filter ver. that fixes murmur3
>>  - repo-settings: introduce commitgraph.changedPathsVersion
>>  - t4216: test changed path filters with high bit paths
>>  - t/helper/test-read-graph: implement `bloom-filters` mode
>>  - bloom.h: make `load_bloom_filter_from_graph()` public
>>  - t/helper/test-read-graph.c: extract `dump_graph_info()`
>>  - gitformat-commit-graph: describe version 2 of BDAT
>>
>>  The Bloom filter used for path limited history traversal was broken
>>  on systems whose "char" is unsigned; update the implementation and
>>  bump the format version to 2.
>>
>>  Still under discussion.
>>  cf. <20230801185232.1457172-1-jonathantanmy@google.com>
>>  source: <cover.1690912539.git.jonathantanmy@google.com>
>
> I am happy with the most recent round, but I think that it is probably a
> little late in the cycle to be merging down such a large change.
>
> I wouldn't be opposed if you did so, but it may be worth waiting until
> we're on the other side of 2.42 so that other reviewers have a chance to

Since I hear some folks (not just Google) base their own edition of
Git on 'next', it probably is a good idea to merge it to 'next' and
have their users help find potential issues in it, as I agree that
the area it touches is important in the correctness department.  Of
course, it is important enough that the topic may very well want to
be cooked longer than the usual "for at least one calendar week" in
'next', so I tend to agree that in a first few batches after the
release may be the best time to have it graduate (if it turns out to
be OK).

Thanks.

