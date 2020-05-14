Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E525C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 01:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286C5205ED
	for <git@archiver.kernel.org>; Thu, 14 May 2020 01:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vPyvmCfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgENBM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 21:12:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56326 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgENBM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 21:12:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA2D5BEFB6;
        Wed, 13 May 2020 21:12:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BQVLdgP91xsG
        e4IF5x+Z8ZCPxgQ=; b=vPyvmCfFkfuRCO2XlSJipfhQff/sOdmrlkpJcixOEQnn
        w34TwKjdhVhJjpQA3ULCYmwzMDXYXFoCR6QiaUD5ScKnKR3621m4tr1K4TudkI2y
        P3X9JomeGyPcxAPBa2ixkeuAZCYtSdoJnXnezM8ZqnxMHjtnG4ZxK6YW1URxG8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hfZ7sW
        1kKTRSTHmt3bEP/Qr6BDxHkq6atLbhSq0E/oSa9IG6cL/wyew+8AREJ90UQvGWKs
        BCfJwc9QUl0qf39Chy4LLk+o6bBoP9OLzNd37YbTvhso3883pTzsDk6mKQUGkPEu
        GgACHpg6WbU5aY8fSaxLHsuoM25tcagG2Na3Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1DEBBEFB5;
        Wed, 13 May 2020 21:12:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6937BEFB1;
        Wed, 13 May 2020 21:12:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 02/44] Documentation: document v1 protocol object-format capability
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
        <20200513005424.81369-3-sandals@crustytoothpaste.net>
        <CAN0heSqYsTZDnTG+roZ9pydUcEXJBayWXnijOcAZqb3-Rqegjg@mail.gmail.com>
Date:   Wed, 13 May 2020 18:12:19 -0700
In-Reply-To: <CAN0heSqYsTZDnTG+roZ9pydUcEXJBayWXnijOcAZqb3-Rqegjg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 13 May 2020 21:28:46
 +0200")
Message-ID: <xmqqh7wjqpzg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5F80330-957F-11EA-B2C3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Wed, 13 May 2020 at 02:56, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>
>> @@ -189,7 +204,6 @@ refs being sent.
>>
>>  Clients MAY use the parameters from this capability to select the pro=
per initial
>>  branch when cloning a repository.
>> -
>>  shallow
>>  -------
>
> Looks like a spurious line deletion snuck in.

Indeed.  I wonder if that is why our documentation build fails near
the tip of 'pu'.

