Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49EDC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759642078C
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BbGece3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgDCWNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:13:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55677 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgDCWNy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 18:13:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BD65B4022;
        Fri,  3 Apr 2020 18:13:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bvTJzUEzjZKwiglhnTi22LXaEhk=; b=BbGece
        3S5+xeb/vTqRmr9P8f2Fxzh93MqKTbjLdRQrisHIN2OP+qeduwpxZvI4lQW9/5HZ
        YMTGVUKFeHOYzZVDiLGRgyxHWPBRqwpUuRgX3CheC1seh+t7N6/0tgSz9IOStoVV
        Y8oGuePmFcGsUTMDoH+wpEBa64zuayGIKZC34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WBJIBmv6wHtrEvkxWNq9HnFDPv9HUjw9
        qHLTtWwW6Zev6XkWygPFRCo4IRwEcf05wp1dbIt4IMMK0jHpCfrnVTUUuQIAJff9
        jjvxGrwrSYlPTsfySUbJq46Sqi3XiseMfQLAg/01fin6YeWlnSnUsoQM7xR9o+FE
        6yqlosLV+7Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43212B4021;
        Fri,  3 Apr 2020 18:13:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 925D6B401D;
        Fri,  3 Apr 2020 18:13:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #10; Tue, 31)
References: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
        <20200403200418.GA58491@syl.local>
Date:   Fri, 03 Apr 2020 15:13:48 -0700
In-Reply-To: <20200403200418.GA58491@syl.local> (Taylor Blau's message of
        "Fri, 3 Apr 2020 14:04:18 -0600")
Message-ID: <xmqqmu7sxlnn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6510B124-75F8-11EA-8FBF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Mar 31, 2020 at 04:04:28PM -0700, Junio C Hamano wrote:
>> * tb/commit-graph-split-merge (2020-03-24) 3 commits
>>   (merged to 'next' on 2020-03-31 at 2183baf09c)
>>  + builtin/commit-graph.c: support '--input=graphed'
>>  + builtin/commit-graph.c: introduce '--input=<source>'
>>  + builtin/commit-graph.c: support '--split[=<strategy>]'
>>
>>  The code to write out the commit-graph has been taught a few
>>  options to control if the resulting graph chains should be merged
>>  or a single new incremental graph is created.
>>
>>  Will merge to 'master'.
>
> I know that this series has been cooking for a while (and that I've
> nagged you about merging it down to master), but I think I may ask you
> to temporarily eject it until I can send some more patches on top.

I'll mark in as "On hold" and throw it in the stalled bin ;-)
