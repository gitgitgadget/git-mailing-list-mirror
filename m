Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EA7C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D261A20748
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fsddaHG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgHGRQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:16:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62107 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGRQa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 13:16:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE874861AE;
        Fri,  7 Aug 2020 13:16:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6tVugFwBnjue+UxCQAeukbAyKdk=; b=fsddaH
        G2JjF47q/0wPs3X/sfoXps/5/4h5AvQh6RQzsVsqH/6TxfCAcf8xbawJ12JMPXbL
        vqqpO+HxZUTT5EhynbDdp+S6h65iuGY6dfbuGH56Q1wU23tWtD+twVl4YAQ+ZNSq
        0n3XoZTnA/ZltB9cqe6SpMC7B+UNYRzs7wf9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pvEd8W+XvwipJxUL7xnoKdgje+N61yga
        nRcGIHhPbBxCNsGwJqRABpyPb2/DGFA3ecnvWDASD/pLYWKLiSWc9sVo8ZdkqSvz
        WQfZfzYayemiovs5noXJSX71YMV1lMZqpQsIEBJgzV/Ev7zxztkxJoi6iou0eKlO
        /rcD4itpkL0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2AE3861AD;
        Fri,  7 Aug 2020 13:16:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65538861AC;
        Fri,  7 Aug 2020 13:16:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 1/2] t: don't spuriously close and reopen quotes
References: <20200802143018.5501-1-martin.agren@gmail.com>
        <cover.1596742823.git.martin.agren@gmail.com>
        <c60416a111bada9624b8b64235ac5c4dd3dedac4.1596742823.git.martin.agren@gmail.com>
        <CAPig+cSjHg2-WYqdkZAS0ye1goj_=5RN3mdjt0-4kSBqNm6WLg@mail.gmail.com>
        <CAN0heSpjgc0GUHnebeBdtr6Yny3Y_jsjz5hTfJqw15bZiPc8HQ@mail.gmail.com>
        <CAPig+cR+JmQsj9qAALq6oxYQb9E94TAEqXHx+dAt=E0FZH6WwA@mail.gmail.com>
Date:   Fri, 07 Aug 2020 10:16:26 -0700
In-Reply-To: <CAPig+cR+JmQsj9qAALq6oxYQb9E94TAEqXHx+dAt=E0FZH6WwA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 7 Aug 2020 12:17:22 -0400")
Message-ID: <xmqq4kpeidg5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA587BB2-D8D1-11EA-930C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I don't feel strongly about whether the series should be re-rolled.
> It's true that dropping that dead code (mentioned above) would make more
> sense coming before the patch which fixes up the quoting, but it
> wouldn't bother me if the dead-code removal was done as a follow-on
> patch.

Yeah, I agree that a preparatory clean-up followed by the main
change would logically make more sense, but if it is swapped it is
not the end of the world ;-)

Thanks, both.
