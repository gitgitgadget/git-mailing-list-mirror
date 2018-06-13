Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82431F403
	for <e@80x24.org>; Wed, 13 Jun 2018 17:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935017AbeFMR0Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 13:26:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58145 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeFMR0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 13:26:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67A09E3BC6;
        Wed, 13 Jun 2018 13:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=3a6Aeddzs5BZY
        cvifHseVmX+Enk=; b=K+JQiMjTkwi/a84ci/H1R7nGjEN37cPOISgGY4p6N9GDD
        CiNcD02dIiX8IDlFWXRqJVZByu/WITG7uJ8ylmq5n9iTwbwsx43f6AO3PEa4FCwG
        fyCZ2BzQrq9aSwrFnGAXTsZxskgo9s3Npu2D/IGKLTw1d5xdUDruA7xMjfHzGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=qF9WZsb
        yDYx2gjxZ/jIIbO2OGIS8TowLF315t091luT/XJrsbvh67X7bi0GzsY9Z5fbFINK
        jY1BBTa28Sy9j0aR6cYKBK0s/daZa9q+RIdYJzDfFw2IHGjWaGACTu5G+9pdeVdm
        Y0dGM25iQD91P2gZOBN820PyJr4BzqmiEPAk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EBA0E3BC4;
        Wed, 13 Jun 2018 13:26:24 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E079AE3BC2;
        Wed, 13 Jun 2018 13:26:23 -0400 (EDT)
Date:   Wed, 13 Jun 2018 13:26:22 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-credential-netrc: remove use of "autodie"
Message-ID: <20180613172622.GI3094@zaya.teonanacatl.net>
References: <CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com>
 <20180613074810.5358-1-avarab@gmail.com>
 <xmqqpo0u7hup.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqqpo0u7hup.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: E539307E-6F2E-11E8-BE17-44CE1968708C-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> =C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:
>=20
>> Per my reading of the file this was the only thing autodie was doing
>> in this file (there was no other code it altered). So let's remove it,
>> both to fix the logic error and to get rid of the dependency.
>>
>> 1. <87efhfvxzu.fsf@evledraar.gmail.com>
>>    (https://public-inbox.org/git/87efhfvxzu.fsf@evledraar.gmail.com/)
>> 2. <CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com=
>
>>    (https://public-inbox.org/git/CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu=
2RA74RErX8s3Pg@mail.gmail.com/)
>>
>> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
>> ---
>>  contrib/credential/netrc/git-credential-netrc | 1 -
>>  1 file changed, 1 deletion(-)
>=20
> Even though this may not be all that release-critical, let's queue
> it so that we do not have to remember to dig it up later ;-)
>=20
> Thank you very much to all of you involved in the thread.

Should I resend the RFC v2 series as well?  The only change
I'd make would be to add my signoff on the patches which are
'From: Luis' per suggestion.

If you think that's worth adding, I can resend or you may
add it while queueing.  Whichever is easier for you works
for me.

Thanks,

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Age doesn't always bring wisdom.  Sometimes it comes alone.

