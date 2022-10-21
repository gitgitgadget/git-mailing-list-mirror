Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850DCC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJUWCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUWCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:02:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3272A43A7
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:02:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D4A115C0C0;
        Fri, 21 Oct 2022 18:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YJaNCxLwP5jK28VMG0KNQhYFFNB60ouCbnYiHW
        3G8Xs=; b=NPD/VzXB0bOsUWCVNGoZZEB5Tn5Nvc6Zvk2f7Z/CKkB7JoodHsk9O0
        3FPho3HUn+v1DSSw4mEur//LygQeAKk0G5wCOvC8+sk2oJ8Qo6GzSz1IqIZ329KY
        ybSLSDf9GABP4Em73a0ZzaFg8eWi8g4qeifcgExhkrOrT1ZjnNYUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 351B615C0BF;
        Fri, 21 Oct 2022 18:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AEBB15C0BE;
        Fri, 21 Oct 2022 18:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git commit .' in a subdirectory also commits staged files in
 other subdirectories
References: <3a4dfad5-0f2e-14d8-61f2-779616de1ae0@tsoft.com>
        <Y1MTtNcUHyv76UEV@nand.local>
Date:   Fri, 21 Oct 2022 15:02:11 -0700
In-Reply-To: <Y1MTtNcUHyv76UEV@nand.local> (Taylor Blau's message of "Fri, 21
        Oct 2022 17:48:36 -0400")
Message-ID: <xmqqy1t8j0nw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0439F35C-518C-11ED-9E41-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> 'git commit .' in one of them attempted to commit all of them, not
>> only the files in that subdirectory.
>>
>> This is a very unreasonable behavior, because while being in any
>> subdirectory 'git commit .' should only affect that subdirectory, and
>> not files elsewhere.
>
> That isn't right, though I can't reproduce what you describe from your
> report. Try this script out:
> ...

"git commit --include ." would exhibit the behaviour, but that
should not be the default, so I am also puzzled.
