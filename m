Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86385C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D2B61177
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355758AbhDGTwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 15:52:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56750 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbhDGTwl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 15:52:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34088126887;
        Wed,  7 Apr 2021 15:52:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jCWmA2RBEgqvT1h58abBvUsdh6I=; b=gLSHBa
        VSDxjpODo6066wZADa18lr/TOzwm2XaQGr0AopZivPJ9/4+8GhXFyMYgIWjKXMvv
        01OTUT5n8LTzN2S4mkCOG7KO5k/X5RAHZhuRCR8ucJR1sNx4N031cabK2jhnzzHH
        gGuVwW0d5nzFmmQiOSCOa9paK7yg6KwXbFV38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GWOzyncLhcN8vHUTUUHR1+HRA7kHpnDD
        s20RSMqy/QldPugzp65oGR8P8N+JCc6nNdUN5mfe/FImQFYL0Sdqd5OpPOekB7sD
        /om12zujqZ6dziL8WlbXAvhRmuhZnJVCacnQ5HsqaJM/jfq2jQtfN+G//cnf1ShV
        WGIZ0NvLIYU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2CB64126886;
        Wed,  7 Apr 2021 15:52:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 790E6126882;
        Wed,  7 Apr 2021 15:52:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     jost.schulte@tutanota.com
Cc:     Git <git@vger.kernel.org>
Subject: Re: Shell completion for branch names
References: <MXghkzC----2@tutanota.com>
Date:   Wed, 07 Apr 2021 12:52:26 -0700
In-Reply-To: <MXghkzC----2@tutanota.com> (jost schulte's message of "Wed, 7
        Apr 2021 16:23:16 +0200 (CEST)")
Message-ID: <xmqqr1jlzxc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C85CC510-97DA-11EB-AD67-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jost.schulte@tutanota.com writes:

> I have a question regarding git-completion. I'm using zsh and have
> added the function .git-completion.bash. That gives me some
> auto-completion for branch names.
>
> What I'm looking for: I have a branch named
> "feature/issue-123-add-feature" for example. I'd like to type "git
> switch 123[tab]". Is there some function out there that provides
> this?

I am not an area expert for shell completion, but as a mere user,
unless the shell completion in a directory where I have README.txt
file, responds to

    $ cat EAD<TAB>

and completes the request to

    $ cat README.txt

I would find such a behaviour quite confusing.

On the other hand if

    $ git log feat<TAB>

expands to

    $ git log feature/issue-

then another <TAB> after that would offer 123-add-feature and 143-fix
as candidates, or instead of <TAB> if I type "123<TAB>" and get it
expanded to the full feature/issue-123-add-feature, then I wouldn't
find it confusing or unnatural.
