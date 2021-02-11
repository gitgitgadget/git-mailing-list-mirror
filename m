Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68DDC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 22:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F8864E3E
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 22:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhBKWpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:45:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52098 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhBKWpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 17:45:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B91D9ACF68;
        Thu, 11 Feb 2021 17:44:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pVeciRr7uFimXD1KG1H5EhesPQ4=; b=bIAXr4
        H96WMXivW6JoylfXHZpB26TB+rgAXUewVMHSNpvq/U1OWf1719ICxQ14eVp96RYI
        6vfuLnuIVLuDoibdm6U8bmL58QJf8/mFP7tEIgj787Tyf7BRpm172YiG16Tok8Vw
        lE3qpM25UiNf8pbkQRZZQgTTP8tGRMgolFWxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lklak4qwqz+OjGwyXwY4+/mJd1dCSbZA
        xU1ZxD0onvmkKTHqfWDA1NM1KQiuynfvU10DvTEteveiHFo2k2beXFMexEVOEr24
        2XjO5Ip1Ls6ASbZfkvqsmGWnJjTp7b1Q0YIXzCA/0N6z283wyM2yBHNjXGR26G0G
        bPYU+wRw11I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B002DACF67;
        Thu, 11 Feb 2021 17:44:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44A60ACF66;
        Thu, 11 Feb 2021 17:44:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/11][Outreachy] Improve the 'fixup [-C | -c]' in
 interactive rebase
References: <20210207181439.1178-1-charvi077@gmail.com>
        <20210210113650.19715-1-charvi077@gmail.com>
        <xmqqeehmy129.fsf@gitster.c.googlers.com>
        <CAPSFM5fWmTXRHKseqXwZyE6MOVccR2OPSs5kyEu-k1K1p01EPw@mail.gmail.com>
Date:   Thu, 11 Feb 2021 14:44:52 -0800
In-Reply-To: <CAPSFM5fWmTXRHKseqXwZyE6MOVccR2OPSs5kyEu-k1K1p01EPw@mail.gmail.com>
        (Charvi Mendiratta's message of "Fri, 12 Feb 2021 03:56:34 +0530")
Message-ID: <xmqqblcqw7ff.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C19D7BC0-6CBA-11EB-A212-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> On Thu, 11 Feb 2021 at 22:49, Junio C Hamano <gitster@pobox.com> wrote:
>>[...]
>> Thanks.  Looking good.  Unless there is any other nits, let's
>> declare victory and merge the two topics down to 'next' and then to
>> 'master' for the next release?
>
> Thanks for confirming. Here in these two topics  `fixup -C` works with
> "amend!" commit in interactive rebase and we are still working on some
> improvements on the new patch series ( to be sent)  that implements
> "amend! " commit . So I think to rebase that  work also on this topic,
> to make project history clear and avoid the confusion ( it also
> improves the same test script in this topic).
>
> So maybe please wait for that, before merging to master.

Sorry, but I do not quite understand.

Aren't you talking about adding even more features to what is
already there in the cm/rebase-i plus cm/rebase-i-updates topics?
Or are you saying that what is in these two topics is still buggy
and we need fixes to it before we can give them to the general
public?

I had an impression that it was the former, and if that is the case,
then moving them to 'next' and then to 'master', regardless of the
follow-up changes, would be a useful thing to do.  Of course, if it
is the latter, i.e. these two topics make "git rebase -i" worse by
introducing an unfinished feature that is not yet usable and/or
buggy without further work, yes, it would be prudent to wait merging
the cm/rebase-i-updates topic to 'next' and replace it with a fixed
version.

But then you'd be stopping me from merging the "updates" one to
'next', not to 'master'.

