Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A119C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50F0206B5
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aGZII37z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgHRUjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:39:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54692 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRUjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 16:39:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E7C8EA5D0;
        Tue, 18 Aug 2020 16:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tL7G8TPp/tq3KHtTWhpX8oMBJjY=; b=aGZII3
        7z9a2d6dPOvBrPvRz9lvjBHJ7lTERsv8FlKIQ5KV9keQkd6S3ox7QBW/yPAgaoZW
        2a9YgyVBvf/yZFEjJdTHZWMzpZKHrCnuMtFVFUPUNdQp3JEVneGrWvPtjHKkjMw4
        NWD5Of6jmHk/sr6GUy3ONpAWOJQ/plFgOQAjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bj1wGkWg90jo7esItcdqWwFVHxROV661
        ayb9uVw43kFYZt9g9uLQyA2fCOL+lrQxPe8Djj0rkCy5RLg8wh+9eewD0hHAyOxT
        yVTmAlgX6jD43wqbJ8MU2/tan6NW4VbXZ7VzJIf6kQXUnAJNGQUZPi2qeNWxF6eo
        IT9TzPRu5aA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8039EA5CF;
        Tue, 18 Aug 2020 16:39:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 171EBEA5C8;
        Tue, 18 Aug 2020 16:39:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/3] Make refs_ref_exists public
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
        <5e29fa74dc70b5e36ace27ed6d83060cf0925681.1597753075.git.gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 13:39:26 -0700
In-Reply-To: <5e29fa74dc70b5e36ace27ed6d83060cf0925681.1597753075.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Tue, 18 Aug 2020
        12:17:53 +0000")
Message-ID: <xmqqwo1vwuwx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9234DA4-E192-11EA-8866-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 1/3] Make refs_ref_exists public

Documentation/SubmittingPatches[[describe-changes]]

Applies to all three patches and probably other recent topics from
you.

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c | 2 +-
>  refs.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index cf91711968..d46080f4b6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -313,7 +313,7 @@ int read_ref(const char *refname, struct object_id *oid)
>  	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
>  }
>  
> -static int refs_ref_exists(struct ref_store *refs, const char *refname)
> +int refs_ref_exists(struct ref_store *refs, const char *refname)
>  {
>  	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
>  }
> diff --git a/refs.h b/refs.h
> index 29e28124cd..04bd25019f 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -105,6 +105,8 @@ int refs_verify_refname_available(struct ref_store *refs,
>  				  const struct string_list *skip,
>  				  struct strbuf *err);
>  
> +int refs_ref_exists(struct ref_store *refs, const char *refname);
> +
>  int ref_exists(const char *refname);
>  
>  int should_autocreate_reflog(const char *refname);
