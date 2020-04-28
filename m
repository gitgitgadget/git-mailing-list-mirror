Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4ABC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092F62085B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkTqluD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgD1RcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgD1RcO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 13:32:14 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF7C03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 10:32:14 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id a7so14275679uak.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbBSuScVGCzpeWfIFUrSKhcRbvo+zUjCwjdsffV3zeg=;
        b=qkTqluD8Cu8KyJxluiPMN+FWqUdXmskgh2ZKSLttVh3JWRAKc6iEop5so3ODhhZ9qq
         KA+cABBuIZCZjflxzj5Hyyufit0D/CXhc3BcKAQs4bSVqGQYNYx61z8Vqv/NAGR88aoH
         LwOkg/cx2ihcD/4w5Psked/Vz0mP+4CKwalyD+Q9CXBr2Ecq8RmlrcHzo7AIo1hkX/1h
         i+uJnDhwtiKsFABwWTv/wpMoVdk1ITjyPv5FkRBjXJ3Gt7S1U9P0YHzN7JHP6Nlejn20
         FwRfLpobLgSbDofuvh1toQDz6RyWqdXJQ/WjsGX9aR7mTzym7CZgeHBR4lXB0CRuCW1x
         hlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbBSuScVGCzpeWfIFUrSKhcRbvo+zUjCwjdsffV3zeg=;
        b=SWIglZipLgydRyPtlRAdnPDfHK/Ksyzglg6rc58uEsMqY1Aob23ilGLATZvebJ9D1M
         tnwKMBNj555MczLYuTl+5Si6UH31FpTC5xhkse2J+x8NOFwblmaqwZdhtKwkjfCxrhHe
         V69p7sW+AAOvT+FQMpAMSW4uMr8odasrv2KOxKe4B1G/uBR9tEKIWHjPPF6vvCBBZ0jh
         iIR3ify7XanIvmGi1lwVzcezBnC0C0K99jqB0C8BM+bEMME/sWQMapMYq2r8cw5+Dosm
         K5xe1Ympnm4RjDwAEYMD9UGTVOHvp4K2h4HotrOmSW4nYspgCAdRYxP4/PLLYNLu3sPN
         zhbQ==
X-Gm-Message-State: AGi0PuZ7UfU9zfT7W/YaTWMkYwZNMO2X0334clY+LTiZvDg1qQIaJm5D
        NsCdiMw+tNvS+MG1OBMxUoFxQrzP9ozwvNVKTeI=
X-Google-Smtp-Source: APiQypLkb7xr3QMeyNZ5RCSgf4t9SiRWYkjaY0eNHhSiM+hi0SWqHduw/atzs2b9eaXx+3OKjgNorNdlbJE79bTc99A=
X-Received: by 2002:a67:7382:: with SMTP id o124mr23955686vsc.153.1588095133808;
 Tue, 28 Apr 2020 10:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
 <20200425022045.1089291-6-jacob.e.keller@intel.com> <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
 <CA+P7+xpEMb-A1cOkOxdWf0pM=5o8Cyn9=5HLZPtFNMcLUaypsg@mail.gmail.com> <xmqqo8rb4lyj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8rb4lyj.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 28 Apr 2020 10:32:02 -0700
Message-ID: <CA+P7+xoBnS8huHiU+QM8x6LRiSDRYVVS2pduv6i_qrwb1ZS7fg@mail.gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for
 git switch --orphan
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 9:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > The proposed SQUASH you have in gitster/jk/complete-git-switch is
> > correct. The commit message body is correct, but the title could be
> > reworded to
> >
> > "completion: stop completing refs for git switch --orphan"
> >
> > I can send a v2 if that would be helpful, and I've got it fixed up
> > locally if other review increases the need for a new spin.
>
> Thnaks.  In the meantime, what I have is attached (the test title,
> in addition to the commit title, has been updated).
>
> The same logic would apply to "git checkout -b <TAB>" (or "git
> switch -c <TAB>") as this change: these are meant to create a new
> branch so you do not want to offer an existing branch name.
>

While true, you may optionally have a 2nd argument which provides a
start point that can be an arbitrary reference.

> I have a mixed feelings about that reasoning, though.  I understand
> that not offering any existing branch name would avoid offering a
> branch name that would cause an error message from the command,
> which at a first glance feels like a nice help to the user, but I am
> not sure if it is really helping.
>
> When you are on jk/complete-switch branch to work on this topic, you
> may want to keep the current state of the branch and use a "v2"
> branch to play around (running "rebase -i" etc.), for which the way
> I would hope to work would be:
>
>         git checkout -b jk/comp<TAB>
>
> that would complete to an existing branch
>
>         git checkout -b jk/complete-switch
>

Hmm.. Yes this would be useful.

> and then I can just type "-v2<Enter>" (or "<BackSpace>-v2<Enter>" to
> remove the inter-word space completion adds?)  after that.  After
> all, "git checkout -b jk/complete-switch" in that scenario would
> error out by saying that you already use that name, which is a good
> enough protection.
>
> And that same "is this really helping?" reasoning applies equally to
> the "--orphan" option.
>
> I dunno.
>

Fair enough, new branches based on previous branches makes sense.

Thanks,
Jake

> -- >8 --
> From: Jacob Keller <jacob.keller@gmail.com>
> Date: Fri, 24 Apr 2020 19:20:38 -0700
> Subject: [PATCH] completion: stop completing refs for git switch --orphan
>
> git switch with the --orphan option is used to create a new branch that
> is not connected to any history and is instead based on the empty tree.
>
> It does not make sense for completion to return anything in this case,
> because there is nothing to complete. Check for --orphan, and if it's
> found, immediately return from _git_switch() without completing
> anything.
>
> Add a test case which documents this expected behavior.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/completion/git-completion.bash | 11 ++++++++++-
>  t/t9902-completion.sh                  |  6 ++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c21786f2fd..08d3406cf3 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2223,9 +2223,18 @@ _git_switch ()
>                 __gitcomp_builtin switch
>                 ;;
>         *)
> +               local track_opt="--track" only_local_ref=n
> +
> +               # --orphan is used to create a branch disconnected from the
> +               # current history, based on the empty tree. Since the only
> +               # option required is the branch name, it doesn't make sense to
> +               # complete anything here.
> +               if [ -n "$(__git_find_on_cmdline "--orphan")" ]; then
> +                       return
> +               fi
> +
>                 # check if --track, --no-track, or --no-guess was specified
>                 # if so, disable DWIM mode
> -               local track_opt="--track" only_local_ref=n
>                 if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
>                    [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
>                         track_opt=''
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index a134a87910..7e4dd8e722 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1351,6 +1351,12 @@ test_expect_failure 'git switch - with -C and --no-track, complete all reference
>         EOF
>  '
>
> +test_expect_success 'git switch --orphan completes no references' '
> +       test_completion "git switch --orphan " <<-\EOF
> +
> +       EOF
> +'
> +
>  test_expect_success 'teardown after ref completion' '
>         git branch -d matching-branch &&
>         git tag -d matching-tag &&
> --
> 2.26.2-266-ge870325ee8
>
