Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C9A211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 00:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeLFAbk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 19:31:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62841 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbeLFAbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 19:31:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 628D4120936;
        Wed,  5 Dec 2018 19:31:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YO/Cm4KzsoGJLs5allslkCiT+4I=; b=yk7YSu
        Ws9TgUH6uOLIBYifBGXGQmoFgZrkg4cgTCMxSBDWM9t1KsA6xrqe50Dl/bTCEn7t
        RZ9rlil6pXn6KZoM/DLuzVjjb6xIzVF/y6viTNPyUzT8IMdBTx6YefrfNjGjuY2Q
        Nf0gyS7zIpG99Uo3MVCsKq22R+b2WRjP/alOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gZTqJuXHElIkwZ4aRK1X96Hhk8Pys0P9
        U9E6K9Un4Y9CuvsXUfA0JchstZQeU0zOeevPzbmZc7J2/c8no3/1N9SA/6OkO3ZC
        yMNgJZw/nAa+/JuHO2o2ssWk9KhI2W+62FlE3XD837DRFK6hYU5NJxtsLlonAxpS
        DlXifCTBHlM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A40B120934;
        Wed,  5 Dec 2018 19:31:38 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7329120933;
        Wed,  5 Dec 2018 19:31:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     Konstantin Kharlamov <hi-angel@yandex.ru>, git@vger.kernel.org
Subject: Re: Any way to make git-log to enumerate commits?
References: <5e5c6d1c-6b3e-c94a-17be-a2af518c1607@yandex.ru>
        <20181205145419.vbbaghzzrnceez45@tigra>
Date:   Thu, 06 Dec 2018 09:31:36 +0900
In-Reply-To: <20181205145419.vbbaghzzrnceez45@tigra> (Konstantin Khomoutov's
        message of "Wed, 5 Dec 2018 17:54:20 +0300")
Message-ID: <xmqqa7ljbimv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AF539B4-F8EE-11E8-86E3-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix@bswap.ru> writes:

> On Wed, Dec 05, 2018 at 05:22:14PM +0300, Konstantin Kharlamov wrote:
>
>> It would be great if git-log has a formatting option to insert an
>> index of the current commit since HEAD.
>> 
>> It would allow after quitting the git-log to immediately fire up "git
>> rebase -i HEAD~index" instead of "git rebase -i
>> go-copy-paste-this-long-number-id".
>
> This may have little sense in a general case as the history maintained
> by Git is a graph, not a single line. Hence your prospective approach
> would only work for cases like `git log` called with the
> "--first-parent" command-line option.

I do not see why the "name each rev relative to HEAD" formatting
option cannot produce HEAD^2~2 etc.

It would be similar to "git log | git name-rev --stdin" but I do not
offhand recall if we had a way to tell name-rev to use only HEAD as
the anchoring point.
