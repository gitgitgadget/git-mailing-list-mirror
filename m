Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70916C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 01:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiISBZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 21:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiISBZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 21:25:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C0FD0D
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 18:25:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77CE9139E2E;
        Sun, 18 Sep 2022 21:25:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RgO2IayZYIhE
        IjQjQbaGwh8l/4MUel8AmAMMbme2HpM=; b=WVMD1StaTs4nHaEt5UhPM8id3AMs
        ukz8PZR6va2sE/4g1HLFOFkuUnGE3vnzxv9ZmqJTpRBWdJPBjuANstalYZ+mFETa
        0onDFd+sVyj+0HvCkgg77UX0/61h6GzYgrVduygTfdxkzh7BEykbkYgHZRkA8mbD
        vxtWhg3tYBlbltM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6ECE3139E2D;
        Sun, 18 Sep 2022 21:25:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEA5C139E2C;
        Sun, 18 Sep 2022 21:25:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2022, #04; Thu, 15)
References: <xmqq7d24kpck.fsf@gitster.g>
        <20220918172659.mjkvdpryr3iaitys@tb-raspi4>
Date:   Sun, 18 Sep 2022 18:25:18 -0700
In-Reply-To: <20220918172659.mjkvdpryr3iaitys@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sun, 18 Sep 2022 19:26:59
 +0200")
Message-ID: <xmqq4jx4dukh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ECC673C6-37B9-11ED-882A-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> * tb/diffstat-with-utf8-strwidth (2022-09-14) 1 commit
>>  - diff.c: use utf8_strwidth() to count display width
>>
>>  "git diff --stat" etc. were invented back when everything was ASCII
>>  and strlen() was a way to measure the display width of a string;
>>  adjust them to compute the display width assuming UTF-8 pathnames.
>>
>>  Expecting a reroll.
>>  source: <20220914151333.3309-1-tboegi@web.de>
>>
>
> Just a question:
> Is the patch good "as is" ?

I thought I spotted and pointed out a few remaining bugs?

> Further developments need to go into different patches anyway.
> /Torsten

But these two bugs affect how the width of the lines is computed,
the computation for same number the patch tries to fix, so leaving
them broken would not make the end result any better than status
quo, no?
