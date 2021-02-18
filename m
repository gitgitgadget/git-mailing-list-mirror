Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE744C43381
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A89664EB8
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhBRSww (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:52:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62674 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhBRS0y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 13:26:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 163701082ED;
        Thu, 18 Feb 2021 13:26:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WBuENIvgboNcZkkup7gZRy0hvH0=; b=HDghxe
        xfUok4doaEyappwTsepgtmg36Fo8zCLFcUEx96rt6NGlB8oBDOQZ0xb5TQlLYrR3
        m7h2UtWqo0fYBY24HM57mfBK0nCWTPQMzTwjrHqTrRhwzqll7W4zJeSPsk2zLkH7
        gMHXdoBYnF645KMVyk1LqI4Tlwgjjmnw9ImvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g1bN4zJGxzp8+IaqW1t0kf909H03Z5B/
        2FUrs/NUhsijHcvcw+T99OUlWDAu/Vw5sMfDnUL3bCxxARRbhtHZiWWuWhuYPoSG
        i6/4ofEjLAqiP9/dt7nuS+Cdl9c/69n9ECb/7keQyFDYtrJNSfCV/toOh3mfCYv/
        Cs8Un2ttBaY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F4CC1082EC;
        Thu, 18 Feb 2021 13:26:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4477D1082EA;
        Thu, 18 Feb 2021 13:25:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2021, #03; Wed, 17)
References: <xmqqr1legm5v.fsf@gitster.g>
        <CAHd-oW4SxfAdJyDOdgqFsw2biUHHnU9wo78SLQMxs2VTeOar6Q@mail.gmail.com>
Date:   Thu, 18 Feb 2021 10:25:57 -0800
In-Reply-To: <CAHd-oW4SxfAdJyDOdgqFsw2biUHHnU9wo78SLQMxs2VTeOar6Q@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Thu, 18 Feb 2021 00:19:59
        -0300")
Message-ID: <xmqqmtw1grm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF851A76-7216-11EB-A04A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Hi, Junio
>
> On Wed, Feb 17, 2021 at 11:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * mt/grep-sparse-checkout (2021-02-09) 1 commit
>>  - grep: honor sparse-checkout on working tree searches
>>
>>  "git grep" has been tweaked to be limited to the sparse checkout
>>  paths.
>>
>>  Break out and fast-track bugfix from the remainder of the topic.
>>  cf. <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>
>
> Perhaps is this description outdated? I see that you have already
> picked up the bugfix [1] which was broken out from the previous
> version.
>
> [1]: https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br/

Indeed, what is queued and listed above is the updated one from Feb
9th.  Let's mark it for 'next'.

Thanks.
