Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38BB81F731
	for <e@80x24.org>; Sat,  3 Aug 2019 14:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfHCOoT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 10:44:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51274 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHCOoS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 10:44:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B02B163971;
        Sat,  3 Aug 2019 10:44:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SPRciN0USRMg
        U7NdgcTYUi2Bqmg=; b=czebP7+HrSNizPQ/6qBVrZCZ5YzCtPBdndGpoy0vRBta
        idwot5ypx81+1N103Z8HV0zIXUmDBRatA4K8qVAvOMQNvKCkgVj8FvjijQZOD7GQ
        bwVWLYv4KOc+cSz5Qg8aIXoP/ng7zzbDUOBoqv4m6diFM137js6a2cDBKqRlU8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PxMe69
        vgls9EfcRNGbMA055NkaKdL/Jm9u56YRTQ0r0s4qNO8so6TsG3ew5jN4P3QlhztK
        Hb4mhCoDV735FFyT3uAXyTmIqBRwd1ZiL3p8rmATdttVJcV2uUnUwsKzsn/ORmIW
        F8Hlwrit1dh+OkjQZ9w0QewZ1+mM0+46N9+iI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91E4F163970;
        Sat,  3 Aug 2019 10:44:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0447716396F;
        Sat,  3 Aug 2019 10:44:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?Q?=C3=89tienne?= SERVAIS <etienne.servais@voucoux.fr>,
        git@vger.kernel.org,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: Re: Simplify-by-decoration with decorate-refs-exclude
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
        <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
        <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
        <5de287e9-a8e8-780a-7d39-2229b61914ca@web.de>
        <xmqqh86zjmcg.fsf@gitster-ct.c.googlers.com>
        <64bc5556-b098-7991-b7c2-3483277bb73c@web.de>
Date:   Sat, 03 Aug 2019 07:44:14 -0700
In-Reply-To: <64bc5556-b098-7991-b7c2-3483277bb73c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 3 Aug 2019 08:51:38 +0200")
Message-ID: <xmqqwofuia0x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2AC438B2-B5FD-11E9-AE62-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Sure, but we'd need to move the code to handle the raw format as well, =
no?
> Perhaps like this?  It depends on callers of parse_revision_opt() calli=
ng
> setup_revisions() before using decorations.  And it may have other side
> effects; I'm not comfortable with this change.

Hmph, fair enough.  I missed the fact that we do want to keep
"--pretty=3Draw" being "special" but only in "log"; a move in this
direction teaches the revision walk API layer about it, which is
probably not a good idea.

Thanks for sanity checking.

