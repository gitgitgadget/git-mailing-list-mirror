Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A9C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 01:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410CF233CF
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 01:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAJBSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 20:18:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64848 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAJBSF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 20:18:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 787639FF1F;
        Sat,  9 Jan 2021 20:17:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DrAaUGTw6i6D4/rm1y4w6tSs01A=; b=sIZone
        iNqQktgooZdsCDL6SKcmhieXBnMpph6de3XuiZLRGECCPZW4PKk9cCRf7rhNtkMS
        zLuO4KfU+2thArIN/DL/2GbNv2Vj4fpx3Y7/PkfTeJiYUnWl8Tj4bD+qWeW/GzYc
        q6PbiUIzDxf7My/etaZ02yWH2R2JDqwrTGkkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RZur2bs1R5k4Hp2kRLB67WGlGw+AAck6
        wDe3P+4jVO4rY/g9H4kZvuli3212XjlH55alAwoGAUuHnJAHeagk4DpqTahIVdso
        hbo66rCbnqo0di96YGuB5qtlwnSdMApRpkC1bVhXDyEvrgE4nLfWgNYSUJhGG1jN
        SlKVcZayK0M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F83C9FF1E;
        Sat,  9 Jan 2021 20:17:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E81E69FF1D;
        Sat,  9 Jan 2021 20:17:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] fixup! mergetool: add automerge configuration
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
        <20210109224236.50363-1-davvid@gmail.com>
        <20210109225400.GA156779@ellen>
Date:   Sat, 09 Jan 2021 17:17:22 -0800
In-Reply-To: <20210109225400.GA156779@ellen> (Seth House's message of "Sat, 9
        Jan 2021 15:54:00 -0700")
Message-ID: <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 979D0D7E-52E1-11EB-B312-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Sat, Jan 09, 2021 at 02:42:36PM -0800, David Aguilar wrote:
>> Replace "\r" with a substituted variable that contains "\r".
>> Replace "\?" with "\{0,1\}".
>
> Nice. I was (very slowly) converging on that as the culprit. Thanks for
> the elegant fix! I'm running the test suite on Windows and OSX (now that
> they're set up locally) with this included and I'll send a v10 once
> complete.

Note that the topic fails t7800.5 even with the fix-up (and without
these fix-up on a platform with sed that do not need the portability
fix-up).
