Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0ABF1FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 17:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbcHTRtB (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 13:49:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51605 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752946AbcHTRtA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 13:49:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E17E135757;
        Sat, 20 Aug 2016 13:48:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KNh4vndQwRF3bif/+zzZpiiS4rA=; b=dYkA0S
        qBVTAohwYpDNuPpk8aH1iJff7wO9TMugOcv/wJVtkdbjsjoMn9SKpfGXOby8BxZj
        wEbgRitC7TOpB/YtIPy0QQeHuGy6urt7/8+9Li8XtEj2/tGQ86U/VLC7C2bwFW6n
        hFdzJsws9h2v0N7GuYC/OuedG1xkMx9hoRyos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vW3XxZH+WYUSg7hlE00P0syXjje1+y8/
        VyJjq1euZaeffLTaZVfO+lDxhs63//vx28HQRYs3OQq7gsw53oaJd//SKiRT34ut
        eaofxT1OsseRitzOSzE31MXVkgUF5cpuEyOUFNjtxIFThOcrp1wllOGXQPtpEvtR
        RGj0/UF9aH4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D813235754;
        Sat, 20 Aug 2016 13:48:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6091E35753;
        Sat, 20 Aug 2016 13:48:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Zenaan Harkness <zen@freedbms.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: git rm --cached should be git rm --cache or git rm --stage
References: <20160820072214.GB24992@x220-a02>
Date:   Sat, 20 Aug 2016 10:48:56 -0700
In-Reply-To: <20160820072214.GB24992@x220-a02> (Zenaan Harkness's message of
        "Sat, 20 Aug 2016 17:22:14 +1000")
Message-ID: <xmqq37lzz5yv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F113C10-66FE-11E6-B8F7-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zenaan Harkness <zen@freedbms.net> writes:

> From man git-rm:
>
> --cached
>   Use this option to unstage and remove paths only from the index.
>   Working tree files, whether modified or not, will be left alone.
>
> This wording is unclear and dangerous, and ought be cleaned up somehow.

I think "unstage and" can be removed to make it more clear [*1*],
but otherwise I do not see much wrong with the description to make
it dangerous.

Can you elaborate?  Which part of the description is unclear?

"git help cli" gives a brief description as to why it should be
called "--cached".


[Footnote]

*1* The reason why "unstage" makes it ambiguous is because people
tend to use the word "stage" loosely.  Even though Git keeps track
of the entire state of a file, it is easy to confuse oneself to
mistakenly think that "git add" a modified file as "staging the
difference between the last committed state and the contents being
added", and from that mistaken world view, you would imagine
"unstage" may bring the last committed state back in the index,
which is not what "git rm --cached" does (it does "remove" the path
from the index).
