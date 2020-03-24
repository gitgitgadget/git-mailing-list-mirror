Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134EEC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 21:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51622078A
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V+OcXVB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCXVNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:13:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58535 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgCXVNq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 17:13:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6990BCDAE6;
        Tue, 24 Mar 2020 17:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8eUpXjrCAG/PjBNXsPd2GgDtA5s=; b=V+OcXV
        B6HOe7nylWCfaD+bgoOJtByg93ZxuTbCVIyt4H7GBsGhkVjqElSbEKvWQUIoZDzE
        ibw0FBvCGu/YhDpX80VBkeuC6dYbuszw+hhKkuW9EZbUr/kpPd7QZ7OOqnlbPtFH
        jnnD1rsQTu62OAcjHK1uklOyl50U/cTHRYrT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AeqLzmr3HgAO6wj+kYsE6vzc3g9PJDTw
        11vf46ubXFYFp/K6TE4Pqp9HSUJZXSQvmhy9/vH4jacH1sdJvMggeUoesvpi1Yun
        7CzBRujuhBGLFTzUAdODM0LpjfBHZMf5w/e4J10+Ryp+VdQmx8rptNCplvdi1tDl
        lMcyC2ck+w4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59290CDAE5;
        Tue, 24 Mar 2020 17:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5723CCDAE4;
        Tue, 24 Mar 2020 17:13:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC][GSoC] Implement Generation Number v2
References: <20200322093526.GA4718@Abhishek-Arch> <86eetkrw8p.fsf@gmail.com>
        <20200323042517.GA1258@Abhishek-Arch>
        <xmqq369z7i1b.fsf@gitster.c.googlers.com> <86mu87qj92.fsf@gmail.com>
        <xmqqtv2f5a6x.fsf@gitster.c.googlers.com> <86k139ahb7.fsf@gmail.com>
Date:   Tue, 24 Mar 2020 14:13:36 -0700
In-Reply-To: <86k139ahb7.fsf@gmail.com> (Jakub Narebski's message of "Tue, 24
        Mar 2020 16:44:28 +0100")
Message-ID: <xmqq8sjp1mnz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5476D0B4-6E14-11EA-ACE7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> About moving commit data with generation number v2 to "CDA2" chunk: if
>>> "CDAT" chunk is missing then (I think) old Git would simply not use
>>> commit-graph file at all; it may crash, but I don't think so.  If "CDAT"
>>> chunk has zero length... I don't know what would happen then, possibly
>>> also old Git would simply not use commit-graph data at all.
>>
>> Yeah, if it makes it crash, then we cannot use that "missing CDAT"
>> approach.
>
> I have not tested this, but from reading the code it looks like "missing
> CDAT" makes Git fail softly -- it would return NULL for the
> commit-graph, and thus not use commit-graph data at all... which might
> be too high a price (too high performance penalty for old Git).

Oh, that would not make me worried an iota.  If anything, it
encourages adoption of the new version ;-) As long as the
correctness is not violated, it is fine as a fallback behaviour.

> On the other hand computing generation number v1 (topological level) and
> generation number v2 ([monotonic] offset for corrected commit date)
> should not be much more costly than calculating single generation
> number, assuming that most of the cost is walking the commit graph.  But
> this would need benchmarking.

Good point.  If we can do so cheaply enough, there is no reason to
omit the v1 data from the file and stuff placeholder 0 in these
fields.

> Also, as Stolee wrote, with generation number v2 in separate chunk we
> have commit data not together, but split into two areas.

Yes, that is a problem.  The "empty CDAT with everything not just
generation numbers in CDA2" approach would help us move forward with
v2, while not harming older version of Git.  Just like pack bitmap,
commit-graph is designed to be a local optimization matter, and
worrying about older Git not being able to use the optimization
hints left by newer version of Git is not useful.  Quite honestly,
the only two things we should make sure are that the repository does
not appear corrupt and unusable by current Git when it has graph
files with new generation number scheme, and that manipulations by
current Git of a repository with newer graph files will not corrupt
the repository for current or newer Git.

Thanks.
