Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291091F667
	for <e@80x24.org>; Thu, 10 Aug 2017 22:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbdHJWki (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 18:40:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58382 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752135AbdHJWki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 18:40:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75E18A2822;
        Thu, 10 Aug 2017 18:40:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bx3Ugg4oAQHqrQILbRHiDlNILD0=; b=RPEbjm
        ThuqfpDzMj4xNjUoBn4n2/JO07cG7bCrUFw4/baZU6i5kr/1/pZGswJUL4bAPjQC
        VjfpBwSTEe+y/608jQ/lQTlJvTbnPaI14PkBZfugY+759q7P10b7yQP6rIM2NSQg
        52OWI54QP7OG9ANirJqqsDzBDUg/k8FfclQwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qQf19X5gGfLNR7caNSFjfRAAfSQy6LhY
        QSLjbPMFo3kHg1I1ZOZJL8ajQm962nEC1mXhlDsSQu/xOmpAeFNISD4446b3TZwT
        ENLTfmJzpTh79qEjHnHYWwYk2zDAD18KVcOsfuS4RaS3V8mNsryPoAN1dcyitVG2
        sat+RUjuLwI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BAB6A2821;
        Thu, 10 Aug 2017 18:40:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD180A2820;
        Thu, 10 Aug 2017 18:40:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v2 00/25] Move exported packfile funcs to its own file
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1502241234.git.jonathantanmy@google.com>
        <xmqq7eyb2k8w.fsf@gitster.mtv.corp.google.com>
        <20170810145948.60c2b9f8@twelve2.svl.corp.google.com>
Date:   Thu, 10 Aug 2017 15:40:28 -0700
In-Reply-To: <20170810145948.60c2b9f8@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Thu, 10 Aug 2017 14:59:48 -0700")
Message-ID: <xmqqfucz11yb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E96DDC52-7E1C-11E7-8040-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Thu, 10 Aug 2017 14:19:59 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> > Here is the complete patch set. I have only moved the exported functions
>> > that operate with packfiles and their static helpers - for example,
>> > static functions like freshen_packed_object() that are used only by
>> > non-pack-specific functions are not moved.
>> 
>> This will interfere with smaller changes and fixes we want to have
>> early in the 'master' branch, so while I think it is a good idea to
>> do something like this in the longer term, I'd have to ask you to
>> either hold on or rebase this on them (you'll know what else you are
>> conflicting with when you try to merge this to 'pu' yourself).
>> 
>> Thanks.
>
> OK, I'll wait until you have updated the master branch, then I'll try to
> rebase on it.

That will take a few weeks, and I do not think we want you idling
during that time ;-).

You'd need to double check, but I think the topics that cause
trouble are rs/find-apck-entry-bisection and jk/drop-sha1-entry-pos;
you can start from v2.14.1 and merge these topics on top and then
build your change on top.  That would allow you to start cooking
before both of them graduate to 'master', as I expect they are both
quick-to-next material.  There might be other topics that interfere
with what you are doing, but you can easily find out what they are
if you do a trial merge to 'next' and 'pu' yourself.

Thanks.
