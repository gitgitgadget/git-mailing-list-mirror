Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3EEC4725C
	for <git@archiver.kernel.org>; Wed,  6 May 2020 04:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D953020736
	for <git@archiver.kernel.org>; Wed,  6 May 2020 04:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LrKtb9/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgEFE3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 00:29:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50836 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgEFE3X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 00:29:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68394C0A84;
        Wed,  6 May 2020 00:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dQF1cQQzsOl0
        jhKh5FfvqFtVTZw=; b=LrKtb9/GM4pAY5A7uy8gcVW56rQEYOCBMjM5hcRBAS5G
        bEzlozrqzMW4XnDkdzF+hYmgzxdKm/uxFkioMLeJY1OKry3Dlv66u9OIRdffnSpM
        YLOTgWeiPv//MXmVNXsVW2ZHyZ83AeDPDGOXkFRFuDC6caEBaTCZ7VbeaF8OgnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lGYdj1
        HI28HPxonPKcvfFBMVMsct/+mCg1mNn1eXOVIfWmk/871sKkd9JugDs69Ps3ZIzD
        g7v7hbswekmXmn9GmC0A0Edxi/6PMKw6i/nC1WcGyFMez5LaqCyLOXxVi0rCpCnk
        z2Hvlh0UBN61GwZ9U5C9+vJxIg3imfYjMZeVY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61077C0A82;
        Wed,  6 May 2020 00:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A42EFC0A80;
        Wed,  6 May 2020 00:29:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v11 00/12] Reftable support git-core
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
Date:   Tue, 05 May 2020 21:29:17 -0700
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 04 May 2020 19:03:36
        +0000")
Message-ID: <xmqqimh98z4y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 26A85180-8F52-11EA-A0CF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This adds the reftable library, and hooks it up as a ref backend.

I queued this to 'pu', and we are seeing

    https://github.com/git/git/runs/648285159

The ci/run-static-analysis.sh job's failure report ends like so:

    HDR reftable/record.h
    HDR reftable/refname.h
    HDR reftable/reftable.h
    HDR reftable/slice.h
    HDR reftable/stack.h
    HDR reftable/system.h
    HDR reftable/tree.h
    HDR reftable/writer.h
    HDR remote.h
In file included from reftable/refname.hcc:2:0:
./reftable/refname.h:12:24: error: field =E2=80=98tab=E2=80=99 has incomp=
lete type
  struct reftable_table tab;
                        ^~~
./reftable/refname.h:32:13: error: =E2=80=98struct reftable_ref_record=E2=
=80=99 declared inside parameter list will not be visible outside of this=
 definition or declaration [-Werror]
      struct reftable_ref_record *recs, size_t sz);
             ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [reftable/refname.hco] Error 1
Makefile:2842: recipe for target 'reftable/refname.hco' failed
make: *** Waiting for unfinished jobs....

Thanks.
