Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F87C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F63205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I3S0XUpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390785AbgEMT5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:57:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63851 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390350AbgEMT5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 15:57:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9874F54B46;
        Wed, 13 May 2020 15:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E+mDQkCjD+RvIi6/5AE4dpf9HWc=; b=I3S0XU
        pkORoaAUt3XBTyGT+/2XSkgRaxPXXn6aGJ5mv/ocmrggQBARGOt0GnN5KgEBnvz4
        Ki00+h4e7ufJ10DXJJKfeThVZmMdKAFkwJwconOcQS8+Q7KqsWrtawKsY667Dgom
        zmBDChiPNXQHgXG2h0NbFXSxFdLDophSg0WaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xJONp0DFLjfLNyBXyd1bjxSB/vGokZ7O
        O8F3CFQJa4x68KZM61eLCDtt1FPdgKW+qUQ/O/K9B+k9Dslj+AOb5FLYw7RHO9Tf
        BNkKpYC4K/IzGH1xbCPTsYDiSqzIuAe82TaoGzXU0fcnO0PKJj9pN23Ol9xmd23L
        jt39Vg3SiUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FDE354B44;
        Wed, 13 May 2020 15:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC0D754B42;
        Wed, 13 May 2020 15:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v13 13/13] Add some reftable testing infrastructure
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <0e732d30b516855a7e91240a9055712b26905b2e.1589226388.git.gitgitgadget@gmail.com>
Date:   Wed, 13 May 2020 12:57:09 -0700
In-Reply-To: <0e732d30b516855a7e91240a9055712b26905b2e.1589226388.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 11 May 2020
        19:46:28 +0000")
Message-ID: <xmqq8shvtxpm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EED355C2-9553-11EA-82BD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index b7053b9e370..da5b4670c84 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -545,7 +545,7 @@ static const char *const init_db_usage[] = {
>  int cmd_init_db(int argc, const char **argv, const char *prefix)
>  {
>  	const char *git_dir;
> -	const char *ref_storage_format = DEFAULT_REF_STORAGE;
> +	const char *ref_storage_format = default_ref_storage();
>  	const char *real_git_dir = NULL;
>  	const char *work_tree;
>  	const char *template_dir = NULL;
> diff --git a/refs.c b/refs.c
> index e8751415a9e..70c11b05391 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1742,7 +1742,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
>  	r->refs_private = ref_store_init(r->gitdir,
>  					 r->ref_storage_format ?
>  						 r->ref_storage_format :
> -						 DEFAULT_REF_STORAGE,
> +						 default_ref_storage(),
>  					 REF_STORE_ALL_CAPS);
>  	return r->refs_private;
>  }

Would it make sense to let NULL stand for "we use the default,
whatever it is" so that anybody outside the implementation of the
refs API does not have to care what the default is, and make
ref_store_init() function the only thing that knows what it is?

