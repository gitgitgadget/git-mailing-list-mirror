Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFF3C47255
	for <git@archiver.kernel.org>; Tue, 12 May 2020 00:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFCBD20675
	for <git@archiver.kernel.org>; Tue, 12 May 2020 00:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LemUYFGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgELAmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 20:42:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59299 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgELAmB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 20:42:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D68984270E;
        Mon, 11 May 2020 20:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R9dT2hQUpZGJ99ezTj5LFfG/7JI=; b=LemUYF
        GhuCi69eghqubr6yt4yxQB+frF3rWfgub5EPebWKvCx6MFFODsqBTxpXIJR0izyk
        xrUs3LlUWZgXzZp63AwGxFKbHcqFi7RrqC11k9QvPshRivHAUrHxhz+FeSl1Ds9G
        t3ApPFqj/o249lsTT+VA29tRFDMXhArtmDkC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QDEBpBPvv4wEcECp38CvzY+67RfTqtub
        ru1wJ+y3Fu2y4k1l+8AoQVJQXwJupwADshTJdkOPCGwG8ZdottvGq2qAKdcx86ki
        4f9VUP2Qfcjw3lNgpASq5pE4tyLpoD7RvlUnh+UYpue/xVnnccVaWOeV4wd3WAP1
        vMo8EHI+Lvk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD7504270D;
        Mon, 11 May 2020 20:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 565A142700;
        Mon, 11 May 2020 20:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v13 00/13] Reftable support git-core
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 17:41:56 -0700
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 11 May 2020 19:46:15
        +0000")
Message-ID: <xmqq8shyq90r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6247D738-93E9-11EA-8135-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Han-Wen Nienhuys (11):
>   refs.h: clarify reflog iteration order
>   t: use update-ref and show-ref to reading/writing refs
>   refs: document how ref_iterator_advance_fn should handle symrefs
>   reftable: clarify how empty tables should be written
>   reftable: define version 2 of the spec to accomodate SHA256
>   Write pseudorefs through ref backends.
>   Iterate over the "refs/" namespace in for_each_[raw]ref
>   Add .gitattributes for the reftable/ directory
>   Add reftable library
>   Reftable support for git-core
>   Add some reftable testing infrastructure
>
> Johannes Schindelin (1):
>   vcxproj: adjust for the reftable changes
>
> Jonathan Nieder (1):
>   reftable: file format documentation

I often wish we had something better than shortlog when writing
a cover letter for a multi-author series like this.

Anyway.

As I already said earlier today [*1*], I think some parts of the
series can be reviewed before the "dense code" part, so let's draw
the line between patch 8 and 9 (or patch 7 and 8) and try to see if
we can get the parts before the line reviewed adequately and merge
them to at lesat 'next' during this cycle, which will close in 3
weeks.

  1/13 refs.h: clarify reflog iteration order
  2/13 t: use update-ref and show-ref to reading/writing refs
  3/13 refs: document how ref_iterator_advance_fn should handle symrefs
  4/13 reftable: file format documentation
  5/13 reftable: clarify how empty tables should be written
  6/13 reftable: define version 2 of the spec to accomodate SHA256
  7/13 Write pseudorefs through ref backends.
  8/13 Iterate over the "refs/" namespace in for_each_[raw]ref
  9/13 Add .gitattributes for the reftable/ directory
 10/13 Add reftable library
 11/13 Reftable support for git-core
 12/13 vcxproj: adjust for the reftable changes
 13/13 Add some reftable testing infrastructure

Thanks.

(ps) I took the Cc: list from a message by JNeider earlier today.



[Reference]

*1* https://lore.kernel.org/git/xmqqwo5isf09.fsf@gitster.c.googlers.com/
