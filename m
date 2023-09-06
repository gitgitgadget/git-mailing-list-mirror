Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33C4EE14C3
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 22:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbjIFWPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 18:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIFWPu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 18:15:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8019AF
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 15:15:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 725561B5748;
        Wed,  6 Sep 2023 18:15:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=JObEmdw3GWnfMy1nGb8adupyoLnNoZa78W92XZ
        6spOs=; b=e5Q8zT5emYWS+X2PD9MXstjRxxSw0s5xsllOn4cEfxLl+XrLUb+55+
        Lm+fTIKm5cDT1mnPSaL8X9tsMJhWCr+uxHrIUGEpw2eHy0sA+lFIDqWzzun1TEx1
        8bHcOYH7qTfzMVxxheRXe0nXLN8n1eYz/226ZWUK+2joHiKzgISlE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 687A91B5747;
        Wed,  6 Sep 2023 18:15:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA2D11B5744;
        Wed,  6 Sep 2023 18:15:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
In-Reply-To: <878r9juflz.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        07 Sep 2023 01:00:24 +0300")
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
        <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
        <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
        <87edjbuugw.fsf@osv.gnss.ru>
        <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
        <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
        <xmqqledjm4k2.fsf@gitster.g> <878r9juflz.fsf@osv.gnss.ru>
Date:   Wed, 06 Sep 2023 15:15:43 -0700
Message-ID: <xmqqy1hjkkxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC7B4D88-4D02-11EE-B823-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I agree "inline" is not much better than "main", nor "attached" is
> better than "linked". I just pulled mine out of thin air, and what's
> already there is probably fine.

Heh, the initial draft of my message you are responding to used
"primary" (and "attached"), because they are the word I am
accustomed to use (out of thin air) on the list a few times, before
checking with the existing documentation to realize that we use
"main" for that.

> That said, to be picky, "main" suggests
> that linked worktrees are somehow inferior. Are they?

I'd say that 'main' is different, not necessarily superiour, from
all others and they are equally useful and usable.  The difference
is that it cannot be removed.  There may be other differences I am
forgetting, but I do not think it is about which is superiour and
which is inferiour.
