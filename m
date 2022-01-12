Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB977C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbiALTUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:20:48 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:43814 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiALTUr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:20:47 -0500
Received: by mail-pl1-f181.google.com with SMTP id e19so5538503plc.10
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNrMQLLBhG3qvpjVCGMNDh6PsjmIXzi7y+OKgIi2gsY=;
        b=zWbm36J42mlauZSGTX1XDgXmoKrzqfW3mD1CkAqXnILyOhAjG3RR7CZlhIESFzoruM
         gIkrDaZz4Xy1FgVnQXGAQnqayFlw7r1FVDrnKih9Tqn4XkXn904FvIHPgfNjyYox8uV+
         T/Q/hSzI/l7ZpqFKqg6JWYpAvz8+7uucOOiOgYzwRKWo4tQf+dIVVXzg0cvP+m6oWH83
         i45Hq8NXQAU818GzWp4g+UY0BdPD3Wk4nWVuF8Mm/H9/dznZCrfEPpWHCdv1lr7/0pOw
         I2HlvXn5oLbcTqk+hFtz42hFpc69/ePPHaITMfK9tNvGwH9LdDfEWeujMe1yvNxh5YJN
         noRg==
X-Gm-Message-State: AOAM532ZjycXtq92D41g2vRDNTKBwznnwu1N2MkWwCER6N76QWaRXvDF
        UGeR/w5nNqSBMRJfmJzk3IotamK1tnNK5RedsA/xdj60
X-Google-Smtp-Source: ABdhPJxdKDw7h7XwMtOT4kyvckHZ0U3AKGIzHn26NCjkJYOwCw4fzouZvunEdZF0vb+LvgWwFp4kNaZYHJCOFboki0c=
X-Received: by 2002:aa7:8d02:0:b0:4c1:b464:9826 with SMTP id
 j2-20020aa78d02000000b004c1b4649826mr758055pfe.67.1642015247139; Wed, 12 Jan
 2022 11:20:47 -0800 (PST)
MIME-Version: 1.0
References: <20220112134635.177877-1-jholdsworth@nvidia.com> <20220112134635.177877-5-jholdsworth@nvidia.com>
In-Reply-To: <20220112134635.177877-5-jholdsworth@nvidia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Jan 2022 14:20:36 -0500
Message-ID: <CAPig+cQodfguFukatAN73Z1VvgCQqyFpUOkExvprmwhL55Zt1g@mail.gmail.com>
Subject: Re: [PATCH 04/20] git-p4: improve consistency of docstring formatting
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 8:47 AM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> This patch attempts to improve the consistency of the docstrings by
> making the following changes:
>
>   - Rewraps all docstrings to a 79-character column limit.
>   - Adds a full stop at the end of every docstring.
>   - Removes any spaces after the opening triple-quotes of all
>     docstrings.
>   - Sets the hanging indent of multi-line docstrings to 3-spaces.
>   - Ensures that the closing triple-quotes of multi-line docstrings are
>     always on a new line indented by a 3-space indent.

A couple very minor comments below... probably not worth a re-roll.

> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -271,20 +271,20 @@ def run_git_hook(cmd, param=[]):
>  def run_hook_command(cmd, param):
>      """Executes a git hook command

Missing full-stop (as described by the commit message)?

> -       cmd = the command line file to be executed. This can be
> -       a file that is run by OS association.
>
> -       param = a list of parameters to pass to the cmd command
> +       cmd -- the command line file to be executed.  This can be a file that
> +           is run by OS association.
> +
> +       param -- a list of parameters to pass to the cmd command

These were changed from `=` to `--` (double hyphen), which is fine, but...

> @@ -715,21 +718,22 @@ def getGitTags():
>  def parseDiffTreeEntry(entry):
>      """Parses a single diff tree entry into its component elements.
>
> +       See git-diff-tree(1) manpage for details about the format of the diff
> +       output. This method returns a dictionary with the following elements:
> +
> +       src_mode - The mode of the source file
> +       dst_mode - The mode of the destination file
> +       src_sha1 - The sha1 for the source file
> +       dst_sha1 - The sha1 fr the destination file
> +       status - The one letter status of the diff (i.e. 'A', 'M', 'D', etc)
> +       status_score - The score for the status (applicable for 'C' and 'R'
> +                      statuses). This is None if there is no score.
> +       src - The path for the source file.
> +       dst - The path for the destination file. This is only present for
> +             copy or renames. If it is not present, this is None.

... these just use `-` (single hyphen).

> +       If the pattern is not matched, None is returned.
> +       """
