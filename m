Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA3F2022D
	for <e@80x24.org>; Sun, 20 Nov 2016 17:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932127AbcKTRdE (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 12:33:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53357 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932111AbcKTRdB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 12:33:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E36D54C853;
        Sun, 20 Nov 2016 12:32:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hocoaa26kWd0mWAbS8W7knU4y0E=; b=oKZHSW
        Y7OMIqD5Ij037CjhO1ihPouKkASe0EG2bmYmehUexlY290mAL0bzWQIMr55fs0s5
        HGjCZf1q0MsEurMy32JTz8tRYp3qzJtoCThqZoVnoALqf3tWDRklxE9kNmACC4Sw
        +bOfAuHIDRHf6S9KnGEXdHt/C1+7SWXSxmRSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n3/JG+zLeJVjjKBUXbPSena/OO8hDRxZ
        mUY6rbanUoNhu4dK1cVrAeaq1COBUPm2Ql4xGIuvnchL8+4RiY9jxefnN10N7H6U
        ZqgJ64+y6rUsIGNMgSFuLcFnaevg+Z69Sn/bVuzZ6mHJijoIiIRBS0qoHhG9nLh8
        ZSypQfk2eXw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB6374C851;
        Sun, 20 Nov 2016 12:32:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59A374C850;
        Sun, 20 Nov 2016 12:32:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for ref printing atoms
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-14-Karthik.188@gmail.com>
        <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
        <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
        <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
        <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
        <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
        <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
        <20d067ef-9e2c-0d1f-f81a-06c154e95e4f@gmail.com>
        <CAOLa=ZRf+vPOPK=ovP7JmJ52qdgwuqkpGH4UfP=+caQeyu9Ucw@mail.gmail.com>
Date:   Sun, 20 Nov 2016 09:32:58 -0800
In-Reply-To: <CAOLa=ZRf+vPOPK=ovP7JmJ52qdgwuqkpGH4UfP=+caQeyu9Ucw@mail.gmail.com>
        (Karthik Nayak's message of "Sun, 20 Nov 2016 20:46:03 +0530")
Message-ID: <xmqq4m32kqet.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 617C1FB0-AF47-11E6-B9E0-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> We could have lstrip and rstrip as you suggested and perhaps make it work
> together too. But I see this going off the scope of this series. Maybe
> I'll follow up
> with another series introducing these features. Since we can currently
> make do with
> 'strip=2' I'll drop this patch from v8 of this series and pursue this
> idea after this.

My primary point was that if we know we want to add "rstrip" later
and still decide not to add it right now, it is OK, but we will
regret it if we named the one we are going to add right now "strip".
That will mean that future users, when "rstrip" is introduced, will
end up having to choose between "strip" and "rstrip" (as opposed to
"lstrip" and "rstrip"), wondering why left-variant is more important
and named without left/right prefix.

