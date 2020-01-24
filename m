Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9699C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 23:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ED1206D5
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 23:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jdfSQpxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgAXXrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:47:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58932 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgAXXrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 18:47:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 946FF4313F;
        Fri, 24 Jan 2020 18:47:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EzAstrHBH4YY
        aWFQBbLsdSgv9os=; b=jdfSQpxoF4apmtkkEpb1NV1mi4SAY2kbR6lYthIEhAMo
        vZRLVFpJD3ysiNZkPyAqIYfYmQM9BmZ2GfUTIuFX6tP5/4v5w17JXklA+5F8W1Nx
        QSdUTuWRW/lQcN14+hJGdNHxeea9JL+6HSJXXRl1hXDuHja/71xLagnMntExsic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IWRyjB
        8qoUltD/UbFBtieOiRt/ZLqf/rTE7cQIEoigDFatlJb9pJ5oFRktylPhvHQxUye5
        qKgJn398QJf9o/AsV9lgjlzs2vJTUfBCrahI/ufALbvjqIF+sruFear3DarDDwY1
        WnLo49khEHGSXB1ClrbbM68SRycl2PnghP+0A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C1984313E;
        Fri, 24 Jan 2020 18:47:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EED824313D;
        Fri, 24 Jan 2020 18:47:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] checkout/reset/read-tree: fix --recurse-submodules in linked worktree
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
        <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
        <xmqqwo9j5ei3.fsf@gitster-ct.c.googlers.com>
        <69FFF66E-9273-488F-A747-2B4EBBDD7A7B@gmail.com>
        <37804466-7DC9-4161-9B98-D2175233831D@gmail.com>
Date:   Fri, 24 Jan 2020 15:47:16 -0800
In-Reply-To: <37804466-7DC9-4161-9B98-D2175233831D@gmail.com> (Philippe
        Blain's message of "Fri, 24 Jan 2020 18:00:39 -0500")
Message-ID: <xmqqd0b8ct8b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DB00DFD4-3F03-11EA-B841-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>>>> Cc:Max Kirillov max@max630.net [max@max630.net] Brandon Williams=20
>>>> bwilliams.eng@gmail.com [bwilliams.eng@gmail.com] Jonathan Tan=20
>>>> jonathantanmy@google.com [jonathantanmy@google.com] Stefan Beller=20
>>>> stefanbeller@gmail.com [stefanbeller@gmail.com] Nguy=E1=BB=85n Th=C3=
=A1i Ng=E1=BB=8Dc Duy=20
>>>> pclouds@gmail.com [pclouds@gmail.com] Eric Sunshine sunshine@sunshin=
eco.com
>>>> [sunshine@sunshineco.com] Derrick Stolee stolee@gmail.com [stolee@gm=
ail.com]
>>>=20
>>> This is somewhat unreadable wall of names X-< Is it a funny
>>> rendering of what is originally in some mark-up format (perhaps
>>> HTML???)
>>=20
>> Yes, Gitgitgadget unfortunately failed to convert this wall of text in=
to a proper CC: list because there was no space between the "Cc:" and "Ma=
x".=20
>> I=E2=80=99ll try to submit a PR for that in GGG.=20
> For the record, https://github.com/gitgitgadget/gitgitgadget/pull/198 h=
as been merged so this should not happen again.

That's good to know.  As long as the resulting e-mail addresses are
sensible (e.g. if Markdown markups are not cleansed enough and the
duplicated addresses inside [] seep through, the result would still
not be good), it is OK.

Thanks.
