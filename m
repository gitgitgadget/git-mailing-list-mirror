Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E87EC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDC922527
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WJHI0o4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgA0W2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:28:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62218 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA0W2M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 17:28:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CE2A57C81;
        Mon, 27 Jan 2020 17:28:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HAwhL+9PsvOcUwq04j1c+LN7uOI=; b=WJHI0o
        4ywM0eFzGeA9epfVm1S86p3q3zoBigKQuEhewHzjVwzwUG7C9pObn0/DdqanPgaI
        PCO+l6y1ZER69Z6O5w0p7xdJeSR5bMsKPt7rFoMRiHxmVPuTnZtfpwG8oV9wlZRc
        qZp6yct4G+P165Uf6DrYfbch2cwab2WpLDaB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vJkwfobq5byH+nYGZSpt+bgUdWggqhNC
        mJ6S/askOYnRh7pFWLOOSCjqrpGmykidNlGAoG/Im9W9R99ggl/vgBnB6qvOkcDE
        PpwarOhqozi5KxiPmHuXz5dqa1gYnJ0VpFn1993dW0K/6Eo6+0C86d5z7dy07k/g
        XA9hz5wEuas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7476A57C80;
        Mon, 27 Jan 2020 17:28:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EC0557C7F;
        Mon, 27 Jan 2020 17:28:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 2/5] create .git/refs in files-backend.c
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <d7d642dcf6f3c661c51302d02c69e781e201cc6e.1580134944.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jan 2020 14:28:05 -0800
In-Reply-To: <d7d642dcf6f3c661c51302d02c69e781e201cc6e.1580134944.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 27 Jan 2020
        14:22:21 +0000")
Message-ID: <xmqqr1zka616.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A36B8AE-4154-11EA-B85C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
> Subject: Re: [PATCH v2 2/5] create .git/refs in files-backend.c
>
> This prepares for supporting the reftable format, which creates a file
> in that place.

The idea is sound, I think.  We want to let each backend to be
responsible for creating and maintaining what is at .git/refs on the
filesystem.

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>


> Change-Id: I2fc47c89f5ec605734007ceff90321c02474aa92

Do we need to keep this, which is pretty much private name for the
patch that is not valid for most of the people on the list?

> ---
>  builtin/init-db.c    | 2 --
>  refs/files-backend.c | 4 ++++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 944ec77fe1..45bdea0589 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -226,8 +226,6 @@ static int create_default_files(const char *template_path,
>  	 * We need to create a "refs" dir in any case so that older
>  	 * versions of git can tell that this is a repository.
>  	 */
> -	safe_create_dir(git_path("refs"), 1);
> -	adjust_shared_perm(git_path("refs"));
>  
>  	if (refs_init_db(&err))
>  		die("failed to set up refs db: %s", err.buf);
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0ea66a28b6..f49b6f2ab6 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3158,6 +3158,10 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
>  		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
>  	struct strbuf sb = STRBUF_INIT;
>  
> +	files_ref_path(refs, &sb, "refs");
> +	safe_create_dir(sb.buf, 1);
> + 	// XXX adjust_shared_perm ?

I am not sure what's there to wonder about with the question mark.

If this step is meant to be a preparation before we actually allow
a different backend to be used, shouldn't the updated and prepared
code behave identically in externally visible ways?

Thanks.
