Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC9C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 20:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4FB20748
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 20:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCqFraqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgC2Uez (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:34:55 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43148 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgC2Uez (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 16:34:55 -0400
Received: by mail-qv1-f68.google.com with SMTP id c28so7879502qvb.10
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2b0xzkd30Tdnp0DHxUABxhuUeWWD2ROAH6gqttlcUCU=;
        b=JCqFraqHiX1zOATf+ijPRAXWlGEwk8UMHaDyto0bJsex7d7fjOvcvxBKDaIi9eDysh
         lVH6XcEYL7u0fawCY+mg/Ck3MZhz6dO/SdRxIRN2JiOkJG/Vl51YxK4gF827Dfmh1SXA
         eZDEFQBLSMJkHdfEVTnrUHsAll7R0c+fwgeTxOHxYhl8SaT9jxTtnp70HurZUot8bNk1
         CYf2W4xiCmabwM30gD3JP6cR3zbZK+ACiakuVEz4P929W5qby+ssGBAAZ/HXro4ChR7O
         CRHyC+AAaxZ4hkXL1J/GTE1bRRiVUQm9rHJVVR+rA7D9VfWKkGau+Jeh3HAZQhhBHAgu
         ARKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2b0xzkd30Tdnp0DHxUABxhuUeWWD2ROAH6gqttlcUCU=;
        b=oE+2Uu8Tix6ZVOcLh/NQs7oEz/wfYe7uaIp6Lt07lj02fSZiHZdqzJvL0TLTH9pn7c
         yW2OC00Yj5pBrddz5sop7ofI4rah9o94LizkJ2DxxFIi2xsEaod1FfruWN32pHZOXqZW
         01XQQ4gjjXR5Un1cx1hCHepAbG03Nld1oTCwxpvBjSac5WR25hzs4FaVwaqPnQ8rlRXg
         4IS4I+hDQ5L0KQPbA3IkfJJkYegDtogWidfSoscRrDfoXG7NJGFVvzHUrPSEYIJEFgH4
         CqGDdJZLgca3VPMAnMdOGhBd13tYeb+pfW+mu96e3z3GoUfz1rzkMReIjkm7+Coupniq
         CAeg==
X-Gm-Message-State: ANhLgQ0Xzgi8/3VXHgVGW7HRcO+sZLxBuFC5kctnrcNDTGdZUN1W0xpV
        OK7urXrPHJXlv1++HvnPe94=
X-Google-Smtp-Source: ADFU+vsY+ZdKcSbp0enkhRuZdwzqBhMlGrGBBKvrVEQNAkCVOHd1EZOa9KVw1QjeGNDxZpsjvRJzpA==
X-Received: by 2002:ad4:4832:: with SMTP id h18mr9182017qvy.165.1585514093449;
        Sun, 29 Mar 2020 13:34:53 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m67sm8612832qke.101.2020.03.29.13.34.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 29 Mar 2020 13:34:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 2/5] doc: document --recurse-submodules for reset and restore
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200325210943.339240-3-damien.olivier.robert+git@gmail.com>
Date:   Sun, 29 Mar 2020 16:34:50 -0400
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F03FAA2F-EDFB-4497-A4E8-3AC267C779FC@gmail.com>
References: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com> <20200325210943.339240-3-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 25 mars 2020 =C3=A0 17:09, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Also unify the formulation about --no-submodules

that should be '--no-recurse-submodules'

> for checkout and
> switch, which we reuse for restore.
>=20
> And correct the formulation about submodules' HEAD in read-tree, which
> we reuse in reset.
>=20
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
> Documentation/git-checkout.txt  |  2 +-
> Documentation/git-read-tree.txt |  2 +-
> Documentation/git-reset.txt     |  6 ++++++
> Documentation/git-restore.txt   | 11 +++++++++++
> Documentation/git-switch.txt    |  2 +-
> 5 files changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-checkout.txt =
b/Documentation/git-checkout.txt
> index c8fb995fa7..140bd3eabb 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -296,7 +296,7 @@ Note that this option uses the no overlay mode by =
default (see also
> 	submodules according to the commit recorded in the superproject. =
If
> 	local modifications in a submodule would be overwritten the =
checkout
> 	will fail unless `-f` is used. If nothing (or =
`--no-recurse-submodules`)
> -	is used, the work trees of submodules will not be updated.
> +	is used, submodules working trees will not be updated.
> 	Just like linkgit:git-submodule[1], this will detach `HEAD` of =
the
> 	submodule.
>=20
> diff --git a/Documentation/git-read-tree.txt =
b/Documentation/git-read-tree.txt
> index da33f84f33..807cad4691 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -118,7 +118,7 @@ OPTIONS
> --[no-]recurse-submodules::
> 	Using --recurse-submodules will update the content of all =
initialized
> 	submodules according to the commit recorded in the superproject =
by
> -	calling read-tree recursively, also setting the submodules HEAD =
to be
> +	calling read-tree recursively, also setting the submodules' =
HEADs to be

I've rethought about that and I think it should be "submodules' HEAD" =
(sorry!)

> 	detached at that commit.
>=20
> --no-sparse-checkout::
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 932080c55d..d7a09f11a0 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -87,6 +87,12 @@ but carries forward unmerged index entries.
> 	different between `<commit>` and `HEAD`.
> 	If a file that is different between `<commit>` and `HEAD` has =
local
> 	changes, reset is aborted.
> +
> +--[no-]recurse-submodules::
> +	When the working tree is updated, using --recurse-submodules =
will
> +	also recursively reset the working tree of all active submodules
> +	according to the commit recorded in the superproject, also =
setting
> +	the submodules' HEADs to be detached at that commit.

same here

> --
>=20
> See "Reset, restore and revert" in linkgit:git[1] for the differences
> diff --git a/Documentation/git-restore.txt =
b/Documentation/git-restore.txt
> index 5bf60d4943..8e3b339802 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -107,6 +107,17 @@ in linkgit:git-checkout[1] for details.
> 	patterns and unconditionally restores any files in
> 	`<pathspec>`.
>=20
> +--recurse-submodules::
> +--no-recurse-submodules::
> +	If `<pathspec>` names an active submodule and the restore =
location
> +	includes the working tree, the submodule will only be updated if
> +	this option is given, in which case its working tree will be
> +	restored to the commit recorded in the superproject, and any =
local
> +	modifications overwritten. If nothing (or
> +	`--no-recurse-submodules`) is used, submodules working trees =
will
> +	not be updated. Just like linkgit:git-checkout[1], this will =
detach
> +	`HEAD` of the submodule.
> +
> --overlay::
> --no-overlay::
> 	In overlay mode, the command never removes files when
> diff --git a/Documentation/git-switch.txt =
b/Documentation/git-switch.txt
> index 197900363b..79dbc9624d 100644
> --- a/Documentation/git-switch.txt
> +++ b/Documentation/git-switch.txt
> @@ -183,7 +183,7 @@ name, the guessing is aborted.  You can explicitly =
give a name with
> 	Using `--recurse-submodules` will update the content of all
> 	initialized submodules according to the commit recorded in the
> 	superproject. If nothing (or `--no-recurse-submodules`) is
> -	used, the work trees of submodules will not be updated. Just
> +	used, submodules working trees will not be updated. Just
> 	like linkgit:git-submodule[1], this will detach `HEAD` of the
> 	submodules.
>=20
> --=20
> Patched on top of v2.26.0 (git version 2.25.2)
>=20

