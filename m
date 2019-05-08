Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC861F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEHK76 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:59:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60069 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHK76 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:59:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DD9B6D5B1;
        Wed,  8 May 2019 06:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tzDROAV+MVIQKh8nsWnlyj0hP2U=; b=AMsJzG
        XPBqAGA1mxVFx8VgbqnxAgMCnLbUkGJ+7+PvBSIVa1oDYgNJde3HhGACRc28LsXR
        G2ghE2Bu26VBG16wActmbNJyrQfbycRYHKkpSOrb6AHk6X+Sl3miawWMrazTYYMW
        acpfQ1HnGJP5xTKjdnz4sggAt/toYGAiLp0XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cdQUsIwh64cx/ayhveouSc75eZ1v/g9j
        jj3SK1fRN2CrvwQevDQ7xOoM04hfSjouhBLHSYQJuKChD0CGAEl5IXTvBRLBG0XT
        4go7/o/t6UfP9sceoCnTz3DHPMp2KLpaAtnGqpaPOAzfyBaiTa2hYI7B1ZZUMH9q
        +gdlVq2DXVU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 756906D5B0;
        Wed,  8 May 2019 06:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA9FF6D5AF;
        Wed,  8 May 2019 06:59:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Dustin Spicuzza via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Dustin Spicuzza <dustin@virtualroadside.com>
Subject: Re: [PATCH 1/1] cvsexportcommit: force crlf translation
References: <pull.132.git.gitgitgadget@gmail.com>
        <9b508af11be125ce5fd80c40c732dbcaf45067fb.1556575126.git.gitgitgadget@gmail.com>
        <xmqqtve6lito.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905081248190.44@tvgsbejvaqbjf.bet>
Date:   Wed, 08 May 2019 19:59:51 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1905081248190.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 8 May 2019 12:56:26 +0200 (DST)")
Message-ID: <xmqqr299fbyw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68A867FA-7180-11E9-8BCD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about this:
>
> 	The offical CVS for Windows (called CVS NT) produces DOS line
> 	endings in its `cvs status` output. Let's teach our own
> 	`cvsexportcommit` command to handle that gracefully.
>
> It is unlikely that anybody wants to spend time "fixing" this in CVS NT,
> even less likely that anybody would take that patch, and even if that was
> the case, there will still be plenty of CVS NT versions out there that
> `cvsexportcommit` cannot handle.
>
> I think it would be best to just integrate this change in Git and be done
> with it. It's not like it adds a ton of maintenance burden there.

One thing that took some time (at least to me) to audit was that the
helper being touched is *NOT* limited to running "cvs status".  If
other commands cared about passing binary data intact, this change
would have been disasterous.  After seeing what external commands it
is told to drive, I think it is OK.  It's not like we'd be updating
the program often and reusing the function blindly to accept possibly
binary data in a near future.


