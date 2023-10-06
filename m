Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234FCE81E17
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 16:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjJFQpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjJFQpG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 12:45:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5222139
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 09:42:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB59B1B7117;
        Fri,  6 Oct 2023 12:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=89C/6FRx3NdzXBfaZfdp34Wql3ACdPQXTj3mxO
        dKjoU=; b=IsED96z8KAVTJ+TDrQiPiEFElW2OOYK+ObxaPQ8vFPZoLZ0cXIf9CL
        uMzz3qsDQd3qNXdQhGvyRwPp4QAQmg9SR957TYXfylCu5EyoDhqMMkaXXtfa2Wgx
        Y51y6iGx8h8TE8OwJMGj1r3UX1qhn4N47J9Hi0NSsF84+lhHY6Ncg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C42061B7116;
        Fri,  6 Oct 2023 12:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BC451B7115;
        Fri,  6 Oct 2023 12:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision: clear decoration structs during
 release_revisions()
In-Reply-To: <20231006005132.GA992085@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Oct 2023 20:51:32 -0400")
References: <20231005212802.GA982892@coredump.intra.peff.net>
        <20231005213014.GB986467@coredump.intra.peff.net>
        <xmqq34yoekt5.fsf@gitster.g>
        <20231006005132.GA992085@coredump.intra.peff.net>
Date:   Fri, 06 Oct 2023 09:42:29 -0700
Message-ID: <xmqqa5svbt3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57C4D94E-6467-11EE-8287-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 05, 2023 at 04:00:54PM -0700, Junio C Hamano wrote:
>
>> Wow, nested maze of callbacks make my head spin ;-) but they all
>> look reasonable.  Thanks.
>
> Yeah, I don't love those one-liner callbacks just to handle the cast.
>
> The other alternative is to write some kind of for_each_decoration()
> macro, but I think it ends up in the usual macro hell (requiring the
> caller to provide iterator variables, hanging half-open braces, and so
> on). It might be worth it if iterating could be used in other places,
> but I don't think it is.
>
> So I tried to choose the lesser of two evils. :)

Oh, I am happy with the result.
