Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFFC433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9460D20774
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gNJYdVnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgH2S7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:59:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57517 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2S7M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 14:59:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C7A1D66D5;
        Sat, 29 Aug 2020 14:59:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d0iSCEsnjBAEN00asUd33nuE59s=; b=gNJYdV
        nblpml0/cg70kkmMRW2uFvIaQB8a2CLIjbH2i9ziP8h8ycGQLHCfAgGesslXTYme
        gpImWsrQOS+IgjYcJGoGK2YatUdhYoRHedMB3YGe/g7eSJkJNb5yAmiymBJHTuVw
        OrmXExbQz1T26OpdCA/GnaO+LaZg5VorbGwDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WS9C41qoTJEPpncaKRT4X1TKuzfoZLxO
        8OftqM+kscq17Or1oFLL96FYtcoew2hqECTrWc+Cw0GmdrNA+3GIUu0IhfXAey4j
        0NpjDGaeau1+ktNbeFx6H2bgc9GqjM6cG42jwfo2rwUKx791IH/lYae7hEEd3AU0
        SuX9ymnJe4Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35B8CD66D4;
        Sat, 29 Aug 2020 14:59:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7EA04D66D3;
        Sat, 29 Aug 2020 14:59:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
        <CA+CkUQ-SsxrJk+7e-ygm8FfCto6XZt2Ts9UcTMpgkmAQWZkLhA@mail.gmail.com>
        <xmqq1rjpjohy.fsf@gitster.c.googlers.com>
        <CA+CkUQ_3jvkwNvakGxCvDk-C2RMCfAd7pAxy8OmjwVvJT2S_Cw@mail.gmail.com>
Date:   Sat, 29 Aug 2020 11:59:07 -0700
In-Reply-To: <CA+CkUQ_3jvkwNvakGxCvDk-C2RMCfAd7pAxy8OmjwVvJT2S_Cw@mail.gmail.com>
        (Hariom verma's message of "Sat, 29 Aug 2020 18:50:10 +0530")
Message-ID: <xmqqk0xhi8hw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8548838-EA29-11EA-BE96-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

> Yeah, I agree with you.
> Let's not delay these 2 patches. Sorry for the noise though.

Please do not be sorry, as you didn't raise any unnecessary noise.
Sanity checking each others' action is a good way to make sure we
collectively avoid mistakes, and you just did with the other topic
of yours yesterday, which was very appreciated.

Thanks.
