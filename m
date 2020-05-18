Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A98FC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E27420826
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j2FXVrVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgERRc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:32:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60831 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgERRc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:32:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71A75BEDFF;
        Mon, 18 May 2020 13:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aH9tAPrXsJrgBr3bFHE4ilF/Mks=; b=j2FXVr
        VCQNV8LZwQvUWhnCWQCTuRDFk3vTKZY/rFGVrimeqWXibAfA5ynhBoWaz34fFJFM
        EGyu8hCgAfolmkQlmBA1qGiDIYz+DYRChR7PDUl5wPzlaGcbDA3lpC+yiqnjqi2/
        tHJOIi4hz+cG4bQuRjSd/c7IlWKoY4TiYAvDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m7t/YWHMsK5utQTE0SUYrAkkkU/VvAyv
        zgSfKMDP7dcLw+A7GWyhBU2Ms04s2KXoaYwhqwVnIVJmP7ipxOO6exNqU/cRvVNN
        Go/t6pF5RxCVWCYyfHdquO4qu/fUWOnZOdLAZYArLX4FbNAKK0Jloixy5JRB/aZD
        5lKLefDZudc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6953EBEDFE;
        Mon, 18 May 2020 13:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A585CBEDFD;
        Mon, 18 May 2020 13:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] commit-slab-decl.h: fix define guards
References: <20200516172837.2872-1-abhishekkumar8222@gmail.com>
        <20200518143023.14217-1-abhishekkumar8222@gmail.com>
        <xmqqsgfx415z.fsf@gitster.c.googlers.com>
        <CAPig+cTFp0rHkYUwxvRJUWLBsV8gt-qL=UNVBB=+oTCkpe0oyA@mail.gmail.com>
Date:   Mon, 18 May 2020 10:32:49 -0700
In-Reply-To: <CAPig+cTFp0rHkYUwxvRJUWLBsV8gt-qL=UNVBB=+oTCkpe0oyA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 18 May 2020 13:29:08 -0400")
Message-ID: <xmqqblml408u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 998CE6B8-992D-11EA-A0EE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 18, 2020 at 1:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>> Subject: [PATCH] commit-slab-decl.h: update include guard
>>
>> When a9f1f1f9f8 ("commit-slab.h: code split", 2018-05-19) split
>> commit-slab.h into commit-slab-decl.h and commit-slab-impl.h header
>> files, commit-slab-decl.h were left use "COMMIT_SLAB_HDR_H", while
>
> s/were left use/was left using/

Thanks, I meant to say "left to use" actually.



>> commit-slab-impl.h gained its own macro, "COMMIT_SLAB_IMPL_H".
>>
>> As these two files use different include guards, there is nothing
>> broken, but let's update commit-slab-decl.h to match the convention
>> to name the include guard after the filename.
>>
>> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
