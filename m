Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D9C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 23:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ADFF610E5
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 23:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhHSXtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 19:49:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59737 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhHSXtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 19:49:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67E7FE1425;
        Thu, 19 Aug 2021 19:48:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SgSi37RiqlFS
        Ey21mP3rjyYfWMsQBHpI+zj0oCf2yTc=; b=IglfpNEgY2m5ufsPerk47Af9OCpm
        NUx906NQlOmLCGfikwUhL82zVsnIEWHm+20EwkGoa3aQxFPoAYIz17HlaX9WznWS
        +vFL5mm82szukMgXsSvmSezVUg13QBaKAcoWmxswdU/nL4GN00TeluyiASgRJCDH
        YNW1LiurQww5X1I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60202E1424;
        Thu, 19 Aug 2021 19:48:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DEBC9E1423;
        Thu, 19 Aug 2021 19:48:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] hook: include hooks from the config
References: <20210819033450.3382652-1-emilyshaffer@google.com>
        <20210819033450.3382652-6-emilyshaffer@google.com>
        <xmqqo89txdo5.fsf@gitster.g> <YR7sko1vKy1rpJR/@google.com>
Date:   Thu, 19 Aug 2021 16:48:31 -0700
In-Reply-To: <YR7sko1vKy1rpJR/@google.com> (Emily Shaffer's message of "Thu,
        19 Aug 2021 16:43:14 -0700")
Message-ID: <xmqqfsv5xagg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5C5617A-0147-11EC-99F4-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Thu, Aug 19, 2021 at 03:39:06PM -0700, Junio C Hamano wrote:
>>=20
>> My original question was primarily because I thought the
>> second-level <name> corresponded to <event>.  If that were the case,
>> it can trivially be made simpler without making it typo-prone, i.e.
>>=20
>>     [hook "pre-commit"]
>> 	command =3D check-whitespace && spellcheck-log-message
>>=20
>>     [hook "another-hookable-event"]
>> 	command =3D check-whitespace && spellcheck-log-message
>>=20
>> since the name of the event would be much shorter than the command
>> line.  But since we are not grouping per hookable event (to apply
>> the "last one wins" rule to determine which single command is the
>> one that gets to run).
>>=20
>
> To be clear, the config schema did work the way you describe until this
> revision. =C3=86var suggested the change and it seemed like a good idea=
 to me
> (and the rest of the Google folks) so I changed between v2 and v3 of th=
e
> restart.

To be clear, you do not want to take the above as my suggestion to
go back to the previous one, since that is not what I meant.  As
long as you and others are happy with what you folks ended up with,
i.e. the current one that uses <name> that is a short-hand for
<command>, that is what matters.

Thanks.
