Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A781E1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 01:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKMBrq (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 20:47:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59005 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKMBrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 20:47:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38D1EA3DB4;
        Tue, 12 Nov 2019 20:47:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6PHf+uonhWxwWvvjgDjTM7LRDmI=; b=Tlo0ra
        OHshdZzqNQKJRbYYhEv8FkeSnToj5ppcyWfcASzcEqy170ZoA5sk9QS1VOKkEQ6r
        dkEerEreyBUtp8YF5nReUDEadHbgEiAqZOvQmmUVmyDHD8PpMhKqtk3qFTbx4RRq
        k1MKNBo9Wy/G3bvRI5eaDyvLK+xSNQ8xT01ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZNHS8aJxXFKaU6naWktHwdysx78DKPCJ
        Uh/ylN4mDLNEBHkrrixtJuuI0Xnf1ktbTE7ed5sB0Y5/CyZjzNkbmAutCT3AL2Lq
        5kApicXdPk2QFdk1MwmjCJ0wT6cXKIOx7PUK8+quTgLMs8DfXYomby5jYivDX8wN
        m4VCdcKMgBM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 308A0A3DB3;
        Tue, 12 Nov 2019 20:47:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0C9F8A3DB2;
        Tue, 12 Nov 2019 20:47:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Change behavior of git add --patch on newly added file?
References: <20191108225035.GA60198@google.com>
        <xmqq5zjtn07v.fsf@gitster-ct.c.googlers.com>
        <20191112184720.GB38770@google.com>
Date:   Wed, 13 Nov 2019 10:47:37 +0900
In-Reply-To: <20191112184720.GB38770@google.com> (Emily Shaffer's message of
        "Tue, 12 Nov 2019 10:47:20 -0800")
Message-ID: <xmqqv9roczt2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9389FE72-05B7-11EA-8366-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> Patches welcome, but you may want to check with Dscho as there is an
>> effort going on to reimplement the entire "add -i" machinery in C.
>
> Ah, this is a compelling point. I imagine the landscape will be fairly
> different when that effort is finished.
>
>
> From the replies, it sounds like it's a favorable change, but it makes
> sense to wait on it considering the refactor to use C. Thanks, all.

Peff's "how would you tell between genuinely untracked ones and
those you would want to add" and "should 'add -p' with no pathspec
attempt to 'add -N' everything under the sun?" are both quite valid
points.  I already raised "'add -N && add -p' would give you a
single hunk that adds everything. Are you willing to manually split,
and how well would it work?" in a separate message.  These design
issues can be resolved without coding, and should be resolved before
you start randomly typing ;-)

Thanks.
