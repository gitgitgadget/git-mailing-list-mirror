Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9BBC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 04:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720D1611C4
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 04:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhHUEWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 00:22:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62241 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhHUEWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 00:22:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA9BC131C38;
        Sat, 21 Aug 2021 00:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZbwB1Jb+XAbAddupY2NSXzbpFj3cGK0PaiXAWo
        oYcbM=; b=ul+mB1x8l/y3nuBf71TlVgLJiI+WmgnaB4M+9bEQnR5ArKdHvot0Q5
        Dwba3ZzHF+bdij4RfVh8Uu0z/Y4NP3AzGYEW7MwxS7ZYMqiZ+8TqUUEe8q2BmYFC
        8Oonz+/QXEztMVr4tIDgL0R7VjexBcBZhLyN1KaO4rCHykl/FJ3J8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A57E6131C37;
        Sat, 21 Aug 2021 00:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89317131C36;
        Sat, 21 Aug 2021 00:21:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xiaowen Xia <haoyurenzhuxia@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, worldhello.net@gmail.com,
        Xia XiaoWen <chenan.xxw@alibaba-inc.com>
Subject: Re: [PATCH] add http.maxReceiveSpeed to limit git-receive-pack
 receiving speed
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
        <xmqq4kbl2sre.fsf@gitster.g>
        <CAHLXgnYsQcfgddNHdH+geoczq8isgLaf-b3oLzjNS+m96N5ESg@mail.gmail.com>
Date:   Fri, 20 Aug 2021 21:21:29 -0700
In-Reply-To: <CAHLXgnYsQcfgddNHdH+geoczq8isgLaf-b3oLzjNS+m96N5ESg@mail.gmail.com>
        (Xiaowen Xia's message of "Sat, 21 Aug 2021 11:19:00 +0800")
Message-ID: <xmqqsfz3sa0m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43370766-0237-11EC-93D2-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xiaowen Xia <haoyurenzhuxia@gmail.com> writes:

> But this patch is similar to the `http.lowspeedlimit` and `http.lowspeedtime`.
> And `http.lowspeedlimit` will not error out the negative values:

An earlier mistake by others does not make it OK to make the same
mistake knowingly, though.

