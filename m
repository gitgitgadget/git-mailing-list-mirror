Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EEB1FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 11:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdDHLlP (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 07:41:15 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32874 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdDHLlN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 07:41:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id g19so23298358wrb.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIvdMWwwJ7XRdFVAFjcWFdTg70/tm8GPytOkY9bzxTc=;
        b=ObLAX33qkebKTnrfrEpCEtgZQYSJ5gj4Z0EaoRyHcNE+yxhfuz1dqOfnD44SivSieK
         4A6Lla4Zv7Maj9yg/QoHXwCwoC0PkKDt9LrFGc52KM3jIiE4q9A1xJbWr+b38i/wj3Gj
         d+GwqY0wEFBA5AnvXk86GKjZAgObiBkcJJkIhumS7Etk/zUoA8k9Ov24e3XnY0iDEhAP
         3GFOEeP+399Nwp7gloGw3hOszNiLB0n+y2KAEY4QJ0g4/LMAiw8Wqw8PEEWHf38ovfXg
         6dhJiEyK6BLUxvkLrc/qoOZ/rCHd9KXVSnfcCOkbkMC4VFJXC8lMCswskd2jEl713ec/
         gxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIvdMWwwJ7XRdFVAFjcWFdTg70/tm8GPytOkY9bzxTc=;
        b=k8h3ruEUOxXfbnQOq+qyBClPC9bX8bcjpIucASItcG3YiYVhCNi4jl8gvQchtDzswl
         yeB3XARDjI7G6g7pYmpScAYgH0/4GoqCPdjakiJ9HXm8wI6LJw6ifrSOoaO36WWUNsV3
         LhgWHAj3aebjhJqFMvoyjU3bkg0+3AWQzhP9Y/HP5+lsocrApH+NLBSRjhADtbDh8ABz
         kK/iWvua5CcsXuWUdmjfoofOid0vKQg7KLRNzsnwbBz647CSmZeyYBTTnzlTuSP7852I
         CvzQVYMJLQSYHWix/QcdZ9j4sEK07Wd3Lch1xxHu4gW+rIWLvqUDcmDjQ+aGU74hH36i
         hTmg==
X-Gm-Message-State: AN3rC/7gsL1vb6JZAeEAhHZcNtSkLOzdcTUglIJkaXD8A+Sxw2MiEFQPd298tn65NO7ztQ==
X-Received: by 10.223.133.252 with SMTP id 57mr1128166wru.94.1491651671817;
        Sat, 08 Apr 2017 04:41:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b13sm2482144wmf.6.2017.04.08.04.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 04:41:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] push: document & test --force-with-lease with multiple remotes
Date:   Sat,  8 Apr 2017 11:41:00 +0000
Message-Id: <20170408114100.13743-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <487622bf-00d0-e4fc-4a74-08e18d59336a@gmail.com>
References: <487622bf-00d0-e4fc-4a74-08e18d59336a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document & test for cases where there are two remotes pointing to the
same URL, and a background fetch & subsequent `git push
--force-with-lease` shouldn't clobber un-updated references we haven't
fetched.

Some editors like Microsoft's VSC have a feature to auto-fetch in the
background, this bypasses the protections offered by
--force-with-lease as noted in the documentation being added here.

See the 'Tools that do an automatic fetch defeat "git push
--force-with-lease"' (<1491617750.2149.10.camel@mattmccutchen.net>)
git mailing list thread for more details. Jakub Narębski suggested
this method of adding another remote to bypass this edge case,
document that & add a test for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sat, Apr 8, 2017 at 11:29 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 08, 2017 at 09:35:04AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> Is it correct that you'd essentially want something that works like:
>>
>>     git push --force-with-lease=master:master origin master:master
>
> I don't think that would do anything useful. It would reject any push
> where the remote "master" is not the same as your own master. And of
> course if they _are_ the same, then the push is a noop.
>

Yeah my whole suggestion is obviously dumb & useless. But I liked
Jakub's suggestion to work around this, so here's docs & a test for
that.

According to my eyeballing of the MS VSC code this should work,
i.e. it seems to do a 'fetch' here, not a 'fetch --all':
https://github.com/Microsoft/vscode/blob/master/src/vs/workbench/parts/git/node/git.lib.ts#L505

Of course another way is to just disable autofetching:
https://github.com/Microsoft/vscode/blob/535a3de60023c81d75d0eac22044284f07dbcddf/extensions/git/src/autofetch.ts#L27

But having two remotes allows you to have your cake & eat it too
without all the hassle of tag creation, which I've added to the docs
though for completeness.

 Documentation/git-push.txt | 37 +++++++++++++++++++++++++++++++++++++
 t/t5533-push-cas.sh        | 29 +++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 1624a35888..2f2e9c078b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -210,6 +210,43 @@ or we do not even have to have such a remote-tracking branch when
 this form is used).  If `<expect>` is the empty string, then the named ref
 must not already exist.
 +
+This option interacts very badly with anything that implicitly runs
+`git fetch` on the remote to be pushed to in the background. The
+protection it offers over `--force` is ensuring that subsequent
+changes your work wasn't based on aren't clobbered, but this is
+trivially defeated if some background process is updating refs in the
+background. We don't have anything except the remote tracking info to
+go by as a heuristic for refs you're expected to have seen & are
+willing to clobber.
++
+If your editor or some other system is running `git fetch` in the
+background for you a way to mitigate this is to simply set up another
+remote:
++
+	git remote add origin-push $(git config remote.origin.url)
+	git fetch origin-push
++
+Now when the background process runs `git fetch origin` the references
+on `origin-push` won't be updated, and thus commands like:
++
+	git push --force-with-lease origin
++
+Will fail unless you manually run `git fetch origin-push`. This method
+is of course entirely defeated by something that runs `git fetch
+--all`, in that case you'd need to either disable it or do something
+more tedious like:
++
+	git fetch              ;# update 'master' from remote
+	git tag base master    ;# mark our base point
+	git rebase -i master   ;# rewrite some commits
+	git push --force-with-lease=master:base master:master
++
+I.e. create a `base` tag for versions of the upstream code that you've
+seen and are willing to overwrite, then rewrite history, and finally
+force push changes to `master` if the remote version is still at
+`base`, regardless of what your local `remotes/origin/master` has been
+updated to in the background.
++
 Note that all forms other than `--force-with-lease=<refname>:<expect>`
 that specifies the expected current value of the ref explicitly are
 still experimental and their semantics may change as we gain experience
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index a2c9e7439f..d38ecee217 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -229,4 +229,33 @@ test_expect_success 'new branch already exists' '
 	)
 '
 
+test_expect_success 'background updates of REMOTE can be mitigated with a non-updated REMOTE-push' '
+	rm -rf src dst &&
+	git init --bare src.bare &&
+	test_when_finished "rm -rf src.bare" &&
+	git clone --no-local src.bare dst &&
+	test_when_finished "rm -rf dst" &&
+	(
+		cd dst &&
+		test_commit G &&
+		git remote add origin-push ../src.bare &&
+		git push origin-push master:master
+	) &&
+	git clone --no-local src.bare dst2 &&
+	test_when_finished "rm -rf dst2" &&
+	(
+		cd dst2 &&
+		test_commit H &&
+		git push
+	) &&
+	(
+		cd dst &&
+		test_commit I &&
+		git fetch origin &&
+		test_must_fail git push --force-with-lease origin-push &&
+		git fetch origin-push &&
+		git push --force-with-lease origin-push
+	)
+'
+
 test_done
-- 
2.11.0

