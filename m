Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F4E1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 18:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406154AbfITSDw (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 14:03:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55462 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404946AbfITSDw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 14:03:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 358252DEB2;
        Fri, 20 Sep 2019 14:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3d7xBB0if2eP
        c4QrYO2SeLwL/z4=; b=ZNtIC79w+cwACkrLjaqb7Ex9pD5TGPmrUpC+z1HnYy4A
        Q71nMUqCg53CrtthQsUvnAFWG7k2/5xyf2yJFpzGHQ2BtwG7jOZbno+Rot2FMq8a
        +KUCQa30BUizfMl6oqYokTsNsmL1FRWiHj1NBjLkg9YHyWuh8OO0ENsH5pP8qyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZJpQuX
        5cRC6vVrmLpF6bSfhrq7Q3+E/TsEKYQkXXVPvDUKwGzPrna4PlSUcUOvL8gu/vrG
        FnexoeHj+0Kwys91dnmkgR3bn6JpqXyuwm3EYeqoOWwl0k9naMrgFQb0zMQHQ5PY
        beW9gIp0LokTyH151lTnO2w7PaJpud7ZgfbGs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B4832DEB1;
        Fri, 20 Sep 2019 14:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5551C2DEB0;
        Fri, 20 Sep 2019 14:03:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: ignore already tested trees in debug mode
References: <20190919173514.24074-1-szeder.dev@gmail.com>
Date:   Fri, 20 Sep 2019 11:03:48 -0700
In-Reply-To: <20190919173514.24074-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 19 Sep 2019 19:35:14 +0200")
Message-ID: <xmqqftkqvo8r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF41D2A4-DBD0-11E9-A474-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>  skip_good_tree () {
> +	if test "$TRAVIS_DEBUG_MODE" =3D true
> +	then
> +		return
> +	fi

I think you convinced readers why it is a good idea to avoid
skipping an already tested tree, and technically the title of this
commit is not incorrect per-se.  You are teaching to ignore
"already-tested-ness" from a part of the logic).

But in the larger picture, I would expect that readers would more
immediately grasp what it is about if it were titled "do not skip
versions that have already tested good in debug mode" or something
like that (IOW, we do not want to ignore such trees, we want to test
them again).

