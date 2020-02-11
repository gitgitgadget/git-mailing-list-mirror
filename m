Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67132C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C024206D6
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v/r2y50Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgBKU4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:56:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53111 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgBKU4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 15:56:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B137B9A2DA;
        Tue, 11 Feb 2020 15:56:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g3po/3nUqO59Jw1JBD540RM+Ouk=; b=v/r2y5
        0YNULPEsfRx5zV+FoJ9gf4o6gzZt3Z/mR7VoCwozKCs+22NBFa5KUYL31H9Eu14O
        RX6Pn9rLAvET5stRQBp9wjIfrdue4ji4N4T0Bnx2D1KCwhb1kPFrPw5pI+rgcI8l
        kNxyHjkf15OVcWGmpTKCL08jxCrcK5coLbTJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a/AwskUhe278mds5zPocV4NVhvjEtn7B
        R937eXC54i5AfqQlCnTJu/lu+OoHMfLnJ6jnv1+oktX+gVftOt7xy4KQ4qQZjagy
        rjReVP9uzOSQWMIb/whatt9ellQYC8pU97f54W+54XakqlcCubNzS4PEw+CDA3ya
        g+Aq4T2r/fU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A92F69A2D8;
        Tue, 11 Feb 2020 15:56:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC1BC9A2D4;
        Tue, 11 Feb 2020 15:56:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2020, #02; Mon, 10)
References: <xmqqimkexeed.fsf@gitster-ct.c.googlers.com>
        <819852c9-68dc-11e3-d81d-ddd216953d72@gmail.com>
Date:   Tue, 11 Feb 2020 12:56:31 -0800
In-Reply-To: <819852c9-68dc-11e3-d81d-ddd216953d72@gmail.com> (Garima Singh's
        message of "Tue, 11 Feb 2020 15:04:21 -0500")
Message-ID: <xmqqtv3wvo5c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC8820B6-4D10-11EA-BEDA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:

> On 2/10/2020 5:31 PM, Junio C Hamano wrote:
>
>> * gs/commit-graph-path-filter (2020-02-06) 11 commits
>>  - commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
>>  - revision.c: use Bloom filters to speed up path based revision walks
>>  - commit-graph: add --changed-paths option to write subcommand
>>  - commit-graph: reuse existing Bloom filters during write.
>>  - commit-graph: write Bloom filters to commit graph file
>>  - commit-graph: examine commits by generation number
>>  - commit-graph: examine changed-path objects in pack order
>>  - commit-graph: compute Bloom filters for changed paths
>>  - diff: halt tree-diff early after max_changes
>>  - bloom: core Bloom filter implementation for changed paths
>>  - commit-graph: use MAX_NUM_CHUNKS
>> 
>>  Introduce an extension to the commit-graph to make it efficient to
>>  check for the paths that were modified at each commit using Bloom
>>  filters.
>> 
>>  Breakage due to byte-order dependency reported.
>> 
>
> Hey Junio! 
>
> We fixed the byte-order dependency bug in the patch I just sent out 
> here: 
>  https://lore.kernel.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmail.com/
>
> I am squashing this patch into the appropriate commits in v3, which I will 
> send out after people have had a chance to complete their review of v2. 
>
> Could you please apply that patch on top of the pu branch 
> gs/commit-graph-path-filter so that it also has the fix? 

Can you fix that in place?  The topic is not in 'next' yet, so we do
not have to go incremental and apply an "oops, this on top will fix
all the gotchas in earlier steps" band-aid.

Thanks.
