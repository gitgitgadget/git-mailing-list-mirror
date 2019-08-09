Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28A11F731
	for <e@80x24.org>; Fri,  9 Aug 2019 20:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfHIUDS (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 16:03:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51843 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfHIUDS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 16:03:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37DD98C3ED;
        Fri,  9 Aug 2019 16:03:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ghuGp657qOcXEgOUUsEcj9PI+c4=; b=GcRE8H
        IJevMSojhdHfQlIzUNHtsXsBRcAD/ObuJNyTmKig69AZ6HPzmFxZp8d2bNDo5lAq
        VB2fnnkyWcxinYx/FGnZxkBRnwimDh/9EWLeVDjsFlnivRey5LneN3fa58ZZZFHU
        5990Fs/W/V1Y0NaeGk0nWV0sezQBjPftlNALs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=skLMOOdwryz194x6X2j9E3HtRDq+u2kj
        bcKIc7abYKhoyU0uMiohZkWR82VAS5ZtHOasF5Ym77w1Y3PjX1Mt9pagAReXhZWv
        CBa7KzzI38/bCJFFtsE/zGWyAtKKMASPOAHC8b5WqHPLLHT8/61nPy89rySDRC+u
        HN/iX2QqVS4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FD358C3EB;
        Fri,  9 Aug 2019 16:03:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C2488C3EA;
        Fri,  9 Aug 2019 16:03:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     git@vger.kernel.org,
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
Date:   Fri, 09 Aug 2019 13:03:12 -0700
In-Reply-To: <7a515181-d73f-f21c-a564-db5602d91e93@yadavpratyush.com>
        (Pratyush Yadav's message of "Fri, 9 Aug 2019 20:12:33 +0530")
Message-ID: <xmqqftmacdj3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B91CB3D6-BAE0-11E9-A72C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

>> If you meant to volunteer to act as a git-gui maintainer, that would
>> be wonderful.  Then I do not have to play an interim maintainer.
>
> Yes, I do mean to volunteer to act as a git-gui maintainer.
>
> Is there something I should know other than
> Documentation/howto/maintain-git.txt?

Well, I do not think that document has anything useful for being a
maintainer for git-gui in it.

The Git community members needs to be able to trust that the new
Git-gui maintainer would make a sensible decision when picking up
(or asking to improve) a patch from the list to collect and forward
to me.  We somehow need to make sure that happens.

It also is nice if we can get the handing over the maintainership
endorsed by the current Git-gui maintainer.

Compared to that, the procedural issues (how the patches are
reviewed, when and how they are forwarded to me, etc.) are much less
important.
