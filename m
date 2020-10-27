Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A086C55178
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2384521D41
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjziJSVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbgJ0NmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:42:02 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:36252 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409344AbgJ0NmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 09:42:01 -0400
Received: by mail-qk1-f170.google.com with SMTP id r7so1138360qkf.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rgoP1vIHBENF4f+TgeKdF1Mddgu2z+3ZHcJSb2+yG7s=;
        b=QjziJSVNFDgStqix7XAKAxRtUrKRVVaYKpbGlSL5q0pm65GucUCSw5r3hh0kVLYj5K
         2rp6Gnaaox34Ag8i59ch1ZDieZEn7kMfFYqGUw9A8ryxR5RQwLlq/qrho9hteVYieMVc
         80euvKLWPLRyX4FDV8hlbY9nXRABpaTSp58U6oaS5mJ/EmbKSyvWDi6Szg5IpT8h/gKQ
         casYzBpsxTQj0TYF1OXj1HMkQhNqYdaw/lT806hOKjPhVX6zlQ9zA9KqFGNFPGrnxtLB
         YPllLsG3Ah+0TN7BigijTPAXFbcZrEoa5yqkWHVPRr9BNPH6VVSfoYNvg3hdT7+Cc1/g
         peMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rgoP1vIHBENF4f+TgeKdF1Mddgu2z+3ZHcJSb2+yG7s=;
        b=aHqneKxbkrc8GayjeuN49lDm3s2zUBDmBuCFlEiJ9qtWubLLyWQvge/MetFPAZg3i1
         T5+d0V7gsom1mujlPFFKInwnuiIvyF7vA7h4ailNEX84H+00vc7TwsWnSXpLnMX3D7Kl
         3Qj3oKmq3xqys9NqdjCkWr4RhZIZ0PhTwGnyHJqixL8FSp/N1ztbbIGE8Nqm7XUn5DeL
         CpEVKE5wyzHhtNQ/MrLGiUJAl3hkkDEIKIAb2dhiMIy1nSjNYi4BEWeWLmycgK3Gnbxg
         8wLBvWwreL32u6chb6A/W4McxnyNr+zFVXwYpsejsrKyn/JQ0AuGR/mds/e01UfnR1H4
         WEag==
X-Gm-Message-State: AOAM530hR3t7S60vl/l/2rYD83Er+sJsC9+L9GgOAPPxuzZZphLUDW4k
        xIkPYeHHTnXjenW/T5FlKhE=
X-Google-Smtp-Source: ABdhPJyquvRy2kO+5lDYXeYHE3n+TU2r0zPz/Lcv1e02LGwxS5y86b74cLVcNXhbtpOY8X80ZhHvsw==
X-Received: by 2002:ae9:ea18:: with SMTP id f24mr2036783qkg.135.1603806119807;
        Tue, 27 Oct 2020 06:41:59 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id f22sm661403qkl.99.2020.10.27.06.41.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2020 06:41:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 3/3] clone: document partial clone section
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <c1a44a35095e7d681c312ecaa07c46e49f2fae67.1586791560.git.gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 09:41:55 -0400
Cc:     Git mailing list <git@vger.kernel.org>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B90939A5-5693-4EB6-8F07-5B50F63B3143@gmail.com>
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com> <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com> <c1a44a35095e7d681c312ecaa07c46e49f2fae67.1586791560.git.gitgitgadget@gmail.com>
To:     Dyrone Teng via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dyrone,=20

> Le 13 avr. 2020 =C3=A0 11:26, Dyrone Teng via GitGitGadget =
<gitgitgadget@gmail.com> a =C3=A9crit :
>=20
> From: Dyrone Teng <dyroneteng@gmail.com>
>=20
> Partial clones are created using 'git clone', but there is no related
> help information in the git-clone documentation. Add a relevant =
section
> to help users understand what partial clones are and how they differ
> from normal clones.
>=20
> The section briefly introduces the applicable scenarios and some
> precautions of partial clone.

"some precautions users should take when using partial clone"=20
would read better, I think.

> If users want to know more about its
> technical design and other details, users can view the link of
> git-partial-clone(7) according to the guidelines in the section.

