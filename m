Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28EFC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7742D206C0
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cvPXx+bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgHNUjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:39:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60158 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgHNUjm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:39:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CD266C390;
        Fri, 14 Aug 2020 16:39:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O9HAU+6KaBYu
        BFcgxhvQeCxark4=; b=cvPXx+bsD5HiohuRzjVDPJ9LK2GWUAhFY4teFAQhvtb+
        Lnkv1BI2AJat0q++5W4h2izyQgSSiEjFwmoIs2StE5sDDGrhOmEQuUAGL2teDhYX
        ogKHavDhJyfBlMN/pPlCEehI2oJ5WvRvGSwP9el5IqQQBFWPXSEv9VxUAwithl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YT4e/o
        AXFVmbhag1r71Tbtwj+RS+Q1W6iAG/LpDCoZrS0oI86m9EFZWeecWONKSeMuuRu2
        p+P/Xm6I2yTgHbJWb4G95wco/zjPrVsqOPPdvpIAv4Loh0RXJIKYYZELwcjlcOwz
        mccNt42RXtWM0TP4iorVo7/7fh6DACmTWdNRI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34EDE6C38F;
        Fri, 14 Aug 2020 16:39:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B67426C38E;
        Fri, 14 Aug 2020 16:39:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] http-protocol.txt: document SHA-256 "want"/"have" format
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
        <cover.1597406877.git.martin.agren@gmail.com>
        <5590a68c5ba7081cd7e64c708b5c25db23f5e95b.1597406877.git.martin.agren@gmail.com>
        <xmqqk0y1xhl0.fsf@gitster.c.googlers.com>
        <20200814202347.GN8085@camp.crustytoothpaste.net>
Date:   Fri, 14 Aug 2020 13:39:37 -0700
In-Reply-To: <20200814202347.GN8085@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 14 Aug 2020 20:23:47 +0000")
Message-ID: <xmqqo8ndufli.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 45D5D60C-DE6E-11EA-A19D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-08-14 at 17:28:27, Junio C Hamano wrote:
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>=20
>> > Document that in SHA-1 repositories, we use SHA-1 for "want"s and
>> > "have"s, and in SHA-256 repositories, we use SHA-256.
>>=20
>> Ehh, doesn't this directly contradict the transition plan of "on the
>> wire everything will use SHA-1 version for now?"
>
> SHA-256 repositories interoperate currently using SHA-256 object IDs.
> It was originally intended that we wouldn't update the protocol, but
> that leads to much of the testsuite failing since it's impossible to
> move objects from one place to another.
>
> If we wanted to be more pedantically correct and optimize for the
> future, we could say that the values use the format negotiated by the
> "object-format" protocol extension and SHA-1 otherwise.

Yup.  I think a reasonable evolution path is

    0) everything on the wire is SHA-1 and no local operation knows
       SHA-256 (i.e. a few releases ago)

    1) local operations are either SHA-1 or SHA-256 but not both.
       On the wire, only protocol for SHA-1 repositories are
       defined, so SHA-256 repositories cannot talk with anybody
       using any official protocol, but a "borked" SHA-1 protocol
       that naturally extends the object names width exists and
       SHA-256 repositories can interoperate with each other.  This
       will be a backward compatibility nightmare, as Git from
       SHA-256 repository that tries to talk to SHA-1 repository
       will fail but without grace (i.e. the current situation).

    2) on-the-wire protocol gains just one new capability to safely
       unleash SHA-256 repositories to talk to the wider world.  The
       "borked" SHA-1 protocol above will become official when the
       object-format=3Dsha256 capability is negotiated by both ends.
       At this stage, SHA-256 repositories still cannot talk with
       SHA-1 repositories, but at least they can talk among
       themselves as long as they use new-enough version of Git that
       knows about the new capability.

    3) on-the-fly SHA-1 vs SHA-256 migration gets implemented.
       SHA-256 reposotories trying to talk to somebody else, after
       discovering that the other end lacks object-format=3Dsha256
       capability, on-the-fly converts its SHA-256 objecst to SHA-1
       and vice versa.  Between SHA-256 repositories, the capability
       above in 2) will allow native conversation with SHA-256.

Reaching 3) may be a lot of work, but at least we should get to 2)
to be able to safely let SHA-256 repositories to talk to the outside
world (yes, I consider it OK for SHA-256 repositories talking among
themselves in a private setting in the current state, and it would
be a good milestone and also test towards the eventual goal of
reaching 3), and with much smaller effort.

Thanks.

