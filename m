Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA5C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39AD2207E8
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ti1bP4Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgETUXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 16:23:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63553 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgETUXa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 16:23:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD6D9604E5;
        Wed, 20 May 2020 16:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nMxCq1mkJZbV
        0O0GWmuNCJoAZzA=; b=ti1bP4DzwqHtIwkPEX0c8BcOH46C8NUyVwg4ZsQOx5yB
        WYhpk8HmvZ+hlJDsnmpzIu0v+sGtr48IIFtK+sRh9cFNt9x+Om0NWYrhcvUjJKQQ
        qwxQ6WH11UNYRyOAImN+6yrW9Qwbc6x7a6qK1kBMIp5Xb6DQtM237mZ96Jj3Z/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XBnVFo
        2O4pEA0bhX70GKMTx/bEHFgqqKWkYO8Vm9ca6cXnJB6JqAj5C0I+Aqb7eWmN29fs
        trb70rTi9+tXnkziQBAs+7Nqzfr+3X1jbVpzRgkfaxvfSOsX/R7pg1+yCtnxWpKB
        2Axb8PfoWYMk4Fqnds9jss9EBRvj51y0ftzLc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D577A604E4;
        Wed, 20 May 2020 16:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59BC3604E3;
        Wed, 20 May 2020 16:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2020, #07; Wed, 20)
References: <xmqqr1vev2ke.fsf@gitster.c.googlers.com>
        <20200520200217.GD20332@Carlos-MBP>
Date:   Wed, 20 May 2020 13:23:26 -0700
In-Reply-To: <20200520200217.GD20332@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 20 May 2020 13:02:17 -0700")
Message-ID: <xmqqeereuzi9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C352EBCC-9AD7-11EA-922E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Wed, May 20, 2020 at 12:17:21PM -0700, Junio C Hamano wrote:
>>=20
>> * cb/t4210-illseq-auto-detect (2020-05-18) 2 commits
>>  - t4210: detect REG_ILLSEQ dynamically and skip affected tests
>>  - t/helper: teach test-regex to report pattern errors (like REG_ILLSE=
Q)
>>=20
>>  As FreeBSD is not the only platform whose regexp library needs
>>  REG_ILLSEQ prerequisite, add a logic to detect the prerequisite
>>  automatically.
>
> since this does no longer use a prerequisite, it might be probably
> better to use somethig like :
>
> As FreeBSD is not the only platform whose regexp library will report
> a REG_ILLSEQ error when fed invalid UTF-8, add logic to detect that
> automatically and skip the affected tests.

Thanks.  That does read much better.
