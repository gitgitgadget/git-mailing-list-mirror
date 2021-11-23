Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE23C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 18:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhKWSzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:55:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33182 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhKWSzq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 13:55:46 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8B1521F953;
        Tue, 23 Nov 2021 18:52:37 +0000 (UTC)
Date:   Tue, 23 Nov 2021 18:52:37 +0000
From:   Eric Wong <e@80x24.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
Message-ID: <20211123185237.M476855@dcvr>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> wrote:
> diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
> index 80ae5030a590..8429d45d661c 100644
> --- a/Documentation/maintainer/configure-git.rst
> +++ b/Documentation/maintainer/configure-git.rst

<snip>, +cc git@vger

> @@ -56,7 +56,7 @@ by adding the following hook into your git:
>  	$ cat >.git/hooks/applypatch-msg <<'EOF'
>  	#!/bin/sh
>  	. git-sh-setup
> -	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
> +	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Reviewed: https://lore.kernel.org/r/$1|g;' "$1"

Side note: that regexp should match "Message-ID" case-insensitively.
git send-email is an outlier in its capitalization of "Message-Id",
most RFCs capitalize it "Message-ID", as do common MUAs.

git send-email's capitalization does annoy me and I've looked
into changing it; but there's a bunch of tests and probably
dependent code that also need to be updated...
