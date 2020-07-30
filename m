Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75749C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3892072A
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jx9I3ueL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgG3TkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:40:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61141 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgG3TkS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 15:40:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACB116D075;
        Thu, 30 Jul 2020 15:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2hsdqjcRf717uzLYeFcsBPbyK88=; b=jx9I3u
        eLrV83a4uUWHuZlKDvZ75Aumc3D0joMOJ2xatH802Zh0gYQWLm+SvF3H8GJQV1WB
        dcKJN5pX4+zkzZCO348xWddC55dpEX2XnGrycW1JHt0ZpDftUR87K4CjO2zx3O1o
        KoWu7lbfSVwXiKMuqxfvbnzzow1ehIfqZ3+O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mc1M2GtrN/0eCr/sMMJ8lRlsRHgYArTH
        wpRjP/6QjmPsaTTYv6St/XM8ph8dPuErMukaES6rlI0WpvNW9RlfdmzIBPQ1Izy/
        qI+Y9If84nyTyfRjfaB/Er3wUd3zcvuWzbtPy5lggUl2KOE7R4Gdt2alDfGinn7S
        NJF8kGM7piw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A358F6D074;
        Thu, 30 Jul 2020 15:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26C836D073;
        Thu, 30 Jul 2020 15:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] Revert "fmt-merge-msg: stop treating `master` specially"
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
        <20200730180237.1392480-1-gitster@pobox.com>
        <20200730180237.1392480-2-gitster@pobox.com>
        <CAPig+cS=icR6PGBObChLQf5+OKbNPDvvZ62n7Y9jGnifoSUdkA@mail.gmail.com>
Date:   Thu, 30 Jul 2020 12:40:15 -0700
In-Reply-To: <CAPig+cS=icR6PGBObChLQf5+OKbNPDvvZ62n7Y9jGnifoSUdkA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 30 Jul 2020 15:10:45 -0400")
Message-ID: <xmqqbljw7pwg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E2C0C34-D29C-11EA-8EC9-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> /On Thu, Jul 30, 2020 at 2:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>> This reverts commit 489947cee5095b168cbac111ff7bd1eadbbd90dd, which
>> stopped treating merges into the 'master' branch any specially when
>
> s/any specially/specially/
> ...or...
> s/any specially/as special/
>
>> preparing the default merge message.  As the goal was not to have
>> any single branch designated as special, it solved it by leaving the
>> "into <branchname>" at the end of the title of the default merge
>> message for any and all branches.  An obvious and easy alternative
>> to treat everybody equally could have been to remove it for every
>> branch, but that involves loss of information.
>>
>> We'll introduce a new mechanism to let end-users specify merges into
>> which branches would omit the "into <branchname>" from the title of
>> the default merge message, and make the mechanism, when unconfigured,
>> treat the traditional 'master' special again, so all the changes to
>> the tests we made earlier will become unnecessary, as these tests
>> will be run with out configuring the said new mechanism.
>
> s/with out/without/
>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.
