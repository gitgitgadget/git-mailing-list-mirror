Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB40C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 22:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIWWHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiIWWHA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 18:07:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151FA140AD
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 15:07:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D9391B990D;
        Fri, 23 Sep 2022 18:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vrb9xkCr7mhlJ1sFqSmjwGWfN5aZQ3xMrRli8Q
        iaCwM=; b=SX7eSobBtaOzXGTURGIz8B2wA7BqTlDRcwLDqKN8W2ze+IyYrOFSqi
        QKryzMsC+tsK8idVrPkmS7QYAmFuFRfNc0X4PlMmO+B5KQQAlha/f/x9IgXReWca
        lvYvusvURhlW1Sc9Fjg0CX9ELaEs6n7OyDTNHcoJ2oCtD5d0Jd8A4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95EBE1B990C;
        Fri, 23 Sep 2022 18:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E1CF41B990B;
        Fri, 23 Sep 2022 18:06:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
References: <20220922061824.16988-1-jacob@initialcommit.io>
        <20220922232536.40807-1-jacob@initialcommit.io>
        <xmqqillevzeh.fsf@gitster.g>
        <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
Date:   Fri, 23 Sep 2022 15:06:54 -0700
In-Reply-To: <Yy4sIAHdvp6yRql+@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 23 Sep 2022 17:58:56 -0400")
Message-ID: <xmqqpmflsq2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09832C90-3B8C-11ED-9A26-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you give up the regex thing, then that naturally falls out as
> (imagining we learn about authordate as a placeholder):
>
>   git shortlog --group='%(authordate:format=%Y-%n) %an'
>
> without having to implement multiple groupings as a specific feature
> (which is both more code, but also has user-facing confusion about when
> --group overrides versus appends). That also skips the question of which
> --group-by-regex applies to which --group-by-value.
>
> I do agree the regex thing is more flexible, but if we can't come up
> with a case more compelling than subsystem matching, I'd just as soon
> add %(subject:subsystem) or similar. :)

;-)  I like that as a general direction.
