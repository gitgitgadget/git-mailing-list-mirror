Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307C62018E
	for <e@80x24.org>; Thu, 18 Aug 2016 19:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbcHRTZS (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 15:25:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751041AbcHRTZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 15:25:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4436D3549D;
	Thu, 18 Aug 2016 13:27:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yoRsy6jStJFXhN+W91mObHXbips=; b=k3lqag
	/W2HxbIOV/1GguHX7Z5akSt7BHFNfSeBwquhyj3MblC5DgLFvxuS/1z+qjmZU4dh
	ByMIcdMc/nyFu5kAd1vV0gwfVyFTsms9K8G52BOFGZa2oSHzsxyI/GBgXqNCbplg
	E45Np6Z0WTTJvyzLn35DAlBSWjcLOr9JyVfzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kKcIQ6Wugus6QR3buLOe16dXurkThp5y
	SwchpK/OwiUQXaQ8yE+mKmc6K0xP+7VCDHOJ2LOGdDwpFA3bcbMaMojG8VyXpGla
	4k4LUfnbyxrm8tyTk9AzhP+IYqYs676K0G6wJX4PK0e7ExmJf7krX71x/snxYV3U
	uCye5TAdOGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BE9C3549C;
	Thu, 18 Aug 2016 13:27:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B98AC3549B;
	Thu, 18 Aug 2016 13:27:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Olaf Hering <olaf@aepfle.de>, git@vger.kernel.org
Subject: Re: git format-patch --break-rewrites broken in 2.9.3
References: <20160818144421.GA9062@aepfle.de>
	<alpine.DEB.2.20.1608181713440.4924@virtualbox>
Date:	Thu, 18 Aug 2016 10:27:45 -0700
In-Reply-To: <alpine.DEB.2.20.1608181713440.4924@virtualbox> (Johannes
	Schindelin's message of "Thu, 18 Aug 2016 17:15:08 +0200 (CEST)")
Message-ID: <xmqq7fbe6l7y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14E21574-6569-11E6-80FB-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Olaf,
>
>>         --break-rewrites \
>>         --keep-subject \
>>  95fa0405c5991726e06c08ffcd8ff872f7fb4f2d^..95fa0405c5991726e06c08ffcd8ff872f7fb4f2d
>> 
>> What must be done now to get a usable patch?
>
> Maybe --no-renames? BTW this behavior was not introduced in 2.9.3, but in
> 2.9.0:
>
> https://github.com/git/git/blob/v2.9.0/Documentation/RelNotes/2.9.0.txt#L7-L9

I think that is one half of the story.

The other half is a long/well known bug that lets "diff -B -M" to
produce incorrect/broken patch that cannot be applied.  It was
documented in the thread that begins at:

    public-inbox.org/git/xmqqfvapuhkk.fsf@gitster.dls.corp.google.com

but still hasn't been solved.
