Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D1AC1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 22:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72062070A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 22:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROPhsek/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCVWga (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 18:36:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37936 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVWg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 18:36:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id z12so10182548qtq.5
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N42JztdTkDFSe6uIu0W+LTIPlnw5yFSSIAJKKC1HQ6c=;
        b=ROPhsek/eIKN8TPd9m1ACCs/uYt0CovaWG8sCfRMyqT6bIz/18JSzMKyhgAKzQMxL5
         VwpUKYvRCSQ32MxBIuXUnWueGHr+6GimAawI1QatWiTqg6fmrD2rE19e6Jxq3luYdpZi
         BJDB3PF5N4V6A55t79q0a37Vsslb8vUlRxHJFMK28qKOLHQWkKyc6PjM+9jQIaQDXI4w
         e1qMG6ojkZPkfhHg5oo9iQ4fc5m45hCmg3eM+TZWkVNvF++cLgHwJ89dwnqc3981H2ks
         RGVdynOjjyRZBEUkXcVCEB6t8G2zhZM6stpQqkn2D2YfKp4iBdISMKaEBc0Ph94yvItp
         RVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N42JztdTkDFSe6uIu0W+LTIPlnw5yFSSIAJKKC1HQ6c=;
        b=CnuAWaLYW/Hmx2ghuKLmQp/tKelYIUOInnsntkGdqbfg/XLBm2WvUzissy13/b9a1M
         +aQZ1j6UlEV7eHDyu1hfvGf99M8K2QAnecEXQQfJkEorxyJYhid0v3qTW9xsfdYSzcEs
         Irnwcl6daRbkQlnbgeM0M3yg0SDdgAMESTKtx9nTmrLSFyDDbhg5UBZaCvyykiOJFTAS
         lACP4fvPawWph42UDkymfjMJYL+SBYEhfGg+olBX8pwrJQ5hY7ahUXlORColr1PS4WBj
         wzFO6lEJGp95jW6t5DknPng8w6JWPCu9XZ9o3vu5XJmyDX7JSi/vxn7/spuKdrZpJvpm
         fHHg==
X-Gm-Message-State: ANhLgQ1rmCeWoBFNH0mKbackGG4qTZ2J+aUF+lzQqEeEuEZ0DUw8i4Ux
        07b7yE3pdtLtGtS0PeKoLQ5Pvh+S
X-Google-Smtp-Source: ADFU+vuM9qx6/XQiL47Lns+yeY0ogfZH0byMOVKpiszNyEDRiKljvji/Hjn21xHg/cpY5J/0MVBoFA==
X-Received: by 2002:aed:38ea:: with SMTP id k97mr19076268qte.66.1584916587187;
        Sun, 22 Mar 2020 15:36:27 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u13sm9683903qku.92.2020.03.22.15.36.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 15:36:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 2/5] doc: document --recurse-submodules for reset and restore
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200320213729.571924-3-damien.olivier.robert+git@gmail.com>
Date:   Sun, 22 Mar 2020 18:36:23 -0400
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <298AFA4F-3D0D-46C7-872A-9B0A0F38E770@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com> <20200320213729.571924-3-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 20 mars 2020 =C3=A0 17:37, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
> Documentation/git-reset.txt   |  6 ++++++
> Documentation/git-restore.txt | 10 ++++++++++
> 2 files changed, 16 insertions(+)
>=20
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 932080c55d..c8623cfc34 100644
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
> +	the submodules HEAD to be detached at that commit.

I *think* that should be "the submodules' HEADs" but I'd prefer that a =
native speaker confirm.

> --
>=20
> See "Reset, restore and revert" in linkgit:git[1] for the differences
> diff --git a/Documentation/git-restore.txt =
b/Documentation/git-restore.txt
> index 5bf60d4943..47f31d4a0f 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -107,6 +107,16 @@ in linkgit:git-checkout[1] for details.
> 	patterns and unconditionally restores any files in
> 	`<pathspec>`.
>=20
> +--recurse-submodules::
> +--no-recurse-submodules::
> +	If `<pathspec>` names a submodule and the restore location =
includes

To be consistent with patch 5, I think that should be "names an active =
submodule".
(restore is in the unpack-trees machinery so that would be correct; I =
checked this behaviour).

> +	the working tree, the submodule will only be updated if this =
option
> +	is given, in which case its working tree will be restored to the
> +	commit recorded in the superproject, and any local modifications
> +	overwritten. If nothing (or `--no-recurse-submodules`) is used,
> +	the work trees of submodules will not be updated. Just like

For consistency I'd use "working trees" here also, as in the first =
sentence.=20
In fact I think it would read better as "submodules working trees will =
not be updated".
