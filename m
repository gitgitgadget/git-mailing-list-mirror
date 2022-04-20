Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA03C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 17:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381326AbiDTRxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiDTRxc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 13:53:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185E381B7
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:50:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C5C312FDB9;
        Wed, 20 Apr 2022 13:50:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HQbPYt+8icGPPsdSNBnbEHAjG+bzXTSn6sCKeV
        ugvMQ=; b=D2pagdZYsJ1BXYSD4mz+4kXYdl/nBwQCzvT642JBZkshQfoqaXH1Ae
        /cjdqFbHsJKlsMd3dJbVXAeRXMeTOjstYrmdZ367WHnMduvs5AG33h1tpNz3QwR9
        eHqIL9Jet5MQkINW68BR0top+4Je0x/5mFN8Ve7zbVQ0bBL47EJfU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82C2312FDB6;
        Wed, 20 Apr 2022 13:50:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2DDE12FDAC;
        Wed, 20 Apr 2022 13:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Kevin Long <kevinlong206@gmail.com>, git@vger.kernel.org
Subject: Re: help request: unable to merge UTF-16-LE "text" file
References: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
        <CA+JQ7M8+FR+_t+Fafoggz47bT0joAZFEkjhjf72teZgdNEoNZQ@mail.gmail.com>
Date:   Wed, 20 Apr 2022 10:50:42 -0700
In-Reply-To: <CA+JQ7M8+FR+_t+Fafoggz47bT0joAZFEkjhjf72teZgdNEoNZQ@mail.gmail.com>
        (Erik Cervin Edin's message of "Wed, 20 Apr 2022 19:25:42 +0200")
Message-ID: <xmqq8rrzr6dp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 668817C8-C0D2-11EC-BB74-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

> On Wed, Apr 20, 2022 at 6:29 PM Kevin Long <kevinlong206@gmail.com> wrote:
>>
>> The problem file is a .sln file (Visual Studio "solution"). Edited in
>> both branches. It is a "text" file, but is encoded as such:
>
> Can you convert it to utf-8 in both branches and then merge?
>   iconv.exe -f utf-16le -t utf-8 foo.sln > tmp.sln && mv -f tmp.sln foo.sln

For that to work, it is likely that you'd need to convert not just
the tips of two branches getting merged, but also the merge base
commit, so that all three trees involved in the 3-way merge are in
the same text encoding.
