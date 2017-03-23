Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846C120958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965088AbdCWP3t (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36487 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964956AbdCWP3o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:44 -0400
Received: by mail-wr0-f195.google.com with SMTP id l37so31602645wrc.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TiWJEmKg4GONmY9wN2rGNY1tW/FWV8lubmpAUW0mYm8=;
        b=UL0YnImrYvibhJYPpOxyE7PUnakdA0Me2+skS8N0xdh/U2KhvPaEdauSyD8GwI8Efj
         AtHO34MdDk2MY/aGJQq4N0x/KQtPVLMvTfYWlgFpGiuuR6/rJttyvXugByBGDVEL01iV
         4WarUrxz+qqk+mvGt48UwCmrbNuN5DFxvdhmAUyCs1hqEU9RbMUML+ew8KizijhUea1Z
         dd2jOPVY+Wf1mbdGF5IynKxeJ4aUBrDWDe5563TTVfrBltSTlhwm3tpUlL2P+0QFjaoH
         ZhIcEwRi/jKiZ2EgknQXPJTXBDbhW6m9WLKgF0HKBG0wnA1FHR3Q81U46OyROkeP1F0m
         S4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TiWJEmKg4GONmY9wN2rGNY1tW/FWV8lubmpAUW0mYm8=;
        b=gCHHaw3urQfhq8ykcCSAl9Oo39rPk84vcAjkmrqhfTIjzfDnvwQ/rNPjVpv1mL42IK
         AODQHtV5vSyK4jlgAn+PpxrA7G3T7YPKixvzfNIzWMqBsAOjNhQ2hXodzcvgXoqPNxkO
         OuGINnmaqcrc9FXOe+TmPJNNA7OQ66tjs/1GFMIFdUrojB3mDYrC8hZwYWIQGS/xh/om
         Z0J6fH12CPOUChXJhETbwEa0Ukvy54q8AcaEkfAS01JA9IdhUsbyiTKceCc/qTqkDtUK
         H5mdJDuK220nRWrDr9soRVv9UsJjPRLbyBT0BUiqU/9Fzk18fUUcP8Qb51aMN2+GYT3v
         gVaA==
X-Gm-Message-State: AFeK/H0YT+Ju3IzRadau/UYVS+0TMdYquztLTR3bqUTGTiCNhc5usR3rSTfzyyz3iJpX8w==
X-Received: by 10.223.156.2 with SMTP id f2mr3133711wrc.176.1490282982192;
        Thu, 23 Mar 2017 08:29:42 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:41 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 07/14] completion: don't disambiguate short refs
Date:   Thu, 23 Mar 2017 16:29:17 +0100
Message-Id: <20170323152924.23944-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the completion script lists short refs it does so using the 'git
for-each-ref' format 'refname:short', which makes sure that all listed
refs are unambiguous.  While disambiguating refs is technically
correct in this case, as opposed to the cases discussed in the
previous patch, this disambiguation involves several stat() syscalls
for each ref, thus, unfortunately, comes at a steep cost especially on
Windows and/or when there are a lot of refs to be listed.  A user of
Git for Windows reported[1] 'git checkout <TAB>' taking ~11 seconds in
a repository with just about 4000 refs.

However, it's questionable whether ambiguous refs are really that bad
to justify that much extra cost:

  - Ambiguous refs are not that common,
  - even if a repository contains ambiguous refs, they only hurt when
    the user actually happens to want to do something with one of the
    ambiguous refs, and
  - the issue can be easily circumvented by renaming those ambiguous
    refs.

  - On the other hand, apparently not that many refs are needed to
    make refs completion unacceptably slow on Windows,
  - and this slowness bites each and every time the user attempts refs
    completion, even when the repository doesn't contain any ambiguous
    refs.
  - Furthermore, circumventing the issue might not be possible or
    might be considerably more difficult and requires various
    trade-offs (e.g. working in a repository with only a few selected
    important refs while keeping a separate repository with all refs
    for reference).

Arguably, in this case the benefits of technical correctness are
rather minor compared to the price we pay for it, and we are better
off opting for performance over correctness.

Use the 'git for-each-ref' format 'refname:strip=2' to list short refs
to spare the substantial cost of disambiguating.

This speeds up refs completion considerably.  Uniquely completing a
branch in a repository with 100k local branches, all packed, best of
five:

  On Linux, before:

    $ time __git_complete_refs --cur=maste

    real    0m1.662s
    user    0m1.368s
    sys     0m0.296s

  After:

    real    0m0.831s
    user    0m0.808s
    sys     0m0.028s

  On Windows, before:

    real    0m12.457s
    user    0m1.016s
    sys     0m0.092s

  After:

    real    0m1.480s
    user    0m1.031s
    sys     0m0.060s

[1] - https://github.com/git-for-windows/git/issues/524

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e129f674e..5ee35d530 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -401,7 +401,7 @@ __git_refs ()
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
 				if [ -e "$dir/$i" ]; then echo $pfx$i; fi
 			done
-			format="refname:short"
+			format="refname:strip=2"
 			refs="refs/tags refs/heads refs/remotes"
 			;;
 		esac
@@ -412,7 +412,7 @@ __git_refs ()
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			local ref entry
-			__git for-each-ref --shell --format="ref=%(refname:short)" \
+			__git for-each-ref --shell --format="ref=%(refname:strip=2)" \
 				"refs/remotes/" | \
 			while read -r entry; do
 				eval "$entry"
@@ -437,7 +437,7 @@ __git_refs ()
 	*)
 		if [ "$list_refs_from" = remote ]; then
 			echo "HEAD"
-			__git for-each-ref --format="%(refname:short)" \
+			__git for-each-ref --format="%(refname:strip=2)" \
 				"refs/remotes/$remote/" | sed -e "s#^$remote/##"
 		else
 			__git ls-remote "$remote" HEAD \
-- 
2.12.1.485.g1616aa492

