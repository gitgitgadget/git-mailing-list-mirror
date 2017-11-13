Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1665C201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 01:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbdKMBks (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 20:40:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58675 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751753AbdKMBkq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 20:40:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA2DA955DE;
        Sun, 12 Nov 2017 20:40:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o1YllDLinJonASVNkBXF/s9Uwa4=; b=h3z5lE
        vT2HZSffLhciegnP/QtnTCBRniVd0X839i1YS5sitmyBFFbI+VaZme2Il/k+yYyC
        eHcblSQP2EoLm07RMecuIAbf5pPHNevKIJ2/2mcweYNIZzv4Oohb8ejnUc+ECXnR
        yd7iNhRRkcYHwapMr5JZCff0+LH6QtD8OMXRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h6ciAnTrCwGY1CyX9SGmR4+zE/NQIYIS
        F82pUXsH5FvrrBphq6z43iXmkzGyfEOjsxHJBVbMbI3vWg8qvsgtFLdowWJ39EkN
        Lqg+GNJwPk6IGvInt3noQ8C1dy7tV45kViXgxnZxPctGbDKP5e7dtWXwJPDg+Wwx
        qknDyFyC+JU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0C1A955DD;
        Sun, 12 Nov 2017 20:40:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40A3E955DB;
        Sun, 12 Nov 2017 20:40:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christian Couder <christian.couder@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Subject: Re: should "git bisect" support "git bisect next?"
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
        <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
        <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com>
        <20171111194616.a2hl4dwz5cycuzdh@thunk.org>
        <xmqqvaigclv0.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3DzdTf6-yZVwMvc1=nP+ejrinjvE8wAPhdaHoOQOmpGw@mail.gmail.com>
        <20171112184252.vpasjhfkt63izrun@thunk.org>
Date:   Mon, 13 Nov 2017 10:40:44 +0900
In-Reply-To: <20171112184252.vpasjhfkt63izrun@thunk.org> (Theodore Ts'o's
        message of "Sun, 12 Nov 2017 13:42:52 -0500")
Message-ID: <xmqqpo8narc3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAC10F42-C813-11E7-9151-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> On Sun, Nov 12, 2017 at 03:21:57PM +0100, Christian Couder wrote:
>> 
>> Yeah I agree that it might be something interesting for the user to do.
>> But in this case the sequence in which you give the good and the bad
>> commits is not important.
>> Only the last bad commit and the set of good commits that were given
>> are important.
>
> Is it really true that of the bad commits, only the last one is significant?
>
> Suppose we have a git tree that looks like this:
>
>           *---*---*---*---*---*---M2---*---B1
>           |                        |
>   G1--*--D1---*---*---*---B2-\     |
>           |                   \    /
>           *---*---*---B3--*---M1--/
>
> If we know that commits B2 and B3 are bad, if we assume that all
> commits before the "bad" commit are good, all commits after the "bad"
> commit are bad, can we not deduce that commit D1 should also be "bad"?

You are correct.  Christian fell into an understandable and common
confusion.  It is true that we only maintain one significant bad
(i.e. the breakage that is known-ealiest so far), but that oldest
bad is the result of the bisection taking into account all the 'bad'
we have got in sequence so far, not necessarily the same as, and
hopefully way better than, the last bad the user gave from the
command line.  In your topology, "git bisect log" would contain "bad
B1", "bad B2", and "bad B3", and when the earlier session that
produced that log saw these three bad commits, it would have marked
D1 as the known-earliest bad one.

Taking the last-given bad B3 is suboptimal than that.
