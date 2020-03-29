Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81203C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485CA20748
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 20:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRNcvuI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgC2Utw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:49:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42574 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgC2Utw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 16:49:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id t9so13455583qto.9
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pasrQ07kabQVCLo1zis22Akz2Pz6PsbZyFfd8urjT8c=;
        b=SRNcvuI0MVddCyFAESE6EkSOESCrnmah+eJ3rQ7+pLipo1JmorxCTkahrdphDkjJSi
         MzjBlGH/g8kg5q2F3WH8ucgCbF5LxJZaydXURwDJc2hSE1RcJpJh8+HOrtPyMiSXbIDr
         WzbxjYUJrML4InF9DXDrE7ZVeqMke77zpdrfUjZxGrL3TKrG78Dg9QvlbzkE37dyVLSc
         JHjFtYQKft41gnv+c5gk4aFF7e0et9d2Lffro91xQL4ZzgMjDZ27D6O8rD9uoSqMbRBo
         ia/naN9i8FGJlgF/1MNppLmdvfh9HOtZWhk2dc6sUeG+tAU7Z12Vf1v0q2Ch8cD1Xofw
         ipSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pasrQ07kabQVCLo1zis22Akz2Pz6PsbZyFfd8urjT8c=;
        b=mGWo9zCfR+KkwW+d0fn1CnvQq12ZWAfRr5DqYg88T2fd7LXCn1pdLb6FDQboeeuTEp
         m0Sa7DMMyP89QBn8fPkhCpt9MSd8v4NmbYE7NKBMdpkseJzSKvt9EuQf6Ipm9v6Lsn1O
         QVOIJRWVUiflOfgI7MfRAm2YPCyzOHuieYlMGPkMZAGa9N3mXJ9HEdeqlQ0Ci6fdHnLp
         Ske3sQ1hAYCY0xpuJHoOjtv1qzwCbuBkE4qyRLgH2sZF/ssSBtQqEK27W8vojaG0HTQB
         N73vXf98bZj/o0mUHXBzUFFL5MeqOO1Xvd7ZkLib++hsIf9a0fRb/Aw2IhRB9hxfLNlB
         whAg==
X-Gm-Message-State: ANhLgQ21EeiwGCzX0tx8OllzNU/UwxOGAgE+INvCgApunpDO/1STla8R
        sgTBCoiaIf95gpcjHp6vacgzkNaQ
X-Google-Smtp-Source: ADFU+vtett8KMr24u7NQ3cRWw925EJ88vq7wyn86ZOmVb96GmXmHR25n5gxhwKMkDCHj1w4kJ5muJw==
X-Received: by 2002:ac8:36a1:: with SMTP id a30mr8726129qtc.103.1585514990829;
        Sun, 29 Mar 2020 13:49:50 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id j50sm9724971qta.42.2020.03.29.13.49.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 29 Mar 2020 13:49:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 4/5] doc: be more precise on (fetch|push).recurseSubmodules
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200325210943.339240-5-damien.olivier.robert+git@gmail.com>
Date:   Sun, 29 Mar 2020 16:49:48 -0400
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EA4CEB1-D329-4916-A9AC-2F64A7A4F6D0@gmail.com>
References: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com> <20200325210943.339240-5-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 25 mars 2020 =C3=A0 17:09, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> The default value also depends on the value of submodule.recurse.
> Use this opportunity to correct some grammar mistakes in
> Documentation/config/fetch.txt signaled by Robert P. J. Day.
>=20
> Also mention `fetch.recurseSubmodules` in fetch-options.txt. In
> git-push.txt, `push.recurseSubmodules` is implicitly mentioned (by
> explaining how to disable it), so no need to add it there.
>=20
> Lastly add a link to `git-fetch` in `git-pull.txt` to explain the
> meaning of `--recurse-submodules` there.
>=20
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
> Documentation/config/fetch.txt  | 9 +++++----
> Documentation/config/push.txt   | 2 ++
> Documentation/fetch-options.txt | 3 ++-
> Documentation/git-pull.txt      | 3 +--
> 4 files changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/config/fetch.txt =
b/Documentation/config/fetch.txt
> index f11940280f..cd5b1417c4 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -1,11 +1,12 @@
> fetch.recurseSubmodules::
> -	This option can be either set to a boolean value or to =
'on-demand'.
> +	This option can be set either to a boolean value or to =
'on-demand'.
> 	Setting it to a boolean changes the behavior of fetch and pull =
to
> -	unconditionally recurse into submodules when set to true or to =
not
> -	recurse at all when set to false. When set to 'on-demand' (the =
default
> -	value), fetch and pull will only recurse into a populated =
submodule
> +	recurse unconditionally into submodules when set to true or to =
not
> +	recurse at all when set to false. When set to 'on-demand',
> +	fetch and pull will only recurse fetching into a populated =
submodule

The chosen formulation seems to imply that only for "on-demand" will =
fetch and pull
recursively *fetch* in submodules, which is misleading. I think it might =
be clearer to just
add a sentence at the start :

This option controls whether `git fetch` (and the underlying fetch in =
`git pull`)=20
will recursively fetch into populated submodules.
This option can be set either to a boolean value or to 'on-demand'.
Setting it to a boolean changes the behavior of fetch and pull to =
recurse unconditionally=20
into submodules when set to true or to not recurse at all when set to =
false.
When set to on-demand, fetch and pull will only recurse into a populated =
submodule=20
when its superproject retrieves a commit that updates the submodule=E2=80=99=
s reference.


> 	when its superproject retrieves a commit that updates the =
submodule's
> 	reference.
> +	Defaults to 'on-demand', or to the value of 'submodule.recurse' =
if set.
>=20
> fetch.fsckObjects::
> 	If it is set to true, git-fetch-pack will check all fetched
> diff --git a/Documentation/config/push.txt =
b/Documentation/config/push.txt
> index 0a7aa322a9..f5e5b38c68 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -112,3 +112,5 @@ push.recurseSubmodules::
> 	is 'no' then default behavior of ignoring submodules when =
pushing
> 	is retained. You may override this configuration at time of push =
by
> 	specifying '--recurse-submodules=3Dcheck|on-demand|no'.
> +	If not set, 'no' is used by default, unless 'submodule.recurse' =
is
> +	set (in which case a 'true' value means 'on-demand').
> diff --git a/Documentation/fetch-options.txt =
b/Documentation/fetch-options.txt
> index a115a1ae0e..b1058d63bc 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -163,7 +163,8 @@ ifndef::git-pull[]
> 	value. Use 'on-demand' to only recurse into a populated =
submodule
> 	when the superproject retrieves a commit that updates the =
submodule's
> 	reference to a commit that isn't already in the local submodule
> -	clone.
> +	clone. By default, 'on-demand' is used, unless
> +	`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).
>=20
> -j::
> --jobs=3D<n>::
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index dfb901f8b8..47bc4a7061 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -86,8 +86,7 @@ OPTIONS
>=20
> --[no-]recurse-submodules[=3Dyes|on-demand|no]::
> 	This option controls if new commits of all populated submodules =
should
> -	be fetched and updated, too (see linkgit:git-config[1] and
> -	linkgit:gitmodules[5]).
> +	be fetched and updated, too (see linkgit:git-fetch[1], =
linkgit:git-config[1] and linkgit:gitmodules[5]).
> +
> If the checkout is done via rebase, local submodule commits are =
rebased as well.
> +
> --=20
> Patched on top of v2.26.0 (git version 2.25.2)
>=20

