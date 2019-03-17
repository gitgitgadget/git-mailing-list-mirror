Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572B220248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCQSQn (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:16:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64173 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQSQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:16:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C15E6117E;
        Sun, 17 Mar 2019 14:16:41 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Kn9416gq4Y08
        kXKQoYqGoNeeWdI=; b=URkfy4aPF3GQAo1kWRvTD7nJJu0DAg6Wkks9s1by3StF
        uLD93vkxdNO37EXXYjf4nwiq/4KFN7dzIXqtOXuyDXVPmIq6xS3RZl9z8HYkW2Do
        /cEbFmPNyouZ2MXvzwO/Zzo1DBu/JtZ7bNtgSZP2Xdkd1M0XVxU5MWu43yc56s0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iqtgGR
        9BomQC5kY7XOzbkRLtUpM1Qh31SqxKR4I975eel69ub3bNrgBGWSFsTRX1l6ZSSi
        l3SbTxc2J8s+rkjaVw+GM9CXJyazq7aHOStYQCbbkoPlO4AEinHzvgrwnwROvUsv
        DkSExiF676Q39RwhcQeURBmSqSXn9JKL+wElI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 046606117D;
        Sun, 17 Mar 2019 14:16:41 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67B1661179;
        Sun, 17 Mar 2019 14:16:36 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] completion: use __git when calling --list-cmds
Date:   Sun, 17 Mar 2019 14:16:20 -0400
Message-Id: <20190317181620.26727-5-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
References: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: CE23A90A-48E0-11E9-B462-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since e51bdea6d3 ("git: read local config in --list-cmds", 2019-03-01),
the completion.commands variable respects repo-level configuration.  Use
__git which ensures that the proper repo config is consulted if the
command line contains 'git -C /some/other/repo'.

Suggested-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Junio, I referenc the commit id for "git: read local config in
--list-cmds" which is earlier in this series, so the id will, of
course, differ when you apply it.  Let me know if you'd prefer
this commit to be dropped and resent once the others in the
series are applied or if it's easy for you to adjust when it's
queued.

Also, as I wrote in an earlier reply, at the moment, I think
using __git only matters for calls where config is in the
--list-cmds list.  But since Jeff's fix affects all --list-cmds
calls, it seems prudent to adjust the 3 other uses of --list-cmds
in the completion script.

 contrib/completion/git-completion.bash | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
index 499e56f83d..e505f04ff7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1010,7 +1010,7 @@ __git_all_commands=3D
 __git_compute_all_commands ()
 {
 	test -n "$__git_all_commands" ||
-	__git_all_commands=3D$(git --list-cmds=3Dmain,others,alias,nohelpers)
+	__git_all_commands=3D$(__git --list-cmds=3Dmain,others,alias,nohelpers)
 }
=20
 # Lists all set config variables starting with the given section prefix,
@@ -1620,9 +1620,9 @@ _git_help ()
 	esac
 	if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
 	then
-		__gitcomp "$GIT_TESTING_ALL_COMMAND_LIST $(git --list-cmds=3Dalias,lis=
t-guide) gitk"
+		__gitcomp "$GIT_TESTING_ALL_COMMAND_LIST $(__git --list-cmds=3Dalias,l=
ist-guide) gitk"
 	else
-		__gitcomp "$(git --list-cmds=3Dmain,nohelpers,alias,list-guide) gitk"
+		__gitcomp "$(__git --list-cmds=3Dmain,nohelpers,alias,list-guide) gitk=
"
 	fi
 }
=20
@@ -2888,7 +2888,7 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(git --list-cmds=3Dlist-mainporcelain,others,nohelpers,a=
lias,list-complete,config)"
+				__gitcomp "$(__git --list-cmds=3Dlist-mainporcelain,others,nohelpers=
,alias,list-complete,config)"
 			fi
 			;;
 		esac
