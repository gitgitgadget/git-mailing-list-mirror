Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C492720133
	for <e@80x24.org>; Fri,  3 Mar 2017 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdCCTdG (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 14:33:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63356 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751551AbdCCTdF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 14:33:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC61364205;
        Fri,  3 Mar 2017 14:10:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8jF+awd2nb47BZSEUWmwQB3ODI4=; b=yZzDdj
        r1RHt54hP1GGDoPHcqHeY6VavyMXJCXcnKOtOwf4MmucsMYGm3/KLtXiDAgff3SH
        40nPazS0qRowLBt9kEbUtIGCVOi3zO/sEBGRwte/4quJIk0S4MPHkB6Pv9gYKQGt
        FcrMn38I/bgXC31M96ejCvR7Uggy/2CySiWuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XlwJX9TohkyZ6Ew/KrPIo9WgAIoxMjQq
        o+bCt3y0rCTyTrcfFzGwrlENFNxHEsfXXkBka/5fxAycMgIzD2AIJWmOZ7jJg/85
        /wdMK6Ofhgaap1cF0zZ9pj7bD4O0HoYsOROGUDVkfRk2oEAaUlr0/YfzkQfrNe9H
        F7bMr84pCDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C37F464204;
        Fri,  3 Mar 2017 14:10:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DCCC64201;
        Fri,  3 Mar 2017 14:10:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Do not require Python for the git-remote-{bzr,hg} placeholder scripts
References: <0102015a93d18443-c574aaf8-5656-49e8-8848-810e1fadc87a-000000@eu-west-1.amazonses.com>
        <a9273d37-388a-8c27-1cf1-51e9cb28ef55@xiplink.com>
Date:   Fri, 03 Mar 2017 11:10:03 -0800
In-Reply-To: <a9273d37-388a-8c27-1cf1-51e9cb28ef55@xiplink.com> (Marc
        Branchaud's message of "Fri, 3 Mar 2017 10:32:29 -0500")
Message-ID: <xmqqtw7a89dg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02742400-0045-11E7-9ACC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 2017-03-03 05:57 AM, Sebastian Schuberth wrote:
>> It does not make sense for these placeholder scripts to depend on Python
>> just because the real scripts do. At the example of Git for Windows, we
>> would not even be able to see those warnings as it does not ship with
>> Python. So just use plain shell scripts instead.
>
> Just a niggle:  This change moves the warning message from stderr to stdout.

Right.  Here is what I'll queue.

-- >8 --
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Fri, 3 Mar 2017 10:57:46 +0000
Subject: [PATCH] contrib: git-remote-{bzr,hg} placeholders don't need Python

It does not make sense for these placeholder scripts to depend on Python
just because the real scripts do. At the example of Git for Windows, we
would not even be able to see those warnings as it does not ship with
Python. So just use plain shell scripts instead.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/remote-helpers/git-remote-bzr | 16 +++++++---------
 contrib/remote-helpers/git-remote-hg  | 16 +++++++---------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 712a1377e2..ccc4aea362 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -1,13 +1,11 @@
-#!/usr/bin/env python
+#!/bin/sh
 
-import sys
-
-sys.stderr.write('WARNING: git-remote-bzr is now maintained independently.\n')
-sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-bzr\n')
-
-sys.stderr.write('''WARNING:
+cat >&2 <<'EOT'
+WARNING: git-remote-bzr is now maintained independently.
+WARNING: For more information visit https://github.com/felipec/git-remote-bzr
+WARNING:
 WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-bzr \\
+WARNING:   $ wget -O $HOME/bin/git-remote-bzr \
 WARNING:     https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
 WARNING:   $ chmod +x $HOME/bin/git-remote-bzr
-''')
+EOT
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 4255ad6312..dfda44f311 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -1,13 +1,11 @@
-#!/usr/bin/env python
+#!/bin/sh
 
-import sys
-
-sys.stderr.write('WARNING: git-remote-hg is now maintained independently.\n')
-sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-hg\n')
-
-sys.stderr.write('''WARNING:
+cat >&2 <<'EOT'
+WARNING: git-remote-hg is now maintained independently.
+WARNING: For more information visit https://github.com/felipec/git-remote-hg
+WARNING:
 WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-hg \\
+WARNING:   $ wget -O $HOME/bin/git-remote-hg \
 WARNING:     https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
 WARNING:   $ chmod +x $HOME/bin/git-remote-hg
-''')
+EOT
-- 
2.12.0-368-g85767a6c71

