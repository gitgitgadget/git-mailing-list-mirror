Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 870C220133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbdCCPmo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:42:44 -0500
Received: from smtp66.iad3a.emailsrvr.com ([173.203.187.66]:40823 "EHLO
        smtp66.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752050AbdCCPmA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 10:42:00 -0500
Received: from smtp17.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp17.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id E115D25E3F;
        Fri,  3 Mar 2017 10:32:29 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp17.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id BA1D226060;
        Fri,  3 Mar 2017 10:32:29 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 03 Mar 2017 10:32:29 -0500
Subject: Re: [PATCH] Do not require Python for the git-remote-{bzr,hg}
 placeholder scripts
To:     Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
References: <0102015a93d18443-c574aaf8-5656-49e8-8848-810e1fadc87a-000000@eu-west-1.amazonses.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <a9273d37-388a-8c27-1cf1-51e9cb28ef55@xiplink.com>
Date:   Fri, 3 Mar 2017 10:32:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <0102015a93d18443-c574aaf8-5656-49e8-8848-810e1fadc87a-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-03-03 05:57 AM, Sebastian Schuberth wrote:
> It does not make sense for these placeholder scripts to depend on Python
> just because the real scripts do. At the example of Git for Windows, we
> would not even be able to see those warnings as it does not ship with
> Python. So just use plain shell scripts instead.

Just a niggle:  This change moves the warning message from stderr to stdout.

		M.

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-bzr | 16 +++++++---------
>  contrib/remote-helpers/git-remote-hg  | 16 +++++++---------
>  2 files changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index 712a137..ccc4aea 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -1,13 +1,11 @@
> -#!/usr/bin/env python
> +#!/bin/sh
>
> -import sys
> -
> -sys.stderr.write('WARNING: git-remote-bzr is now maintained independently.\n')
> -sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-bzr\n')
> -
> -sys.stderr.write('''WARNING:
> +cat <<'EOT'
> +WARNING: git-remote-bzr is now maintained independently.
> +WARNING: For more information visit https://github.com/felipec/git-remote-bzr
> +WARNING:
>  WARNING: You can pick a directory on your $PATH and download it, e.g.:
> -WARNING:   $ wget -O $HOME/bin/git-remote-bzr \\
> +WARNING:   $ wget -O $HOME/bin/git-remote-bzr \
>  WARNING:     https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
>  WARNING:   $ chmod +x $HOME/bin/git-remote-bzr
> -''')
> +EOT
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 4255ad6..dfda44f 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -1,13 +1,11 @@
> -#!/usr/bin/env python
> +#!/bin/sh
>
> -import sys
> -
> -sys.stderr.write('WARNING: git-remote-hg is now maintained independently.\n')
> -sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-hg\n')
> -
> -sys.stderr.write('''WARNING:
> +cat <<'EOT'
> +WARNING: git-remote-hg is now maintained independently.
> +WARNING: For more information visit https://github.com/felipec/git-remote-hg
> +WARNING:
>  WARNING: You can pick a directory on your $PATH and download it, e.g.:
> -WARNING:   $ wget -O $HOME/bin/git-remote-hg \\
> +WARNING:   $ wget -O $HOME/bin/git-remote-hg \
>  WARNING:     https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
>  WARNING:   $ chmod +x $HOME/bin/git-remote-hg
> -''')
> +EOT
>
> --
> https://github.com/git/git/pull/333
>
