Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 734AE1F428
	for <e@80x24.org>; Thu, 14 Dec 2017 21:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbdLNVJL (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:09:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64926 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752361AbdLNVJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:09:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71AB1C99DC;
        Thu, 14 Dec 2017 16:09:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FPHhsBicbwXMZaRmjCFwKzlW7dY=; b=Eir8BP
        lINOwf7Wos1rDsOTZBbED8AsAcq5vYsdPCIhkye8sPj4O6IKlPjRz7YIaif1J3Tp
        PlZ5vMbw2xZIKwCzSE+azshcFWFd6MwMI84vYlO7szm3cmIhBWKJqF/NRj4xqbFr
        66JsKS/LSa1dYbr6ctadC0IhUagRua8PXJlmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=laL/8fquv5VfXYjB5wKpnIHw9vIygQG5
        UN0ATWicquGgQ3Ue9NEuSIMQoksIAKafhVDd+nB6RMmEdMicMZ8i8/fdNeh/5XnK
        NadfB5/WD6B2tUzUXIUrlm3KXaMCUFVLVirjGCN5O5KHMFQYASzRrJMSg5R83zCR
        z994DuGj1j0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 689F0C99DB;
        Thu, 14 Dec 2017 16:09:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1C0DC99DA;
        Thu, 14 Dec 2017 16:09:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v4 2/3] rebase: distinguish user input by quoting it
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
        <1513255038.6351.2.camel@gmail.com>
        <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 14 Dec 2017 13:09:08 -0800
In-Reply-To: <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 14 Dec 2017 09:20:38 -0800")
Message-ID: <xmqqwp1prp8r.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 070997DE-E113-11E7-87DB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Mon, 27 Nov 2017 22:51:03 +0530

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 5526b17a36..e5adb596a0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -477,7 +477,7 @@ then
 		;;
 	esac
 	upstream=$(peel_committish "${upstream_name}") ||
-	die "$(eval_gettext "invalid upstream \$upstream_name")"
+	die "$(eval_gettext "invalid upstream '\$upstream_name'")"
 	upstream_arg="$upstream_name"
 else
 	if test -z "$onto"
@@ -539,7 +539,7 @@ case "$#" in
 		head_name="detached HEAD"
 
 	else
-		die "$(eval_gettext "fatal: no such branch/commit: \$branch_name")"
+		die "$(eval_gettext "fatal: no such branch/commit '\$branch_name'")"
 	fi
 	;;
 0)
-- 
2.15.1-554-g7ec1e7e2b9

