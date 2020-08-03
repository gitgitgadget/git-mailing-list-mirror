Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A4C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB42A20792
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EoiYniHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHCREU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:04:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56407 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgHCRES (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 13:04:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CD1083914;
        Mon,  3 Aug 2020 13:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vsLyElSyl2hUxGY7dyh+a84pXY0=; b=EoiYni
        HaE3ZNfkuqNtwph6w6Kavu9sW1K3+oVh998eRuOn3qXVQmfRrg77kUm/EmOf2ili
        2nbiUq6OrI9SpEKNkcBq367TUEXQVNndW2/utoXv0PXXUiBveCG/DKPhbcWfuvzZ
        +IirLs6m8XXF8bypfc+Aou2Q9AgF+GFtc57IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XiKQxQLbT9X3WE6LmqAaCfmJ7r2GZOdO
        ++/+2ghOssEnsTdKA/r09JUub/5rY55tlU8H4nDYw+obtFugtPGObtorrtzQ4wzq
        Ffka+LyoRHtUu+GhH0wdURVz1O1Vf/uro2FOHBiRVSSJEqyLUMC4sx4HBZdHLY3L
        TGBIbCqAVMI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 931F083913;
        Mon,  3 Aug 2020 13:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F93A83912;
        Mon,  3 Aug 2020 13:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Noam Yorav-Raphael via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Noam Yorav-Raphael <noamraph@gmail.com>
Subject: Re: [PATCH] docs: improve the example that illustrates git-notes path names
References: <pull.692.git.1596465817121.gitgitgadget@gmail.com>
        <20200803154852.GA48612@syl.lan>
Date:   Mon, 03 Aug 2020 10:04:15 -0700
In-Reply-To: <20200803154852.GA48612@syl.lan> (Taylor Blau's message of "Mon,
        3 Aug 2020 11:48:52 -0400")
Message-ID: <xmqq7dufwtio.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CD012B2-D5AB-11EA-A58C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
>> index ced2e8280e..9fc1979531 100644
>> --- a/Documentation/git-notes.txt
>> +++ b/Documentation/git-notes.txt
>> @@ -223,7 +223,7 @@ are taken from notes refs.  A notes ref is usually a branch which
>>  contains "files" whose paths are the object names for the objects
>>  they describe, with some directory separators included for performance
>>  reasons footnote:[Permitted pathnames have the form
>> -'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
>> +'12'`/`'34'`/`'56'`/`'...'`/`'789abc...': a sequence of directory
>
> I had to read this twice to figure out why the first 'ab' changed to
> '12'. It appears that this is to avoid having to use 'gh...' in the
> last directory, since 'g', 'h' and so on aren't hexadecimal digits.

You can wrap-around to '0' after counting up to 'f', no ;-)?

Having '/.../' between '56' and '789' to indicate "there are more
levels possible here" is somewhat misleading with the new example.
We could argue that the original objectname does not have to be
"123456789abc.." but then the whole exercise becomes somewhat
pointless as the objectname could have been 'abcdef...abcdef...'.

Another minor nit: it probably makes it read more natural to start
counting from '0' when writing hexadecimal, if we really want to
use sequence of ascending hexdigits.

Using a seemingly random example 85/b4/.../808d9ee6debdf167ced3
might be less confusing, because ...

>>  names of two hexadecimal digits each followed by a filename with the
>>  rest of the object ID.].

... I think these two lines is pleanty clear than any example, so I
am OK with either the old or the updated example, but I think a
seemingly random example as long as the leaf level does not share
the leading hexdigits as the pathname would work the best.

