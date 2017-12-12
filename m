Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2801F404
	for <e@80x24.org>; Tue, 12 Dec 2017 00:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbdLLASG (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 19:18:06 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:46490 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdLLASF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 19:18:05 -0500
Received: by mail-it0-f68.google.com with SMTP id t1so20275992ite.5
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 16:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0/WThyxSAM2qRSXOaTz/T7yVPN24w53kAASy06XaxvM=;
        b=G5hp87tK3jLnMAsK51GHT1U021XMKqO5/wgEmkiLIsPsVuGt5/Q77hKyhEp1rOy8zz
         Z+tsEM5+mqY2QS0oKEFnXlIDSxO2o0aTOIPVc3IpNTYFhI8V1UpsJ180xe4ezBGFoAC9
         N1VWLkXqLduf31R6QEGb8KFXvGXZ2gU0fxADvXoDlbIMXVldys5hrtE00ihDBp4pqtIs
         1XT7E7UZaBLijO6XQgbspilkAcywmtrRCK/F1dfpgF8d58/22C70IADOcM++jq6852E0
         7OivBwiMMhCKFrSLagiIDdte6V9uvXDp5pDnij2l+B6XGwlKFQCClCkaEAh5AOvMRfMS
         tk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0/WThyxSAM2qRSXOaTz/T7yVPN24w53kAASy06XaxvM=;
        b=KzEERI1gPs+HWYzchLKfVKR5H8fNZM0R1bCg8zsTeEZj0TYPOft3OuR6H3D6s5Uo1t
         5FnvLOr0LDyMUcgjh7CuWJhk8sjJiiFHvFMBzjo53XsNQ4KwLJoOGWbDwFDPXZbxxUHQ
         OlX0oZdwD/dnmpfZK6sS8lGMCkXG73yYnFkw/f4eawlt1b1MZgmO4NKpCBP5pdojtV0I
         eNA8JJMtuPofIJhwM+ZGRDtWmQE46T8EwFh6+se6h1/4Qh55f9xEKLAg1wQ4f2FrnpE5
         2ra/2Sadtyb0sV5AC6DyTbYZaUQoWrAMedyC6YEQQdSb5LzjuaUFNYuVDMYCogx75goY
         CBcQ==
X-Gm-Message-State: AKGB3mLyf5lEsyNrt5qRdtxt/8oacqyauU+uGokF/WwOgIckgigGIbd4
        IdRe29kffPMIN5WtCTohGsOOFTBDbno=
X-Google-Smtp-Source: ACJfBote0Qn4lE/kDZnD6ZbEgJLdtKI5jBNze3RN/M6DZHvJLopN/UKBQPh5qI3F4gEWQ16dGYxb7Q==
X-Received: by 10.107.183.195 with SMTP id h186mr3138245iof.159.1513037884975;
        Mon, 11 Dec 2017 16:18:04 -0800 (PST)
Received: from google.com ([2620:0:100e:422:bdc4:e5a2:2ef4:d600])
        by smtp.gmail.com with ESMTPSA id q6sm4661063ita.38.2017.12.11.16.18.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 16:18:04 -0800 (PST)
Date:   Mon, 11 Dec 2017 16:18:02 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] clone: support 'clone --shared' from a worktree
Message-ID: <20171212001802.GC177995@google.com>
References: <20171211231612.29275-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171211231612.29275-1-sunshine@sunshineco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11, Eric Sunshine wrote:
> When worktree functionality was originally implemented, the possibility
> of 'clone --local' from within a worktree was overlooked, with the
> result that the location of the "objects" directory of the source
> repository was computed incorrectly, thus the objects could not be
> copied or hard-linked by the clone. This shortcoming was addressed by
> 744e469755 (clone: allow --local from a linked checkout, 2015-09-28).
> 
> However, the related case of 'clone --shared' (despite being handled
> only a few lines away from the 'clone --local' case) was not fixed by
> 744e469755, with a similar result of the "objects" directory location
> being incorrectly computed for insertion into the 'alternates' file.
> Fix this.
> 
> Reported-by: Marc-André Lureau <marcandre.lureau@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  builtin/clone.c         | 3 ++-
>  t/t2025-worktree-add.sh | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b22845738a..6ad0ab3fa4 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -452,7 +452,8 @@ static void clone_local(const char *src_repo, const char *dest_repo)
>  {
>  	if (option_shared) {
>  		struct strbuf alt = STRBUF_INIT;
> -		strbuf_addf(&alt, "%s/objects", src_repo);
> +		get_common_dir(&alt, src_repo);
> +		strbuf_addstr(&alt, "/objects");

If you wanted to do this in one function call you could either use
'strbuf_git_common_path()' or either 'strbuf_git_path()' or
'strbuf_repo_git_path()' which will do the proper path adjustments when
working on a path which should be shared between worktrees (i.e. part of
the common git dir).

>  		add_to_alternates_file(alt.buf);
>  		strbuf_release(&alt);
>  	} else {
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index b5c47ac602..7395973318 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -245,6 +245,12 @@ test_expect_success 'local clone from linked checkout' '
>  	( cd here-clone && git fsck )
>  '
>  
> +test_expect_success 'local clone --shared from linked checkout' '
> +	git -C bare worktree add --detach ../baretree &&
> +	git clone --local --shared baretree bare-clone &&
> +	grep /bare/ bare-clone/.git/objects/info/alternates
> +'
> +
>  test_expect_success '"add" worktree with --no-checkout' '
>  	git worktree add --no-checkout -b swamp swamp &&
>  	! test -e swamp/init.t &&
> -- 
> 2.15.1.502.gccaef8de57
> 

-- 
Brandon Williams
