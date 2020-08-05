Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76EC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890D22250E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="szhAbQyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHEXou (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:44:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52331 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHEXou (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 19:44:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9E79E76D6;
        Wed,  5 Aug 2020 19:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+F6BWowi8nDBSSYyhTg6guLR6/c=; b=szhAbQ
        yqo7+3yTBXAbGJ+ol5mWzZwLefqveUVPNcNHH8VUTkIViWyv0Fslr/o4Baaws+gz
        Csu+buFrGW7RQODReP6buQZGjs168h/cyhcrzfPEgKT0LyfvVWg2iFbiH/7/LA3p
        0UT9mrqL5COkK7GM1q0JwfZ704Ug0pFHcviHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a1dVJJuHODTvVjM/01MqajlAQOFVKZWD
        +7LqoTNaQlSFGa+9f+yAx2sk36upLsxFriqFv/QTLkULp13UMi/n3jUvpnmhrTuE
        Vp5Y33QX8IyHl6jHDYc1oH3f6aoRyDDRrRWRrHp30uXnig/b35IfdWmhI0WYKJi4
        bJcg/MFdOYs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2381E76D5;
        Wed,  5 Aug 2020 19:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B2A6E76D4;
        Wed,  5 Aug 2020 19:44:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  3/3] t/t4013: add test for --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-4-sorganov@gmail.com>
        <xmqq3650n2rc.fsf@gitster.c.googlers.com> <87lfisk915.fsf@osv.gnss.ru>
        <xmqqy2msllz0.fsf@gitster.c.googlers.com>
Date:   Wed, 05 Aug 2020 16:44:45 -0700
In-Reply-To: <xmqqy2msllz0.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 05 Aug 2020 16:19:31 -0700")
Message-ID: <xmqqtuxglksy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A55F3154-D775-11EA-B639-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Dunno, why original Jeff series didn't need 
>>
>>      log --first-parent --no-diff-merges -p master
>>
>> then?
>
> Who said it didn't need it?

To elaborate a bit more, we are all humans, and even reviewers
should be given the second chance to suggest improvements to things
that can use them, which s/he previously missed.  If we keep saying
"you say this is wrong, but the other guy did the same wrong thing
last week", we can never make the world better.

