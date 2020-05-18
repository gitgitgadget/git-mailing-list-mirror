Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C041CC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B26C20826
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A+msMn4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgERRdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:33:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62647 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgERRdn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:33:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94EF6C84E2;
        Mon, 18 May 2020 13:33:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yj+SZ6Iz9n7bM1DzxicR5Z/QFFk=; b=A+msMn
        4KMhqCDqtVAvCY68A7jzEN/A7awV4mCvNI7pH10Pk+higKFfltfkZG+WidOtHt0Z
        qUFQ1B10YT3XSLUl6fOZwQ3kcg72PgfgIb6lTL89rLdZArqG5ytLOlijrZbPJulM
        Mu9yqsRcWSFRaEpWYvQQYbIGkwLEiHmZZMan8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qwf7k4VpCC/XmsIuYWSfAZpZrfu+fq4z
        /RZ/S31yM6PYG/mD475duEpsufPeRJ7e2RTTan3XkSFJog89RAdJhGNG+Fcbg0UW
        PErIsf+dbizP/78jtyxCtz0lNGL5doyPbKNamK+VsJcuBld8EtrQ+jLYv0WvhRIU
        EdjOwqfjrX8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C3BDC84E1;
        Mon, 18 May 2020 13:33:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D4081C84E0;
        Mon, 18 May 2020 13:33:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v6] diff: add config option relative
References: <20200515233130.GC6362@camp.crustytoothpaste.net>
        <xmqq1rnk923o.fsf@gitster.c.googlers.com>
        <20200516173828.GB34961@spk-laptop>
        <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
        <20200516194033.GA2252@spk-laptop> <20200517021452.GA2114@danh.dev>
        <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
        <20200518094021.GA2069@spk-laptop> <20200518135656.GB1980@danh.dev>
        <xmqqzha541la.fsf@gitster.c.googlers.com>
        <20200518172103.GA2110@spk-laptop>
        <xmqqftbx40br.fsf@gitster.c.googlers.com>
Date:   Mon, 18 May 2020 10:33:37 -0700
In-Reply-To: <xmqqftbx40br.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 18 May 2020 10:31:04 -0700")
Message-ID: <xmqq7dx9407i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5AD7BF0-992D-11EA-B880-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Laurent Arnoud <laurent@spkdev.net> writes:
>
>> Subject: Re: [PATCH v6] diff: add config option relative
>
> This is not a new problem with this round, but can you stop starting
> a new iteration that is v6 with "Subject: Re: [PATCH v6]"? 
>
> It is good to make v6 a reply to v6, but this is the *first* message

Sorry, "make v6 a reply to v5" is what I meant X-<.

> that begins v6 iteration, so it is easier to find it without "Re:"
> prefix.
>
> Thanks.
