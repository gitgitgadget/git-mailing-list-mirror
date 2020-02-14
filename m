Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A74C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DE2222C4
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JiIakIns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbgBNRcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:32:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58396 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391122AbgBNRcL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 12:32:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01FA446D03;
        Fri, 14 Feb 2020 12:32:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JdEfpetHNyw526ZRpkGFb0uE+sM=; b=JiIakI
        ns9u/ps7oiS0KrybbR71n08Y25BfBQTZLsUBZDzUOEDRF6FMXeQdd7OA9kW04KaJ
        wYLfri5Xe1dOMlA4p//cRa6HuiDe9ehB+6iD8QwWMLOT2SDsCpR7VoZhoPTf8yvI
        V0Nq0RvGw1Q3G8DxbN1kWlbsA2+oLH4NM12NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZlnWqS2APDZyx+PXL6z8rJGzIAzLweec
        W82qay6XbrefgKaD9mSiLIBrF4fJ96ECjjbaKGZ3Kaz+y6i2lXaWzbifjaieS8Bh
        wnfPwiQ0DkZCppCQE7AeNxSI5bvici/VnOdwkfoMMD9iLb2Tg/KRrKXuAvBjZhK2
        hjhVdU3SOkM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED2E946D02;
        Fri, 14 Feb 2020 12:32:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EA9846D01;
        Fri, 14 Feb 2020 12:32:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v7 00/15] add git-bugreport tool
References: <20200214015343.201946-1-emilyshaffer@google.com>
Date:   Fri, 14 Feb 2020 09:32:08 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 13 Feb 2020 17:53:28 -0800")
Message-ID: <xmqqv9o9nkh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED79B77E-4F4F-11EA-A1A8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>    present(patch 9/15). This now uses POSIX character classes and {}
>    notation instead of + and has been tested on OSX; I'd love to hear if

I'd rather not to see unnecessary uses of POSIX character classes.

The interdiff of this step between the previous and this round looks
to me more like "I used it, just because POSIX says I *can* use it",
not "I did so because I needed to do, and it should be OK on POSIX
platforms."

Instead of overly long

's/^\([^[:blank:]]*\)[[:blank:]]\{1,\}annotate:bugreport\[include\].* ::$/  "\1",/p'

just limiting ourselves to SP and saying

's/^\([^ ]*\)  *annotate:bugreport\[include\].* ::$/  "\1",/p'

would keep the result much easier to read, I would think.

