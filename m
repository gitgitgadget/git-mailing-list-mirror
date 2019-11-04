Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF70F1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 04:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfKDEEV (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 23:04:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65057 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfKDEEV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 23:04:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A347D3120D;
        Sun,  3 Nov 2019 23:04:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vf24Ke9Lydfhm6B9uWTw2zmnyVA=; b=VctjvH
        u73ZxOP8XHginT+NrTxctYbMqfklNz/Ch+cx3vVBXCe/1D2QNJEFzk6YljyjFZr8
        iMJl6EKNGfpnFBXaFpekY1ft+mEqMdcui4TAFLYsyaTrHnPBuB/KENfc2uRm6roP
        mO/N5pbZzhAfPY12nbjCoXLkQabeP/Fc7Svk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sXfEESFRZzUCuJUz6sHmY24VHVNhiNw3
        qFOvbjt90c/txNu0uwn6onorIFlbnPx1NN84VGIqPM61JR+9fCgYEqnroPXWJusv
        f70Nd2jovuiyJtGELw+0HnqtzLIuTnUmoTy9gLD72IpYhldqfc36UpA1CejOHvrb
        C4osZ6Tje3w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C1313120C;
        Sun,  3 Nov 2019 23:04:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 103263120A;
        Sun,  3 Nov 2019 23:04:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     "Abimbola via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Abimbola Olaitan <craftwordltd@gmail.com>
Subject: Re: [PATCH 1/5] remove-annotate: change cmd_annotate to cmd_blame
References: <pull.442.git.1572753114.gitgitgadget@gmail.com>
        <6e164528059529fe07a53f0cfceb22a388a6758b.1572753114.git.gitgitgadget@gmail.com>
        <86tv7khgtf.fsf@gmail.com>
Date:   Mon, 04 Nov 2019 13:04:17 +0900
In-Reply-To: <86tv7khgtf.fsf@gmail.com> (Jakub Narebski's message of "Sun, 03
        Nov 2019 20:59:24 +0100")
Message-ID: <xmqqy2wwz3r2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C38E6EE-FEB8-11E9-8C72-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> "Abimbola via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Subject: Re: [PATCH 1/5] remove-annotate: change cmd_annotate to cmd_blame
>> From: Abimbola <craftwordltd@gmail.com>
>>
>> Changing this command is to remove the annotate.c file which does almost
>> the same thing as blame.c. git annotate will invoke blame directly
>
> Both the summary and the detailed description of the changes is not
> entirely clean.  What is this 'remove-annotate' subsystem?  Why we would
> want to change cmd_annotate to cmd_blame -- and wouldn't we loose
> difference (in defaults, and thus in output format) between git-blame
> and git-annotate?
>
>>
>> Signed-off-by: Abimbola <craftwordltd@gmail.com>
>
> Why not
>
>   Signed-off-by: Abimbola Olaitan <craftwordltd@gmail.com>
>
>> ---
>>  git.c | 143 +++++++++++++++++++++++++++++++++-------------------------
>>  1 file changed, 82 insertions(+), 61 deletions(-)
>
> Looks like a big change, strangely.  And annotate.c is not actually
> deleted...

Thanks for all the good comments.  The first priority of any work in
this area is not to lose the different defaults between "annotate"
and "blame", as the former has ("had", at least when we invented
"blame") known uses in widely used script(s), and the solution we
took was to use a small annotate.c shim to tell the blame machinery
to emit historical "annotate" output format.  If we can do so
without having the shim, that would be OK.  If removal of shim loses
the distinction, then it is not.

I suspect that cmd_blame() can be taught to look at argv[0] and
pretend "-c" was given on the command line, and then the command
dispatch table can call cmd_blame() upon seeing "annotate" as the
subcommand name, but I haven't actually tried it so there may be
hidden dragons.

Thanks.
