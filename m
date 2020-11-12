Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF03C5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976EF21D40
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AxGtN+in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgKLRc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 12:32:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52097 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgKLRc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 12:32:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3ED896922;
        Thu, 12 Nov 2020 12:32:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kCJy7kiq5XI+
        BgkbXKtoDygpp9E=; b=AxGtN+in/WX2iw+JT9o9oc+6OwX7FRcoTbFTlnmv2Ffy
        WDmjBHMKLEyRMJlMhlfDVvVEzO/qPvaF38DoCbx1Ke6GVfQafL3nwVpTmV32zI4c
        KOdhtBYApdn8QK3X617r2AvqAQn1xhurvrEv4OP27OYn6K+Zyzmprx4iGY086PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yYiKLd
        V1e6+zjzOhm+56xypy1MUwEFqHj4qGD4jCu5C/tJYZCaDxoLMhoOubw/ktAlb+mC
        +8kR7PqOTnVL70QnJd5Jssu8IbK3GYoOLJCKZJ3e7nBLTHElYL1mDBODfqAVAncL
        v2CJR11Ca+wo3PH9FRMsHM+GLfG+zpbVkKdQY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA83D96921;
        Thu, 12 Nov 2020 12:32:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D42796920;
        Thu, 12 Nov 2020 12:32:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 01/11] docs: new capability to advertise trace2 SIDs
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <d04028c3c7574e3ca0f9c1b3d711192ca756158d.1604355792.git.steadmon@google.com>
        <xmqq5z6mqg60.fsf@gitster.c.googlers.com>
        <634cf106-7bc2-e8fa-5745-5e2d26b50e14@jeffhostetler.com>
        <87d00ihdqf.fsf@evledraar.gmail.com>
Date:   Thu, 12 Nov 2020 09:32:53 -0800
In-Reply-To: <87d00ihdqf.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 12 Nov 2020 15:05:44 +0100")
Message-ID: <xmqqo8k2jxa2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 189CDC9A-250D-11EB-860D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> AFAICT the way it's documented now is the "is the session-id[...]"
> paragraph in api-trace2.txt.
>
> I'd like to see us document the implementation a bit better and
> explicitly support the "hack" of setting GIT_TRACE2_PARENT_SID=3Dhello.
>
> I.e. maybe I've missed something but we just say "session-id is
> prepended with the session-id of the parent" but don't mention that we
> separate them with slashes, so you can split on that to get the depth &
> individual ID's.
>
> My reading of the updated doc patch in v3 is that not allowing
> "non-printable or whitespace" allows you to e.g. have slashes in those
> custom session IDs, which would be quite inconvenient since it would
> break that property.

A few things I want to see stakeholders agree on:

 - In "a/b/c", what's the "session ID" of the leaf child process?
   "a/b/c"?  or "c"?  If the former (which is what I am guessing),
   do we have name to refer to "b" or "c" alone (if not, we should
   have one)?

 - Do we encourage/force other implementations of Git protocol to
   adopt a similar "slash-separated non-whitespace ASCII printable"
   structure?  I do not think such a structure is too limiting but
   others may feel differently.  Or is a "session ID" supposed to be
   an opaque token without any structure, and upon seeing "a/b/c"
   the recipient should not read anything into its slash, or any
   relation  with another session whose ID is "a/b/d"?

> And we should explicitly support the GIT_TRACE2_PARENT_SID=3D* setting
> from an external process, and make the SID definition loose enough to
> allow for SIDs that don't look like Git's in that chain. I.e. a useful
> property (and one I've seen in the wild) is to have some external
> programt that already has SIDs/UUID run IDs spawn git, setting
> GIT_TRACE2_PARENT_SID=3D<that program's SID> makes things convenient fo=
r
> the purposes of logging.n
