Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39DCC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854C6613C1
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGIR0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 13:26:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63928 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIR0r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 13:26:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE450D337F;
        Fri,  9 Jul 2021 13:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sF5OM3BVTETv4JytsaSrDtDH8KWAFIoZIcu0jH
        i8bKo=; b=iCYR6rCjGjcdpjFW10TfWsVbG53DmPuCdjTA4+CCa1YlguBdRva8Ni
        wEcQc3ARTTDWpc7ppiH/S94KoeoeyDgy0gBXn2P3lX88/5fp3+l22PgPgLXoY6yt
        wf03+R8wROQLhPeKQVG1QTF45ujrCmC1NezKz1OrWARmYDnSIs2hU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E745BD337D;
        Fri,  9 Jul 2021 13:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B81FD3379;
        Fri,  9 Jul 2021 13:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [filter-repo PATCH] filter-repo: help with local install
References: <e3d6c6d670b46d4f0dc133e83c6feede4d55c412.1625844149.git.git@grubix.eu>
Date:   Fri, 09 Jul 2021 10:24:01 -0700
In-Reply-To: <e3d6c6d670b46d4f0dc133e83c6feede4d55c412.1625844149.git.git@grubix.eu>
        (Michael J. Gruber's message of "Fri, 9 Jul 2021 17:25:30 +0200")
Message-ID: <xmqqk0lz764u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 745BB5E0-E0DA-11EB-A533-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> The Makefile suggests a local install and works almost as is, except for
> the python path. Make it work automatically for this typical use case,
> and give a corresponding hint in INSTALL.md.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  INSTALL.md | 5 +++--
>  Makefile   | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/INSTALL.md b/INSTALL.md
> index 00aabb7..d479681 100644
> --- a/INSTALL.md
> +++ b/INSTALL.md
> @@ -75,8 +75,9 @@ filter-repo only consists of a few files that need to be installed:
>      You can create this symlink to (or copy of) git-filter-repo named
>      git_filter-repo.py and place it in your python site packages; `python
>      -c "import site; print(site.getsitepackages())"` may help you find the
> -    appropriate location for your system.  Alternatively, you can place
> -    this file anywhere within $PYTHONPATH.
> +    appropriate location for your system, `python -c "import site;
> +    print(site.getusersitepackages())"` for a local install. Alternatively,
> +    you can place this file anywhere within $PYTHONPATH.
>  
>    * git-filter-repo.1
>  
> diff --git a/Makefile b/Makefile
> index 31f5e3a..c97d1f6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -4,7 +4,7 @@ bindir = $(prefix)/libexec/git-core
>  localedir = $(prefix)/share/locale
>  mandir = $(prefix)/share/man
>  htmldir = $(prefix)/share/doc/git-doc
> -pythondir = $(prefix)/lib64/python3.6/site-packages
> +pythondir = $(shell python -c "import site; print(site.getusersitepackages())")

There may be no "python" on $PATH, yet the user may have told the
make via PYTHON_PATH that /usr/bin/python3 is to be used.

