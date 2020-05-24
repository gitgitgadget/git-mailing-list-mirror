Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1008AC433DF
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CB820787
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8Psz2DV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbgEXQcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 12:32:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64819 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgEXQcr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 12:32:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7223E65FEB;
        Sun, 24 May 2020 12:32:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tB1o2/YQ0uYv
        BO2KOYW7KAHBx5E=; b=Y8Psz2DVi3ykgCB1hCEmPCHiESnq6V8iA3K6r5tZyGxP
        q8h86nqHbg3r4i075/riftdUfQ+ZAjJnv9rdAQOSclLmN5HkzvqMXB4I1q4jsnf2
        pxCc3Qr7PXLLf5L31caPnvkIryA9A6d7nZmLmkP2kcahm6gvzEsZ1MaE4AHRSys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QyN7i+
        k8iTj6pu+DU+vnrJeWrmY9Mu783qKrEDxO5yODjajRwTVUirEcpEIs7ylRswD0kE
        G7F2j1NLZ0RxYwDYSl0F2qkyAHBjr1iZl/7OB/DoFoz3a3rO7ghaSbN7Wjr3np1Z
        6Wce+Z1CrdoWUUSCypmales0frEoxF/iMhua0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69F2465FEA;
        Sun, 24 May 2020 12:32:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E85E865FE9;
        Sun, 24 May 2020 12:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] rebase -i: support --ignore-date
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200521101455.63484-1-phillip.wood123@gmail.com>
        <20200521101455.63484-5-phillip.wood123@gmail.com>
        <20200523123025.GA20683@danh.dev>
        <bc6bc4d4-79cb-f788-deca-41a3735fcaae@gmail.com>
        <20200523155203.GA10163@danh.dev>
Date:   Sun, 24 May 2020 09:32:44 -0700
In-Reply-To: <20200523155203.GA10163@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Sat, 23 May 2020 22:52:03 +0700")
Message-ID: <xmqqy2phpa37.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 324100DA-9DDC-11EA-B5BC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> > I think there're some grep out there considers file doesn't end with
>> > newline as non-text files.
>>=20
>> Yes it would be better to print the newline, thanks
>>
>> Junio - are you happy to fix this up (assuming there are no other issu=
es) or
>> do you want a re-roll?
>
> There're 11 invocation of git-log with "--pretty=3Dformat",
> in 2/5 and 4/5
>
> I think it's worth to have a re-roll to avoid mistake.

It would be appropriate to send "[PATCH v3 6/5] fixup! ..." if the
fix needs to be made only to a single step.  It would be the least
error-prone approach.

Thanks.


