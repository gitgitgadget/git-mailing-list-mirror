Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA66C433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 19:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJITdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJITdV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 15:33:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29F4205DC
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 12:33:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 599131B62D3;
        Sun,  9 Oct 2022 15:33:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5DX12GDufzjAKAnzczaaQPi4fKllDqQsLZCfG2
        Eb2wQ=; b=AUKiU/qy2GBpMsLfu6C72bvkxHxlMkTNTNoCXNBfZZjsMKoWwcazvF
        eEnyEbfF0xiWTtjywKstMAN0DJzVFi0hh3D/6ioXojye2wmVzkKuQHUMEuY2SRAP
        jdBs7bIBs5AMPpApmz6cmbK3Bko+VDocPMbex5NcTP3DK6z+/ieY4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 526181B62D2;
        Sun,  9 Oct 2022 15:33:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D3F21B62D0;
        Sun,  9 Oct 2022 15:33:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
        <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
        <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
        <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com>
        <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
        <a7aca891-dd37-7e5e-61fc-8012fec18ae9@gmail.com>
        <CAPig+cRxy5C+CqUOzmhe16j+hssxsygha3huVga8tLJ+imM4Hw@mail.gmail.com>
        <32e4f8cf-696c-317d-236b-0f64c1398a01@gmail.com>
        <CAPig+cSdQsK7xVBb=ooOfP-hq1zavSV++iorLoni6o6etoLjzQ@mail.gmail.com>
Date:   Sun, 09 Oct 2022 12:33:15 -0700
In-Reply-To: <CAPig+cSdQsK7xVBb=ooOfP-hq1zavSV++iorLoni6o6etoLjzQ@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 9 Oct 2022 02:46:30 -0400")
Message-ID: <xmqq5ygs7pxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38E24884-4809-11ED-BA77-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> That said, I'm not yet seeing all that much added value in such a
> function; at most, it seems to save only a single line of code, and
> it's not as if the code it's replacing was doing anything complicated
> or hard to grok.

I share the sentiment.  Leaving the result that was used in comparison
in file(s) also helps debugging.
