Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112EAC433E2
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD47520720
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iOWI5ct4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgGUUeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:34:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64786 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgGUUeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 16:34:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4508F1BE4;
        Tue, 21 Jul 2020 16:34:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O54XJfImkCeI
        gsdZyMbU8VIfJMc=; b=iOWI5ct4oi2nN7PJ/Ifc1OB9XwLpVNh7QxXUtsYmbFhn
        MF0Y9DS+0Gcqd01utxWoXsN9Mt6ZYfMwB4iNR6bAQAw9SrrFBNzIg66JNcOO9LqZ
        nXp4rnLLmq+sU2Te/X7lMUJ8olrtJKWRf9AclNFw+qUwRx9MI5f+Nr0JD4ajePs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=C8wJVr
        cIrOkip+XfpFscKA8xkJxA8apPq7Zjhnwb+3VNSHy/2JAkAF4KBKSB9SJPxxHycK
        YxCL7RBJi6ThtohhviOAaB2OX9d9RuBiKBbxIE1GsuBLH8yoc8SAHRDySDpw3hSm
        TKccpkuLd96OuM4Uo+ZZlyCq9XOJpvBdsjHbQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD476F1BE3;
        Tue, 21 Jul 2020 16:34:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 127A4F1BE0;
        Tue, 21 Jul 2020 16:34:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] [RFC] travis-ci: remove bogus 'pyenv' in the Linux jobs
References: <20200721161225.6769-1-szeder.dev@gmail.com>
Date:   Tue, 21 Jul 2020 13:34:29 -0700
In-Reply-To: <20200721161225.6769-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 21 Jul 2020 18:12:25 +0200")
Message-ID: <xmqqsgdk7gkq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9520FAD8-CB91-11EA-B8C5-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>     Alternatively, we could avoid the PATH lookup and thus the bogus
>     'pyenv' by explicitly using '/usr/bin/python{2,3}'.  The Linux imag=
es
>     in both Travis CI and Azure Pipelines are standard Ubuntu images, s=
o I
>     think we can safely rely on these Python paths.

That sounds quite sensible, actually.  The CI environment being
"special" in the sense that we have certain control over it makes
this rather straight-forward.



