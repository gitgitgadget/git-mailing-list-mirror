Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A542C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1524520754
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W+iAlc8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgCUWzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:55:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54450 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCUWzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 18:55:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7164154A71;
        Sat, 21 Mar 2020 18:55:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N+BIMeJqsfrz7wQHzXUWppI2fQk=; b=W+iAlc
        8Ej5rnlOo1EkAuSzz1/wq9dKIfdaZ5dSdABBh/qyd8LGspT7MhOzHALHnlxd3doB
        hNSgqkyHKyoZNb6HM74bnV2s/utWS8OHJnkUNbfzpAEZC5McsE4zLxZbR7LmQTgU
        MQen3o/Is1D4xbSEkW7xEsyJNrQTS91bvRT9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yiVeZ2ykEbpJ6T27zWEfX8KegFJE51B/
        LeY6qR/at782Ly9EvT+cKETqr2rToc/Cw/QD/v847ujLXbHwoDSTRqG4QeyL6dYO
        2czVY25wrg9ATw9a+SCYxyNHlUmPUgMfF19YbvX3yzRsDnW/m0OUZoSelqR/J434
        qWy17pyf1cw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E71F554A6F;
        Sat, 21 Mar 2020 18:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 129CA54A6E;
        Sat, 21 Mar 2020 18:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: macOS builds having trouble at travis-ci.org?
References: <xmqqlfnt8k47.fsf@gitster.c.googlers.com>
        <CAHd-oW7B+Q+hGfAkbu8PYjhQ+-81u9L-swk-iHzasHuJOh5GLA@mail.gmail.com>
Date:   Sat, 21 Mar 2020 15:54:59 -0700
In-Reply-To: <CAHd-oW7B+Q+hGfAkbu8PYjhQ+-81u9L-swk-iHzasHuJOh5GLA@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Sat, 21 Mar 2020 19:35:53
        -0300")
Message-ID: <xmqqd0958gjg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE375FF6-6BC6-11EA-BEA3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> On Sat, Mar 21, 2020 at 6:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Starting sometime yeserday, it appears that macOS builds of our
>> branches at travis-ci.org are having trouble in an undiagnosable
>> way.  All you see on their webpage is a helpful message "An error
>> occurred while generating the build script." and nothing else.
>
> It might be a problem at the travis-ci infrastructure. They reported
> an issue with macOS builds failing two days ago[1]. The issue is
> marked as solved, but there are still some reports[2] from people
> getting the same error message we are experiencing in git.git.
>
> [1]: https://www.traviscistatus.com/incidents/9861dc7dtsb0
> [2]: https://twitter.com/traviscistatus/status/1240759726905815040

I knew we have folks who have wider antennae on these things than I
do ;-)

Thanks.  This means that we can just wait to see what happens at
least fo now ;-)


