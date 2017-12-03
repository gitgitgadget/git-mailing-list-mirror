Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F5520A40
	for <e@80x24.org>; Sun,  3 Dec 2017 05:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbdLCFyn (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 00:54:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61760 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752075AbdLCFym (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 00:54:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24632B6730;
        Sun,  3 Dec 2017 00:54:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GVDertWeXbVFV0Fp4ZFyOYQspBQ=; b=SQEhn8
        r3kzqerHEmUIXp02T8l0rcQsBM8XuxPprSq8XtbmVU7xuAOzUeQ0MaAZAEe2IkNR
        5g+qYQu1AMfwMBnX0KdLz5q86h+///dD3OtW7pMHmGHGAqb9Q0thDN62juS9tF3x
        gId7J2hTZUln1nRhUcuKbCFCDw8J32qnCZtq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bTQ2BTrX+tDfWkLQfcsBzCznKZGuSYc1
        ktb41+n2nlLbtA1Yg7+zDi/1jeSl/nc8J9As41+RPM6OsFVfdB88Yme+FQjEf7X1
        l1bBf7rnIRMcxXYFAKQwM/NyjCtpwFanXE0fq8bcWEzv/YzskwRiNurXe+DNVRHR
        ED7Jp1sgYSs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C62EB672F;
        Sun,  3 Dec 2017 00:54:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94A7DB672E;
        Sun,  3 Dec 2017 00:54:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Subject: Re: Unify annotated and non-annotated tags
References: <201711231458.vANEwUMK048049@elephants.elehost.com>
        <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com>
        <CAPkN8xJBWRs-2DxViBACLKzAbD1_EBA2MvmWVZmWgL+Sg72znw@mail.gmail.com>
        <CACBZZX4SM45hgA=PW0MEP9Ea0OG_8OTb5U7JCOX7xnd=hT5n3A@mail.gmail.com>
        <CAPkN8xKDQrf+LMpj9GHw9n_crJ1UUwq7Zek+Z1dgQ0n2Jz5U6g@mail.gmail.com>
Date:   Sat, 02 Dec 2017 21:54:40 -0800
In-Reply-To: <CAPkN8xKDQrf+LMpj9GHw9n_crJ1UUwq7Zek+Z1dgQ0n2Jz5U6g@mail.gmail.com>
        (anatoly techtonik's message of "Sun, 3 Dec 2017 00:26:59 +0300")
Message-ID: <xmqqa7z0jqzj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74956C3E-D7EE-11E7-B0D1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

anatoly techtonik <techtonik@gmail.com> writes:

>> Git is not doomed to preserve anything forever. We've gradually broken
>> backwards compatibility for a few core things like these.
>>
>> However, just as a bystander reading this thread I haven't seen any
>> compelling reason for why these should be removed. You initially had
>> questions about how to extract info about them, which you got answers
>> to.
>>
>> So what reasons remain for why they need to be removed?
>
> To reduce complexity and prior knowledge when dealing with Git tags.

Then you are barking up a wrong tree, I would have to say.  If you
do not think non-annotated tags are serving any good purpose in the
context of _a_ project you are involved in and making your life
miserable because some tags are and other tags are not annotated,
suggest to _that_ project to refrain from using non-annotated tags.

Projects that do use non-annotated tags have chosen to use them for
reasons of their own.  It may be that these tags could be annotated
tags instead for some projects, and depending on their tooling there
might be no downside in switching.  Or they may have chosen to use
non-annotated tags for reasons that you do not know.

