Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A08C352A4
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 05:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EC1222C2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 05:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vUBtzMpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgBGFkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 00:40:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50728 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgBGFkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 00:40:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36CB3A2880;
        Fri,  7 Feb 2020 00:40:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dsEMNIVXvxBh
        YT0rtCGMqg+I+R8=; b=vUBtzMppYY9m5xoevPTnnXvmbThPGL7ADqXFpDEv/w98
        cMIFdjAQ5OfsIkVWHGL7Y2cOf+8/USZprGG5Guc9IRWecwZaGcUHUmUCvYTvapZN
        zzHWN0S/C4Wqvh7ugEsK7TeZGj0/lsg4kpivntZdQ4B+g66QdvjKeMDiSt2IOBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tSbzI9
        aHtt54novydEDNyo8ribkc8B1gz6norSZO0yr9u2Ukpu/bUc/gNFcTYU/dRJQSWa
        SdQbHs8a8VuLsmzIDgdsvcY/lAMdPf1dcSbFIE/n6/p8r2k4UOvVoIJCwuzYV4AM
        35iOhi3H3QdZhY2waN91SpPWWKgJp0YbSjdmA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FA80A287D;
        Fri,  7 Feb 2020 00:40:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5EF01A287C;
        Fri,  7 Feb 2020 00:40:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
Subject: Re: bug? illegal text in commit log
References: <20200204010524-mutt-send-email-mst@kernel.org>
        <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
        <xmqqd0arfyw8.fsf@gitster-ct.c.googlers.com>
        <e271bb17-376d-426f-61b2-86971f1cb02b@web.de>
Date:   Thu, 06 Feb 2020 21:40:08 -0800
In-Reply-To: <e271bb17-376d-426f-61b2-86971f1cb02b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 6 Feb 2020 18:30:06 +0100")
Message-ID: <xmqqlfpf3qh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4EB51A36-496C-11EA-952D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>  * the first line that
>>    - begins with "diff " or "Index", or
>>    - is "---" (and nothing else on the line)
>>    signals that the line no longer is part of the log
>>
>>  * but if it finds a line that begins with "diff --git" (or
>>    optionally just "diff "), do not blindly assume that is the end
>>    of the log, and instead try to find the first "---" line.  If
>>    there isn't any "---", then take that "diff" line the beginning
>>    of the patch, but if there is, "---" is the end of the message.
>>
>> The latter rule is the new one.  And there is no need to change
>> format-patch output.
>
> I like this idea.  It will probably be tricky to implement, though,
> as mailinfo currently goes through the input line by line and has no
> easy way to look ahead.
>
> Ren=C3=A9

Another issue with the approach is that it will be fooled if the
patch is about removing a line with double-dash and nothing else
on it.  Unless we can trust the numbers on hunk header lines in the
"sample patch" embedded in the log message, we cannot reliably tell
if a line with "---" on it is such a line, or the true end of the
log message.

