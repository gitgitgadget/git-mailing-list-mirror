Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A71FC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F215601FE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhDTTel (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:34:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61095 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhDTTel (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 15:34:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFE4DB8B73;
        Tue, 20 Apr 2021 15:34:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XqKha+K/e78rgJ37ZstS/jiuY/g=; b=dYeFip
        nagJw/mawoQFO5EAcE0p7oixQphlyoA8tGphDKDSutFa++msGP+GZOoKewsnyWY3
        xOmzVzw80gAzcK+n14oppL3Wb7q4ugJ7R1RDstYXKJizSGX+FsfYbS+SJksL9iuV
        +MNxVGIjhKhTyd8UdgdId8DFnh5F+eJ3NVRa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YEqsXRE228iFFa5BsCS4wgX+Y61LUOUp
        RkGl+taGuHtVHiJBHwtZsdBImaun5gvs8Bhc4b+4Ns6lyIgHYiCq0dTSZCRW0UOf
        8KNxTRhCTJSOOjIL6CoLtEVCSPl+5H4Nn/UCTgUQvrfmYBfUJZS1RVwTMlZ0X84Q
        WMmuWARuLr4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7722B8B71;
        Tue, 20 Apr 2021 15:34:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27B98B8B70;
        Tue, 20 Apr 2021 15:34:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 02/28] refs: document reflog_expire_fn's flag argument
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
        <554bb1ac3aed066eb578a305b7fe76f1660f6153.1618832277.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 12:34:07 -0700
In-Reply-To: <554bb1ac3aed066eb578a305b7fe76f1660f6153.1618832277.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 19 Apr 2021
        11:37:30 +0000")
Message-ID: <xmqqy2dc698w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FE2DFDA-A20F-11EB-A657-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs/refs-internal.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 546a6b965dcc..a31c1f465beb 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -592,6 +592,10 @@ typedef int reflog_exists_fn(struct ref_store *ref_store, const char *refname);
>  typedef int create_reflog_fn(struct ref_store *ref_store, const char *refname,
>  			     int force_create, struct strbuf *err);
>  typedef int delete_reflog_fn(struct ref_store *ref_store, const char *refname);
> +
> +/*
> + * `flags` accepts a bitmask of `expire_reflog_flags`.
> + */

OK.  It would have been better to say what expire_reflog_flags is
(i.e. `enum expire_reflog_flags`), though.

>  typedef int reflog_expire_fn(struct ref_store *ref_store,
>  			     const char *refname, const struct object_id *oid,
>  			     unsigned int flags,
