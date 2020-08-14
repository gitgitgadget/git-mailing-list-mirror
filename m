Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A404C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52EDF20838
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QxeoXoKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHNBGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:06:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55221 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHNBGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 21:06:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87BFF7CF88;
        Thu, 13 Aug 2020 21:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rtSKaziZW7Ct
        GdiU41uw23Ixzn4=; b=QxeoXoKdZf9pMesUHxrxuF+m02gF9vs08IZ4YNdLh1P+
        ENcIM/Rfpa21Bgmk1jnhusDZBgmfbP4dPO+JUudG/80UvJIKuLfjGyhXej3zUOMU
        g4bieMgjsi1Y6s58hETAHNWnD4NJiYcZ0tDB54aPELnF+zpEU/ufEuqn37TqJnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=efaR/C
        fz+pYn8vs8tYDewpBnKQpf31B7fG3y5g6S15ErgseNj17MfcFP7q5SYA1WqkFz68
        Q+SjeYfDYNBTPCjPCp99o1lWeX5olx2G9sLfdx6LSfjCyWRcJFUSuMWanEsamo56
        4qhI9RFmSvbQbwNFwtOg/xXoSHfrDIuOcDDzA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FC827CF87;
        Thu, 13 Aug 2020 21:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D73E7CF86;
        Thu, 13 Aug 2020 21:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] revision: differentiate if --no-abbrev asked explicitly
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597364493.git.congdanhqx@gmail.com>
        <9a26c5b6110081cd8d029f2ab0327c4a1d228ef7.1597364493.git.congdanhqx@gmail.com>
        <xmqq8sei125k.fsf@gitster.c.googlers.com>
        <20200814005947.GA9518@danh.dev>
Date:   Thu, 13 Aug 2020 18:06:22 -0700
In-Reply-To: <20200814005947.GA9518@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Fri, 14 Aug 2020 07:59:47 +0700")
Message-ID: <xmqqzh6yyr1t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5EBB949E-DDCA-11EA-96C2-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Let me list some combination here:
>
> * none of --abbrev --no-abbrev --full-index -> default short index
> * --abbrev --full-index                     -> full-index
> * --full-index --abbrev                     -> full-index
> * --abbrev --no-abbrev                      -> full-index
> * --no-abbrev --abbrev=3D[n]                  -> shortened index to n c=
har
>
> So, we can't use full_index bit, because --no-abbrev can be defeated
> by --abbrev, but --full-index will always win --abbrev.

Sure, I wasn't suggesting to flip the flags.full_index bit upon
seeing "--no-abbrev".  When --no-abbrev is in effect (i.e. the last
one among --no-abbrev, --abbrev, or --abbrev=3Dn), .abbrev field is
set to 0.  So wouldn't it be sufficient to say

 - If flags.full_index bit is set, show the full object name

 - If abbrev is 0, show the full object name

 - All other cases, after clamping the value of abbrev to reasonable
   value, truncat the object name to that length

What am I missing?

> I'm planning for:
>
> * BOTH --abbrev and --no-abbrev but NOT --full-index;
> * BOTH --abbrev AND --full-index

