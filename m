Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB8A20756
	for <e@80x24.org>; Fri, 13 Jan 2017 20:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbdAMUTk (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 15:19:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65301 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750978AbdAMUTj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 15:19:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 572775E556;
        Fri, 13 Jan 2017 15:19:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+4o6bcWOSYDukRCZCUfrzD4PjFc=; b=lEYJDx
        TxV+7yE2ozoch8yW9Nfca4UvhQglzHBbYoamzA64W5ethKg4zzh4FpyS5AC7/VTh
        zs1xaFhjDcXemQb3iXqbFqNPO6/yHLuGyF/ivOEi36R69hIsL8Ej0TCvl5PEVzxm
        ZuytWPj/O+NdOyAGkIb2WndpeV4LR+Fq/SJCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gRBFMl9j9G7Hfa4M7iRaROOliWJDgN2Q
        5pDIR7iHL5JFrP6m0FX62BlOmYYAJOnibuVnN1RifsJNmLABgIn6dgitiierA6LM
        VjWO5xsC7Jso8vw10M+qQ+PrVAHtv0Q+tspgGEoIqi/NPzmBOKOtrX2wVMGbdpvl
        egN4zxVV5z0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DF3D5E555;
        Fri, 13 Jan 2017 15:19:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B20F05E554;
        Fri, 13 Jan 2017 15:19:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] lib-submodule-update.sh: drop unneeded shell
References: <20170111184732.26416-1-sbeller@google.com>
        <xmqqtw92hkgc.fsf@gitster.mtv.corp.google.com>
        <xmqqa8auhgzt.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kayLoH7EURQ9aKGh+FzDz_BegJRjB2175qo53beLZDYog@mail.gmail.com>
Date:   Fri, 13 Jan 2017 12:19:36 -0800
In-Reply-To: <CAGZ79kayLoH7EURQ9aKGh+FzDz_BegJRjB2175qo53beLZDYog@mail.gmail.com>
        (Stefan Beller's message of "Fri, 13 Jan 2017 12:01:18 -0800")
Message-ID: <xmqqk29yg1bb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BD6FD00-D9CD-11E6-B94A-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jan 13, 2017 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> In modern Git we prefer "git -C <cmd" over "(cd <somewhere && git <cmd>)"
>>>> as it doesn't need an extra shell.
>>>
>>> There is a matching '>' missing.  The description is correct (I am
>>> not sure if there actually is "preference", though), but I found the
>>> title a bit misleading....
>>
>> It turns out that there were two missing '>' ;-)  It tentatively has
>> become like this in my tree.
>
> Thanks for fixing up locally. I had resent as
> "[PATCH] lib-submodule-update.sh: reduce use of subshell by using git -C <dir>"
> but you can ignore that now.

Yeah, apparently our mails crossed.  Yours still have "git -C <cmd>"
that should have been "git -C <dir> <cmd>", so I'll keep the locally
munged one.

Thanks.


