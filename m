Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B955C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBC024672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B18K5I16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLSTYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:24:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61505 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSTYC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 14:24:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A40B909AE;
        Thu, 19 Dec 2019 14:24:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3IO7ALajlC1bOUbuUejfOHgsr+o=; b=B18K5I
        16PUFOgoU/SNiNwbTiQ2NkT/KcB9juj209uuUYQ8pRAe+zkitmMAPHaP/C/MYlBL
        xrEOQtdbd0chddD3O+jaEqeXrWEM5zd9Sd/U9lH+t6PyuTUxQ0YtWiaSH55lNJME
        /3heIj7ikcOO1RYh+BPGx4T6qKBSvgO+TPbK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZOUbSIJ2trC8RZBN44VPjgfafN5kK6da
        c6wm1z4yB/ympOkKgkBLSM3Yile2ouJo/pkXRDp/kaE3vT1lApcMr/5QNZMqu2qF
        g/LAAubSiEB/GgpktpXL7dhzevJB7XkQRakDaVj/Z6Bw7gGTC5eFXSND1xKLqHsU
        k2ORz18Lxp0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 142AA909AD;
        Thu, 19 Dec 2019 14:24:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 34E4B909AC;
        Thu, 19 Dec 2019 14:23:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 0/1] [Outreachy] commit: display advice hints when commit fails
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
        <xmqqlfr8b28v.fsf@gitster-ct.c.googlers.com>
        <20191219185427.GA227872@google.com>
Date:   Thu, 19 Dec 2019 11:23:54 -0800
In-Reply-To: <20191219185427.GA227872@google.com> (Emily Shaffer's message of
        "Thu, 19 Dec 2019 10:54:27 -0800")
Message-ID: <xmqq7e2sazlh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A250D06-2295-11EA-977F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Thu, Dec 19, 2019 at 10:26:40AM -0800, Junio C Hamano wrote:
>> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>> >      @@ -19,16 +19,16 @@
>> >             #   (use "git add <file>..." to update what will be committed)
>> >             #   (use "git checkout -- <file>..." to discard changes in working directory)
>> >             #
>> >      -      #   modified:   ../builtin/commit.c
>> >      +      #   modified:   /builtin/commit.c
>> 
>> Really?
>
> It's hard to know what this cryptic comment means.. :)
>
> This was a recommended change:
> https://lore.kernel.org/git/20191218031338.203382-1-jonathantanmy@google.com
>
> Since other changes were being made at the same time, I personally don't
> mind a little nit fix in the commit message.
>
> Or, do you mean that "now it looks like the file is at the filesystem
> root, which is wrong"? It is indeed wrong now when it wasn't before. But
> I, for one, can't tell what you mean by just the one word.

That is exactly the point.  I am not in the business of spoon
feeding answers.  I want my contributors to *think*.
