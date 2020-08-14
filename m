Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B301C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B6820838
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="viaXrcRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHNQb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:31:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60783 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNQb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 12:31:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE8EFE547C;
        Fri, 14 Aug 2020 12:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=esWiG9nyI1jhgXiRliPEFAc+hPk=; b=viaXrc
        RXxiqJmjrTA4Ee/BodQWs8DqZEmgeJqLFb+edLDEtAwAqQOb33b/c5vdLakFnWir
        pkXyBOS750BI7w1t6mdkRYKK9EM6sxN+szdMUsYEqlPxgRTJAXa6EEXPW5jO5FNL
        U5I4y5FkNEScdknsYSg1JuY3iI8UrANDEfjyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jnuEO+fkmx6jDHI65fUbQsDnpL+fkax0
        hTznjL7eCfCMSXN1JsxitG7/ufBK5GStpDtKxSAllq6l3zEaURzpIIXFQu3Dfc6s
        9WxL0jAsRXKx29qeo+1kAHvL+ahjH7xw71mL3HrSAdFj9QgNR+61hIFYfJnRZsqM
        OLXoywMG388=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7519E547B;
        Fri, 14 Aug 2020 12:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0677BE5479;
        Fri, 14 Aug 2020 12:31:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] messages: avoid SHA-1 in end-user facing messages
References: <xmqqy2miyr0f.fsf@gitster.c.googlers.com>
        <ee61b773-91c0-4b30-1d5b-e941bba03867@gmail.com>
        <xmqqlfihzvhu.fsf@gitster.c.googlers.com>
        <CAPig+cTTr8VdzeaPewktdncvnTWHjieEnEPV+vbD=GVbK7zQNQ@mail.gmail.com>
        <xmqqd03tzley.fsf@gitster.c.googlers.com>
        <5e9805f4-81c0-39bc-463a-8c47872f6456@gmail.com>
Date:   Fri, 14 Aug 2020 09:31:22 -0700
In-Reply-To: <5e9805f4-81c0-39bc-463a-8c47872f6456@gmail.com> (Derrick
        Stolee's message of "Fri, 14 Aug 2020 08:21:38 -0400")
Message-ID: <xmqq8sehyysl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97E3D53E-DE4B-11EA-BA74-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> What about something as simple as:
>
> 	"Do not show object names of boundary commits (Default: off)"
>
> While this doesn't imply that the object name positions are filled with
> whitespace, that is just a formatting concern.

Nice.  I like messages that stick to simple and easy words.

Thanks.
