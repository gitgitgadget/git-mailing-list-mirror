Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A65C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBF92070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="THPgJ3+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgFJRGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:06:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60898 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJRGi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:06:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3C895A828;
        Wed, 10 Jun 2020 13:06:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=G5hl09k8/Ze0
        84KcCEu1DAkfxKE=; b=THPgJ3+GFKM1ws1silnNDv4Z2SvW8+C4Bte2G77hY0F0
        0BOU3POugNiloQNakhXgkoTD5+ZkYxfdvzjty1a/+yKvwq/ufdcBGDOqXcaejo5X
        A4YNTQ8zT20kuRm+GxxIM/UJHCADgjS+SDO4fOwHTM4tn4uAtsBDKtNgAbon9Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TTxvMr
        T8ryo+GUafE0wZhDT4YEhRmmCjIZZl8RN2JqiGbLvYb+0IcOCVhlX4Ir1AWAo4q+
        9broj3sgKWlFB631fk9E8isZ///ZWatDKH1QI8BoG5nxdl+4CUmOouIFKYhDxlOG
        kQcRNryWZwq6/26h7OucEtyPsxnWq6ZQnW04s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C04C5A827;
        Wed, 10 Jun 2020 13:06:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 271185A826;
        Wed, 10 Jun 2020 13:06:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: osx autocrlf sanity?
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
        <20200609231336.GQ6569@camp.crustytoothpaste.net>
        <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
        <20200610143404.5sgww2fmsouubloj@tb-raspi4>
Date:   Wed, 10 Jun 2020 10:06:35 -0700
In-Reply-To: <20200610143404.5sgww2fmsouubloj@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 10 Jun 2020 16:34:04
 +0200")
Message-ID: <xmqqmu5ag89w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BDF8136C-AB3C-11EA-9706-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Tue, Jun 09, 2020 at 07:31:23PM -0400, Martin Langhoff wrote:
>> Hi Brian,
>>
>> good question! There is a .gitattributes file, all the files affected
>> have these attributes
>>
>> *.py     text diff=3Dpython
>
> That is the important information, that we need.
> Since there is a .gitattributes file, (wich is good),
> you can forget about core.autocrlf (at least for all python files).
> (That should be clear from the documentation of Git,
>  but it could be, that we can make things more clear).

So a "text" attribute trumps the settings of autocrlf?  That makes
it sound like ...

> There is only one way out of this dilemma:
> renormalize the line endings in the repo (and live a happier life ;-)

... there is another way out, which is to drop "text" attribute?
