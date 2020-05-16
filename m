Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DE1C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC7620756
	for <git@archiver.kernel.org>; Sat, 16 May 2020 00:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cqxtp5/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgEPACo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 20:02:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52992 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEPACn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 20:02:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF0D4D8187;
        Fri, 15 May 2020 20:02:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mFwkQzKyTp0U
        GqeBgoDFsugALYo=; b=Cqxtp5/nuegjw0TVweLvH9ROUJuYJuiofvzl6tZlKU/C
        wmo2mLrbZ0p1DKV+6GGqGcZzpoWESliSe7MlTXOwcDu4g7n/QkTi58xVnSCM94Xu
        e5/z7uzskevPuHb5s+AApd2m188Z1TDln7fvyqSmfR+hJ/mL3c/hFgDj/g2+QPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ExckXx
        CrMlXDFVbzXN8cfZBJJ3/KGUpRmDuJSVmmxXsknEK05Zk6fbH3br+HzfeYsSfnFn
        7gydRtNPxUzWxSgUfzlWj5oD5cBTJQrtPRqRmn2GzSIREIMurBQzrjWk7dPLem3z
        oOnNEQBLB8yo2mAHx5Mzm3aosNFRrGvKWNnR8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C67A5D8186;
        Fri, 15 May 2020 20:02:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C2D2D8185;
        Fri, 15 May 2020 20:02:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 02/44] Documentation: document v1 protocol object-format capability
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
        <20200513005424.81369-3-sandals@crustytoothpaste.net>
        <CAN0heSqYsTZDnTG+roZ9pydUcEXJBayWXnijOcAZqb3-Rqegjg@mail.gmail.com>
        <xmqqh7wjqpzg.fsf@gitster.c.googlers.com>
        <20200515232212.GB6362@camp.crustytoothpaste.net>
Date:   Fri, 15 May 2020 17:02:38 -0700
In-Reply-To: <20200515232212.GB6362@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 15 May 2020 23:22:12 +0000")
Message-ID: <xmqq5zcw9275.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8EDE148E-9708-11EA-987E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-05-14 at 01:12:19, Junio C Hamano wrote:
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>=20
>> > On Wed, 13 May 2020 at 02:56, brian m. carlson
>> > <sandals@crustytoothpaste.net> wrote:
>> >
>> >> @@ -189,7 +204,6 @@ refs being sent.
>> >>
>> >>  Clients MAY use the parameters from this capability to select the =
proper initial
>> >>  branch when cloning a repository.
>> >> -
>> >>  shallow
>> >>  -------
>> >
>> > Looks like a spurious line deletion snuck in.
>>=20
>> Indeed.  I wonder if that is why our documentation build fails near
>> the tip of 'pu'.
>
> I'll definitely do a reroll this weekend and kick a basic doc build off
> before I send it out.

FWIW, I've fixed it up on my end so the documentation build of 'pu'
has been working OK.
