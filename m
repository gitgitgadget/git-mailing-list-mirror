Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB2F1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 04:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeKPOU6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 09:20:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57762 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeKPOU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 09:20:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D9182C335;
        Thu, 15 Nov 2018 23:10:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XOQaWm2mmfWi
        ImlaiKNO7USB3mc=; b=MYjBnttmpgK1UaK4QXD2EbqKePp+LdDQAPJNVl9wDv3t
        ZhxU0brNiByyHwYLC4j1JiuY/m6tij0ReSqwRycASEizTntzfl9sLvsi/TUGMZjd
        L9A95To/L4pPm0/kmRKKJlgXoTrtMdH9kxFBbj7gjikYt5M16xQNrlV0bWglkyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Veefxe
        sSYM/Mjdu5okfumdDrN3EnTZaglL3AXtDfWoZsUXStZNEkdsHB0I5T/S3E0lkm1r
        SnQLVoytntbgiElN3w+aPd90y34WvMd+f17AL+nUN0HUMcgGN1I6lQ9rJ5lHAr0K
        SuhcNJrTHeO3wf59yfkvf22gK1hhgP6WW/dGY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 653102C334;
        Thu, 15 Nov 2018 23:10:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 749572C333;
        Thu, 15 Nov 2018 23:10:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: insteadOf and git-request-pull output
References: <20181115182826.GB25806@pure.paranoia.local>
        <87pnv6189j.fsf@evledraar.gmail.com>
        <20181115192624.GA18204@pure.paranoia.local>
Date:   Fri, 16 Nov 2018 13:10:07 +0900
In-Reply-To: <20181115192624.GA18204@pure.paranoia.local> (Konstantin
        Ryabitsev's message of "Thu, 15 Nov 2018 14:26:24 -0500")
Message-ID: <xmqqbm6pll28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81DBB258-E955-11E8-A152-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Thu, Nov 15, 2018 at 07:54:32PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> > I think that if we use the "principle of least surprise," insteadOf
>> > rules shouldn't be applied for git-request-pull URLs.
>>=20
>> I haven't used request-pull so I don't have much of an opinion on this=
,
>> but do you think the same applies to 'git remote get-url <remote>'?
>>=20
>> I.e. should it also show the original unmunged URL, or the munged one =
as
>> it does now?
>
> I don't know, maybe both? As opposed to git-request-pull, this is not
> exposing the insteadOf URL to someone other than the person who set it
> up, so even if it does return the munged URL, it wouldn't be unexpected=
.

Yeah, I think the local "git remote" should show the rewritten URL
(because that information is not available otherwise) and it is OK
to optionally show the original.  Also, I think it would be nice if
request-pull gave external-facing names.  After all, insteadOf
address is for your own use (e.g. maybe pointing at corporate
mirror), and not for the intended recipient of request-pull.

In short, I think I agree with things you are saying in this
exchange.

