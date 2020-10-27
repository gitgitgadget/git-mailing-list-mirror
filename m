Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04EDC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7159420760
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WlGjvdkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829026AbgJ0SqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:46:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50753 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828979AbgJ0Spm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 14:45:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D07F67FA4E;
        Tue, 27 Oct 2020 14:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YbmoqpadghoDP6w7A44cqKHvj8I=; b=WlGjvd
        klcKSzJp2gBEY5q8igd6LCp0xct83PGQheNLHP1zGO1XkeA60VKQrmeTgoJBDFR8
        gsMs0ssVt0amyHvyafCQJb/12N0VkXNZ2BGkJBrJSKNT6Po1QoOeBjE9r/Y2dB5K
        qmiDLgKj9Ukcze0DDTClFZ2qEcWgJln9OUatM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lbHVY96ANEC80sNzh+ivONF70X6QuEJb
        oLVIphNtbzcJ48/cBjPtT6GDhQF0Sa2NMTpa0IvurdciqyhKF/SOF4qycD3YQjXn
        pgGBGV4CNX6gZuunk/qGoQu8b8DVbM+PXlZPIa0DLzhXooThoEYTwHhroVVJwA9M
        OP46p+zxgvc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6B947FA4C;
        Tue, 27 Oct 2020 14:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F3F37FA4A;
        Tue, 27 Oct 2020 14:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation symlink restrictions for .git* files
References: <20201005071751.GA2290770@coredump.intra.peff.net>
        <20201005121609.GA2907272@coredump.intra.peff.net>
        <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
        <20201023081711.GB4012156@coredump.intra.peff.net>
        <8bb54778-507c-2e3f-d35a-5e32edb8bee7@iee.email>
        <20201026225300.GA23128@coredump.intra.peff.net>
        <xmqqo8kod0ms.fsf@gitster.c.googlers.com>
        <20201027072648.GG3005508@coredump.intra.peff.net>
Date:   Tue, 27 Oct 2020 11:45:36 -0700
In-Reply-To: <20201027072648.GG3005508@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 27 Oct 2020 03:26:48 -0400")
Message-ID: <xmqqk0vbcxtb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A98E5BC-1884-11EB-A11B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  DESCRIPTION
>>  -----------
>>  
>> -A `gitattributes` file is a simple text file that gives
>> -`attributes` to pathnames.
>> +A `gitattributes` file is a simple text file (it cannot be a
>> +symbolic link to anything) that gives `attributes` to pathnames.
>
> I worried that even a short mention like this would be distracting. Not
> because it's so long, but because it's right there in the very first
> sentence, and I really think this is a corner case that most people
> would not even think about.
>
> So it is helpful if you are looking for info on symlinks and these
> files, but probably clutter if you are looking for something else.
>
> I have to admit I don't feel all that strongly either way, though.

I don't, either, and as I said, I found that the placement of new
text was OK.


