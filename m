Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55433C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B77F2078E
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jg+dX1ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgIOVrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:47:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53597 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgIOVqP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:46:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5449DEF8A;
        Tue, 15 Sep 2020 17:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6X74998QVftc
        jhj4SSwhSaPluHA=; b=jg+dX1ceeH2FFP4SUxCwOlFaW3IxqvnLIJ7WVArl47nl
        GpjP8XU2DD3PQIFXz2iLYqG/Opx+/CTZF/5u/2pX4J+QktTdBr+UG99PjLUbDCCO
        MJ3+ixZPUsrDp7CYJlYfDEMbvH9fbyw66YEIsS36Wi6Ose4nCfB8zXf5/oO+DoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cIjBKG
        C8LqJoNBTlrEP1XOh7BoQ5p2HlGmySg7TNgYYQCoay8HYtlem0FaxaRKF0b8/aY5
        7l+8omMLPi85aaNysxxLP/Ttq8cBh/nKl3I6Vo32P0ZM+QF89iGMD7EPtYKaIsJh
        xgP+0Jur90JqDEYjK0VM2U50OiEXJZaSgFjAU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF24BDEF89;
        Tue, 15 Sep 2020 17:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E7744DEF87;
        Tue, 15 Sep 2020 17:45:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
        <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
        <xmqqimcezqs5.fsf@gitster.c.googlers.com>
        <CANQwDwc3-n4X16F1Xuf-y-yLeXoGRTeT5c=kVVFXH1E6P=ZEqA@mail.gmail.com>
Date:   Tue, 15 Sep 2020 14:45:51 -0700
In-Reply-To: <CANQwDwc3-n4X16F1Xuf-y-yLeXoGRTeT5c=kVVFXH1E6P=ZEqA@mail.gmail.com>
        ("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 15 Sep 2020
 23:25:16 +0200")
Message-ID: <xmqqzh5qyar4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3DC92BE-F79C-11EA-91DB-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:


>> My gut feeling is that overflow handling needs to be there whether the
>> field is 32-bit or 64-bit.
>
> Not if the size on-disk is the same as the size in memory:
> timestamp_t is usually 64 bit (and even unsigned 64 bit epoch
> would be enough - its range is over twenty times the present
> age of the universe per direction).

Yes, and "corrected commit dates" is about accommodating commits
with absurd out-of-sync timestamp mixed in a history with commits
with correct timestamp, right?  What happens if the absurd timestamp
is near the limit of the range?  You do not have to live through the
end of the universe---you only have to create a commit object that
records such a timestamp, no?

