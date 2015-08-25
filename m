From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH v5 2/2] worktree: add 'list' command
Date: Tue, 25 Aug 2015 05:01:33 +0200
Message-ID: <CAHYJk3SaDAJ6rfB2=GtGdeL47=Ckyrktd3qEM-UBH4ZbPYtKgg@mail.gmail.com>
References: <1440280294-50679-1-git-send-email-rappazzo@gmail.com>
	<1440280294-50679-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com, git <git@vger.kernel.org>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 05:01:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU4Uf-0004F0-IT
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 05:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbbHYDBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 23:01:34 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36793 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbbHYDBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 23:01:34 -0400
Received: by iodv127 with SMTP id v127so171513533iod.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ezdsvfr420Yimt52K+wp71mBvJiIpTURwwIoQaDl/4k=;
        b=SJAZiYiPUxmch0TzlmfUNsOMD9lkWoQJx+koDTCslN3SXFW0Ss7w6EajEdPAlQb5E9
         4RNUnii/NS+gw3I1iCradmC0e3FlKojyJiaMJLv8v1kgBckrmFi84LwTsk6K88LmjX/4
         t40TxrXowzXoCRq+f3p2Z+VSReTQ15ZLSU5Eaf4uDRdJ57gHrMbwKqEBf1x4ptF6521v
         K2KrA9YrSYhYTOEmMtt8UNljef6taEX/MKRul4oAc0+V0HjO3zW8fsc3cc5ttNtDi/Ea
         ybEQ/M1W03QGSd0hkyKBGlZ1JFnlZu/xtv4Nfhct4baXxwgmTzqIhIy4491k6IAl0wcd
         MwJQ==
X-Received: by 10.107.138.216 with SMTP id c85mr21359639ioj.187.1440471693467;
 Mon, 24 Aug 2015 20:01:33 -0700 (PDT)
Received: by 10.36.206.132 with HTTP; Mon, 24 Aug 2015 20:01:33 -0700 (PDT)
In-Reply-To: <1440280294-50679-3-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276503>

On Sat, Aug 22, 2015 at 11:51 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> 'git worktree list' uses the for_each_worktree function to iterate,
> and outputs in the format: '<worktree>  (<short-ref>)'
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  Documentation/git-worktree.txt | 11 +++++-
>  builtin/worktree.c             | 55 ++++++++++++++++++++++++++++
>  t/t2027-worktree-list.sh       | 81 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 146 insertions(+), 1 deletion(-)
>  create mode 100755 t/t2027-worktree-list.sh
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index fb68156..e953b4e 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
>  'git worktree prune' [-n] [-v] [--expire <expire>]
> +'git worktree list' [--path-only]
>
>  DESCRIPTION
>  -----------
> @@ -59,6 +60,12 @@ prune::
>
>  Prune working tree information in $GIT_DIR/worktrees.
>
> +list::
> +
> +List the main worktree followed by all of the linked worktrees.  The default
> +format of the list includes the full path to the worktree and the branch or
> +revision that the head of that worktree is currently pointing to.

Maybe just "and the branch or revision currently checked out in that worktree."?

-- 
Mikael Magnusson
