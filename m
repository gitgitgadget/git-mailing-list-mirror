Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDCD20964
	for <e@80x24.org>; Thu, 23 Mar 2017 15:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965361AbdCWPyV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:54:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58737 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965314AbdCWPyT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:54:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBFD586F7E;
        Thu, 23 Mar 2017 11:54:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OjbpuLszW8UU+JrxLWV5NXV+1DI=; b=DbqJwR
        T/36lFvpbQmljjySrfR0zrWImAEMP6cGDsEC8IxdAvZqeIkj5b3uXDr6ufQFxlfc
        fSUQjVOczxbNf5+B6tNbNW0BA8CuD2bucTFY11OHxG2nJMK7c01Z/3Y/qSsPZE8y
        jJsuwH198R9ikeJ+Y56Lj7vWmKB4HFVKDyfLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JWjv5aRw69p+w54syeZZJnjmSdbC31AO
        vBvaaFj2GN0blvfxLTHbyv8TVTcRvmFfr83uHaoATbyixTdjc9F1KHBBhxi0zGqF
        JFoH3blpMympZH62IlMYup6rMNRRs0OJlfve03O9Vi4b3LvhmpjoXbL5KxyNdPLM
        eWgSW/oX0Hw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5F3E86F7D;
        Thu, 23 Mar 2017 11:54:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 478D286F7C;
        Thu, 23 Mar 2017 11:54:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
        <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com>
        <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
        <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
        <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com>
        <CAMMLpeR-zCpL5Gx=BoK8G9_wL2TBe-wD3VnsAShAuVVzS=Nirg@mail.gmail.com>
Date:   Thu, 23 Mar 2017 08:54:10 -0700
In-Reply-To: <CAMMLpeR-zCpL5Gx=BoK8G9_wL2TBe-wD3VnsAShAuVVzS=Nirg@mail.gmail.com>
        (Alex Henrie's message of "Thu, 23 Mar 2017 09:07:15 -0600")
Message-ID: <xmqqfui4f0pp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F571CF9A-0FE0-11E7-B611-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> 2017-03-22 10:54 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>> No problem. Do I need to submit a second version of the patch with a
>>> test for `git -p log`?
>>
>> You do want to protect this "without an option, we default to
>> 'auto'" feature from future breakage, no?
>
> Yes, but I need to know whether you want a v2 of this patch with all
> of the changes including the new test, or a second patch that depends
> on the first patch and only adds the new test.

Sorry, I misunderstood the question.

In general, we prefer to have tests that protects the updated
behaviour in the same patch that makes code changes that brings in
the new behaviour, i.e. a single v2 patch with new test would be
more appropriate in this case.

When people work on a large bugfix, especially one that needs
multiple steps, we sometimes see a patch that adds new tests that
describe the desired behaviour as failing tests first, and then
subsequent patches to the code to update the behaviour flip
"test_expect_failure" to "test_expect_success" as they fix the
behaviour.  But for a small change like this one, that approach is
inappropriate.

When a patch that was reviewed, deemed good enough and has been
already merged to the 'next' branch later turns out that it needs
further work (like "we do need some tests"), we do such necessary
updates as separate follow-up patches, simply because we promise
that 'next' won't be rewound and are not allowed to replace patches.
But this one is not yet in 'next', so we can freely take a
replacement patch.

Hope this message makes it clear enough?

Thanks.

