Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB04C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A65B20730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJgocIC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDGUt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:49:28 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:36495 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGUt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 16:49:27 -0400
Received: by mail-ot1-f49.google.com with SMTP id l23so4644300otf.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGR74o5uBtVNHjTGg0Tt4z6GThrB+43iHtV5Ip7II38=;
        b=TJgocIC1XIV812UW8yR/W2XDCyR+G+ZS+o+qGj+WLwqsBacPCme0eKVKFtnsHeotNo
         7nZGfQ9B1u/T0CtqkeTpkfoBOTTfHk2tyLmWsfbY55LDH+gbjOz+gEruCyAiqS9DZN9u
         36q2lMMJSHtYi6X2tM/lSU8BGF+ntl/sMKmiUbBTJ7W63Sj383H0zLWq2Vf/4tBBK0hu
         12nKK4jFOfsD0N48JrPFcO/B+sCZgebH/IybCFTi3iCNzpwtCcsDMAySgKpQ55dY87k9
         GUXOb3xhVaPu44ttviSXaD8X3k1Nvmm4aLVBFjf8xFJYI77YwSSv3zZ2/XNUhzy3dHmM
         AH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGR74o5uBtVNHjTGg0Tt4z6GThrB+43iHtV5Ip7II38=;
        b=F7wJYhzpMHquo72Hy+3UxhJuGkUXBgfqD5GDdfDgOiixOUCmGvo6ZyvvsFOI9PAx5J
         EC6jUOtn4NkfHsherRvpLyN6GI+Efn+nUvE01pR8ewNl5PR28P/OCtJ83xigCeVOm0aq
         3HEa7X7kmPowx0l2rf+q8NrHhjl1PjLKBGkJsEnevSVLSgOGXx6MzJeM/uCBX9PRaq8i
         UjSasn0lO1a+CIH4nfx7UAUcti0ddLo2lqzDJ4r8n5HdgnQz7goWabrA8AfEi6D9kWKo
         3ZD0jpyj3tSSkywHGZAUfA3Z5/CC1EQzUlnTYMKUvg8Vc80ZUPrB3qLFvhWxu1BZTYkp
         wT9Q==
X-Gm-Message-State: AGi0PuZB5B4tCtPi3VfEzy48yj1nDHTsJwiQXdro0Cyb7p0vvBL280yV
        hU2K/hp4Y3fJ1k08/wCiS+Y/rgeY58zib3e2bjc=
X-Google-Smtp-Source: APiQypKyweQx4l7SluhZ1dSyk9KK+hLJqS1dqXZusoiu1QzR9Zn+3TBbrneTGrqcsTVT8i+RJLdAYV3gfH1wt6Dvft8=
X-Received: by 2002:a05:6830:2428:: with SMTP id k8mr3263706ots.345.1586292566686;
 Tue, 07 Apr 2020 13:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <702823257.805273759.1586276452976.JavaMail.root@zimbra39-e7> <277700231.805340039.1586277291215.JavaMail.root@zimbra39-e7>
In-Reply-To: <277700231.805340039.1586277291215.JavaMail.root@zimbra39-e7>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 13:49:15 -0700
Message-ID: <CABPp-BEHQUzRjddKrC7Q7j+2W-W9ZjdVnXVjsM6wVWrpDF7cwQ@mail.gmail.com>
Subject: Re: [BUG] submodule move badly handled by git-rebase
To:     ydirson@free.fr
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yann,

On Tue, Apr 7, 2020 at 9:36 AM <ydirson@free.fr> wrote:
>
> Hello all,
>
> When rebasing commits involving move of a submodule, git-rebase fails to
> record in index the "add" part of the rename.  This leaves the workdir
> dirty and the rebase gets stopped.
>
> fast-export of a testcase is attached.  To reproduce, just
> "git rebase -i", add a "break" before the move commit,
> use this to introduce some noise, and watch.
>
> Best regards,
> --
> Yann
>
>
> (master)$ git rebase -i HEAD^^
> hint: Waiting for your editor to close the file... Waiting for Emacs...
> Stopped at b0e1b00... add submodule
>
> (master|REBASE 2/3)$ echo >>README
>
> (master|REBASE 2/3)$ git commit -a -m noise
> [detached HEAD d67c886] noise
>  1 file changed, 1 insertion(+)
>
> (master|REBASE 2/3)$ git rebase --continue
> Adding as subdir/gitlab-oe~08e230f... move submodule instead
> error: could not apply 08e230f... move submodule
> Resolve all conflicts manually, mark them as resolved with
> "git add/rm <conflicted_files>", then run "git rebase --continue".
> You can instead skip this commit: run "git rebase --skip".
> To abort and get back to the state before "git rebase", run "git rebase --abort".
> Could not apply 08e230f... move submodule
>
> (master|REBASE 3/3)$ git st
> interactive rebase in progress; onto c21ef8e
> Last commands done (3 commands done):
>    break
>    pick 08e230f move submodule
>   (see more in file .git/rebase-merge/done)
> No commands remaining.
> You are currently rebasing branch 'master' on 'c21ef8e'.
>   (fix conflicts and then run "git rebase --continue")
>   (use "git rebase --skip" to skip this patch)
>   (use "git rebase --abort" to check out the original branch)
>
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         modified:   .gitmodules
>         deleted:    gitlab-oe
>
> Unmerged paths:
>   (use "git restore --staged <file>..." to unstage)
>   (use "git add <file>..." to mark resolution)
>         added by them:   subdir/gitlab-oe
>
> (master|REBASE 3/3)$

I couldn't figure out how to duplicate.  Maybe I did something wrong,
but it was:
    # download your fast-export stream
    git init temp
    cd temp
    cat ~/Downloads/submodule-move.fexp | git fast-import --quiet
    git checkout master
    git rebase -i HEAD^^
    # Insert a line with just 'b' between the two pick lines; save and
exit and when it breaks:
    echo >>README
    git commit -a -m noise
    git rebase --continue

After the rebase --continue, the rebase completes just fine applying
the patch with the submodule move.  git range-diff master@{1}... will
show that I inserted a new commit in the middle.  git log --raw looks
good, showing all four commits including the moved submodule at the
end.


What git version did you use?  Do you need special settings (what's in
your ~/.gitconfig and your .git/config)?
