Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E822BC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 22:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B896C206F1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 22:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S+7bJmbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436730AbgE1WEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 18:04:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54362 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436758AbgE1WEl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 18:04:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE593D509E;
        Thu, 28 May 2020 18:04:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R5u/tvEmb4az5+CWXbeBMHk8D84=; b=S+7bJm
        bg9ixv7il6HNwuFr7vRXf67qo0BR3wZWgbmyyrc+YCHv8ShbTNpWVIV4u9YOuxJM
        0ywjfL4ER7+/n169XuNSqb1NY7F+BhTG3hhxAAh2N9/aWHnSkOXru8VtY4PLYInD
        S+rsUjG2pX/EOD57R30TtD5e9XIqladMsWdSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GAlFlVrige8gu2KdtLvXDZQKB42/2AyD
        5XiVcAXLaEc18NsCJWK9oGk367GnRrOdcaqOVyAOLHgOe7GJGw27yZ9C3swnSWyz
        OvwMdFlWp99JAotpGq6f3sB7sUjPSXSKUlWi3krSpnS2RqAsMTpziRhRNPFG/m1D
        5PKoMptBk1w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C621CD509D;
        Thu, 28 May 2020 18:04:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17EC5D509C;
        Thu, 28 May 2020 18:04:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Steven Willis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Steven Willis <onlynone@gmail.com>
Subject: Re: [PATCH] doc: ls-tree paths do not support wildcards
References: <pull.796.git.git.1590700996483.gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 15:04:33 -0700
In-Reply-To: <pull.796.git.git.1590700996483.gitgitgadget@gmail.com> (Steven
        Willis via GitGitGadget's message of "Thu, 28 May 2020 21:23:16
        +0000")
Message-ID: <xmqq4krz3edq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3746CB90-A12F-11EA-A0CF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Steven Willis via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Steven Willis <onlynone@gmail.com>
>
> Signed-off-by: Steven Willis <onlynone@gmail.com>
> ---
>     doc: ls-tree paths do not support wildcards
>     
>     The documentation for ls-tree says that paths can be wildcards, but this
>     appears to be incorrect, only raw paths seem to work.

This is not something you would write after the three-dash line.

The documentation does not say paths can be wildcards.  It allows a
list of "patterns to match" and never says they are wildcards.

I think they take the traditional "leading paths" (i.e. by saying
"git ls-tree HEAD t/", you can show all paths that are under t/,
and is different from the "raw path" i.e. "git ls-tree HEAD t").

