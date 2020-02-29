Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA67C3F2D3
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A06246A2
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 13:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW/GhxAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgB2NIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:08:01 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54052 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgB2NIB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 08:08:01 -0500
Received: by mail-wm1-f53.google.com with SMTP id f15so6382621wml.3
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 05:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2OeFoo4vPFtYXQ5CfkqfbSK3/CLEdYstRlpiN/FzD64=;
        b=aW/GhxAvQHgtkmQgKXLIJr94A4Ky/p2F+Anvj7mwnhLFltpSQrwU9RRkQVtw4vAT5R
         XCrHkUHhvDo5Wgg8AbkLdQfZ0mW51rHiRV2EArT1N63OHDYNyuvn0E77wMFJzkH5kh5s
         prXbZnGB2wBO1W7LwTkHK2x68zF3oGhNYp1fu9n4+sEJR4npcU1NdMqPL6kCczXUqgZf
         SNPyChb/Ty4m1iVnC2H/Xd1pPU+/8rT403vIpneUX6SnDm7lNpaL+hSgJiYaMRxLTzoG
         NG4anOMIDix2EXUVMajsE37b6xpXtlO8bf6xmbGsUfFWevg3PTJNxf9hMuQpx318/hKb
         jVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2OeFoo4vPFtYXQ5CfkqfbSK3/CLEdYstRlpiN/FzD64=;
        b=YuxsmYmrL61bGavZ/OKX83eF9FAWzbi1ulNaisESWuPQu01i0mKlKIPOBvK8kdu8DU
         L2YyVR+yGQYnR7AcTIsvfInK7geT6BZf0fPYev/i6Z+WsgMtr+Fv5QqfZ23L31QCLTC1
         6FHkOQIpu5lbc856rcMgartUla0vUlMvq4yAMpW4mi+zV0I4NgyArpIFgB5q67D4wOTO
         9/B4kVkUrWx4AHzHplHilkgtwAcfg+lkQhlj+yG6ru3GbXPKQDlD4vy1scu3ur5X2/UF
         6AN6TuMVtkIGYuahQH2Ij6YZchCyMGasE62ygUh2RpHr0MLd3hlrJ3qe39uGoPqWnHGo
         UX6g==
X-Gm-Message-State: APjAAAV1+/jG80Q/w3C2EvTO31MXjmLY7F7z7Q+I+EiFHrNHl0Wzt6mA
        iz/rvF2vNjKSMlgx5ony7B0keKmP
X-Google-Smtp-Source: APXvYqyLd+uNVMxE5r4N69K0CuiDnuWONvGuBpL3LD+Fb2NJ08uWbHRQZuP9foX6PbGdUeNL6awByw==
X-Received: by 2002:a1c:791a:: with SMTP id l26mr10108220wme.58.1582981679229;
        Sat, 29 Feb 2020 05:07:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16sm1510726wrj.5.2020.02.29.05.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 05:07:58 -0800 (PST)
Message-Id: <pull.568.git.1582981677312.gitgitgadget@gmail.com>
From:   "Harald van Dijk via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Feb 2020 13:07:57 +0000
Subject: [PATCH] show_one_mergetag: print non-parent in hex form.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Harald van Dijk <harald@gigawatt.nl>,
        Harald van Dijk <harald@gigawatt.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Harald van Dijk <harald@gigawatt.nl>

When a mergetag names a non-parent, which can occur after a shallow
clone, its hash was previously printed as raw data. Print it in hex form
instead.

Signed-off-by: Harald van Dijk <harald@gigawatt.nl>
---
    show_one_mergetag: print non-parent in hex form.
    
    When a mergetag names a non-parent, which can occur after a shallow
    clone, its hash was previously printed as raw data. Print it in hex form
    instead.
    
    Signed-off-by: Harald van Dijk harald@gigawatt.nl [harald@gigawatt.nl]
    
    Before, after a shallow clone of 
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/:
    
    $ git show -s --show-signature
    commit a2f0b878c3ca531a1706cb2a8b079cea3b17bafc (grafted, HEAD -> master, origin/master, origin/HEAD)
    tag kbuild-fixes-v5.6-2 names a non-parent 꼋<CB>)/<B9><A5>u{^L<8A><B7>u^_A<B0><A1>^D<F8>
    No signature
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Thu Feb 27 11:26:33 2020 -0800
    [...]
    
    After:
    
    $ git show -s --show-signature
    commit a2f0b878c3ca531a1706cb2a8b079cea3b17bafc (grafted, HEAD -> master, origin/master, origin/HEAD)
    tag kbuild-fixes-v5.6-2 names a non-parent eabc8bcb292fb9a5757b0c8ab7751f41b0a104f8
    No signature
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Thu Feb 27 11:26:33 2020 -0800

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-568%2Fhvdijk%2Fmergetag-hex-form-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-568/hvdijk/mergetag-hex-form-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/568

 log-tree.c     |  2 +-
 t/t4202-log.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index cae38dcc662..2a2db96d5ec 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -517,7 +517,7 @@ static int show_one_mergetag(struct commit *commit,
 			    "merged tag '%s'\n", tag->tag);
 	else if ((nth = which_parent(&tag->tagged->oid, commit)) < 0)
 		strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
-				    tag->tag, tag->tagged->oid.hash);
+				    tag->tag, oid_to_hex(&tag->tagged->oid));
 	else
 		strbuf_addf(&verify_message,
 			    "parent #%d, tagged '%s'\n", nth + 1, tag->tag);
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 192347a3e1f..20cb436c433 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1634,6 +1634,26 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
 
+test_expect_success GPG 'log --graph --show-signature for merged tag in shallow clone' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b plain-shallow master &&
+	echo aaa >bar &&
+	git add bar &&
+	git commit -m bar_commit &&
+	git checkout --detach master &&
+	echo bbb >baz &&
+	git add baz &&
+	git commit -m baz_commit &&
+	git tag -s -m signed_tag_msg signed_tag_shallow &&
+	hash=$(git rev-parse HEAD) &&
+	git checkout plain-shallow &&
+	git merge --no-ff -m msg signed_tag_shallow &&
+	git clone --depth 1 --no-local . shallow &&
+	test_when_finished "rm -rf shallow" &&
+	git -C shallow log --graph --show-signature -n1 plain-shallow >actual &&
+	grep "tag signed_tag_shallow names a non-parent $hash" actual
+'
+
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	test_config gpg.format x509 &&

base-commit: 2d2118b814c11f509e1aa76cb07110f7231668dc
-- 
gitgitgadget
