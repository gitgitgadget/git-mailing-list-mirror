Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA4720A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754486AbdASTQu (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:16:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63209 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754415AbdASTQt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:16:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70F11618B0;
        Thu, 19 Jan 2017 14:00:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eqg5MczWfmM0YIntO2FuGmLPOzk=; b=j+wRcq
        vNivQkrw3VNhzHGXgX2HJgQulm9sdnfeG3JNaj5r4rS/AIw2CXys7LZ19y2wIPjl
        1Qqs+VzdviIExBvbqHzWgG6D6t7l2hWYM/2IS4JG7CAB7Xgqfq4YqwkoKDZ8z0rJ
        jI4nohUAawypmaTbgF+U4uAh3sMemracppuNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K3SLCKp3VrKgIr3ktCtKv2dyChH1GY7Z
        J/F73EXBzN0ggrD8d9FQbGJQ7n5bhMGhxm5B6t1sPK81KZ82Fcf2PE+xQuMKGkA0
        6pYqfgSaTAgKCq3VrKDdASHfAIra5ahloPYgx4/VYCVTS1OoS6Gu+2FXfRz0Q52i
        vkxVjxO30BE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68FEC618AE;
        Thu, 19 Jan 2017 14:00:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF993618AD;
        Thu, 19 Jan 2017 14:00:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-15-chriscool@tuxfamily.org>
        <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
        <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
        <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
Date:   Thu, 19 Jan 2017 11:00:20 -0800
In-Reply-To: <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 19 Jan 2017 19:13:04 +0700")
Message-ID: <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 878DC80A-DE79-11E6-A615-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jan 9, 2017 at 9:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Sun, Jan 8, 2017 at 4:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Christian Couder <christian.couder@gmail.com> writes:
>>>>
>>>>> So what should we do if freshen_file() returns 0 which means that the
>>>>> freshening failed?
>>>>
>>>> You tell me ;-)  as you are the one who is proposing this feature.
>>>
>>> My answer is, we are not worse than freshening loose objects case
>>> (especially since I took the idea from there).
>>
>> I do not think so, unfortunately.  Loose object files with stale
>> timestamps are not removed as long as objects are still reachable.
>
> But there are plenty of unreachable loose objects, added in index,
> then got replaced with new versions. cache-tree can create loose trees
> too and it's been run more often, behind user's back, to take
> advantage of the shortcut in unpack-trees.

I am not sure if I follow.  Aren't objects reachable from the
cache-tree in the index protected from gc?

Not that I think freshening would actually fail in a repository
where you can actually write into to update the index or its refs to
make a difference (iow, even if we make it die() loudly when shared
index cannot be "touched" because we are paranoid, no real life
usage will trigger that die(), and if a repository does trigger the
die(), I think you would really want to know about it).
