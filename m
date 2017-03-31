Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748F520969
	for <e@80x24.org>; Fri, 31 Mar 2017 18:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbdCaSd6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 14:33:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53256 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751346AbdCaSd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 14:33:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96BC57C52A;
        Fri, 31 Mar 2017 14:33:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hfqZOIjVAnPN5G4GTwzlS13cNjE=; b=OEU3cZ
        hMFeApvgyb804NcIaicb4rjI5LlYsKkOEKVGS8PhywpkfKeUA+NOt0F0WkuqyQVE
        SNUweycKW2czB/4sxk90oa2qiwXcrnP04UXgrMiNfJ4fcWvvGV86N/l/7NsW5oxc
        nIuobEFD9R4cn8nTMtG6vlr6UX7+BnVCOkc04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ktSG9H+tOsMA6T5A6huViPTmvCRXJ7UE
        c0o+YNlPCHG2vvinnJasQJct6K3TCPBRY8MNrzcUfebOHWX9JnR/quIzgCpMoyXS
        95booqFBam9dWbKTBRgHVWaBtbLjQwm2YRiGslIwbF0s2LHaQs55IyJm7iByhaLS
        E9a0UJ3WGyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EA2F7C529;
        Fri, 31 Mar 2017 14:33:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1A3E7C528;
        Fri, 31 Mar 2017 14:33:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 3/4] name-rev: provide debug output
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
        <cover.1490967948.git.git@grubix.eu>
        <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
        <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
        <14D0E7F4-0DC7-42ED-8DEE-B0338ECBA80D@grubix.eu>
        <xmqqd1cxz5gb.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 31 Mar 2017 11:33:53 -0700
In-Reply-To: <xmqqd1cxz5gb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 31 Mar 2017 11:06:28 -0700")
Message-ID: <xmqqzig1xpm6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 987B3C52-1640-11E7-8F7B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@grubix.eu> writes:
>
>>>The only case that this change may make a difference I can think of
>>>is when you have a tag object pointed at from outside refs/tags
>>>(e.g. refs/heads/foo is a tag object); if you are trying to change
>>>the definition of "from_tag" from the current "Is the tip inside
>>>refs/tags/?" to "Is the tip either inside refs/tags/ or is it a tag
>>>object anywhere?", that may be a good change (I didn't think things
>>>through, though), but that shouldn't be hidden inside a commit that
>>>claims to only add support for debugging.
>>>
>>>What problem are you solving?  
>>
>> Sorry, I forgot about that change and failed to mention it.
>>
>> It makes no difference in the non-debug case which cares about the
>> Boolean only. In the debug case, I want to distinguish between
>> annotated and lightweight tags, just like describe --debug does. By
>> adding 1 via deref and passing this down, I know that an annotated tag
>> gets the value 2, a lightweight tag 1 and everything else 0, just like
>> describe --tags.
>
> So it sounds like you meant to do something else, and the
> implementation is wrong for that something else (i.e. it wouldn't do
> the right thing for a tag object outside refs/tags/, with or without
> the "--debug" option passed).

The damage seems worse, but I may be misreading the code.

is_better_name() compares name->from_tag and from_tag numerically,
because it was designed to take a boolean view of that variable.
Now, an artificially bumped 2 gets compared with name->from_tag that
may be 1 and gets different priority.  That artificially inflated
value may be propagated to name->from_tag when the current tip is
judged as a better basis for naming the object.

If this change is only for debugging, perhaps inside if(data->debug)
you added, instead of looking at from_tag, you can look at both
from_tag and deref to choose which prio-nmes to show, without
butchering the value in from_tag variable to affect the existing
code that is exercised with or without --debug?
