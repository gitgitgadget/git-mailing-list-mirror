Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC4EC433E1
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52A72176B
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ao3DZlcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgGTRut (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:50:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50001 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGTRus (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 13:50:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90E81E8536;
        Mon, 20 Jul 2020 13:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pWW9C9uceXyc
        nOw3SA5s7Mz1MAU=; b=Ao3DZlcFuI22UdVIF/8CWI8n4YBCxX3kRn2sI2Zsixeb
        Oc6mlx4celH7P0EjLh65jJX+TixzPYlXlJrKHBzpQc7rzY/JNqqxX11/AzYo5d+k
        PKPnjlqOoVJc5x82l6VGwrPhfy7/LTYyTIkEmknSNu6oPmKPetMkkjkzEHDoMxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=i5KyOH
        Mja+HtwBmvIhzGCh3a8TI1woKO77wa/5AB+Z834gvLFBInibfDEBCtF3h8Toy08Q
        SKT+EE3J9KEo8tirYt31dYeNFFiIS3lH2dZdHD0LVV1ZveN7UhfdZCnPZnId1bRi
        3JKEvRrQxOU0NSvq/s/MdSTqMNr6llHxnq6VY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8976EE8535;
        Mon, 20 Jul 2020 13:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDFA5E8534;
        Mon, 20 Jul 2020 13:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: How can I search git log with ceratin keyword but without the other keyword?
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
        <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
        <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
        <20200716153159.GA1061124@coredump.intra.peff.net>
        <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
        <20200717063324.GB1179001@coredump.intra.peff.net>
        <xmqqd04ufutq.fsf@gitster.c.googlers.com>
        <xmqq7dv2fnpb.fsf@gitster.c.googlers.com>
        <CAAvDm6bG-s2m9fGXVtuyLB7_FSDRduhb3ptrBsL3ezR9LaS-hQ@mail.gmail.com>
        <xmqqlfjgbssl.fsf@gitster.c.googlers.com>
        <CAAvDm6aNN2kDh=SF6_K-v+cq0a94tcQ1AQ-Fpgs2mNo18FTFfQ@mail.gmail.com>
        <CAPUEspj3A-bCo+WqiGksuLkqm65HAPiOjrWaAyy7S8XSy_Ohiw@mail.gmail.com>
Date:   Mon, 20 Jul 2020 10:50:41 -0700
In-Reply-To: <CAPUEspj3A-bCo+WqiGksuLkqm65HAPiOjrWaAyy7S8XSy_Ohiw@mail.gmail.com>
        (Carlo Arenas's message of "Sun, 19 Jul 2020 01:26:55 -0700")
Message-ID: <xmqqmu3u9itq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 88A2995A-CAB1-11EA-AA57-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Sat, Jul 18, 2020 at 10:28 PM =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong=
 <sunshilong369@gmail.com> wrote:
>> Is there some method(or command provided by git) that could get the
>> comments of a certain commit (e.g: first, second,... nth)
>
> what you are looking for is described sometimes as "relative
> reference" [1], so for example if you want to refer to the commit
> before last (ex: second from the top, counting as 0 base) in a
> repository that looks like:
>
> $ git log --oneline
> b1824b2 (HEAD -> master) second
> 00d85f1 first
> 68757c9 initial
>
> $ git log --oneline -n 1 HEAD@{1}
> 00d85f1 first

You meant HEAD~1, not the nth reflog entry (which does not have
anything to do with the parenthood sequence between commits).


