Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F5BC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0EF2166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yGDmSC49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBDV3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:29:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50929 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBDV3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:29:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EEA72A68C9;
        Tue,  4 Feb 2020 16:29:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sv4HYoYTud+MrdgFlRnVW/sccQE=; b=yGDmSC
        4996Yi9+jsu6vMz3TE01TZGigiqqW4DvymeTaOT0NVdFgOprkn9unaLoSbuGoW8A
        CT6oUMidpWaBVcias3sKdldnB6uVkCcaMIL3Sy4SYBRlZRBTkxv06R/MtVh02JaN
        obym31jo5G4a+FKBhwF1JWoMy8OYlz1pCnINM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mIJ0ibgEYR3UKVy1gCKFbO27SC/dBj9L
        SquMIf8tXP5UceE73lTcRL7ukz7IdU030QLoEuVhq/8uPlhFRP41e0qcQxyZl9nc
        bcUt0J5DgT7LpGTgSCVj+Ama4gSZF7u3AhvD/cSqd5yEDkNtJGsVA3LMcqE9mm9Y
        ESIAag9gnAU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5CBFA68C5;
        Tue,  4 Feb 2020 16:29:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1BD06A68C4;
        Tue,  4 Feb 2020 16:29:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 3/6] create .git/refs in files-backend.c
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
        <5b7060cb2fc25fc1c71b7c70864ebf758b59aa90.1580848060.git.gitgitgadget@gmail.com>
Date:   Tue, 04 Feb 2020 13:29:11 -0800
In-Reply-To: <5b7060cb2fc25fc1c71b7c70864ebf758b59aa90.1580848060.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Tue, 04 Feb 2020
        20:27:37 +0000")
Message-ID: <xmqqeeva6nyw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63FAC4AA-4795-11EA-AFB2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This prepares for supporting the reftable format, which will want
> create its own file system layout in .git
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  builtin/init-db.c    | 2 --
>  refs/files-backend.c | 5 +++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
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
> index 0ea66a28b6..0c53b246e8 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3158,6 +3158,11 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
>  		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
>  	struct strbuf sb = STRBUF_INIT;
>  
> +	files_ref_path(refs, &sb, "refs");

Have you run "git diff --check" before committing?

> +	safe_create_dir(sb.buf, 1);
> +        /* adjust permissions even if directory already exists. */

whitespace error here, but this comment is really appreciated.  It
wasn't immediately clear why we do this again in the original.

> +	adjust_shared_perm(sb.buf);
> +
>  	/*
>  	 * Create .git/refs/{heads,tags}
>  	 */
