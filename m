Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F387C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D500464E10
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhBPSpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:45:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52138 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhBPSpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:45:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79262A6271;
        Tue, 16 Feb 2021 13:44:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cHkBOIyn9R6L
        ugMtNjuWeUhbIt0=; b=il283EoWLTSNxWdzFA/NW93rlH31MWTYDBjl5ZIbxERt
        6nR1JcvyyQPPkJJqVxnABYfoRMHYjArKPyZKTS+GZzi+QKNNVEMe0XlPqtMwsGX9
        qjv/bf8QsP84HB4m6SIN+JYoTfp2LXdcFGgKEH4qAnipbdPwnUshWA177GeidHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Rc1PpS
        m02pH9cofR5oClXaupYOZMESPcPGl58dQfXNtLwICUiFaYO6ss+De8aMZTQzCX9c
        +8nASfapeh0ffOHUSxg4Ue6QqsZnDT0IddvvC7x2sHhfMqPYdhrNDIFo88zHgfZh
        mX+lzUU+FNzyuCwEtf1jtNgLtPWJiXYcf/jZ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71264A6270;
        Tue, 16 Feb 2021 13:44:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC5F6A626F;
        Tue, 16 Feb 2021 13:44:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pretty: add %(describe)
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
        <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
        <87pn109nhr.fsf@evledraar.gmail.com>
Date:   Tue, 16 Feb 2021 10:44:33 -0800
In-Reply-To: <87pn109nhr.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 16 Feb 2021 14:00:00 +0100")
Message-ID: <xmqqft1vrgxa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0319E88E-7087-11EB-A6EF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Feb 14 2021, Ren=C3=A9 Scharfe wrote:
>
>> Add a format placeholder for describe output.  Implement it by actuall=
y
>> calling git describe, which is simple and guarantees correctness.  It'=
s
>> intended to be used with $Format:...$ in files with the attribute
>> export-subst and git archive.=20
>
> Does it really guarantee correctness though? In "builtin/describe.c" we
> first walk over the refs and use that to format all N items we're asked
> about.
>
> Under "git log" this is presumably in a race where refs added/deleted
> during the run of "git log" will change the describe output to be
> inconsistent with earlier lines.

Yes, but it is not a news that the describe for a given commit will
not stay the constant while you add more objects to the repository
or you change the tags, whether the "describe" is driven internally
by "git log" or by the end-user, so I am not sure how that becomes
an issue.  If the output is inconsistent in a quiescent repository,
that would be a problem, though.

Puzzled.

Thanks.

