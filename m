Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4704C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7541520753
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jF+36eAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgCWVuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:50:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62100 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWVuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:50:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48D5C57F0E;
        Mon, 23 Mar 2020 17:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=UmdwPkHCz7/QSIRDSlu8YnOwtEY=; b=jF+36e
        AWYsj2dW1ctdtfLjDvj2Q1hFqbr2bpVQA7r5KhYxDZ7L50PKNFxN+UsjNsvT70Cw
        oHxsBUjuZLj5Uw5qlo6CkkaUIoUiDqnjJmdonMt3WhtAlBTEACv49ALV0h4NrN3F
        c96cokImUn4/f6wiBLIPPb9U0J2jyzgQTkRB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lJW3cpO/ltYicp5OkmxSsEzV7lUQAbKz
        gbQhkeasysEycaXTwWHtNEj2jsdYfOxhWJmXemYBeQuLee5V1XMUlcjpw/PHmNFh
        PHT+jviaGhycKpkP73wiFPoTJZUWO+GC2pp7dKa34nO8dE+kQfrlQfBT654jXmYy
        4LzcUVtQWmQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41E7157F0C;
        Mon, 23 Mar 2020 17:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6B9657F0B;
        Mon, 23 Mar 2020 17:50:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] import-tars: ignore the global PAX header
In-Reply-To: <nycvar.QRO.7.76.6.2003232205580.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 23 Mar 2020 22:08:36 +0100 (CET)")
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
        <fce519db-5ad4-270f-abcf-0e26549486cb@web.de>
        <xmqqh7yf55q7.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2003232205580.46@tvgsbejvaqbjf.bet>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Mon, 23 Mar 2020 14:50:17 -0700
Message-ID: <xmqqtv2e3fmu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49084BF0-6D50-11EA-9BF2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> throws too much.  That would welcome their effort to enhance the
>> importer, if they find it more useful to keep some other information
>> found in global headers, without breaking the intent of this change.
>
> I don't think that we're throwing away anything because the PAX header is
> intended to be a _header_, not a _file_, yet
> `contrib/fast-import/import-tars.perl` currently treats PAX headers that
> way.

What I meant (and wrote) was information contained within the
header.  You could store such metadata (e.g. this tree came from
this commit from the upstream project) in the commit object while
importing, for example.

As I wrote, I do not think we need to implement such feature right
now.  I am just saying that we should make sure we are not
unintendely discouraging future developers from doing so by giving
an impression that we are claiming "a pax header is intended to be a
header and has no interesting information---never look at it".  If
we said "We discard the headers because it is the most expedient way
and we currently have no use for them", that would make it clear
that it is OK for them (the future ourselves developers) to extend
the code not to lose the information, as long as they keep ignoring
the prefix thing alone, if they want to follow the course set by
this change.

>> Having said all that, even before "git archive" existed, release
>> tarballs by many projects had leading prefix so that a tarball
>> extract would be made inside a versioned directory.  To truly help
>> users of the importer, doesn't the logic to allow the user to say
>> "please strip one leading level of directory from all the tarballs I
>> feed you, as I know they are versioned directories" belong to the
>> command line option of the importer?
>
> I guess nobody needed an explicit way to strip path prefixes yet, since
> the implicit way works so well.

Now you confused me.  If implicit way already works well, why are we
adding this patch to make it implicitly ignore?
