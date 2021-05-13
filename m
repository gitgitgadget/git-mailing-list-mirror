Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB374C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9E06109F
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhEMEFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 00:05:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63850 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEMEFC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 00:05:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5DBD146F66;
        Thu, 13 May 2021 00:03:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EGvRSFXS8Oxu1bJ9ZONDM5CIoMcS8ECP/enshJ
        7j1OE=; b=jtQ/7HOa1Mf7FInyNuPdA5ti9Y28CqWzqwGG9WSQgYzIVijgMgW6QO
        lRdG3aH0AiQgfpmrpaqroXRkMiQYXHUsKhm+CLGOfrW+9Dcn35RMq8ILAGZPIhgB
        T6qQwEvywYY2EFG3ZmB+UuqGkNSk27r91z9EvFfwQcjJmBl8Cf1nE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CEA0F146F65;
        Thu, 13 May 2021 00:03:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7DA7146F64;
        Thu, 13 May 2021 00:03:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     git@vger.kernel.org
Subject: Re: git-sh-prompt: bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
References: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
Date:   Thu, 13 May 2021 13:03:48 +0900
In-Reply-To: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
        (Christoph Anton Mitterer's message of "Thu, 13 May 2021 05:38:18
        +0200")
Message-ID: <xmqq4kf7cmaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39047C8C-B3A0-11EB-B545-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Anton Mitterer <calestyo@scientia.net> writes:

> Could it be that git-sh-prompt no longer works properly?
>
> With git 2.31.1:
> $ . /usr/lib/git-core/git-sh-prompt
> $ PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
> $ cd someGitRepo
> bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
> $ 

Would

    $ set +u

fix it, I have to wonder?

