Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4586BC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17271230FC
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgLUSCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:02:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52865 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUSCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:02:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D635AE470;
        Mon, 21 Dec 2020 13:01:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g9LtDTeWH6Z6QHDKVYyuwQB6OyA=; b=etYzeo
        WuYLYFozmjYV3lcor3MIVVby//DPfI+g+ZoH33fTdxJ+MYbSjnvyAracvcpuguPO
        oCxhaCKET52fLGNEwyD8hD4DqIYl5+MUMXRgVcnmiDZBuagrVTrDC5/0xLAwN8Cp
        WhJxtZTxnpALud32hoqo1Uln7DeexQSK2ZLAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=imrqCRD1WeBkuIEoJpSeh9Lg8wna0O6V
        VU2LxmSyIyGdOeWL8e7FgZv7m6EZg2jXTUTORYkYm9W9seoVZm6TEGUV1+/1Aemx
        j+w3kwi0yym3Qo5DGj2keIfcXy7mtKKfRwxSL/kQ+TaMp3YKKGBWQ5+7NIk+HeHq
        fBaNqfe3GrA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54952AE46F;
        Mon, 21 Dec 2020 13:01:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6B9AAE46E;
        Mon, 21 Dec 2020 13:01:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2020, #03; Fri, 18)
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
        <CAFQ2z_MtpPNSpL9=OoyPfDRfkFxnCO19qBDnY9bnZiEEGtuMsQ@mail.gmail.com>
Date:   Mon, 21 Dec 2020 10:01:47 -0800
In-Reply-To: <CAFQ2z_MtpPNSpL9=OoyPfDRfkFxnCO19qBDnY9bnZiEEGtuMsQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 21 Dec 2020 13:40:03 +0100")
Message-ID: <xmqqim8vm41g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98A49C6C-43B6-11EB-8571-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Sat, Dec 19, 2020 at 6:36 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> * hn/reftable (2020-12-09) 15 commits
>>  . Add "test-tool dump-reftable" command.
>>  . git-prompt: prepare for reftable refs backend
>>  . Reftable support for git-core
>>  . reftable: rest of library
>>  . reftable: reftable file level tests
>>  . reftable: read reftable files
>>  . reftable: write reftable files
>>  . reftable: a generic binary tree implementation
>>  . reftable: reading/writing blocks
>>  . reftable: (de)serialization for the polymorphic record type.
>>  . reftable: add blocksource, an abstraction for random access reads
>>  . reftable: utility functions
>>  . reftable: add error related functionality
>>  . reftable: add LICENSE
>>  . init-db: set the_repository->hash_algo early on
>>
>>  The "reftable" backend for the refs API.
>>
>>  Ejected for now, as it has been breaking the tip of 'seen' for too
>>  long.
>
>
> Can you provide more information here? The PR at
> https://github.com/git/git/pull/847 passes all tests (except for the
> VSBuild, with errors that seem unrelated.)

Sorry, but it has been a long time that I have no more detail than
the above handy.  Older CI history might know more, but I have no
time to dig that right now (and I'd be just as efficient as you
would for doing such things).

I can try including it in one of the today's pushout of 'seen' and
see what breaks, which would be the easiest ;-)

Thanks for pinging.
