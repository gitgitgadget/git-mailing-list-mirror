Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787AEC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 18:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531C122B42
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 18:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IYGGe/4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgHDS6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:58:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52615 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDS6r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 14:58:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D01768102F;
        Tue,  4 Aug 2020 14:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cKAvb9YaA/Y7cA9vjCnQjlEgRqg=; b=IYGGe/
        4VoYKpmPUsFVkaVPiJGmrxpPYf6koMcqpixmOIqMFm3OOZLJ1amEFkDfEYS0ceqt
        GP+z4DVyuMboAho6BcI7xt0sU+QJIog0KsTLgjX0AsoYXzcTNM/Nj/ZGF7cg4UHB
        c1RjMjXhERwVc1Ny7LAzsbp98RiGrvKWtdf+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w1iNM1z1yW+xb4RjeDrs9F1ryVx/XWtB
        lk8hpaRxK99iOz9ZuykArD8vJ7Cc4ik4U56/mtw6A5ufjluRlcqQXPJB7Hq4u+eL
        rtiKuOPrH/5I4jd9qyvfdwsmpjCBTAgS9G8UxYefX5L0tNtAFTm7WGYUqMMEYo49
        70DrcG9ZGk8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8C4C8102E;
        Tue,  4 Aug 2020 14:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53F848102D;
        Tue,  4 Aug 2020 14:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
        <20200804185057.GA1400256@coredump.intra.peff.net>
Date:   Tue, 04 Aug 2020 11:58:43 -0700
In-Reply-To: <20200804185057.GA1400256@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 14:50:57 -0400")
Message-ID: <xmqqr1sms0f0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84FFF124-D684-11EA-9DBC-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 03, 2020 at 10:35:40PM -0700, Junio C Hamano wrote:
>
>> * ss/cmake-build (2020-06-26) 8 commits
>>   (merged to 'next' on 2020-08-03 at a0d70165c1)
>>  + ci: modification of main.yml to use cmake for vs-build job
>>  + cmake: support for building git on windows with msvc and clang.
>>  + cmake: support for building git on windows with mingw
>>  + cmake: support for testing git when building out of the source tree
>>  + cmake: support for testing git with ctest
>>  + cmake: installation support for git
>>  + cmake: generate the shell/perl/python scripts and templates, translations
>>  + Introduce CMake support for configuring Git
>> 
>>  Originally merged to 'next' on 2020-08-01
>> 
>>  CMake support to build with MSVC for Windows bypassing the Makefile.
>> 
>>  Will merge to 'master'.
>>  cf. https://github.com/git/git/runs/892824895
>
> I ran into issues with this, as I have several in-progress topics (not
> yet sent to the list) that touch our Makefile, and they needed updates
> to the cmake file (because it reproduces a lot of the lists and logic
> from the Makefile).
>
> The original philosophy behind putting it in contrib is that most people
> wouldn't have to care, and folks interested in cmake would be
> responsible for keeping it up to date. But the top patch makes it hard
> to ignore, because the vs-build CI job will fail.
>
> I'm not sure of the right path forward. I was definitely unenthused to
> be dealing with cmake, and the problem came up as soon as the series hit
> next.

My hope is that if we let vs-build broken long enough, those who
want to see cmake to graduate would fix it.  We can always threaten
the topic to be discarded out of 'next' after the next release if it
hasn't been fixed ;-)
