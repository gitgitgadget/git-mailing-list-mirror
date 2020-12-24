Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5997CC433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307C022286
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgLXWdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 17:33:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50109 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgLXWdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 17:33:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE46E92B87;
        Thu, 24 Dec 2020 17:32:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qg7l1uq4RZaM9IcET/rFnU7c6UM=; b=x80snE
        3o9g+I+mA9CTRtCKeQTnuoEFFT8ozjWOsHxxgPIsaha7eXuAvv9Kz8430b+cNNyE
        oHmym/tiwsuCl7PDxXalKeZH+DXWzb8F6BnbuHnT59oH1XZXjpA5C3dZZGymSyX7
        dYb5pIs6QTW05koh6cjavPAHHCTIEGHROHqzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gpXZPc/O8fYLm61F0OhWOXwNXmUGoP0v
        Nae2sxUVSGgUD3KhEgMa661FPIii3GxJhiDcBJb0kzzKdDcexoj/8wvPNnRuTHLe
        h4UXfSUtnSrwO30D79S/3ma8BwHfpArksWu9q25pP9Uoyax28usIc7clWNMyyhZY
        IXpmfbUgmQ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A546192B86;
        Thu, 24 Dec 2020 17:32:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28D3392B85;
        Thu, 24 Dec 2020 17:32:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
        <20201223045358.100754-2-felipe.contreras@gmail.com>
        <xmqqblekabof.fsf@gitster.c.googlers.com>
        <5fe352e3968f6_198be2083@natae.notmuch>
        <xmqqblek8e94.fsf@gitster.c.googlers.com>
        <5fe3dd62e12f8_7855a2081f@natae.notmuch>
        <xmqqv9cs3uxo.fsf@gitster.c.googlers.com>
        <5fe3f083f27cd_7855a20885@natae.notmuch>
        <xmqqim8r4tjh.fsf@gitster.c.googlers.com>
        <5fe4baed206cc_19c9208e8@natae.notmuch>
Date:   Thu, 24 Dec 2020 14:32:31 -0800
In-Reply-To: <5fe4baed206cc_19c9208e8@natae.notmuch> (Felipe Contreras's
        message of "Thu, 24 Dec 2020 09:59:41 -0600")
Message-ID: <xmqq4kka3ke8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9A2992E-4637-11EB-A424-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> >> Yup, I already mentioned UI mistake so you do not have to repeat
>> >
>> > You said it was a UI mistake, not me. I am a different mind than yours.
>> 
>> Yes, but the point is that I do not need to nor particularly want to
>> hear your opinion on the behaviour of "git merge-file".
>
>> I know (and others reading the thread on the list also know) that the
>> exit code of the command is misdesigned already.
>
> Unless you can read minds, you don't know that.

Actually I do, because they heard from me already ;-).  If this were
the case where our messages crossed, perhaps, but in this case yours
was a response to my message.

>> Again, please realize that on list discussion is a team effort to
>> come up together a better design of a shared solution.
>
> Which is why agreement in a team with different minds and different
> viewpoints is important.

It is not like opinions on all points are important.  Whether the
exit code from merge-file is or is not a UI mistake does NOT have
any influence on what we were discussing.  My opinion is that exit
code from merge-file is a UI mistake, but even if you disagree with
that, that would not change the conclusion we already reached that
the code should ignore its exit status, like you originally wrote.

I am already trying to ignore your opinions on things that do not
matter in the context of this project, as you told me earlier ;-)
But just like patches, messages are written only once but read by
many people, so I'd always aim for reducing noise at the source.

Anyway, happy holidays and pleasant new year to you and to
everybody.
