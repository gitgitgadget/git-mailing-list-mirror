Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5759C1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 17:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfHMRae (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 13:30:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51188 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfHMRae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 13:30:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A651815A84E;
        Tue, 13 Aug 2019 13:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VGHGBTGf1mrvUq3bf2S9FrJvQNk=; b=BSx9LU
        FRJy/RjpA/iWs4lVkZIRqrroIlyJBhQoBJdIhey0V/GKI8NTk3g5Ec5Whop+l2d5
        aVmrzv5s6sOX1cP6BEGapRqZpkY8IgCP2IHeK7vxuFfsnerzZWGt8F1RF0sUvbaI
        g8pKYHjWmUEMp8CswJ64YIRMk6mCjJyvII1Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ni1Ul8Ipa1c9iXsqbAbHJmpzf5a8tc61
        JiM24sgq5DR86p8ePGfz12Uol0cYI9RuhTu1sGrvZAjdS1ykzxat2E1VIzjoNZ6M
        nD9KJ6QfhWJ6MzjSrnBWzbcvo0jA5wtPJIXhxZs2UVpeHuc/az2EedCiSkNWEsIP
        9AGDlNdxcHU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 923E415A84D;
        Tue, 13 Aug 2019 13:30:31 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAF6F15A84C;
        Tue, 13 Aug 2019 13:30:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
References: <20190804143919.10732-1-me@yadavpratyush.com>
        <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
        <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
        <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
        <xmqq5zn8j25p.fsf@gitster-ct.c.googlers.com>
        <9a425bf6-1138-48db-3506-6bee1eff21ee@yadavpratyush.com>
        <xmqqa7ckhcc4.fsf@gitster-ct.c.googlers.com>
        <7a515181-d73f-f21c-a564-db5602d91e93@yadavpratyush.com>
        <xmqqftmacdj3.fsf@gitster-ct.c.googlers.com>
        <20190813134043.7wgxiqainecpopzq@localhost.localdomain>
Date:   Tue, 13 Aug 2019 10:30:29 -0700
In-Reply-To: <20190813134043.7wgxiqainecpopzq@localhost.localdomain> (Pratyush
        Yadav's message of "Tue, 13 Aug 2019 19:10:43 +0530")
Message-ID: <xmqqftm57z2i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C631244-BDF0-11E9-90C3-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

>> The Git community members needs to be able to trust that the new
>> Git-gui maintainer would make a sensible decision when picking up
>> (or asking to improve) a patch from the list to collect and forward
>> to me.  We somehow need to make sure that happens.
>  
> Yes, but how? ...
> ... the only way to build that trust is with 
> time.

Yup, you got it right.  Trust needs to be earned and we need to
start from somewhere ;-)
