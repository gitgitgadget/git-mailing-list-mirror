Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6281C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6529D20DD4
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IotTHSFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgE0Vtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 17:49:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55840 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgE0Vtl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 17:49:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A268C77481;
        Wed, 27 May 2020 17:49:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xq8wkftDvBluwxHNkOFNSyxDvKM=; b=IotTHS
        Fg5zvdMXIpevh7l1lAPY8gRTTVx6yQtF8IghBXrywZxp9oWCoqh8OSgSwF4xP2Xk
        oo98QvNUEIoEEbPDeQFGruZGimDIC0jocbjeJXqX6yl9OlV9T0obZ3aB/GBakh8O
        mOGQUSYf7uGdJupzKJZxdLsbS0UkeA24DExbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g1THbUFfBeVKrR474r1CQpalr39pLSjZ
        StxuuSBKYmZNQmjbJQHbcmHfWDargpzVZ1XP3LtuK1l/2K38iV+3aE+74uzdSBai
        Xmuo958VG20iXO3Yf+coXfEurgdanS8xTpUeNS2T/N05DP0RcwTmqcJBOBwrc65k
        Dokq2i5ChXo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AFE677480;
        Wed, 27 May 2020 17:49:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27FF57747F;
        Wed, 27 May 2020 17:49:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: jn/experimental-opts-into-proto-v2, was Re: What's cooking in git.git (May 2020, #09; Tue, 26)
References: <xmqqsgfmmt2c.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005270526280.56@tvgsbejvaqbjf.bet>
Date:   Wed, 27 May 2020 14:49:37 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005270526280.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 27 May 2020 05:27:54 +0200 (CEST)")
Message-ID: <xmqq1rn5kpzi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6D88574-A063-11EA-B358-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 26 May 2020, Junio C Hamano wrote:
>
>> * jn/experimental-opts-into-proto-v2 (2020-05-21) 1 commit
>>   (merged to 'next' on 2020-05-24 at 53cd664dfe)
>>  + config: let feature.experimental imply protocol.version=2
>>
>>  "feature.experimental" configuration variable is to let volunteers
>>  easily opt into a set of newer features, which use of the v2
>>  transport protocol is now a part of.
>>
>>  Will cook in 'next'.
>
> Given that the `feature.experimental` option is supposed to increase
> testing in the wild, sort of `next` but for users rather than developers
> who build their own Git, could we maybe integrate this into v2.27.0,
> still?

I have been wondering about the same thing, and if it were not using
its own custom way to read the configuration, it would have been a
non-brainer to merge it down before the release.  But this late in
the cycle, I'd rather not.

Thanks.
