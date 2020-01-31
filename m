Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6330FC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F486206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3lCuuem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgAaT7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:59:33 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:33008 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAaT7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 14:59:33 -0500
Received: by mail-oi1-f175.google.com with SMTP id q81so8525580oig.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 11:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXAMXfaV1y6pQcfZFOcW+sjiBlIs3ne+jyr3rwETHTs=;
        b=i3lCuuem2Pf+G3I8OFx615HZTDltHDYjrzUo8uqMXaGWxW9O0KErxNNd9tTPmqlSvC
         SdBgIvA54Kj2vXPxxHRiUPOWLVfoeZ5YcSNQM4Q0ohqv05NwhuMujWUevsGSHEYwUaim
         cvBXIlo1OE5oGnl4mBlTnP1ssDoHFypeDBgmgVxzFeDax4ZNuSCNffpBaqk2o3vxfCOD
         IhW7G5ThyygHFsWahIsW8HUaU/3YLaj6IM60CfR5vqbHx472TxDgC++8n5RZ4nMkSVV0
         IsX4uQg1S03eRo03xBoggV2uuBovlREIr61/aVucEZTXczcZMZuQ2gWty36BGKOkT/q/
         HLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXAMXfaV1y6pQcfZFOcW+sjiBlIs3ne+jyr3rwETHTs=;
        b=VhDsvFz41E6PFDaMEt+ekz8yZSHWkOm2qg3onqwCqzH+MHETNB2B4ohT/Cg8oRaw8e
         2QhM0vKNHJuZY1iO3NOXZcjcCJSuOQk8IFy5Dhv9Kdje1EhMrtwEwR0+kcUnTIVBkO0A
         J4FNSebL7D4w/wun2YmVqOhmmYt0H+XLs0Lvh0To2fYsaw1PswKQd2OFar3IwSEB31R8
         /UcFyIyErO52HU0+nNGEgLZbDYqVRyEVMfkEtpPfsXBNyPKvncpZBYxkmmumLDSGSTOc
         rsi11oAIqOa2+XR8TYtDMqo4YePYYAvfnmzdcBzhvIEeA6q2jPEgR/wbujuPTVJHO9BA
         C1kQ==
X-Gm-Message-State: APjAAAXUggL8PWleMZgkS8T8sHhgOtd/oMMEyLGLa1qmGZOsW+H6N0Bf
        qC4R6TCzfXXtdJEQpwLmCRWIJquy0l0Rgjv8LucLOFci
X-Google-Smtp-Source: APXvYqyS6XsT2DCBf6yDRjJ5CVBSndQts6f+WW9QHQnUTVXu+rdCThYr+vqlzz+I4OroVHidx4RoFQxbqKe1sCXViU8=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr7147446oib.6.1580500770884;
 Fri, 31 Jan 2020 11:59:30 -0800 (PST)
MIME-Version: 1.0
References: <CADSBhNbbO=aq-Oo2MpzDMN2VAX4m6f9Jb-eCtVVX1NfWKE9zJw@mail.gmail.com>
 <ef39f8c5-ce0b-a48b-940d-821df563b292@gmail.com>
In-Reply-To: <ef39f8c5-ce0b-a48b-940d-821df563b292@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Jan 2020 11:59:20 -0800
Message-ID: <CABPp-BHNxGFFgMMABto0y0LA6xxqqDEcVGw4FSN=1JdH53+V9Q@mail.gmail.com>
Subject: Re: Sparse checkout inconsistency with non-folder paths between cone
 mode and full matching (2.5.0)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     finnbryant@gmail.com, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 10:52 AM Derrick Stolee <stolee@gmail.com> wrote:
> Practical: How do we specify if an input is a directory or a file?
>
> As you mentioned, if you run "git sparse-checkout set X" then you get
> a sparse-checkout file containing:
>
>         /*
>         !/*/
>         /X/
>
> But if X is actually a _file_, then we should write this pattern:
>
>         /*
>         !/*/
>         /X
>
> So the input does not provide enough information to say which pattern
> should be written.
>
> The other concern about this second set of patterns is that "/X" is
> only a _prefix_ match, not an exact path name match. That means we
> cannot use the existing hashset matching to result in the same
> pattern matching as non-cone-mode.
>
> Now, there is perhaps a way to decide between the two: inspect the
> current index or tree for whether the input corresponds to a directory
> or a file. This adds a layer of complexity that is not currently in
> the sparse-checkout builtin, but it is not insurmountable. The only
> thing to consider is what happens when the input path is not in the
> index/tree at all! It may be that we want to specify the patterns
> before moving HEAD to a commit that _does_ contain the path, and then
> we would do the wrong thing at this point.

And once people ran into the difference because their repo was weird,
they'd be bewildered.  I don't want to deal with those support
questions; let's just disallow the latter form and require the
trailing slash.  There are three alternate universes we could have
supported such an ability under:

   * If we had decided to use regexes instead of fnmatch for
sparse-checkout/gitignore then we could have a /<path>$ pattern to
match just files
  * If fnmatch had an end-of-input marker like regex's '$', then we
could use it to mark exact files and be able to translate that into
hashes.
  * If we had decided that cone mode uses an input file other than
.git/info/sparse-checkout with a different format, we wouldn't have to
worry about strict compatibility of the format with non-cone mode and
support different types of abilities.

But I think it's too late now.  Let's just leave the trailing slash
there and say we only support directory-based matching in cone mode.

> So I'll put out a question to the community: is this practical issue
> something worth overcoming? Is my concern about a non-existent path
> a true problem, or something more?
>
> Thanks,
> -Stolee
