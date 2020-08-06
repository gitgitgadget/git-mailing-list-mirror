Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80039C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D151F221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A0JHiqhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgHFRvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:51:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58636 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgHFRu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:50:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53B9BE6F15;
        Thu,  6 Aug 2020 13:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qZWFkKQLWWBfHmo2Nc0Vvp0ac9U=; b=A0JHiq
        hAmuDkZxVmhOlIgR+JDoPQJFrSxS1Dwagq2NxdQUxk7My9AIAVZ4UQ6tKQmF2Mno
        UWfwp/Pg+sfsWaAfrO2gXIgUbDUq/4oeM/HzQ9BHI3n0pRtWNsW8y4nofxh9AMd9
        HDIIY/TqIq8Nhl4umbIzUvQmmCwKf8SlFQwC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HOka/+s8fmwITvBnEqwnhx5VCW3FN0Bv
        rZw0nrqp5XNniJK+QzAT/MlcQiE/XEofomHhpTD4GRhtpfAwMGgfmGQBS3XMv7O5
        pRpP6L8QPzXH9d/PWcj35Pgyc7BRr0Fyopyd6Tebt8ZR8KKUHEEHWUJZeXul01v+
        yXre+tyQ35I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C203E6F14;
        Thu,  6 Aug 2020 13:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 916F6E6F06;
        Thu,  6 Aug 2020 13:50:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "KADOTA\, Kyohei" <lufia@lufia.org>
Subject: Re: [PATCH 2/4] Define TAR_CF and TAR_XF variables in Makefile
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
        <22f8f3e37a18263d890307701903dc18c98aa54b.1596675905.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 10:50:19 -0700
In-Reply-To: <22f8f3e37a18263d890307701903dc18c98aa54b.1596675905.git.gitgitgadget@gmail.com>
        (lufia via GitGitGadget's message of "Thu, 06 Aug 2020 01:05:02
        +0000")
Message-ID: <xmqqa6z7ll44.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C6571F6-D80D-11EA-83EF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lufia via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: lufia <lufia@lufia.org>

See Documentation/SubmittingPatches[[real-name]].

> Plan 9's tar(1) don't support o option.
> So I changed Makefiles to replace tar commands if needed.

There is a big gap/leap between these two sentences.  The first
sentence might justify TAR_XF but it does not explain why TAR_CF
is needed at all.  Also there is "$(TAR) czf" that is left without
getting turned into $(TAR_CF)z.

Are there still remaining uses of $(TAR) after applying this patch?
If with a different justification, a patch that abstracts our use of
"tar" as an archiving tool into different use cases and give one
Makefile macro to each of them with more meaningful names might be
more palatable.  E.g. instead of TAR_CF that abstracts only the "tar
cf" part, make "take everything in the current directory and send an
archive of it to the standard output", i.e. "tar cf - .", into a
Makefile macro, with matching "take an archive from the standard
input and extract it to the current directory", i.e. "tar xf -", as
a matching Makefile macro, perhaps---that way people without a
working "tar" might be able to use zip, cpio or pax (or a script
written around them) as an alternative "archiving tool", for
example.

	Side note.  The above would probably be a huge undertaking
	and I am not suggesting it as a serious counterproposal.

A more plausible alternative is to just touch "$(TAR) xof -" and
replace it with $(TAR_XOF) or even $(EXTRACT_TARBALL_AS_MYSELF)
while leaving $(TAR_CF) alone.  That _might_ be palatable.

I dunno.
