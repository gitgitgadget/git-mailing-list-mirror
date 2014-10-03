From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [TOY PATCH]: rebase: Add --show-files option
Date: Fri, 3 Oct 2014 20:42:10 +1300
Message-ID: <CAFOYHZDDq0UfvznUTx5FMaX97kK0nJxYAJ_-sj_Mu+x3o3ftCg@mail.gmail.com>
References: <CAEY4ZpN4HEo-Csf1UjpGX4YLKWRrywinUemeZFZdVg=ZtTsaqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 09:42:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZxVM-0002t6-D6
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 09:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbaJCHmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 03:42:12 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:52826 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbaJCHmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 03:42:11 -0400
Received: by mail-qa0-f49.google.com with SMTP id f12so533716qad.8
        for <git@vger.kernel.org>; Fri, 03 Oct 2014 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9fzvQ6beG983IkeBOKnXDLVjVe26fwemXyiMxYW53zE=;
        b=sY4TLAo+mo83BrBVV6p6gdmy2vXy0Hk7uabAYziFP6702Pvh467Xwn0o2+D0ya/GnR
         qtyQzPG5VHR3gSKXqiRmXqLSTZh/B6yu9IkONmxElvuTXceA4FJqXwz0g7xrLf9kgN7t
         Qbom/VU9PIrUpLhIik1ID06wRNlh2KKvzVNEXh9cDCJhHXwgy2PTxvXYrX2MWdbxv01T
         /hOYZZ7LZB4/NuEG4FOtBRTC/JUu3Cw43poCmpPr/9NcP3rLUn29ntJjyzVtBEl9SBdO
         6lQ4QSDHLnRKDCirJGLRY30JxPZyOx6CdPlbfUEt2E6Fb88UZveuBG+u1AjJRMBVWZ81
         yO1A==
X-Received: by 10.224.88.3 with SMTP id y3mr4687399qal.65.1412322130575; Fri,
 03 Oct 2014 00:42:10 -0700 (PDT)
Received: by 10.140.221.198 with HTTP; Fri, 3 Oct 2014 00:42:10 -0700 (PDT)
In-Reply-To: <CAEY4ZpN4HEo-Csf1UjpGX4YLKWRrywinUemeZFZdVg=ZtTsaqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257834>

Hi,

On Fri, Oct 3, 2014 at 5:42 PM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> Hi,
>
> When working on a "new feature branch" that touches a lot of files I
> tend to make commits that affect only single files, and for very small
> changes. Since at this stage I'm experimentating a lot - trying out
> ideas, etc. - the commits tend to grow a lot (could be 50-70
> individual commits, each modifying one or two files), and I don't
> think much about the commit message beside making a one-liner that
> explains only the gist.
>
> Most of the times I include the filename in the commit message to help
> me identify which commits should be squashed together later.
>
> Only when the feature seems to be functional that I git rebase the
> commits in order to shape the history into its final, proper form.
>
> When rebasing these upwards of 40+ commits, it is helpful if the
> rebase instruction sheet shows me the actual files that the commits
> affect so I made this patch (sorry I couldn't attach it inline since
> gmail eats all the tabs) that adds the "--show-files" option to
> git-rebase to achieve something to this effect:
>
> pick 996fa59 Remove autoconf submodule
>      # :100644 100644 cfc8a25... 28ddb02... M   .gitmodules
>      # :160000 000000 0263a9f... 0000000... D   autoconf
> ... more pick lines
> pick 4c5070f Remove automake submodule
>      # :100644 100644 28ddb02... f907328... M   .gitmodules
>      # :160000 000000 9042530... 0000000... D   automake
>
> Having the list of files shown below each commit, indented to reduce
> cluttering the "pick" instruction, really does help in deciding the
> reorder and squash candidates.

Sounds neat. I do similar things and do sometimes lose track of which
files are being touched by multiple "fix compile error" commits. I
haven't actually looked at your patch because gmail can't display it
in-line but it's a feature I'd use.

>
> The files list came from this:
>
>   git show --raw $sha1|awk '/^:/ {print " '"${comment_char}"'\t"$0}'
>
> Thoughts?
>
> nazri
