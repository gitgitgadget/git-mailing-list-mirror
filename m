Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E2D1FE90
	for <e@80x24.org>; Thu, 20 Apr 2017 03:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940507AbdDTDIH (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 23:08:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55160 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935178AbdDTDIG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 23:08:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6931F6DA91;
        Wed, 19 Apr 2017 23:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MqykIGMyNSUk
        uDt2mN5Wxdjij6s=; b=ZvkPRYXJgTtnfLepVfF5h6qR0ghcteD+m4xtQ9U7v0ij
        povVrqCKWezoUNER8fkL9GZWJYjhF1jA5s3a4G7dGI9de+IxV1XhBc21B32xiGHO
        Pl5uT783h2EC6/uRVXgUNWtNIxfJGAX5Lb64peDRqzUf3uuVDxH5Dhuq2j2tK+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=D8NMUq
        pkSDkpgWix7C8KILEMX9tC95tXhclqsBunVUpsrnx93G9Ne7BFcfj3s4RK52BpmZ
        Z+udRyvDlqp04qC3muY2uM/XHIbctyRM0Go4kl+uV6nWnTRxu02f+PnIPedHsGyJ
        g88habcwyFqsfgQ+Gz7eqS0EFuXspPoOF62bM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F3D06DA8F;
        Wed, 19 Apr 2017 23:08:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C07D26DA8E;
        Wed, 19 Apr 2017 23:08:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 08/12] refs: remove dead for_each_*_submodule()
References: <20170419110145.5086-1-pclouds@gmail.com>
        <20170419110145.5086-9-pclouds@gmail.com>
        <bc3795da-4d9e-ac57-a011-28017494a71d@ramsayjones.plus.com>
Date:   Wed, 19 Apr 2017 20:08:02 -0700
In-Reply-To: <bc3795da-4d9e-ac57-a011-28017494a71d@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 19 Apr 2017 17:07:28 +0100")
Message-ID: <xmqqo9vrai99.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91A5E978-2576-11E7-B963-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 19/04/17 12:01, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> These are used in revision.c. After the last patch they are replaced
>> with the refs_ version. Delete them (except for_each_remote_ref_submod=
ule
>> which is still used by submodule.c)
>>=20
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
>> ---
>>  Documentation/technical/api-ref-iteration.txt |  7 ++-----
>>  refs.c                                        | 29 ------------------=
---------
>>  refs.h                                        |  9 ---------
>>  3 files changed, 2 insertions(+), 43 deletions(-)
>>=20
>> diff --git a/Documentation/technical/api-ref-iteration.txt b/Documenta=
tion/technical/api-ref-iteration.txt
>> index 37379d8337..c9e9a60dbd 100644
>> --- a/Documentation/technical/api-ref-iteration.txt
>> +++ b/Documentation/technical/api-ref-iteration.txt
>> @@ -32,11 +32,8 @@ Iteration functions
>> =20
>>  * `for_each_glob_ref_in()` the previous and `for_each_ref_in()` combi=
ned.
>> =20
>> -* `head_ref_submodule()`, `for_each_ref_submodule()`,
>> -  `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
>> -  `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()=
`
>> -  do the same as the functions described above but for a specified
>> -  submodule.
>> +* Use `refs_` API for accessing submodules. The submodule ref store c=
ould
>> +  be obtained with `get_submodule_ref_store().
>
> missing ` ? ------------------------------------^

Indeed.  Will tweak while queuing.
