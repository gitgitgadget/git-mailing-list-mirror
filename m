Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6A9C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 04:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2473217A0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 04:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wu+rBdzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFREns (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 00:43:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62551 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgFREnq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 00:43:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B867ECB146;
        Thu, 18 Jun 2020 00:43:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kJ6M5H2y9TOf
        Mfgemjkafmxz550=; b=Wu+rBdzdHxEoW/PAMPC0tFD0kYU/ALzqmFAP6SRalReY
        Cq3DAmXq2STLV8Xyj0sKXtMfFrZFPQZ/yVjmiGV1L6k987MBSATT821Ws2txBO1X
        bfMfM9Kffw5b8xCzquc/HBszykQ6nFcAlCoaiwhFb356ERQawL8jtpiJT7APEdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tlnJhf
        N0DI2NFYI5sg+XlDzG1yeGWpwmdNbdDAw2Fu9zRzDRjDjN/93cJBkybE5joyhrpI
        qEbmQMWTxRm6NDnmSJszDAJpDUTOXCqhQtbVqjkGJn2NT1p6Frp4iUiMPxOspC7E
        1CNyGtGqWou9z2Ug2AwDiiIVHg0VJ+h1Z+V8Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B08A4CB144;
        Thu, 18 Jun 2020 00:43:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01241CB143;
        Thu, 18 Jun 2020 00:43:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 6/8] cmake: support for building git on windows with mingw
References: <549f0cd5fffef38e8d85246a9aa2593674aad68c.1591986566.git.gitgitgadget@gmail.com>
        <20200615140349.1783-1-oystwa@gmail.com>
        <CAKiG+9X66yf_F8F3XuYFdFyBWiFRZ_rf0Y1mE5LVCjsi-AzKbg@mail.gmail.com>
Date:   Wed, 17 Jun 2020 21:43:40 -0700
In-Reply-To: <CAKiG+9X66yf_F8F3XuYFdFyBWiFRZ_rf0Y1mE5LVCjsi-AzKbg@mail.gmail.com>
        (Sibi Siddharthan's message of "Tue, 16 Jun 2020 01:17:08 +0530")
Message-ID: <xmqq8sglq8zn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4902132C-B11E-11EA-A9EB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> On Mon, Jun 15, 2020 at 7:33 PM =C3=98ystein Walle <oystwa@gmail.com> w=
rote:
>>
>> > +if(WIN32)
>> > +     set(EXE_EXTENSION .exe)
>> > +else()
>> > +     set(EXE_EXTENSION)
>> > +endif()
>>
>> You can probably use CMAKE_EXECUTABLE_SUFFIX here. See:
>> https://cmake.org/cmake/help/latest/variable/CMAKE_EXECUTABLE_SUFFIX.h=
tml
>>
>
> Could have done it that way, will try to change it once the patch
> series gets merged with next or master.

If it is something that makes the result even simpler than the above
quoted 5 lines, I do not see a reason to postpone it and use that
simpler way from the beginning.

Thanks.
