Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C52C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9068F610A3
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhFSGI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 02:08:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62249 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhFSGI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 02:08:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AD5A129183;
        Sat, 19 Jun 2021 02:06:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6rS4HPsiwzmfEW9syKWxW+APyGbJ6EnmiFqxda
        zozVw=; b=F7SmpRCn0R8DL8gLwAFGdiTnEQiUBXyVPZ5o73XiQf1NQDhOPTa+pa
        NrYwZz5ibyTYQk8MQB0XqR68RQbd69ZjiFKHiYmc94e2DzsbOmfxbKQGDXouFUAS
        pq6APVHC+VzgYGwkHV1SxkigWfGr8CwbHn7l0GjEA3x8/PavZ3f18=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12ABB129182;
        Sat, 19 Jun 2021 02:06:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4EAF3129181;
        Sat, 19 Jun 2021 02:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
        <patch-3.3-f343fc7ae6-20210617T100239Z-avarab@gmail.com>
        <20210618170550.GE6312@szeder.dev>
        <CAPig+cQvn+_56iuZmvHVDFSVYto-FMX2vp5aaEGrdr8L8+NY0w@mail.gmail.com>
Date:   Sat, 19 Jun 2021 15:06:42 +0900
In-Reply-To: <CAPig+cQvn+_56iuZmvHVDFSVYto-FMX2vp5aaEGrdr8L8+NY0w@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 18 Jun 2021 13:50:44 -0400")
Message-ID: <xmqqlf76l765.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85E3D8EA-D0C4-11EB-8936-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> That's a good point and not an idle question. It wasn't all that long
> ago that I rewrote `generate-cmdlist` in Perl and got a complaint that
> the Git project was no longer buildable on FreeBSD[1], with the result
> that I ended up re-implementing it (again) in shell[2].
>
> [1]: https://lore.kernel.org/git/loom.20150814T171757-901@post.gmane.org/
> [2]: https://lore.kernel.org/git/1440365469-9928-1-git-send-email-sunshine@sunshineco.com/

If it works without Perl, I would not complain too much, but NO_PERL
is purely about the execution environment (i.e. do not build and/or
install what requires Perl at runtime), so the old complaint [1]
misses the point, I would have to say.  We do expect a working Perl
in test enviroment to run test suite, for example.


