Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B94320899
	for <e@80x24.org>; Wed, 23 Aug 2017 18:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932467AbdHWS3I (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 14:29:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52336 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932396AbdHWS3H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 14:29:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2814A9B7BB;
        Wed, 23 Aug 2017 14:29:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cVvesqGE4tAQGMOU+Mc5WQD6U2A=; b=WXTGGq
        p6un0vhY/Ern8jQez+f9zNLQqgO77CcKRJag+YtqX5gUCCrB0DaMxwJ2YkHnUYrB
        Nuci13Y9VwuAPtDldinMqS/egWSrqq3BT4zHd2RWZFs1Xt+GeY3N6RWvYzSWw+0y
        /HOKbEmx6kd5JSXHsI5TDESu1FkjVi3nFbleY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m/uAO4Qq8jGZV/lZ+yV/zBYtdyP8Jayr
        Cw8kz+YqMCmQdDRaN8R/XJKEF5yYjvvW584zq3AKKGoAmVFuZ1IZtAtQ//card5z
        g0MvTIXUzh4VumCZpsvoYAhc71QArpIS6O/Az+2LUTPf3ZzoGfX71PDvoAC2bZvs
        3ZLRMBR4iNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 203D99B7BA;
        Wed, 23 Aug 2017 14:29:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8169D9B7B8;
        Wed, 23 Aug 2017 14:29:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>
Subject: Re: [BUG] rebase -i with only empty commits
References: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com>
        <36e9c381-81b0-ae71-153a-0bcabc59856c@gmx.net>
        <alpine.DEB.2.21.1.1708231639470.19382@virtualbox>
        <ece1018b-98b1-e9b7-546a-d7c68dacfbb7@gmx.net>
        <CAGZ79ka-SS8ZyZkp6d=0iNtTtQgh2cAhzJSt4m22F88vb1rbhw@mail.gmail.com>
        <565221dd-b66f-8b88-1bdd-8d0d55c4dc96@gmx.net>
Date:   Wed, 23 Aug 2017 11:29:05 -0700
In-Reply-To: <565221dd-b66f-8b88-1bdd-8d0d55c4dc96@gmx.net> (Stephan Beyer's
        message of "Wed, 23 Aug 2017 20:06:15 +0200")
Message-ID: <xmqqo9r6yw7i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F271FFF4-8830-11E7-8F9D-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> On 08/23/2017 07:29 PM, Stefan Beller wrote:
>> On Wed, Aug 23, 2017 at 8:19 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>>> On 08/23/2017 04:40 PM, Johannes Schindelin wrote:
>>>> These days, I reflexively type `rebase -ki` instead of `rebase -i`. Maybe
>>>> you want to do that, too?
>>>
>>> That's a very valuable hint, thank you very much!
>> 
>> While -k side steps the original problem, it seems like it would
>> have helped me, too.
>> 
>> Is there any value in discussing turning it on by default?

As we often see on this list, people tend to be blinded by their own
needs and fail to strike the right balance when considering the pros
and cons of a change that may help their immediate desire, I think
there is a value in discussing it, even if the conclusion turns out
that it is not a good idea to change the default.  Rather, make that
"even if" "especially if"---we would reach a reasonable balance
between pros and cons and won't have to repeat the discussion.

> I also wondered why empty commits are "discriminated" in such a way.
> I first thought that if you rebase branch A onto B but branch A and B
> contain commits with the same changes, then these commits would become
> new empty commits instead of simply being ignored. But I just checked
> this theory and it is now falsified :)

If you add an identical patch on each of your two toy example
branches and try to rebase one over the other, an early logic that
culls the set of commits to replay based on patch ID will remove
them so you would not even see "it has become empty".

I think you can redo your example by having two consecutive commits
on one branch, and then make one commit on the other branch whose
effect is those two commits' effect combined.  Then rebase the
latter on top of the former.  "cherry-pick A..B" seems to be aware
of this more interesting case and allows you to control the
behaviour by having --keep-redundant-commits and --allow-empty as
two separate options, but it seems there is no similar provision in
"rebase".
