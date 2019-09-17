Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 353F91F463
	for <e@80x24.org>; Tue, 17 Sep 2019 22:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfIQWfN (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 18:35:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58407 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQWfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 18:35:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2B98331BE;
        Tue, 17 Sep 2019 18:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JuZN30AvcwDq
        2oSUV7gEKyYK9O0=; b=s1OPPQOj+VXON1X2op+zKCs528uoJ/LmI5q6OeXatZXF
        1B+lHqgn3SJp7yWERw4yVxSbSPimUGTIDbtt0MLKbTB+XR8wWbVKmEwggVyeG00u
        EtdPqG+X+spawwCw6tBBeLa++yzClJh24pYQ/zHSAJVZuDNgzIPmwaGXnHW2ajc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mZv9aW
        90Xo9B4SnSnF4wK+HNc814b22yxVx0iWn90Of4oghOW/17q/Fz+wBemWVQqMNnMS
        UyevWE241bouPrZ6Onp5ZQdvk36OsXYveYwYxQRpqmt1/QX2VgUHpFrBkBuOMtx3
        8ACr37gpnCS8nUMDpJafrP7sx3S6a99BYx0Sc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5097331BC;
        Tue, 17 Sep 2019 18:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74562331BA;
        Tue, 17 Sep 2019 18:35:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Herv=C3=A9?= Beraud <herveberaud.pro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Rewrite feature to render hg-to-git compatible with python2.x and 3.x
References: <01020161b421939a-4ad52aaa-dda8-4250-9bce-71f0ede1a199-000000@eu-west-1.amazonses.com>
        <0102016d3f74d202-d5b32dd4-0098-4ad0-8ac7-5fde254f7796-000000@eu-west-1.amazonses.com>
Date:   Tue, 17 Sep 2019 15:35:05 -0700
In-Reply-To: <0102016d3f74d202-d5b32dd4-0098-4ad0-8ac7-5fde254f7796-000000@eu-west-1.amazonses.com>
        (=?utf-8?Q?=22Herv=C3=A9?= Beraud"'s message of "Tue, 17 Sep 2019 13:41:23
 +0000")
Message-ID: <xmqqd0fy7dra.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 65F123E8-D99B-11E9-BC42-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Herv=C3=A9 Beraud <herveberaud.pro@gmail.com> writes:

> Rewrite features that are no longer supported (or recommended)
> in Python 3 in the script so that it can be used with both
> Python 2 and 3, namely:
>
> - print is not a statement; use print() function instead.
> - dict.has_key(key) is no more; use "key in dict" instead.
> - map(lambda ..., collection) is not liked; use list comprehension.

The first two are must haves (iow, without them the code would not
work with Py3), but the last one sounds like a mere preference.  Is
there some authoritative source we can quote (e.g. "PEPx says that
we should prefer X over Y")?

> These changes introduce a syntaxe compatible with the both versions of
> python.
>
> Python 2 is EOL at the end of 2019, the major part of distros
> and systems now come with python 3  is the default version so
> these address the situation to render this script compatible with
> the latest versions of python.

The explanation looks vaguely familiar.  I would have placed the
background first, and then description of what is done next, perhaps
like:

    Python 2 is EOL at the end of 2019, many distros and systems now
    come with python 3 as their default version.

    Rewrite features that are no longer supported (or recommended)
    in Python 3 in the script so that it can be used with both
    Python 2 and 3, namely:

    - print is not a statement; use print() function instead.
    - dict.has_key(key) is no more; use "key in dict" instead.
    - map(lambda ..., collection) is not liked; use list comprehension.

to make it even easier to read without unnecessary repetition, but
what you wrote is clear enough already.

The patch text looked clearly done.  Nice.
