Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B54FC79DDB
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4E724741
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQtXQ0EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfLMRRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:17:07 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44860 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbfLMRRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:17:06 -0500
Received: by mail-oi1-f171.google.com with SMTP id d62so1441408oia.11
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 09:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0TBiRM6HpaYn3YBKAWG7XqPc1kHrGFnT/W3IiU6eXk=;
        b=AQtXQ0EWgk9kFzG1KTlI7/q76f9k+oSNY653dWmCwqi3ZlRtQIJrbKWBIPNHVBs7L8
         o/OQpnhFLNQkot39xCPJObgd/lqjNQw4CArlh2ll1ZojDWTDMKaf9fuAg6BYpqHd/Aer
         XglVP3BcIokIDuLJJ5C8SPIrleygydXlNKERCaS83Fs7FSI0j7bmsR9MZuNgpUnVw6P2
         FeTuysAxMMjCGPyYYE74+GLFQTM8qppqCgB+FE8vuuEq2E7/Q9gue15z5GDn3X0Dnzs5
         n5WgabmgEvdcfPdBE/3cJMvSer5svwo8r1xB4EES7vsbqyc6VmbMXQW+oQ6cdutaTzxN
         43ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0TBiRM6HpaYn3YBKAWG7XqPc1kHrGFnT/W3IiU6eXk=;
        b=egMMIpBfx85cZ86b7cwxvYUFdKXRv4CpHeQe0CTcaT0ELps9DFqJCc3k+EoDRU1O8f
         BLLSGnlXZMT+aMr6xDK4IhZfLQb5XJRq0SoyHS9hgI0QmIR1HXqkuaTP9hYGY7jCSiLG
         PvVrBBY+7wa5b16OMz4cqqXRfrlCaXl+I1/n5IJOYty6X5dOi+OsT0XoBl/dUq0j9+W/
         qiZdOfEXaDQvCO4TE57bH8UvLauXdkjk/fftfS34n9MadH5NM8WVHqD81EGLlWGCVc1Y
         C5ph+XBvMgHpwpCnR2A/FCpOONfIm3qf+PoDyahWz3STBisi787s22CTSsBqwr6tOceO
         1QjA==
X-Gm-Message-State: APjAAAX887MoHb0DOhrQQXwGLCa0b40sF4sTfmmEp0ZnJxN5Nl2FFApb
        m+pzLNu8i/gbiqLv6Ucx+KxunsDr8YeAcPfQrqC0Dw==
X-Google-Smtp-Source: APXvYqxAYSZE3K/QUrrHCoCWADRjM/NoociMppLWUHdshcUZ6KDFhAoAnwJhZcrSsgUfVsPft4+WsPx6mBoazazc3Mk=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr7630757oig.39.1576257425626;
 Fri, 13 Dec 2019 09:17:05 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1912130447510.5127@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1912130447510.5127@localhost.localdomain>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Dec 2019 09:16:54 -0800
Message-ID: <CABPp-BEke9YSUp=DDS6jZCk0z6SR64FMv5nLCLoJDE=52d8MMg@mail.gmail.com>
Subject: Re: how to add a (history-laden) subdirectory into a repo?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI Robert,

On Fri, Dec 13, 2019 at 2:28 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   (i suspect there's an easy solution -- possibly involving
> filter-branch or elijah newren's git-filter-repo, or possibly
> something even simpler, so let me try to be brief.)
>
>   i have a xilinx petalinux (vendor) repo that i started from scratch,
> with a certain amount of history that i would like to hang onto --
> assume the top-level structure (as created by the petalinux-create
> tool) is:
>
>   board_name/
>     dir1/
>     dir2/
>     ... etc etc ...
>
> and so on, and so on. that is the structure of my current repo,
> totally isolated from other content.
>
>   now, at this client site, they're using petalinux, but their
> existing repository buried the petalinux project content inside a
> larger build infrastructure that involves docker and other tools, so
> the client's single repo has the structure:
>
>   client_repo/
>     blah1/
>     blah2/
>       woof1/
>       woof2/
>       board_name/      <---- subdir content in client repo
>         dir1/
>         dir2/
>         ... etc etc ...
>
> from my perspective, the ideal solution would have been for the client
> to develop its build infrastructure, and include the PL project as a
> submodule or subtree, as that content really is independent from the
> build infrastructure but, for whatever reason, the above is all just
> one honking big repo with commits to the build content intermixed with
> content related to the PL project.
>
>   i'd like to add my PL repo into that structure -- as you can see,
> all my commits will be relative to the dir structure "board_name/",
> while the corresponding content in the client repo will be relative to
> "client_repo/blah2/woof2/board_name/".
>
>   if submodules or subtrees are not an option, what is the easiest way
> to insert my content into the appropriate subdirectory in the client
> repo, while retaining my history? i'm sure there's a simple way to do
> this, it just escapes me at the moment.

Hi Robert,

I'm still not quite sure what you want, but here's a few possibilities:

If you want the history of your PL repo kept the same (with everything
under "board_name/") but for the merge and subsequent commits to have
the content at "client_repo/blah2/woof2/board_name/", then you just
fetch the PL repo's history into the other and do a merge using the
subtree merge strategy.

If you want to rewrite the history of your PL repo (so that not only
new commits but history has all paths under
"client_repo/blah2/woof2/board_name/"), which will allow people to do
things like "git log -p -- client_repo/blah2/woof2/board_name/" and
see the historical commits from your PL repo, then use filter-repo's
--to-subdirectory-filter option ("git filter-repo
--to-subdirectory-filter client_repo/blah2/woof2"), and then merge the
repos together afterward. (And since the paths now line up, you won't
need to use the subtree merge strategy).  Note that I'm assuming
you'll just be merging one branch in and not pulling in tags.  If tags
of the PL repo are important and possibly conflict, you may also want
to look at the --tag-rename option to filter-repo as well.

If you not only want paths to line up but want to avoid a big merge
commit and instead weave commits together from the two repositories to
pretend they were all in the same repo all along, then I have nothing
for you.  There are so many choices and ways to "weave commits
together"; I think it'd be a cool thing to do on top of filter-repo,
but never came up with anything.  I've got a few ideas, but...they
sound like too much work and it's really not my itch to scratch.  Or
at least isn't right now.


Hope that helps,
Elijah