Note: git-partial-clone(7) does not exist, i.e., there is document
named 'gitpartial-clone.txt' in 'Documentation/ 'that is listed in the =
'MAN7_TXT'
variable of the documentation Makefile. What exists is a document called
'partial-clone.txt' in the 'technical' folder of the documentation.
You can do `git grep 'technical/' in 'Documentation/' to see how these =
pages
are referred to in the rest of the documentation.

Also, the wording could be better:

"In case users want to know more about the technical design of the =
partial clone
feature, add a link to 'technical/partial-clone.txt'."

would be sufficient.

>=20
> Signed-off-by: Dyrone Teng <dyroneteng@gmail.com>
> ---
> Documentation/git-clone.txt | 72 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 72 insertions(+)
>=20
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index eafa1c39927..a6e13666ea1 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -310,6 +310,78 @@ or `--mirror` is given)
> 	for `host.xz:foo/.git`).  Cloning into an existing directory
> 	is only allowed if the directory is empty.
>=20
> +Partial Clone
> +-------------
> +
> +By default, `git clone` will download every reachable object, =
including
> +every version of every file in the history of the repository. The
> +**partial clone** feature allows Git to transfer fewer objects and
> +request them from the remote only when they are needed, so some
> +reachable objects can be omitted from the initial `git clone` and
> +subsequent `git fetch` operations.
> +
> +To use the partial clone feature, you can run `git clone` with the=20
> +`--filter=3D<filter-spec>` option. If you want to clone a repository
> +without download

s/download/downloading/

> any blobs, the form `filter=3Dblob:none` will omit all
> +the blobs. If the repository has some large blobs and you want to
> +prevent some large blobs being downloaded by an appropriate =
threshold,

repeating "some large blobs" two times here feels a little awkward. =
Maybe:

"If the repository has some large blobs and you want to prevent them =
from
being downloaded"

> +the form `--filter=3Dblob:limit=3D<n>[kmg]`omits blobs larger than n =
bytes
> +or units (see linkgit:git-rev-list[1]).

I think you could give an example here, and refer to git-rev-list[1] for =
the full syntax
(also "or units" is a little unclear here). So maybe something like =
that:

"the form `--filter=3Dblob:limit=3D1m` would prevent downloading objects =
bigger than 1 MiB=20
(see the description of the `--filter=3D<filter-spec>` option in =
linkgit:git-rev-list[1] for the=20
full filter syntax)".

> +
> +As mentioned before, a partially cloned repository may have to =
request
> +the missing objects when they are needed. So some 'local' commands =
may
> +fail without a network connection to the remote repository.
> +
> +For example, The <repository> contains two branches which names =
'master'
> +and 'topic. Then, we clone the repository by

wording, and formatting:

For example, let's say a remote repository contains two branches named =
'master'
and 'topic'. We clone the repository with

> +
> +    $ git clone --filter=3Dblob:none --no-checkout <repository>
> +
> +With the `--filter=3Dblob:none` option Git will omit all the blobs =
and
> +the `--no-checkout` option Git will not perform a checkout of HEAD

some punctuation would help:

With the  `--filter=3Dblob:none` option, Git will omit all the blobs, =
and
with `--no-checkout`, Git will not checkout `HEAD`

> +after the clone is complete. Then, we check out the remote tracking
> +'topic' branch by

Here you are not checking ou the remote-tracking 'topic' branch,
you are creating a local branch 'topic' that tracks the remote-tracking =
branch
'origin/topic'.

> +
> +    $ git checkout -b topic origin/topic=20
> +
> +The output looks like
> +
> +------------
> +    remote: Enumerating objects: 1, done.
> +    remote: Counting objects: 100% (1/1), done.
> +    remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> +    Receiving objects: 100% (1/1), 43 bytes | 43.00 KiB/s, done.
> +    Branch 'topic' set up to track remote branch 'topic' from =
'origin'.
> +    Switched to a new branch 'topic'
> +------------
> +
> +The output is a bit surprising but it shows how partial clone works.
> +When we check out the branch 'topic' Git will request the missing =
blobs
> +because they are needed. Then, We

s/We/we/

> can switch back to branch 'master' by
> +
> +    $ git checkout master
> +
> +This time the output looks like
> +
> +------------
> +    Switched to branch 'master'
> +    Your branch is up to date with 'origin/master'.
> +------------
> +
> +It shows that when we switch back to the previous location, the =
checkout
> +is done without a download because the repository has all the blobs =
that
> +were downloaded previously.
> +
> +`git log` may also make a surprise with partial clones.

"make a surprise" reads awkward. "have surprising behaviour" would be =
better.

> `git log
> +-- <pathspec>` will not cause downloads with the blob filters,

I think "if the repository was cloned with `--filter=3Dblob:none`" would =
be clearer
than "with the blob filters".

> because
> +it's only reading commits and trees. In addition

"However, any options" would be more appropriate than "In addition to" =
here.

> to any options that
> +require git

s/git/Git/ (and the same thing below)

> to look at the contents of blobs, like "-p" and "--stat"
> +, options

you don't have to spell out "options" again here. And the options
should be enclosed in backticks instead of double quotes.

> that cause git to report pathnames, like "--summary" and
> +"--raw", will trigger lazy/on-demand fetching of blobs, as they are
> +needed to detect inexact renames.
> +
> +linkgit:partial-clone[1]

Again, I'm pretty sure that does not work. You should build the =
documentation
locally and check that the links you are adding work. =
"MyFirstContrbution"=20
has pointer on how to do that.


Thank you for working on that !=20
It's always great to see people wanting to improve the documentation.

Cheers,

Philippe.

