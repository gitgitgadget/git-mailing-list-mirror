Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E96C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41369207FB
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t0geLyfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgERRbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:31:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63833 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:31:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E88049F3E;
        Mon, 18 May 2020 13:31:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PVfO12xUUfFI6r8tJTkb59pIIxM=; b=t0geLy
        fexqizwPwNkpGSJel2ynklHFbfdc5P4br+dVRGGvN73Xwb6dcfSOUaX2MZIN5b37
        fLciEWW6Tt2PbHx0slsj//Zme1zuqBF0DUSWMPZ1SSEvDSszOrl9+QvDtUl49Bmt
        1JolkLy1Mx1eULv3MbD0qEFMW5Ul2YFIQPVHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RpQXMnMSn1clbG0TUNuuVE3FyqL2lQom
        HFvK0vuthrhLo2KEp0trui+rhkQpilD/hLvQBKV11ujDK0SrYQoz5HI/QssgRglh
        Ob66GMRYaRP2xaKh6l0FKZ2xq9T8wnuDrjxpjHFE53azWLdZ8oABGWMBZrbKf/Fq
        N+MMiyhlEQ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F49749F3B;
        Mon, 18 May 2020 13:31:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5275149F39;
        Mon, 18 May 2020 13:31:05 -0400 (EDT)
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
Date:   Mon, 18 May 2020 10:31:04 -0700
In-Reply-To: <20200518172103.GA2110@spk-laptop> (Laurent Arnoud's message of
        "Mon, 18 May 2020 19:21:03 +0200")
Message-ID: <xmqqftbx40br.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A3C7A3C-992D-11EA-9734-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Laurent Arnoud <laurent@spkdev.net> writes:

> Subject: Re: [PATCH v6] diff: add config option relative

This is not a new problem with this round, but can you stop starting
a new iteration that is v6 with "Subject: Re: [PATCH v6]"? 

It is good to make v6 a reply to v6, but this is the *first* message
that begins v6 iteration, so it is easier to find it without "Re:"
prefix.

Thanks.
