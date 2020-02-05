Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18580C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 17:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA51021741
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 17:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="LNyEmvAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgBERPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:15:20 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:35453 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBERPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 12:15:20 -0500
Received: by mail-lf1-f49.google.com with SMTP id z18so2052491lfe.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 09:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=430n2Q1+NuPYqyaCP52aGmj/oIW0FGgeFX+vmN6CKAs=;
        b=LNyEmvAX4wxYpwpxb5rP5KXyrduAndtqkK+Anya4Xcqy9aRrpRtm0RU6ik8A3enhzY
         nxQA3wWKGrouX8HXD0Q9PPWbX1m2zWLpsYP+JMlvq0+N7NiM6dJEcgZWpOTBc3PgfU+7
         +WWvnbHDkLjx2OXk0rG2S90mOIGRegFHLP3KGNtkAQK66jxAcnnXmP4Wpc6/ouPICUgB
         GDOg8sSLGmct/6prgfTVycXG5lnZqElU7BJDbHaniqaTeL82p43GxlTOkJA86PNd2U6L
         +Asgel8480tyFsPQFK+ZlKgBleWLAwrhQuxuMERJof6f9mXU81+jgKQlAcjU+14Q/Djw
         k0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=430n2Q1+NuPYqyaCP52aGmj/oIW0FGgeFX+vmN6CKAs=;
        b=jUxOa/39e4ScLMcWyPKkYCqzHl3y3Q5WVppCEev2W7mvlCZXCYk5gPHtr4Jg0AXRyF
         iEcLuy5LYCXigJzQ19uMOjHut7CcVLqhISJeS6Q20KdYXp4B/2RTA26JLLqQ04Ns958x
         ul0MTiuIUYxtS4QsEkF9dpH1GhzLiIsllMEuKdJpzrREaRV0AdTBGsSXscER7sbMBcud
         nEuEryfH3DTEdOWBJlZ6xGmkAYfy8eE05qUukZfDca4/ftMuB+E++XdNkBoVhbZ/V46V
         OiVea12vhPFzeo65MZnvZORSKqzsExJIZexDyQeqA9Ph/ws0whoEbpDWIGJnetvGW2wM
         h1aQ==
X-Gm-Message-State: APjAAAUEPeVAu6SkKDAPBIQCWSYrQy3AouhJtDlq4AM7zGAHNg5bfHH0
        akcxBVrpnGgBn79JbW0THw6sOrsT6E1shMKyBBtx8RM1zms=
X-Google-Smtp-Source: APXvYqy50sg2btHXG0Lzv49n6SEY40DYB+71wdOQD5yf506OJ3wTkF0ZYP538l/MUmb/LK7kYaS6oRKLPu4RyEScjIg=
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr17449677lfs.99.1580922918596;
 Wed, 05 Feb 2020 09:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20200205141332.lov2f2fvinehcd3a@pengutronix.de>
In-Reply-To: <20200205141332.lov2f2fvinehcd3a@pengutronix.de>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 5 Feb 2020 14:15:07 -0300
Message-ID: <CAHd-oW6p-zs-SZnQsJNWPGE8-Ls3vXvf_HOeO+W=1PsQ_oihZA@mail.gmail.com>
Subject: Re: git-describe --tags warning: 'X' is really 'Y' here
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 5, 2020 at 11:13 AM Roland Hieber <rhi@pengutronix.de> wrote:
>
> Hi,

Hi, Roland

> I'm working with the GCC Git repo [0] (which was apparently recently
> converted from SVN [1]), and I'm trying to find out the most recent tag.
> So on the master branch I do:
>
>     gcc (master) $ git describe --tags --abbrev=0
>     warning: tag 'gcc_9_2_0_release' is really 'releases/gcc-9.2.0' here
>     gcc_9_2_0_release
>
> It took me a while to find out what the warning means, because
> 'gcc_9_2_0_release' is not in $(git tag -l), and it cannot be used as a
> ref either:
>
>     gcc (master) $ git show gcc_9_2_0_release
>     fatal: ambiguous argument 'gcc_9_2_0_release': unknown revision or path not in the working tree.
>     Use '--' to separate paths from revisions, like this:
>     'git <command> [<revision>...] -- [<file>...]'
>
> That name is in the tag itself:
>
>     gcc (master) $ git show releases/gcc-9.2.0 | head -n3
>     tag gcc_9_2_0_release
>     Tagger: Jakub Jelinek <jakub@gcc.gnu.org>
>     Date:   2019-08-12 09:38:59

It seems that the commit which added the output message you got is
212945d ("Teach git-describe to verify annotated tag names before
output", 2008-02-28) [1]. As the commit message states, the warning is
emitted when a tag is locally stored under a different name from the
one it was originally created (being the former the one you will want
to use at `git show`).

A simple way to replicate what you experienced in a fresh repo is with:

$ git tag -am "testing tag body" testing-tag
$ mv .git/refs/tags/testing-tag .git/refs/tags/testing-tag-with-new-name
$ git describe --tags --abbrev=0

Which outputs:

warning: tag 'testing-tag' is really 'testing-tag-with-new-name' here
testing-tag

And in fact, if we take a look at the tag with hash `dbb1e12` in GCC's
repo (using `git cat-file -p dbb1e12`) we see that the tag was
originally created with the name "gcc_9_2_0_release" (that is the name
stored in the tag object body). But the reference was later renamed,
since, in the `.git/packed-refs` file, we find the said hash
associated with "refs/tags/releases/gcc-9.2.0". I think that is what
`git tag` is warning you about.

> So my question is: is it the intended behaviour of 'git-describe --tags'
> that it outputs tag names that cannot be used as a ref? If so, what is a
> good other way to find out the most recent tag?
>

Hm, other than using the name provided in the warning, I don't know
about a more 'direct' way. But I'm not very used to `git describe`s
code, probably others can suggest a better option :)

---
Matheus

[1]: https://github.com/git/git/commit/212945d4a85dfa172ea55ec73b1d830ef2d8582f
