Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F7331F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbdBCCyo (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:44 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35220 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbdBCCyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so1192551wmu.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJERP2ZqHz9T1k8X0BkmKpQ6bVzgPVmr3XjZHuhQWd4=;
        b=Z8pFX+8jKj+MRzDj9g3DKaYrL8+L3SKnDexOx2kyc3J66ldy96d9Yu0DL4ofy12X3C
         6D7sNiEOzbu7twfsAHTUPHxcJQNL3U1xCbFDxbICLw0XhJYy5W4C7yFkh0v9tXp5wZyD
         9G43vZtNyoJTp5P/W+G2+MNL+PPhWP9ntQiFbTsyuoTrjFAmBMX+ZNI0Al/GKAsWOHJp
         fRawj+F4CAkp8mmQXgb5h22t3SgGUdIxAlvQpefe3kg7GZ7Nvp0Hy5VSoD5W1CGhtqiF
         jDqePepJAPt+1qJrgXCeGvfoJoEV+fGjG3vHRONTLRT7M2/+NDxTL+2CiY7eSYJ0tyez
         FJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJERP2ZqHz9T1k8X0BkmKpQ6bVzgPVmr3XjZHuhQWd4=;
        b=sieVFeJOYxXe9rOWyLXsPEnB1hhy5vb/egFwDsBZk+qDn2k006pbvjd4oCm1AOSqht
         0n0vbeG5Aqxu9dIXp+CkRP38UCueSMYEgsthFc9mPOQCqnteerfEtVXELE6ay1oin0rD
         ML4mqJEDxwGmR/EZv1C0JEUv7ZvyYE9lC0jccVBppVY6w8r3gah1zEeTdpxQUo78wy69
         iu/eV6XSnI/5ah+d6w5jRregc39/JNRlaLu1JbqKpui0z8I2rpkGXN5aucgNO+VsWY2E
         sOB4M0Sa/S10velk3ijrOJB0H0uwTzjMvS/0Yz2h+jwlS5Yaj73ysQA0XEqlw7WDb6B/
         wTfg==
X-Gm-Message-State: AIkVDXIpr4f+DyIWaB9Ijlk9npXNsLqhTxZIe9axtisqD1SV+N8D31H4KIzGbTc2/dz2gA==
X-Received: by 10.223.135.8 with SMTP id a8mr11891199wra.162.1486090470130;
        Thu, 02 Feb 2017 18:54:30 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:29 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 06/12] completion: don't disambiguate short refs
Date:   Fri,  3 Feb 2017 03:53:59 +0100
Message-Id: <20170203025405.8242-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
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
index 19799e3ba..d55eadfd1 100644
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
2.11.0.555.g967c1bcb3

