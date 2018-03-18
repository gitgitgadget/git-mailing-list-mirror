Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406211F404
	for <e@80x24.org>; Sun, 18 Mar 2018 04:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbeCREBi (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 00:01:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57394 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeCREBi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 00:01:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D053D99AE;
        Sun, 18 Mar 2018 00:01:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=xt8UKqo5VhwG9xWE/w3PJoKjMoM
        =; b=QxIjEJUGF41Go3rHjRkEXft47e31L3wI8h9E08rUwyHFUQljuuzjarD8xln
        aWYdQsUbAgzTjkDVw9Ucp4Il0x6LNczlCwQpnbbxht0Q6/NSPXm0PPC+y0wRpMqI
        zUVj095R6LBLUPzjjnGu22fjzTDZxDZ7wxLZlCD+tpYFNyoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=oDOWYJvmI96+IzxdMhPzh
        Ub44WwlgfEiC4qupGuaaJReq+Ty5xtH3O9QdjYbBYOOrwfcdDWEHja+3WbGujRI5
        m/xLNEih6KwUl070JPwyZTluGXW++N/16decajPDUCVc1UW9v2WKtGjMHaeFotuF
        lgCFuTz5WbM/CTJbN8oDug=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34BFDD99AD;
        Sun, 18 Mar 2018 00:01:37 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DC0CD99AC;
        Sun, 18 Mar 2018 00:01:36 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] completion: complete tags with git tag --delete/--verify
Date:   Sun, 18 Mar 2018 00:01:35 -0400
Message-Id: <20180318040135.30710-1-tmz@pobox.com>
X-Mailer: git-send-email 2.17.0.rc0
X-Pobox-Relay-ID: 0DD9899C-2A61-11E8-82C4-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completion of tag names has worked for the short -d/-v options since
88e21dc746 ("Teach bash about completing arguments for git-tag",
2007-08-31).  The long options were not added to "git tag" until many
years later, in c97eff5a95 ("git-tag: introduce long forms for the
options", 2011-08-28).

Extend tag name completion to --delete/--verify.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6da95b8095..c7957f0a90 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2967,7 +2967,7 @@ _git_tag ()
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
-		-d|-v)
+		-d|--delete|-v|--verify)
 			__gitcomp_direct "$(__git_tags "" "$cur" " ")"
 			return
 			;;
-- 
2.17.0.rc0

