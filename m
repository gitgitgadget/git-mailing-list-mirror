Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C628C07E9D
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 00:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIYAIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIYAIq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 20:08:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980BA474CC
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 17:08:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o2so5616328lfc.10
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 17:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i9hwLGMbwyew+mjr9ZD4vaYs9iQUWoHijXvIHDuvlzw=;
        b=Aoxk3AyU8PLMyvU4ehh3O7dT7k99F7rQEPu6ryC/186753NxWuTaZl3muPTjaaqmrh
         RrdPZ5iHEnSLTJ/tWQHhcFffYTsjWnTz8FyjJyQUZfT9yK99LQj8LICujnSELle3IddO
         1VJ8YwD5Ipss80bwh+dWrqaJXEiiaLUMCeZtnXkYTHbQvePXJbHBZl+0+Q6OxgcDJhjF
         zoB8wq2QlNPx17noAkgOxT7zTr7cFzelud3SH/wmPW4TeA5W1MrbU/msDZ4G5qAgNXSO
         XImIvB0h/jcA3btWB9nnPTecx0ajiUmCkhArWFJDGTKug5sUsj05lF4Iifc6xAjN05P5
         gWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i9hwLGMbwyew+mjr9ZD4vaYs9iQUWoHijXvIHDuvlzw=;
        b=JooRlkvFCyo8T48DpcyNsGXqwt7BX2niYjwViQX0Ij6lbOSIzkQS9E8POneCmOVJTe
         W0sNHoLMbInKl4GQknXm5orf8uOCWIuuWMvlnkc4R1EE01gYlMxMzXMY/Ei1PGZ1W+w5
         XSRWnDBhrtcinwbPC4J1/jsWHFwLBPP6fahmD/K+Oq0F9Eyq8VQft3nUJnktrKzTCo6R
         e0AOZ0prZp7vh6sArqHajxR7r38hqr9BWmT/AKXnRFcUizCxG6TAbPNDLC8ZoKR8DAoV
         HZ2Zc8dsm3CEe377+8brguvxFT1Ur8h9BRGXji6YNEDwQtFswqMuRkcIUr7s09jhXeH1
         YVow==
X-Gm-Message-State: ACrzQf2Ntiq621kpGxr9bgW8ynhusYYQApW1EP0a9W3ZjovikGaBNZ2p
        7PEp1vnIIw4ZMKS5tX+g15bQdDtZIO+M04oDLM03ZCwpOEU=
X-Google-Smtp-Source: AMsMyM75DglTkirEuZbfwB5UvUrsRdk39CgsfJ9yFhV1zFkPQiW8tODwc4pTR/aRv/rfv3HF5vtOMJ40Yc32ErZ4dig=
X-Received: by 2002:a05:6512:b82:b0:4a0:5970:115c with SMTP id
 b2-20020a0565120b8200b004a05970115cmr3613074lfv.531.1664064523756; Sat, 24
 Sep 2022 17:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220924033708.2409170-1-tmz@pobox.com> <CABPp-BHPYa4Lzj0Kt-q+qyA+qpo3BLkoMoQOo7sPNoo-0RTxKA@mail.gmail.com>
 <Yy+GzB0gTBHaJJw1@pobox.com>
In-Reply-To: <Yy+GzB0gTBHaJJw1@pobox.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 24 Sep 2022 17:08:32 -0700
Message-ID: <CABPp-BFwJr7xLhdbdbh+eFhaSF36cLEzKbzc7gpuit=iC2Eejg@mail.gmail.com>
Subject: Re: [filter-repo PATCH] fix links to git-fast-import
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 24, 2022 at 3:38 PM Todd Zullinger <tmz@pobox.com> wrote:
>
> Hi,
>
> Elijah Newren wrote:
> > On Fri, Sep 23, 2022 at 8:37 PM Todd Zullinger <tmz@pobox.com> wrote:
> >> I noticed the link to git-fast-import.html in git-filter-repo.html was
> >> missing the `git-` prefix.  The man page similarly lacked it when
> >> referencing it.
> >>
> >>  html/git-filter-repo.html | 2 +-
> >>  man1/git-filter-repo.1    | 2 +-
> >
> > Neither of these files are tracked; both are auto-generated.  I do
> > stuff them into the "docs" branch so people can grab them...but
> > they'll just be wiped out and overwritten the next time I build the
> > docs.  So, either the documentation source file is wrong, or the build
> > process is.
>
> D'oh! I should have looked closer at the build process.
> Somehow I saw the docs branch and just _assumed_ it was the
> source.  And that required looking right past the asciidoc
> version in Documentation/ on the main branch. ;)
>
> I was clearly a few too many tangents deep.
>
> > Is the real problem that in this text from Documentation/git-filter-repo.txt:
> >
> >     There are four callbacks that allow you to operate directly on raw
> >     objects that contain data that's easy to write in
> >     linkgit:fast-import[1] format:
> >
> > that there should be a "git-" on the last line?
>
> Indeed, thanks.
>
> This should work (I tested by symlinking git-filter-repo.txt
> to git's Documentation, as the Makefile does):
>
> -- 8< --
> Subject: [PATCH] git-filter-repo.txt: add missing `git-` prefix to fast-import
>  link
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/git-filter-repo.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-filter-repo.txt b/Documentation/git-filter-repo.txt
> index 9c00a78..09374a4 100644
> --- a/Documentation/git-filter-repo.txt
> +++ b/Documentation/git-filter-repo.txt
> @@ -1047,7 +1047,7 @@ instead of strings.
>
>  There are four callbacks that allow you to operate directly on raw
>  objects that contain data that's easy to write in
> -linkgit:fast-import[1] format:
> +linkgit:git-fast-import[1] format:
>
>  --------------------------------------------------
>  --blob-callback
> -- 8< --

Thanks, applied!
