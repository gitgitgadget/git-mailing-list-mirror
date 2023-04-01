Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E42C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 19:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjDATb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 15:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjDATb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 15:31:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7419C66F
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 12:31:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id br6so33091918lfb.11
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 12:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680377483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0i3EH7MKuorTtfYzU6ZWTrg0fK1EUbP6j1ASsrUQkQ=;
        b=LbdQuNB7itDbRobA1SGF0x4sQuCsdqw0xGjOstflSIdBS39d48InfYZeaJ5uGytetp
         Nyqnt8mF3xQCQvxe8Wzl1SzaM0Ld+QcT3skNpLcDT55B+z4t1jo0i3VWDchd+R4EoghL
         uC5bEJIZeM/2Xdpu6nw/pfCODwDX+PpPXld7x5cOLJtjAjNPBEAJRFIeTOCuQVt8wxHp
         bjIYQlEOSNgHiN78S87NwlOf4Xd5RJXDcK/voB8PBfBgwD8oS+1cg8SC9UshjW4VLUSW
         4KgiSF/LntUn06OrlJCWhWZ3lx17g55hkBYMa1/7XMrnOkuzS+lvumHmjWWuwstM3dTH
         IPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680377483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0i3EH7MKuorTtfYzU6ZWTrg0fK1EUbP6j1ASsrUQkQ=;
        b=svV2PKSqQ80+mA1xuxg075DmYRpwshb3VwmPUnE8yC+Hzd+zwle0KeQyyIvzZ/+hlm
         4aEHNiDbTL/GW6ZjC0J0/8jTvK2Vgu2WNuL+6XpLvRGvdP4mTcH4hnqP8Wt3TR14vFEl
         elElrkzl42QYMjLxpZZAuS2LIaDuE0VEJfgQQBhNasaKaw1LBuZJgoHeDRrme16GKQKv
         zr8L58C7j2BOr1wytiMrthfs33b1qx//m4jbsVjFonqBR5L2ln0D/q0s+xKVQ1Cd6Lyz
         7MZSz5gggaQTENOtAWIuV1CcbaeLc9+Ivx/8OzPhsgFVFLCdqsY21Hh970dOv5eIJ5bD
         6pzg==
X-Gm-Message-State: AAQBX9cojRceRfvtzcOb5MV391AL5iNezt2/JNY2kNNrbgHYiMlaljbw
        N4mSozzdLNxcT0ON8cAGiAkM8Grmdp1FND8KBuyyLeRdbGY=
X-Google-Smtp-Source: AKy350ZHVpO9lz+kLARyvOB/ckjiczmw5KQHvOdac41LZdmbx/+Ky63fIEh1rD/4WAhHGkPCzmL38tlLguq2wXlNNpA=
X-Received: by 2002:ac2:5396:0:b0:4e9:c627:195f with SMTP id
 g22-20020ac25396000000b004e9c627195fmr8913266lfh.7.1680377482662; Sat, 01 Apr
 2023 12:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <3e02eeff78b23711187de47a1a820f9bde683200.1678893298.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <3e02eeff78b23711187de47a1a820f9bde683200.1678893298.git.phillip.wood@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Apr 2023 12:31:09 -0700
Message-ID: <CABPp-BGwj-_JRWose89tg2HXQoOoriPqHzW6XC0s5qJDayPTmQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] rebase: remove a couple of redundant strategy tests
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2023 at 8:38=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The test removed in t3402 has been redundant ever since 80ff47957b
> (rebase: remember strategy and strategy options, 2011-02-06) which added
> a new test the first part of which (as noted in the commit message)
> duplicated the existing test. The test removed in t3418 has been
> redundant since the merge backend was removed in 68aa495b59 (rebase:
> implement --merge via the interactive machinery, 2018-12-11) as it now
> tests the same code paths as the preceding test.

I was really confused by this commit message at first.  Eventually, I
figured out you were talking about the changes in this commit, just in
past tense.  Could we change it to imperative tense?  E.g.

Remove a test in t3402 that has been redundant ever since 80ff47957b
(rebase: remember strategy and strategy options, 2011-02-06).  That commit =
added
a new test, the first part of which (as noted in the old commit message)
duplicated an existing test.

Also remove a test t3418 that has been redundant since the merge
backend was removed in 68aa495b59 (rebase: implement --merge
via the interactive machinery, 2018-12-11), since it now tests the
same code paths as the preceding test.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3402-rebase-merge.sh    | 21 ---------------------
>  t/t3418-rebase-continue.sh | 32 --------------------------------
>  2 files changed, 53 deletions(-)
>
> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
> index 7e46f4ca85..79b0640c00 100755
> --- a/t/t3402-rebase-merge.sh
> +++ b/t/t3402-rebase-merge.sh
> @@ -131,27 +131,6 @@ test_expect_success 'picking rebase' '
>         esac
>  '
>
> -test_expect_success 'rebase -s funny -Xopt' '
> -       test_when_finished "rm -fr test-bin funny.was.run" &&
> -       mkdir test-bin &&
> -       cat >test-bin/git-merge-funny <<-EOF &&
> -       #!$SHELL_PATH
> -       case "\$1" in --opt) ;; *) exit 2 ;; esac
> -       shift &&
> -       >funny.was.run &&
> -       exec git merge-recursive "\$@"
> -       EOF
> -       chmod +x test-bin/git-merge-funny &&
> -       git reset --hard &&
> -       git checkout -b test-funny main^ &&
> -       test_commit funny &&
> -       (
> -               PATH=3D./test-bin:$PATH &&
> -               git rebase -s funny -Xopt main
> -       ) &&
> -       test -f funny.was.run
> -'
> -
>  test_expect_success 'rebase --skip works with two conflicts in a row' '
>         git checkout second-side  &&
>         tr "[A-Z]" "[a-z]" <newfile >tmp &&
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 42c3954125..2d0789e554 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -97,38 +97,6 @@ test_expect_success 'rebase --continue remembers merge=
 strategy and options' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'rebase -i --continue handles merge strategy and opt=
ions' '
> -       rm -fr .git/rebase-* &&
> -       git reset --hard commit-new-file-F2-on-topic-branch &&
> -       test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32=
 &&
> -       test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
> -       mkdir test-bin &&
> -       cat >test-bin/git-merge-funny <<-EOF &&
> -       #!$SHELL_PATH
> -       echo "\$@" >>funny.args
> -       case "\$1" in --opt) ;; *) exit 2 ;; esac
> -       case "\$2" in --foo) ;; *) exit 2 ;; esac
> -       case "\$4" in --) ;; *) exit 2 ;; esac
> -       shift 2 &&
> -       >funny.was.run &&
> -       exec git merge-recursive "\$@"
> -       EOF
> -       chmod +x test-bin/git-merge-funny &&
> -       (
> -               PATH=3D./test-bin:$PATH &&
> -               test_must_fail git rebase -i -s funny -Xopt -Xfoo main to=
pic
> -       ) &&
> -       test -f funny.was.run &&
> -       rm funny.was.run &&
> -       echo "Resolved" >F2 &&
> -       git add F2 &&
> -       (
> -               PATH=3D./test-bin:$PATH &&
> -               git rebase --continue
> -       ) &&
> -       test -f funny.was.run
> -'
> -
>  test_expect_success 'rebase -r passes merge strategy options correctly' =
'
>         rm -fr .git/rebase-* &&
>         git reset --hard commit-new-file-F3-on-topic-branch &&
> --
> 2.39.2

Looks good otherwise.
