Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6EEC1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 04:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeKZPhw (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 10:37:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61421 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeKZPhw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 10:37:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50ECF111EFD;
        Sun, 25 Nov 2018 23:44:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wq0O5iHI7nZf
        yhkuSwBu2iNGcI4=; b=hd5Ogrb/THnaA2zhVkn/m4/wwLTNrrCfipE7H8Wukdm+
        XijX++9K5vsQCeYmEpnyGZbiDFWhy9J7kQk6OG9C8B7kqtNDHLlXxHf5ZC+UXnMt
        xICk2ZEldHLVXyOPX3QDlVYTQhmVbxRif96hS2sJBuQhyDY49IxaXaAm79cWuSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Xd8t6s
        CX577lENEo+MKivuNI8wdnk9P/BqKcC9snONAHqPsebXUDJcPQ7vrz/Gp0K/WVFz
        MQ7mgqqayI+5wVbdafYiC+93FglJXQpCsIKM9YCrdb5FUl37thoOiz+OmSVstcyk
        Go/rDzx+PIqVLaNKzwRrKDp7a+1v3rAFKe79Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47E13111EFC;
        Sun, 25 Nov 2018 23:44:57 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8648D111EF7;
        Sun, 25 Nov 2018 23:44:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     pclouds@gmail.com, avarab@gmail.com, git@vger.kernel.org,
        newren@gmail.com, peff@peff.net, sbeller@google.com
Subject: Re: [PATCH] files-backend.c: fix build error on Solaris
References: <87a7ly1djb.fsf@evledraar.gmail.com>
        <20181125045816.12185-1-pclouds@gmail.com>
        <CAPUEsphe9eXk8zLE35iRq-M9a-tukj8APQ0gHzR6PHfNZNLxLA@mail.gmail.com>
Date:   Mon, 26 Nov 2018 13:44:55 +0900
In-Reply-To: <CAPUEsphe9eXk8zLE35iRq-M9a-tukj8APQ0gHzR6PHfNZNLxLA@mail.gmail.com>
        (Carlo Arenas's message of "Sun, 25 Nov 2018 02:19:20 -0800")
Message-ID: <xmqqin0kzbug.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05FA910C-F136-11E8-B4E5-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Do you mean Tested-by: (meaning, you actually saw the breakage with
SunCC without the patch and also saw the patch fixed the breakage)?

> clang with -Wpedantic also catch this (at least with Apple LLVM
> version 10.0.0); recent versions of gcc also include that flag and at
> least 8.2.0 shows a warning for it, so it might be worth adding it to
> developer mode (maybe under the pedantic DEVOPTS).

Nice to know.

> ..., would this be something I should be adding?, what are the expectat=
ions around
> warnings and compilers?

It may be a worthwhile thing to discuss, and as a discussion
starter, a patch would help ;-).
