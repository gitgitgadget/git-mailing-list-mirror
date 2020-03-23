Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF8CC3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49D520719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KISyUauS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCWPzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:55:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54902 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWPzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 11:55:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D803B47B2;
        Mon, 23 Mar 2020 11:55:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4H3Q6esXAv1duQxaaefcIn6i57M=; b=KISyUa
        uSgXxqr6y/4pX1oKKi5nqeRio+tr+xq2Bs1jFBJaf6CISGqJP6FE8ClhF6NFZ43w
        rEsNzO97YWr2c174UroOXhXVglXKzh1s/Hjf/da/zHUTPz/GKQ3542LRywTd1J1n
        41RBMeF24blrju6bNbDRgJPnrW/oWf9eaPN00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ztgy/1DBP0BRoNNyZpf3jcTQ8wDYX2NY
        omlSdWU++NyDp1Wb07ms3yf6dgSh+gw88geeOLHFoFF0b5SBX5lL9kk3jsFSq/Gv
        0gnOnuaYi7JKzZGJw+YftEi3JOkJG6wfWM2jx+6403iP0RfSc/YhFDE+qBARonL1
        xHgDt58D0uk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95307B47B1;
        Mon, 23 Mar 2020 11:55:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89AB6B47AD;
        Mon, 23 Mar 2020 11:55:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 6/8] t7063: drop non-POSIX argument "-ls" from find(1)
References: <cover.1584838148.git.congdanhqx@gmail.com>
        <59e3f73784b2a3bd9ccec87412e6178411c3708e.1584838148.git.congdanhqx@gmail.com>
        <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet>
Date:   Mon, 23 Mar 2020 08:55:29 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 23 Mar 2020 15:11:50 +0100 (CET)")
Message-ID: <xmqqy2rr5amm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B96F5F96-6D1E-11EA-A011-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/t/t7063-status-untracked-cache.sh
> b/t/t7063-status-untracked-cache.sh
> index 190ae149cf3c..ab7e8b5fea01 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -18,7 +18,12 @@ GIT_FORCE_UNTRACKED_CACHE=true
>  export GIT_FORCE_UNTRACKED_CACHE
>
>  sync_mtime () {
> -       find . -type d -ls >/dev/null
> +       if test_have_prereq BUSYBOX
> +       then
> +               find . -type d -print0 | xargs -0r ls -ld >/dev/null
> +       else
> +               find . -type d -ls >/dev/null
> +       fi

Given that this is only to work around the lazy mtime sync found on
BSDs, if we were to have any if/then/else, shouldn't we be rather
doing

	if test_have_prereq NEEDS_SYNC_MTIME_BECAUSE_WE_ARE_ON_BSD
	then
		find . -type d -ls >/dev/null
	fi

to make it a no-op for most everybody (including Windows)?
