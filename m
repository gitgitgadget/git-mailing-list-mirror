Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6B6C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD5321527
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GgDh3dsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750680AbgJWOjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:39:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61943 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750600AbgJWOjB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:39:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5B83F6CF9;
        Fri, 23 Oct 2020 10:38:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rjp4aBCnElSEgK6DCMD03wlMIEw=; b=GgDh3d
        sjq1RYnbQGGW0mvW43C8c0xnJuPL3AYtuM0/EN8esO14g7ZDZKYx2USUleZucL+J
        dIPQod0z07nGrHCqAGsubevBtTTpa5louWREWxERNNI9W9NnWMj1xi4q84jdJ75o
        mVJQS6fblTfuLY32QvL98diRili6riL2LSlP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dWNeGGcCY0FE3yRrsfoUUj8N3zkkzW0T
        Udu4AOQBk4hAO5mjJ2Tb48Il29l7oGlDD3VbUpBZpCyaCEWbczbQBDnkRSpnE+mH
        xSixSK8SRRa33v27vHfwlenWlE1CZvj1UEays7GJePkjD15FY7u6875GqsECdhZD
        g9EC0/6HbiU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CEA08F6CF8;
        Fri, 23 Oct 2020 10:38:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1F52CF6CF5;
        Fri, 23 Oct 2020 10:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: clarify description of --index
References: <xmqqzh4dk3ey.fsf@gitster.c.googlers.com>
        <23806f2c-df96-b105-3b85-f40b0e8ec7ca@kdbg.org>
Date:   Fri, 23 Oct 2020 07:38:55 -0700
In-Reply-To: <23806f2c-df96-b105-3b85-f40b0e8ec7ca@kdbg.org> (Johannes Sixt's
        message of "Fri, 23 Oct 2020 07:31:16 +0200")
Message-ID: <xmqqzh4dhurk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B571B5A-153D-11EB-83F5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> -	Apply the patch to both the index and the working tree (or
>> -	merely check that it would apply cleanly to both if `--check` is
>> -	in effect). Note that `--index` expects index entries and
>> -	working tree copies for relevant paths to be identical (their
>> -	contents and metadata such as file mode must match), and will
>> -	raise an error if they are not, even if the patch would apply
>> -	cleanly to both the index and the working tree in isolation.
>> +	After making sure the paths the patch touches in the working
>> +	tree have no modifications relative to their index entries,
>> +	apply the patch both to the index entries and to the working
>> +	tree files or see if it applies	cleanly, when `--check` is in
>> +	effect.
>
> I don't think that this is an improvement. The purpose of --index *is*
> to apply the patch to both index and worktree, and that should be
> mentioned first. The check that both are identical, is a prerequisite
> and not the primary objective of the option.

Yeah, but this was an attempt to clarify what that "apply to both",
which is the central part of the operation, exactly means.

The only mode of operation we offer is that we start from identical
index and working tree, and make the same change so that we arrive
at the same outcome.  It is not like you can have some changes in
the working tree file as long as they do not overlap and collide
with the incoming patch, make the same change with the patch to
arrive at different contents as the outcome.  We explicitly forbid
that, but "apply to both" does not exactly tell it to the readers.

But I am OK to drop this, if you do not think it clarifies the
description.

Thanks.
