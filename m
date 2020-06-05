Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AE8C433E1
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4DF206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v++ddj5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFETV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:21:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52594 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgFETV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 15:21:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3345694FD;
        Fri,  5 Jun 2020 15:21:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MCm9jkmM+SSMECAvehFn4bh2MxA=; b=v++ddj
        5kjdQ5yabYg0RvqjdNdhFylJNB58NOQvjn3Kp32JocQDT5UGyZNY2ZLVaDV9QFld
        g0hDdIVzK2xQvR9hqEBxumqKdgQ4nlc+AQWK3lbMSXakNvcCm2GlWDUZJrQlL5dT
        lpXp/fl9LDDlBG2okyf3XegttJ23hedDuocE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aXOec1TW7WZ3Eq+UgTa4sXkaNnWI3xAO
        n56AV18IbP2oHct0w90bMMUHxxRvut2rtSRay/Z30IxjQbAVyGuT29Qd324zSeJC
        GPLpguDnps0gEVZOFLqP6xUDL9DhYG/DuqiilsKZcjn1hUS51+dX3pCqS4pU9adx
        0Db/E5hxPXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC1E1694FC;
        Fri,  5 Jun 2020 15:21:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73F1F694FB;
        Fri,  5 Jun 2020 15:21:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 3/4] sparse-checkout: upgrade repository to version 1 when enabling extension
References: <20200528025359.20931-2-delphij@google.com>
        <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
        <20200528171924.GC58643@google.com>
        <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
        <20200528191739.GA114915@google.com>
        <20200529000432.146618-1-delphij@google.com>
        <20200529010119.GE114915@google.com>
        <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
        <20200605091004.208668-1-delphij@google.com>
        <20200605091004.208668-4-delphij@google.com>
Date:   Fri, 05 Jun 2020 12:21:21 -0700
In-Reply-To: <20200605091004.208668-4-delphij@google.com> (Xin Li's message of
        "Fri, 5 Jun 2020 02:10:03 -0700")
Message-ID: <xmqqpnadmi8e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDB8D51E-A761-11EA-8C3B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

> The 'extensions' configuration variable gets special meaning in the new
> repository version, so when enabling the extension we should upgrade the
> repository to version 1.
>
> Signed-off-by: Xin Li <delphij@google.com>
> ---
>  builtin/sparse-checkout.c  | 2 ++
>  t/t2404-worktree-config.sh | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

The other place that "extensions.*" is referred to is in
builtin/init-db.c::initialize_repository_version() and it already
makes sure that extensions.objectformat is set only in a repository
whose verseion is GIT_REPO_VERSION_READ (which is 1---by the way I
suspect we want a better name than _READ for the symbol---it wants
to use the highest version supported by this binary), so with this
patch we covered everything, hopefully.

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 95d0882417..95669815d4 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -249,6 +249,8 @@ static int set_config(enum sparse_checkout_mode mode)
>  {
>  	const char *config_path;
>  
> +	if (upgrade_repository_format(1) < 0)
> +		die(_("unable to upgrade repository format to enable worktreeConfig"));
>  	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
>  		error(_("failed to set extensions.worktreeConfig setting"));
>  		return 1;
> diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
> index 286121d8de..9536d10919 100755
> --- a/t/t2404-worktree-config.sh
> +++ b/t/t2404-worktree-config.sh
> @@ -23,8 +23,10 @@ test_expect_success 'config --worktree without extension' '
>  '
>  
>  test_expect_success 'enable worktreeConfig extension' '
> +	git config core.repositoryformatversion 1 &&
>  	git config extensions.worktreeConfig true &&
> -	test_cmp_config true extensions.worktreeConfig
> +	test_cmp_config true extensions.worktreeConfig &&
> +	test_cmp_config 1 core.repositoryformatversion
>  '
>  
>  test_expect_success 'config is shared as before' '
