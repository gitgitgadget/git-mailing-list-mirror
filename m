Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC351C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E59610CB
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhJ2FKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 01:10:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57879 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhJ2FKg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 01:10:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16AB2F71CE;
        Fri, 29 Oct 2021 01:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bPvpWvebJuxdPpD2nZPEdmbT+/+FjlhQYeAy0v
        1lXsk=; b=vrCyil3ZQnoINVYrsKqgbnh5jyYtfuCupAKZ4Q2JtdzieZ7y+/9Jch
        0dpVgsHf2JpA4g2To69ejTBEj3JvQcR4Km6OC8H7TkzeSDOXQQ94iTtgV8WviNyc
        jWn/JoSKclXtBYbQ8MrQj7DlQsQmqiR4vW4U1iUqcl2fEwgFXYrVs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBD0DF71CC;
        Fri, 29 Oct 2021 01:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7006F71CB;
        Fri, 29 Oct 2021 01:08:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Nicholas Bransby-Williams'" <nbransby@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: conflict markers in markdown files
References: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
        <xmqq5ytgrkku.fsf@gitster.g>
        <CAGyLXMA93qQw_h97bMd14O26hSxn4xn+AzemVyrf6pn53qO3UQ@mail.gmail.com>
        <xmqqilxgpywf.fsf@gitster.g>
        <CAGyLXMBe2qj8mT+gA2skQr=+bteV9E0nKZ=u-5akCQtTU7AfKA@mail.gmail.com>
        <xmqqilxgoicq.fsf@gitster.g>
        <00c601d7cc53$0ce58800$26b09800$@nexbridge.com>
Date:   Thu, 28 Oct 2021 22:08:05 -0700
In-Reply-To: <00c601d7cc53$0ce58800$26b09800$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Thu, 28 Oct 2021 19:25:04
        -0400")
Message-ID: <xmqq5ytgo1u2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33DB74C6-3876-11EC-AC40-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> It sounds like we might need an attribute like:
>
> *.md	conflict-marker-size=32,conflict-marker-separator='~'
>
> to stick 32 ~ characters as a separator, if going down that path. I'm not
> sure how hard this would be, but tooling other systems, like JGit and every
> client on the planet would be painful.

Well, the underline-style markdown headers can use tilde for headers
below the level that uses hyphens, so you'd need to pick a different
separator letter ;-).  I agree that third-party application would
have trouble with an arbitrary setting of the marker appearance
(note that our own "rerere" knows about the attribute).
