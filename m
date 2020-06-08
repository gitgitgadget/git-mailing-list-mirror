Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2F4C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 13:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2A82072F
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 13:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=niceguyit.biz header.i=@niceguyit.biz header.b="N/M6fbmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgFHN0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgFHN0U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 09:26:20 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34522C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 06:26:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id i74so15275227oib.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=niceguyit.biz; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=iU09kZGoEw1gKqG+wci7m7jN7h5/2D0F1HFKQb97PyU=;
        b=N/M6fbmUxL0GZcmBHeNQwRLYMzWyj0EVLZMN1wSaIHWRVh160TYPXmsHDeBfkQmqgD
         ASdC2YTgYRgARJCJ9b1p09uXsQrZFKPy/qWimt2BTuWNEoPvBABE4N6cLPkChDdynjHi
         SRLXwv4xjP+FA4Zw6o3ke8SR4gLmuYp3yFuRR8ueKwvkIvP+vBrkigddYvJLyRCjWbgU
         ByORXBhPv1yPLW1ECtFNbGuSkI4+CS7ehZ0ie9USwVbbq6LywbUnxkP4e9cEmljOxpKP
         9NpjX7DwAMvM53fqFQ6mynu9lOeWCUrcxVjRkRw+mJUGomA5LPcMtZOesT9npd/7reaf
         znOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iU09kZGoEw1gKqG+wci7m7jN7h5/2D0F1HFKQb97PyU=;
        b=Cc9WK62RaEKSI2YniFLYvnwnPkfI793PDKMRUhH2Qb4uN8MKodi3msmIh520swE1fW
         3jHQws0GOLoPuHcfN2sTKnZ1AhqfQt1a2+4zTex0SnyfyKyArqByNsbG/9q1GhngFM6j
         YrejUt4JTn+hphrQ1Gg6PLmrJ+QK11qGP3aG3tQryvqtZlPjkqhhn1wW9ap2pdUEbPtU
         StmOc5wCGHKXgDBa7dTet+P7HQlOD0S8ataa7ec0jyszgchVhdQRJLt+MPG0VwA5e9SC
         ZV7D1atnzYjwzkiL19e95p/+KPiK46a85JihrvJ6wiObNTN1YzHqG+nyonqUV6+dmNIM
         1jZA==
X-Gm-Message-State: AOAM532H2iiPgJMHqX82rj1O+GvYW8nyuG519WhWTJTxF0tfHEZf8Z5U
        Ed4qiOwqd+ED/PA8XWYgTepGTHft1og6xE42hOKO5+0eEYA=
X-Google-Smtp-Source: ABdhPJysa5v58d2Im5ZeNAiVoNMdWad73f0s5PP/g+OBlMCqbTLeMvt5iFS6q3boql+0+VhocHx94vsAr0JPrbu/hj4=
X-Received: by 2002:aca:415:: with SMTP id 21mr10768654oie.112.1591622777980;
 Mon, 08 Jun 2020 06:26:17 -0700 (PDT)
MIME-Version: 1.0
From:   "David Randall {Nice Guy IT}" <david@niceguyit.biz>
Date:   Mon, 8 Jun 2020 09:26:07 -0400
Message-ID: <CAKCYOsMTRm3Zb733OFWDEmBh+V_z1oU+KY568=b9U=tZqXaPfQ@mail.gmail.com>
Subject: Trailing slash conflicts with url.<base>.insteadOf
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

I ran into an edge case with the url.<base>.insteadOf option and
trailing slashes.

I can clone a git repo with a trailing slash.
    $ git clone https://github.com/NiceGuyIT/git-test-parent/
    Cloning into 'git-test-parent'...
    remote: Enumerating objects: 4, done.
    remote: Counting objects: 100% (4/4), done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 4 (delta 0), reused 0 (delta 0), pack-reused 0
    Receiving objects: 100% (4/4), done.

Cloning with SSH and a trailing slash fails. This is expected.
    $ git clone ssh://git@github.com/NiceGuyIT/git-test-parent/
    Cloning into 'git-test-parent'...
    ERROR: Repository not found.
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.

Inside a repo, I can add a submodule with a trailing slash using HTTPS.
    $ cd git-test-parent
    $ git submodule add https://github.com/NiceGuyIT/git-test-child/
    Cloning into
'/home/user/Projects/git-test/git-test-parent/git-test-child'...
    remote: Enumerating objects: 4, done.
    remote: Counting objects: 100% (4/4), done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 4 (delta 0), reused 0 (delta 0), pack-reused 0
    Receiving objects: 100% (4/4), done.
    $ cat .gitmodules
    [submodule "git-test-child"]
            path = git-test-child
            url = https://github.com/NiceGuyIT/git-test-child/

Adding a submodule with a trailing slash using SSH faills. Again, this
is expected.
    $ cd git-test-parent
    $ git submodule add ssh://git@github.com/NiceGuyIT/git-test-child.git/
    Cloning into
'/home/user/Projects/git-test/git-test-parent/git-test-child'...
    ERROR: Repository not found.
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
    fatal: clone of
'ssh://git@github.com/NiceGuyIT/git-test-child.git/' into submodule
path '/home/user/Projects/git-test/git-test-parent/git-test-child'
failed

The edge case comes from Golang's FAQ[1] why it uses HTTPS to clone a
repo. Specifically, how to
authenticate against private repos when using `go get`. I'm using the
2nd option which uses git's
`url.<base>.insteadOf` configuration to replace HTTPS URLs with SSH
urls. I added this to my
`~/.gitconfig`.
    [url "ssh://git@github.com/"]
        insteadOf = https://github.com/

With this option configured, adding a submodule via HTTPS with a
trailing slash fails. The fact this
fails is not that surprising.
    $ git submodule add https://github.com/NiceGuyIT/git-test-child/
    Cloning into
'/home/user/Projects/git-test/git-test-parent/git-test-child'...
    ERROR: Repository not found.
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
    fatal: clone of 'https://github.com/NiceGuyIT/git-test-child/'
into submodule path
'/home/user/Projects/git-test/git-test-parent/git-test-child' failed

The problem comes from working with other git repos where they do not
have this option configured
and add submodules with a trailing slash. As shown above, the trailing
slash is included in
`.gitmodules`. `git clone --recursive` will fail if submodules were
added with trailing slashes and
you have `insteadOf` configured to replace HTTPS with SSH. I ran into
this problem[2] when trying to
`git submodule update --init --recursive` and having it fail on some
repos but not all repos.

I'm using git version 2.26.2 on openSUSE Leap 15.1. I don't have the
capacity to test a newer
version or compile the latest version. I've added a submodule with a
trailing slash to
the above project. To reproduce this, add the `insteadOf` option
mentioned above to your
`~/.gitconfig` and perform a recursive clone. The parent repo will be
cloned but not the submodules.
    git clone --recursive https://github.com/NiceGuyIT/git-test-parent

Is it possible to remove trailing slashes on HTTPS URLs before doing
the URL rewrite?

Thank you for providing great software!

David


[1]: https://golang.org/doc/faq#git_https
[2]: https://github.com/purpleidea/mgmt/issues/602#issuecomment-640063867
