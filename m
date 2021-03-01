Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7195EC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C52C652FE
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbhCARk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:40:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64656 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhCARfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 12:35:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA8A91227DF;
        Mon,  1 Mar 2021 12:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=co6bWLBZkmjYX/g3v89rIR6ovN0=; b=iwcn0A
        awzHqNiZEXNvObBFoMl1iWoY46mhJFRXv6P7nsiocttQR0LneZQp8JDS/I2aWZxR
        pEmabT64WjbccAbWX6zUx7jt/H/ypB6Os1R9FISg6LAvS4B+5EchrB3OovhiYokJ
        9OLay1FaYWgxVIEbhgZuZe0yQ6kyT+7/8wQuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eeyp8jeqT2X918AcFdKTrnHpBrDsjDt1
        LHczw/ANPyhai0f0pyVNaTAi+fCBoK2RVez00fUFjdUsio0S82qR8g7NXkWVmy76
        WVqp0T+4cU7D3wk6MH470EWoIsuHY/A3FSFKb0iiNIhxr9C7HOeYI/xQJTjbmXcf
        AWLc19U/IBo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A35F21227DE;
        Mon,  1 Mar 2021 12:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ED2991227DD;
        Mon,  1 Mar 2021 12:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Round-tripping fast-export/import changes commit hashes
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
        <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
        <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
        <87mtvolbuj.fsf@evledraar.gmail.com>
        <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
Date:   Mon, 01 Mar 2021 09:34:31 -0800
In-Reply-To: <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
        (anatoly techtonik's message of "Mon, 1 Mar 2021 10:44:12 +0300")
Message-ID: <xmqqblc2srq0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 627B397C-7AB4-11EB-BD76-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

anatoly techtonik <techtonik@gmail.com> writes:

> Is fast-export/import the only way to filter information in `git`? Maybe there
> is a slow json-export/import tool that gives a complete representation of all
> events in a repository? Or API that can be used to serialize and import that
> stream?

I do not think representation is a problem.

It is just that the output stream of fast-export is designed to be
"filtered" and the expected use case is to modify the stream somehow
before feeding it to fast-import.  And because every object name and
commit & tag signature depends on everything that they can reach,
even a single bit change in an earlier part of the history will
invalidate any and all signatures on objects that can reach it.  So
instead of originally-signed objects whose signatures are now
invalid, "fast-export | fast-import" pipeline would give you
originally-signed objects whose signatures are stripped.

Admittedly, there is a narrow use case where such a signature
invalidation is not an issue.  If you run fast-export and feed that
straight into fast-import without doing any modification to the
stream, then you are getting a bit-for-bit identical copy.

But "git clone --mirror" is a much better way to do get such a
bit-for-bit identical history and objects.  And if you want to do so
with sneakernet, you can create a bundle file, sneakernet it to your
destination, and then clone from the bundle.

So...

