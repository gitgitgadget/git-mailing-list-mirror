Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD89C2D0EF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE5420767
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WljC7sjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404642AbgDPE5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:57:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56294 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405272AbgDPE53 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 00:57:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7871C4EFF7;
        Thu, 16 Apr 2020 00:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=snikYfHl5xZOS2OZdwLpbm7h8Q0=; b=WljC7s
        jKC3A4eoXh1DRFcnZJvWJCoXRW6NasaAZPu7Q8wv75mZEZah6hP37MxXkrYX0mm+
        NAnuqmuSFxFfMgcu3qL8+leuxrBDAcwXdQxAjwwwyrlTw07+rvFEki/QJ8d21OG7
        wD/z+0hZEfY0Xw1DEtt942+rinlntFKwY0mFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vEvWs7wDQ6PR2hDERa3c8Cj8PuDFhLQk
        TgBz+/PXYwLzmnr/ICWWMA2gVM6m3z3WJzamG8f1FTVafJCoIGZr6vFMhrA7Mlik
        9kWPEacuKlU0S236XqZ8vpOPoIFgPnjgez+KODLCR1gQEISleyd08L7JgDGgZnq2
        DY/4KeBfke4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 706584EFF6;
        Thu, 16 Apr 2020 00:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAF194EFF4;
        Thu, 16 Apr 2020 00:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Elijah Newren <newren@gmail.com>, Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: fixing ci failure of 'pu' with the es/bugreport topic
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1586309211.git.congdanhqx@gmail.com>
        <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
        <xmqq1rovl54d.fsf@gitster.c.googlers.com>
        <20200410174141.GB27699@danh.dev>
        <xmqqh7xk45l4.fsf@gitster.c.googlers.com>
        <xmqq1roo43sp.fsf_-_@gitster.c.googlers.com>
        <CAJoAoZk9Y9rc7ssfZ6S3pYepK6LpapoSzBAQjL+f7uHXv79HWg@mail.gmail.com>
        <CABPp-BFM-A43GpOkfNeSt6KKsdpXzObhwajvT5qBp-ws_jstRw@mail.gmail.com>
        <20200416041037.GA236872@google.com>
Date:   Wed, 15 Apr 2020 21:57:25 -0700
In-Reply-To: <20200416041037.GA236872@google.com> (Emily Shaffer's message of
        "Wed, 15 Apr 2020 21:10:37 -0700")
Message-ID: <xmqqpnc82fka.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C419D86C-7F9E-11EA-BFD7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Wed, Apr 15, 2020 at 08:45:05PM -0700, Elijah Newren wrote:
>> 
>> Create a fork of github.com/git/git and open a pull request against
>> it.  (I believe you could also fork github.com/gitgitgadget/git and do
>> a pull request against it, but I switched over to /git/git a while
>> ago.) Immediately upon opening the pull request, a bunch of linux,
>> mac, windows, and freebsd builds will be triggered with various runs
>> of the testsuite.  Has been very useful for catching issues for me
>> before I sent them off to the list.
>
> I did before I sent this iteration, and it passed:
> https://github.com/gitgitgadget/git/pull/573
>
> That's why I'm confused :) Did I do something differently? I don't use
> GGG to send the emails, but I do use it to run CI checks.

Comparing the list of "checks" revealed by clicking "Show all
checks" there, with the list of "Actions" with recent tip of 'pu',
say, https://github.com/git/git/actions/runs/79416884, I notice that
the former does not have vs-build.  

Also, the former seems to be on "Azure Pipelines" (e.g. [*1*] which
is "Windows build" among the "checks" on the list), while the latter
is "Github Actions" (e.g. [*2*], among which exists "VS-build" that
seems to be missing from the former).

The latter is coming from having the
dd/ci-swap-azure-pipelines-with-github-actions topic and other two
topics that it depends on, which are right now only in 'pu'.  As
we'd like to advance the Github Actions CI support to 'next', I've
been looking at the failures to it caused by individual topics (and
right now, we know of two topics, one is the bugreport and the other
is reftable) to make sure these other topics can enter 'next'.

Thanks.

[References]
*1* https://github.com/gitgitgadget/git/pull/573/checks?check_run_id=565642291
*2* https://github.com/git/git/runs/590781044?check_suite_focus=true
