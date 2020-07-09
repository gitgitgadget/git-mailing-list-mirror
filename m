Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26AAC433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 05:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B9E206A1
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 05:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c9dYr8rC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgGIFbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:31:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55550 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIFbI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 01:31:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36D86EBC09;
        Thu,  9 Jul 2020 01:31:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qp5+Wr5P+y3HNj8gfpygOSFTfvk=; b=c9dYr8
        rCdfBLzv1tCPnCOB4gQSHLAoLpuS9xp4/OX6j5H0YwZif4kBPuy8Eb6Tkf10Wpqo
        tqaB6LayeI2zXbtTkady3k9xlxKy+I1q/KRCF/RGUDKv4gUev8f3GVt9xdNIpTih
        6Ec/hrWEwR38tNU9Kt77GgliWEDzC97LnaWMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iC4/dGcf180pE4CPZHPXxeLNCPPxBFu7
        okkIe1Q5L/6ILrsqPaUXP8Y4oJpxVgsqaoUqk5Lq2XYc1l6yKYWL6IJAaxTnjrnS
        ARWLoLWFtVChUhsbIHpSvmuXqngr9X/5nMvG8djkIEWbTlxyO/guWKSOPjPPYKKl
        dgH9LbUlaPo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30BE1EBC08;
        Thu,  9 Jul 2020 01:31:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6FFF1EBC06;
        Thu,  9 Jul 2020 01:31:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <lin.sun@zoom.us>
Cc:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
Subject: Re: [PATCH v13] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
        <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
        <xmqqh7uhz98q.fsf@gitster.c.googlers.com>
        <261a01d655a0$71077210$53165630$@zoom.us>
        <xmqqd055z40h.fsf@gitster.c.googlers.com>
Date:   Wed, 08 Jul 2020 22:31:00 -0700
In-Reply-To: <xmqqd055z40h.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 08 Jul 2020 21:49:50 -0700")
Message-ID: <xmqq8sftz23v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6151EE10-C1A5-11EA-B4CF-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>>> +			else
>>>> +				meld_use_auto_merge_option=false
>>>Why? Shoudln't we loudly complain to let the user know of a misspelt value in the configuration?
>>
>> The command line `git config --bool ...` without "2>&/dev/null" will print error message, just passthrough to user.
>> $ git config mergetool.meld.useAutoMerge hello 
>> $ git mergetool --tool=meld 
>> fatal: bad numeric config value 'hello' for 'mergetool.meld.useautomerge' in .git/config: invalid unit
>
> Yes, but you do not exit(1) here, so the user will keep going
> without having a chance to stop, think and correct the misspelt
> value in the configuration file, no?

Hmph, I've been forgetting an important case you are handling well,
which is that the user does not have the variable defined anywhere
in the configuration.  "git config --bool var.ia.ble" fails silently
in such a case, and you do want to declare that the user does not
want to use the "--auto-merge" in that case, which is what this
silent else clause does very well.

So, let's leave this part as-is.

Thanks, I'll push out a new iteration of today's integration before
going to bed.

>
>>
>> I'll upload the changes soon.
>>
>> Regards
>> Lin
