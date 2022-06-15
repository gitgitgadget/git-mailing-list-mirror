Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FD3C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 00:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiFOAKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiFOAKl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 20:10:41 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2C72F02F
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:10:33 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h190-20020a636cc7000000b003fd5d5452cfso5701512pgc.8
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=dmT57xsPv3x7+O3bzYjvJKLFWcohYYLQ6vC5S9jocK4=;
        b=kLGNmZNDfqusCA2rMl1EAzszJkWGlA73CBeyOScUp2uKWMJbnAtZ4cdtHN9WM1GR3B
         /5HLBKrTX7QtIo6jNOikh8TYs0wgIZLwATzkW+Q6mNZBiBuGj61yymC/tcBYlUkLHoHJ
         Q+lhtYK3NR5JPVaghdLJHDWJQbzTFr2R35DGRGd/E4DR6ZcuY6x0zHX0Crd2aspdIkhO
         zdnm0u6jIQfFELwS5RzfTSdCErrU4HaV5tSY8OV9pIP0e7wAJmEBzCOAOVojoge8S0KB
         O493suRE63xWg4ArCsx/9EVWRAcD6XkjR94XGqPKJnI/nGdYGRuI4xduRz0FxHIq1ijV
         RKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=dmT57xsPv3x7+O3bzYjvJKLFWcohYYLQ6vC5S9jocK4=;
        b=csQQmurPCU/YYZarKgQ/02lPyXbRQxKfR3kesq3V76yDa+N2FmAoyKSCntiy9NTnNd
         nY14jP+IM1DTewdkYkNssa2KQhaHTVks3edLMJelBnOo0aajxqVQ61/B6us4r456VXTv
         EnuXaQ4aE2ClgWyg7ThnDRAAbSUBZeYaWYja3MC6iO8cbfclc2dnw6LrolDvUaDzAXUc
         f8FIwUP74ccXaAFhUzaTC2UnsGbPyIabJMmCIMxNWcKu+aK30ZO0Q+UAV91Ww4aE/sOi
         +K75aRHd5vmhNwEZjhNiZzgPN5NTlFCjembVIlqfdcO+d42oA01Mpn+SDgSH9s5C/dQO
         uKDg==
X-Gm-Message-State: AJIora++zGw08B4oLtyKYyJEx6fNmRlbY1YsOFm+ziglAKLTkq7G/G6I
        RipTNMhpEho/xfyUsBswFCr5ZZZVwlcNNA==
X-Google-Smtp-Source: AGRyM1ti+o4vQ51YLn3QoYiYs3PAKCgG6nT+Db6G5qmtq2PMfWBlvqk66i7c08/1EiR4OwXYiLmWW929jZ8qhA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7604:b0:168:cca6:1b38 with SMTP
 id k4-20020a170902760400b00168cca61b38mr7065685pll.174.1655251833115; Tue, 14
 Jun 2022 17:10:33 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:10:31 -0700
In-Reply-To: <patch-v2-04.12-fd328329b68-20220613T220150Z-avarab@gmail.com>
Message-Id: <kl6lo7yu6b2g.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <patch-v2-04.12-fd328329b68-20220613T220150Z-avarab@gmail.com>
Subject: Re: [PATCH v2 04/12] git-submodule.sh: remove unused top-level
 "--branch" argument
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In 5c08dbbdf1a (git-submodule: fix subcommand parser, 2008-01-15) the
> "--branch" option was supported as an option to "git submodule"
> itself, i.e. "git submodule --branch" as a side-effect of its
> implementation.
>
> Then in b57e8119e6e (submodule: teach set-branch subcommand,
> 2019-02-08) when the "set-branch" subcommand was added the assertion
> that we shouldn't have "--branch" anywhere except as an argument to
> "add" and "set-branch" was copy/pasted from the adjacent check for
> "--cache" added (or rather modified) in 496eeeb19b9 (git-submodule.sh:
> avoid "test <cond> -a/-o <cond>", 2014-06-10).
>
> But there's been a logic error in that check, which at a glance looked
> like it should be supporting:
>
>     git submodule --branch <branch> (add | set-branch) [<options>]
>
> But due to "||" in the condition (as opposed to "&&" for "--cache") if
> we have "--branch" here already we'll emit usage, even for "add" and
> "set-branch".
>
> So in addition to never having documented this form it hasn't worked
> since b57e8119e6e was released with v2.22.0 it's safe to remove this
> code. I.e. we don't want to support the form noted above, but only:
>
>     git submodule (add | set-branch) --branch <branch> [<options>]

Hm, that's suprising. But I guess the good news is that if it's been
broken for so long, nobody probably needs this.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  git-submodule.sh | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index b99a00d9f84..20fc1b620fa 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -574,14 +574,6 @@ do
>  	-q|--quiet)
>  		GIT_QUIET=3D1
>  		;;
> -	-b|--branch)
> -		case "$2" in
> -		'')
> -			usage
> -			;;
> -		esac
> -		branch=3D"$2"; shift
> -		;;
>  	--cached)
>  		cached=3D1
>  		;;
> @@ -609,12 +601,6 @@ then
>      fi
>  fi
> =20
> -# "-b branch" is accepted only by "add" and "set-branch"
> -if test -n "$branch" && (test "$command" !=3D add || test "$command" !=
=3D set-branch)
> -then
> -	usage
> -fi
> -
>  # "--cached" is accepted only by "status" and "summary"
>  if test -n "$cached" && test "$command" !=3D status && test "$command" !=
=3D summary
>  then

Looks good.
