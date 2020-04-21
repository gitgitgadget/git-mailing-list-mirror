Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D003C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF2A2072D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jeABwXkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDUU54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:57:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59901 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUU5z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:57:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C12E4B881B;
        Tue, 21 Apr 2020 16:57:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aJtBV2skjKcCWVO1x2oh3LVG3k0=; b=jeABwX
        kAyO56yDP8eSge+eyOKDwBbcbIpaD8KcJDL9tBdqb1GNBojM1VqDFPDdIXCzGyCy
        owoivYOb6ASwVBwymssflDOly0M8JnU9q1LoimKA5BnyOwEihLWKP68sZ9jxulQq
        Kw0K+OzJrOS1SQEAOlH2sAFT8FJV4tPYx00wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iln/V0FzltklpW5/QGx1dZrRDueQZWvN
        xll2q9rbl/UXcLFyR/vqGhrSCn4GaQsJ+aZCo0xKmG0QiAO6IJUZ8XPEtVmcDC6C
        YAS4ulS1Bjq+8EDlo7VZKVgQ6qKTkLnQRJb5iXfjUmvOripl3VJm+WrCrTbAM/DP
        Q91gdFVjrVA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8DCCB881A;
        Tue, 21 Apr 2020 16:57:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E2B1B8817;
        Tue, 21 Apr 2020 16:57:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Shourya Shukla'" <shouryashukla.oo@gmail.com>,
        <git@vger.kernel.org>, <sandals@crustytoothpaste.net>,
        "'Derrick Stolee'" <dstolee@microsoft.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Christian Couder'" <christian.couder@gmail.com>
Subject: Re: [PATCH v3 3/4] gitfaq: shallow cloning a repository
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
        <20200421131223.29337-4-shouryashukla.oo@gmail.com>
        <xmqqy2qomwwl.fsf@gitster.c.googlers.com>
        <011001d6181d$97301fc0$c5905f40$@nexbridge.com>
Date:   Tue, 21 Apr 2020 13:57:49 -0700
In-Reply-To: <011001d6181d$97301fc0$c5905f40$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 21 Apr 2020 16:43:55 -0400")
Message-ID: <xmqq1rogmu9e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C366335C-8412-11EA-B2BB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> I have a feeling that --depth/shallow is deprecated/frowned upon these
> days
>> and more people recommend partial/blob-less clones instead (a few random
>> people added to Cc: to see if they want to say something here).
>
> I rather hate to chime in as a dissenting opinion,...

Oh, don't hate anything.  It is greatly appreciated so that we can
cover "in such and such use case, this solution is good" variants
for similarly-sounding-but-fundamentally-different classes of
problems.  We do not want to give a spinal-reflex answer of "use
shallow" (or "use partial", for that matter) to "too large a repo"
question without contexts that guide the readers to a better choice.

That is where a well-organized FAQ list shines.

Thanks.
