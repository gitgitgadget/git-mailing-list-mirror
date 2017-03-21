Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750942095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757680AbdCUTRR (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:17:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55257 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758364AbdCUTQK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:16:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B041465F31;
        Tue, 21 Mar 2017 15:16:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uB+VUxGzjzmS
        s+Ixb0zMAGyw0To=; b=nCqB0xiRrMxWARwRDTIVrSMEhpWQp93LIkna8rYMFv9Q
        26ccj+UX+K+Oct4cQrd53nV8JEuVYq/T2CiK0HilcwkCZgVXVeN4vLiqDjts9wnV
        mcQ0Je5KlBMCkOO2EUN4jTnblzR1QVT1n8UurINsmb5sOJoaWUDeSycM0pdIEl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gt7XAZ
        8qqgdAwwcRKSbqmTjVzID/SwQXL9ijZleDWTsfFs77KGG1Ca4FMlaGQ9lQD3nmlZ
        wUw/QF9hFyt6pQ6ZVwKAzoS8BITcLqNhCM3yGEYgXJFXzr7WSF4rqRvV0xafr3XS
        OFiLDZcytVTRpFhfSpls/XR6oTTfXxM2VrDkc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A88F265F30;
        Tue, 21 Mar 2017 15:16:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1338E65F2F;
        Tue, 21 Mar 2017 15:16:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/16] for-each-ref: partly change <object> to <commit> in help
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-9-avarab@gmail.com>
        <xmqqwpbipjk9.fsf@gitster.mtv.corp.google.com>
        <CACBZZX6VxxYD1ev0K4jxyUmqxFpALopkHTUFp4iFtYfSuOgrjQ@mail.gmail.com>
Date:   Tue, 21 Mar 2017 12:16:06 -0700
In-Reply-To: <CACBZZX6VxxYD1ev0K4jxyUmqxFpALopkHTUFp4iFtYfSuOgrjQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 21 Mar
 2017 19:50:15
        +0100")
Message-ID: <xmqqy3vyo2yx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D63A0EF2-0E6A-11E7-8C4F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Mar 21, 2017 at 7:32 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> Do these strictly require commit, or does any commit-ish also do?
>
> commit-ish, but that's a good point, and could be the subject of a
> future follow-up patch. Right now most of the things that say <commit>
> really mean <commit-ish>:
>
>     $ git grep '<commit>' -- builtin|wc -l
>     18
>     $ git grep '<commit.*ish>' -- builtin|wc -l
>     3

My gut feeling is that anywhere we say a <commit> for Porcelain
commands, we should be also accepting a <commit-ish>, and it is not
worth repeating to users that these command accept commit-ish.  So I
think it is better to leave these as <commit>, and to add special
note to places where the commands insist taking <commit> and not
<commit-ish>.  They should be minorities, at least for Porcelain
commands.  The same for <tree> vs <tree-ish>.

Thanks.
