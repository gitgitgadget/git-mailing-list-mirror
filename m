Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA5C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 13:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACBB20738
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 13:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmdGLi1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHYNrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgHYNrT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 09:47:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C963C061756
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 06:47:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so646455ejp.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9oKtXrJPKzggZEHXd38u78LH+MMg+CeRotKEYnghq9Q=;
        b=CmdGLi1taTOXcA5gUWHHgGtii8texHr4Lz4gBQ7TT1+/M9NKnSpiXWJsR/RHkVQ0K0
         aNEpSO8pY2NP2bJcU4h8xCF2eVBNQeMXRJl639jp2tUMFzMSFnvKq14ny46hLQKwGpdB
         tIsU7CJpiNyPZKHEGuaDimwBtlpgT3pyumTWoi2lyrNkb63ml+FbCS5BJZfsWqnsFNPT
         fGXB6y/rQ3/cnySDUvEeKdN698PUGQ6zHy/QjZhJM0gq45tmMITnrjw1eELu/dVcP2wj
         2/lx5bMBoIWPt5GF1muHOzJQ3Kj2IW6/mTIkamjOlw6OGSg95DRWbGnKKtfpfFyIV7FN
         vaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9oKtXrJPKzggZEHXd38u78LH+MMg+CeRotKEYnghq9Q=;
        b=QQlNMKg2SG7paUtahuEuLSdCnJvNCNN7jGbclEGhcz/vNba3mQbEF4MNFrfWMWEqdH
         xKzUgHW8xQf1nQnLRVf83lnmvzylRN2/s0GnQq4YGFdYHQSI1J+BuStjr2xrju3zzXmK
         H77HjhKpFoctRlTUd00V6KzdEAT+CWobeHmq2IktI0uCkakK3I3CXkjOLvs0hJYvWpna
         KSkisF5K1ljpa3vtdoK4mQs4hB+GGmHX+JlO66aK7BJ+a4NvwckwBle33f6EV0kGOPrW
         vXjb4fz9prbHq6K1h/arwq18ONTTp/1sE/CC1y0gf+OQa+dJZZ1YiGwWIQliWJIpU0M1
         l8Iw==
X-Gm-Message-State: AOAM531LbzSdJba4lK33iGaKQnMfBLL5tbIPE9laAUO9KMB3uEDAwLA7
        6kRYUgAxTqSSd+qavcxPub4=
X-Google-Smtp-Source: ABdhPJzPMYjVC6OfkrkttN5C8sVzLEQjzY8naoloq22Ux8qBq96+rmK8nSj6yRfwS1NvMqq76mIvsw==
X-Received: by 2002:a17:906:7752:: with SMTP id o18mr10335228ejn.150.1598363237893;
        Tue, 25 Aug 2020 06:47:17 -0700 (PDT)
Received: from szeder.dev (84-236-109-47.pool.digikabel.hu. [84.236.109.47])
        by smtp.gmail.com with ESMTPSA id a26sm13575510eju.83.2020.08.25.06.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 06:47:17 -0700 (PDT)
Date:   Tue, 25 Aug 2020 15:47:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed versions
Message-ID: <20200825134714.GC25052@szeder.dev>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
 <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
 <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 24, 2020 at 03:38:00PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Originally, all of Git's subcommands were implemented in their own
> executable/script, using the naming scheme `git-<command-name>`. When
> more and more functionality was turned into built-in commands (i.e. the
> `git` executable could run them without spawning a separate process),
> for backwards-compatibility, we hard-link the `git` executable to
> `git-<built-in>` for every built-in.
> 
> This backwards-compatibility was needed to support scripts that called
> the dashed form, even if we deprecated that a _long_ time ago.
> 
> For that reason, we just introduced a Makefile knob to skip linking
> them. TO make sure that this keeps working, teach the CI
> (and PR) builds to skip generating those hard-links.

I'm afraid I don't understand this patch or the previous one (or
both?).  So this new Makefile knob stops hard-linking the dashed
builtins _during 'make install'_, but it doesn't affect how Git is
built by the default target.  And our CI jobs only build Git by the
default target, but don't run 'make install', so setting
SKIP_DASHED_BUILT_INS wouldn't have any affect anyway.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/run-build-and-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 6c27b886b8..1df9402c3b 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>  *) ln -s "$cache_dir/.prove" t/.prove;;
>  esac
>  
> -make
> +make SKIP_DASHED_BUILT_INS=YesPlease

Note that the CI jobs executed in containers (Linux32 and linux-musl)
don't use this 'ci/run-build-and-tests.sh' script, so they won't set
SKIP_DASHED_BUILT_INS.  I suppose that's unintentional, because it
wasn't mentioned in the commit message.

>  case "$jobname" in
>  linux-gcc)
>  	make test
> -- 
> gitgitgadget
