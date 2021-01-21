Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B408C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 21:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098C823381
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 21:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbhAUVAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:00:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57810 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbhAUU47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 15:56:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 190AE108B3D;
        Thu, 21 Jan 2021 15:56:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=imP/mC9LX4aw7R0zRwyaMYXuZtQ=; b=oqeC72
        p9EkN8x3rwH4ygyGcjj5VPrbAK+3+2BvQKc2pjqWTKec63kJZnAAwH1b/tPsq/mB
        q+kZha1AEys5Cwe4rLF8ccNQTJE3PIdmpaUHBEeB/wertAlyQ1YhoyTbEk0W48Qu
        42CnPfPAWmp2FgE9xDibvYH3ijkJBudN5yLT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O8CTa+jmHDvaMzwkio6Mf4hMl0JwGdl+
        lfUaEKAqUsL5slM+q8T5V+o3Bes9uSMBvo/bFMYgQkdXWioKGp65bFqt2Z2PJcZb
        2DCCYNLq4unLtxczYebtKOmnBoOjPgNk4/GK37wBoyhlLRqe6A3fBT3BObzhUWG0
        eZS7g46xYAE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 121A3108B3C;
        Thu, 21 Jan 2021 15:56:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54FB3108B3A;
        Thu, 21 Jan 2021 15:56:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
References: <20210108092345.2178-1-charvi077@gmail.com>
        <20210119074102.21598-4-charvi077@gmail.com>
        <xmqqmtx3dq83.fsf@gitster.c.googlers.com>
        <CAPSFM5cxTrvAq6j3yhzidWdr8P8-sYmd1-9tmsK4iXMKrC7TNA@mail.gmail.com>
        <CAP8UFD3PRaiCiSfSMaX0FDrEcOz2xv3992meum7qnKve1rK6nw@mail.gmail.com>
Date:   Thu, 21 Jan 2021 12:56:14 -0800
In-Reply-To: <CAP8UFD3PRaiCiSfSMaX0FDrEcOz2xv3992meum7qnKve1rK6nw@mail.gmail.com>
        (Christian Couder's message of "Thu, 21 Jan 2021 16:21:16 +0100")
Message-ID: <xmqqwnw6au1d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A8BDACE-5C2B-11EB-B70A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> Oops, I think Phillip and Christian also pointed in the last revision
>> to look for alternatives to make it easy. I mistook that point and
>> forgot to look at it.
>
> Yes, please take a look at find_commit_subject() in "commit.c".

Yeah, it uses pretty.c::skip_blank_lines(), which is easy to use.
so something like a loop that calls skip_blank_lines() to see if it
returns a differnt result (which means the argument we fed it was at
the beginning of a blank line, which is what this helper wants to
return), and otherwise we advance by one line with strchrnul() and
retry, perhaps.

    while (*body) {
	char *next = skip_blank_lines(body);
	if (next != body)
	    break; /* found a blank line */
	body = strchrnul(body, '\n');
	if (*body)
	    body++;
    }
    /* body has the answer */
