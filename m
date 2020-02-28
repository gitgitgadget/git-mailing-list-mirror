Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342E6C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC10E246AC
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 17:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TkB3hc7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgB1RSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:18:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51586 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RSF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 12:18:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24C16C7C47;
        Fri, 28 Feb 2020 12:18:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H5zzFCG6/RPLrCVE4c2nc3dOFcg=; b=TkB3hc
        7Z/6Yf19DO9xa7bTlmiCRxdmPCKy9yCkjBYfeDj7vLz22ix1ycqDMFgNmUvwE0cU
        2UNBxge67PI3HckxaGncmjkl4UnWsZmrvA+KuRlq91Y5ch4FAUMBX+WUKL7NcH1A
        8mZlOwEm682/f65nXPRDkSA9Vh0aRFXGBt2Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xEg6boXXnDvktHe9OnpaMKBrrNgpD7BP
        knnV7BejdX8lV3LrsSQ51lUzmVLskei1Bwe12AIS51YYoaQJiiOe5Q/GANMevT+e
        l8Oq6zlSULMWQNIA+4MGQV7KdPJ4IejMgPOl3+CEZ8Jaa8UEaCKPlbTTOYO/KhDe
        Jea+f1anl2U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C1C9C7C46;
        Fri, 28 Feb 2020 12:18:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35B83C7C44;
        Fri, 28 Feb 2020 12:18:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Signed commit regression?
References: <CAHk-=wgg8ctNmHbKjy-yYnz07L3m8=1et_q2FJHKM9mZKXzGAA@mail.gmail.com>
        <CAHk-=whg3uip_N1EjLEzaZNMvS8v+5u2GGueE9Wm2xnY87D+-A@mail.gmail.com>
Date:   Fri, 28 Feb 2020 09:17:58 -0800
In-Reply-To: <CAHk-=whg3uip_N1EjLEzaZNMvS8v+5u2GGueE9Wm2xnY87D+-A@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 28 Feb 2020 08:47:23 -0800")
Message-ID: <xmqqpndyeim1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4657EE0C-5A4E-11EA-A764-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Feb 28, 2020 at 8:44 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I suspect it's due to this commit:
>>
>>   72b006f4bf ("gpg-interface: prefer check_signature() for GPG verification")
>>
>> but as mentioned I don't have the ability to really dig deeper right now.
>
> Never mind - I did a mindless "just revert that and test", and it
> indeed is that commit.
>
> Please revert it in upstream git. The "No signature" message really is
> horribly wrong. It's both technically entirely wrong, but it's wrong
> from a UI standpoint too since you really need to show what the
> missing key was.

True---the messages that told you the missing piece of information
with the original code came directly from gnupg, and the problematic
change stopped showing that and replaced it with the generic (and
wrong) "We tried to verify signature and it failed---it must be that
the input did not have signature" message.

It is in v2.25 already, so we'd need to revert it out of 'maint'; it
seems to have a minimum fallout on a topic in flight, but it looks
manageable.

Thanks.
