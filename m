Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A3C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 22:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiG2WEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiG2WEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 18:04:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC348BABC
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:04:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66CB31A4B6E;
        Fri, 29 Jul 2022 18:04:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PK7UcWCyLajM
        0aPQ93exLgxsEbPzZ1dkwzB4RguP72M=; b=dKWAOj6NRzTR8DM3QfOHtcQ0nTgr
        //ltzwVOy7agbbBXW+mzn/03wKaRlFrlwQK/TlpxmUtkkMnEJjpQvQfuzd4J2JGl
        jeGMXFu2UCYjN+JK9IgyrvPMChVqdVF6KgAxpUMkTREuLBHfO63iWglProtPG1jD
        qx7bmvxaIRUD1Gc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E6361A4B6D;
        Fri, 29 Jul 2022 18:04:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 127E51A4B6C;
        Fri, 29 Jul 2022 18:04:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?TGHEj2EgVGVzYcWZw61r?= <lada.tesarik@olc.cz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Lost file after git merge
References: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
        <220728.865yjhl8wk.gmgdl@evledraar.gmail.com>
        <xmqqilnhcgd7.fsf@gitster.g>
        <701c318c-1a1b-1793-90e8-807cf97dc948@web.de>
Date:   Fri, 29 Jul 2022 15:04:33 -0700
In-Reply-To: <701c318c-1a1b-1793-90e8-807cf97dc948@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 29 Jul 2022 22:23:18 +0200")
Message-ID: <xmqqh72z4lu6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6E6D3250-0F8A-11ED-953D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> Three-way merge between X and Y is all about taking what X did if Y
>> didn't have any opinion on what X touched.  This is exactly that
>> case.  The history 0--->3 didn't have any opinion on what should be
>> in P or whether P should exist, and that is why there is no change
>> between these two endpoints.
>
> The last sentence is not necessarily true.  You could also say that
> 0--->3 cared so much about path P having content A that it brought it
> back from the void.  Determining whether a de-facto revert
> - intended to return to an uncaring state of "take whatever main has" o=
r
> - meant to choose *that* specific content which incidentally is on main
> is not possible from the snapshots at the merge point alone, I think.

Yes, it is doable.  It no longer is a three-way merge if we did so,
though ;-)
