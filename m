Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA7CC54E7E
	for <git@archiver.kernel.org>; Sat,  9 May 2020 23:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF20024953
	for <git@archiver.kernel.org>; Sat,  9 May 2020 23:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vVAIVCd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgEIXmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 19:42:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56701 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgEIXmF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 19:42:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEE6366487;
        Sat,  9 May 2020 19:42:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vxhXAyKTarITuLvgvdr4YHTsFZY=; b=vVAIVC
        d8N8lEAhTc0ubMkwqdngPUExEO0FUgd01pZNeuLA04oMPIG+ihFhYqnUFY8V8+Kr
        XvkiqesFOYnWzN0Qi+1T2338CqMUSh5eFXKpdPUtZKP/uIwuALSrP7W86F5+68o4
        vr6yxXAlZYpp7xnSrxlTgt8ockCp8B4OBAKsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UzlomqEMG9b4GZg01YNfRGVUfZgTtvix
        grn9YJQVpCqAYck64VayGx0XE/aJ8L1Th9Wj8VTqh2oXdaBTdboBr0ltzwySYl8d
        oxB9i0xjW6jTCCsAl42JfHvSvc1+lnRmv1PaMC0xp1Q7YVEjpMvua8X0LuTlfhDg
        nNOWZdNaIns=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A713666486;
        Sat,  9 May 2020 19:42:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D68866485;
        Sat,  9 May 2020 19:42:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     George Brown <321.george@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
        <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
        <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
Date:   Sat, 09 May 2020 16:42:00 -0700
In-Reply-To: <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
        (George Brown's message of "Sat, 9 May 2020 23:04:15 +0100")
Message-ID: <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE87393C-924E-11EA-9B02-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Brown <321.george@gmail.com> writes:

>> The are editors that open their own window, or tell an already open
>> editor instance to edit the buffer (think: emacsclient) and in order
>> to be functional, they do not have to be launched from inside a
>> working terminal window (whose input comes from the keyboard---the
>> test "-t 1" is an approximate check for that).
>>
>> Wouldn't this change hurt the users of such an editor?
>
> I'm unsure of emacsclient but I would have thought that editors in
> general would be more amenable to receiving lines than relying on
> additional spawned instances to behave as clients.

I am not sure what you mean by "receiving lines".  Your patch makes
the "git jump" command completely ignore configured GIT_EDITOR and
refuse to invoke *any* editor.




