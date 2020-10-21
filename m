Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD51C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF03624170
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m0qxEHCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502161AbgJUWM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:12:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63669 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502060AbgJUWM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:12:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABDCFFF023;
        Wed, 21 Oct 2020 18:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hu63KMjw/qqcqoEvhbABI22esFo=; b=m0qxEH
        CkEIliPqF5ptjFbgn5D3ypCaBa+xShnhbElBVTgFxc9oTa0g8qMGgimrSizXe1TQ
        JqgjpIL9h/b2T7XRwGuleUKvCuqUU74yQdgnkxsJH6StSjouH0acPPaSThwhcNCe
        dod70ks8Qo04Wbl1A6EVuuJ1FYCQlU3rWM3uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dmDgWuNX+QLIUSOPVOYWuwckkxeGhcxy
        LLYAo1WkPyJJnnWGTqnQ22KTJZUZnm9Iz0rrvIoO856+8jmav18j0IcVX0HL+I7T
        HQD2eI3EcLFWOK1UTlpuiyd0axOGyhX4k7oEu7J3wcs/oN2zmApZZCANDq7sUoJB
        Wp08zNRQKLU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A45E4FF022;
        Wed, 21 Oct 2020 18:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EFB46FF01F;
        Wed, 21 Oct 2020 18:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/10] fmt-merge-msg: also suppress "into main" by default
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <cf950c6f6a48f9a6ad55ac027afbc0640f9a535d.1603135902.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 15:12:22 -0700
In-Reply-To: <cf950c6f6a48f9a6ad55ac027afbc0640f9a535d.1603135902.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020
        19:31:32 +0000")
Message-ID: <xmqq7drj5iux.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F10379E-13EA-11EB-BC61-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In preparation for changing the default branch name to `main`, let's
> skip the suffix "into main" in merge commit messages.

Hmph, we reversed the course from "no suppression" to "suppress
master as we've always done" because otherwise we'd add _more_
instances of 6-letter string 'master' to our codebase, and that
was to be avoided.  There is no such "let's avoid saying main"
desire, is there?

I can see why a series about updating tests would want a change like
this (i.e. to avoid patches that have to add 'into main' everywhere
to the expected output), but as to the desired behaviour of the
default behaviour of "git merge" command, I am not sure this goes
into the right direction.  After all, there are those (including me)
who find the idea of having one single thing (in this case a branch)
that is special among others is objectionable in itself, not what
word (e.g. 'master') is used to call that single "special" thing.

Having said all that, let me keep my suggested change to the very
minimum.  Let's end the proposed log message with

    ..., let's skip the suffix "into main" in merge commit messages,
    the same way that "into master" has been skipped by default.

That would justify why we are still special casing the new word.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fmt-merge-msg.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index bd22e1ea88..9a664a4a58 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -626,8 +626,10 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
>  	void *current_branch_to_free;
>  	struct merge_parents merge_parents;
>  
> -	if (!suppress_dest_pattern_seen)
> +	if (!suppress_dest_pattern_seen) {
> +		string_list_append(&suppress_dest_patterns, "main");
>  		string_list_append(&suppress_dest_patterns, "master");
> +	}
>  
>  	memset(&merge_parents, 0, sizeof(merge_parents));
