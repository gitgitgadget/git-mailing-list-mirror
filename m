Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563C91F463
	for <e@80x24.org>; Wed, 18 Sep 2019 17:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfIRR2i (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 13:28:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57699 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfIRR2i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 13:28:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58C6E7FC29;
        Wed, 18 Sep 2019 13:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uN7kr8EfPvHL
        G11lqJC7QXvIRnE=; b=WO8FA6FP3V6PO81vV0i7xXPkFvn+L6LfATv7mq+sqOG2
        rDzYGK2XvxzE+9bD/fVm8EdmefF+Q7/hpXERlx0nE0yVXG1Dp/JekHLc1rbOyndk
        5xMTGr+k0wrq7Bm5vKcsktUnQC9uGnbcr7PqrKRLCleArp+VSqyV+IHL1jh6tbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vDWfS/
        LWHQb94/3CtTYSIQNM78nuHk5xVcgYwDV/X4Xk++72wnZ+rcGT/nkRHuqHSSzJHK
        1DlGrONY9AmaAFATO3clfhQOOltLzEJNnYBdyWrZJEhu6al311fWsNfGaEcdZ8F/
        46fw9U/DIkxHbmEHPilE8spYZ420B4L6k9TA4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5191E7FC28;
        Wed, 18 Sep 2019 13:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F4C67FC25;
        Wed, 18 Sep 2019 13:28:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Kamil =?utf-8?Q?Doma=C5=84ski?= <kamil@domanski.co>,
        git@vger.kernel.org
Subject: Re: [PATCH] ls-remote: create '--count' option
References: <20190918001134.20776-1-kamil@domanski.co>
        <f643547f-54e0-fe4f-d8e5-95445431faf3@kdbg.org>
Date:   Wed, 18 Sep 2019 10:28:28 -0700
In-Reply-To: <f643547f-54e0-fe4f-d8e5-95445431faf3@kdbg.org> (Johannes Sixt's
        message of "Wed, 18 Sep 2019 08:28:11 +0200")
Message-ID: <xmqqo8zh5xab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BB81FF1E-DA39-11E9-83FC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 18.09.19 um 02:11 schrieb Kamil Doma=C5=84ski:
>> Create a '--count' option for ls-remote, based on the one from
>> for-each-ref. This allows e.g. to return only the first result
>> from a sorted list of refs.
>>=20
>> Signed-off-by: Kamil Doma=C5=84ski <kamil@domanski.co>
>> ---
>>  Documentation/git-ls-remote.txt | 11 ++++++++---
>>  builtin/ls-remote.c             | 16 ++++++++++++----
>>  t/t5512-ls-remote.sh            |  9 +++++++++
>>  3 files changed, 29 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-re=
mote.txt
>> index 0b057cbb10..5adc1d676e 100644
>> --- a/Documentation/git-ls-remote.txt
>> +++ b/Documentation/git-ls-remote.txt
>> @@ -9,9 +9,9 @@ git-ls-remote - List references in a remote repository
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=3D<exec>]
>> -	      [-q | --quiet] [--exit-code] [--get-url] [--sort=3D<key>]
>> -	      [--symref] [<repository> [<refs>...]]
>> +'git ls-remote' [--count=3D<count>] [--heads] [--tags] [--refs]
>> +	      [--upload-pack=3D<exec>] [-q | --quiet] [--exit-code] [--get-u=
rl]
>> +	      [--sort=3D<key>] [--symref] [<repository> [<refs>...]]
>
> It is understandable that the new option is important to _you_, but it
> does not seem important enough that it must be the first in the list.
> Please add it between --symref and <repository>
>
>> =20
>>  DESCRIPTION
>>  -----------
>> @@ -21,6 +21,11 @@ commit IDs.
>> =20
>>  OPTIONS
>>  -------
>> +--count=3D<count>::
>> +	By default the command shows all refs that match
>> +	`<pattern>`.  This option makes it stop after showing
>> +	that many refs.
>
> Is the meaning of this option perhaps:
>
>     Stops after the specified count of refs have been listed.
>     If `--sort=3D<key>` is specified as well, refs are counted
>     after sorting; otherwise, it is unspecified which subset
>     of is listed.
>
> I do not know whether the "otherwise" part would be true (check it!),
> but I am pretty certain that the "If" part must be true, otherwise the
> option would be pointless.
>
> The comment about the ordering of this paragraph at the very beginning
> of the option list applies here, too, because the list is not sorted
> alphabetically.

All sensible comments and suggestions.  I am not sure what's so hard
to pipe the output to "head -n 20" or something like that, though.
