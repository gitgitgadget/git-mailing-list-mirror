Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188A81F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 04:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfH0Epp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:45:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46320 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0Epo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:45:44 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so43049942iog.13
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XzDkT5I+h6QBHxtxLdCVXB/0avvWcRukXe+OVuGmFJA=;
        b=LGZbcyu7yUf8xt9iIvWDqNnP9TVjWGcvJyzGgmbjZUxbnYmmDc0OCHuwa7Fk393oSB
         6LBQ/6uiAhDxsXUTbApDaQA8E+sM5TEyx3PBN+PPyfBhfjMMAB+eFHUsaRdUzwbUEpfj
         zcoRFsR3DbVfF9BJhKOn+3JUp4DfQoLha3NXHNvu2SqcKBMexDuAvr7HYxi0Il3wEk7U
         bftzFmtKqtFTdv0VatJ5nAWDGB2NtWqkXBRIo5e8lb1PlktqDjJdcHfhaZFsGiD1d4o2
         IcD75aGYKRcXwm9ptk5260Le5nkDfcWBUCMAlSvvng5xC7C14biT8YVrgNVdUOtQ12SC
         OhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XzDkT5I+h6QBHxtxLdCVXB/0avvWcRukXe+OVuGmFJA=;
        b=CqgRx8zgzpoNhTyAJmRex3dQfSLL6eJqozFIXZfVM2vqumGd6j1pJFjhUps0BJR1rQ
         wg4O3UukjaucRUMd8NSFArdF797bGajTyf1i6Zu9Zvvd05rbasq7V3MWr2pngu8/kisi
         VgP8AOTH+LBfrz0RBUjD79VtFpttoDWtHLiGSsLCmYmk5KlYVyw+bNN7jyh4Qr0pV90v
         gDIfYAwRzMn4T2KUpVwOnpZnvg+wzo2CdnZpg787SXC9CSrV2stSxVm+elJ1pOmWlXgR
         sV8YGRFWAyf2DFi9SOejfTrkX9knwMF2J3CA03dQNO0b4MNOUjrNj2y7Ydj4ojmXFgHp
         FetQ==
X-Gm-Message-State: APjAAAW3V3IxVOYlB/5/4J7DOMePzvWmEh76CMGxidkLxn6ZI7Bo2B6o
        8DVHtNFAWbg4l9Ew/uRsFDyH4aKa
X-Google-Smtp-Source: APXvYqwNsDibWQPGFosyR12R5OAl7gWT563DmwMxa2eU07Gbx0BexKiXlm+Ep4Y8NJTI+iT5tBygSg==
X-Received: by 2002:a6b:8d90:: with SMTP id p138mr16035960iod.282.1566881143656;
        Mon, 26 Aug 2019 21:45:43 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id j16sm11878711iok.34.2019.08.26.21.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:45:43 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:45:41 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] status: mention --skip for revert and cherry-pick
Message-ID: <be64ce1e92c60f9587b137d36e98532604d4a1ff.1566880835.git.liu.denton@gmail.com>
References: <cover.1566637431.git.liu.denton@gmail.com>
 <cover.1566880835.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566880835.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reverting or cherry-picking, one of the options we can pass the
sequencer is `--skip`. However, unlike rebasing, `--skip` is not
mentioned as a possible option in the status message. Mention it so that
users are more aware of their options.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7512-status-help.sh | 6 ++++++
 wt-status.c            | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index e01c285cbf..66d7a62797 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -733,6 +733,7 @@ test_expect_success 'status when cherry-picking before resolving conflicts' '
 On branch cherry_branch
 You are currently cherry-picking commit $TO_CHERRY_PICK.
   (fix conflicts and run "git cherry-pick --continue")
+  (use "git cherry-pick --skip" to skip this patch)
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
 
 Unmerged paths:
@@ -757,6 +758,7 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 On branch cherry_branch
 You are currently cherry-picking commit $TO_CHERRY_PICK.
   (all conflicts fixed: run "git cherry-pick --continue")
+  (use "git cherry-pick --skip" to skip this patch)
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
 
 Changes to be committed:
@@ -778,6 +780,7 @@ test_expect_success 'status when cherry-picking after committing conflict resolu
 On branch cherry_branch
 Cherry-pick currently in progress.
   (run "git cherry-pick --continue" to continue)
+  (use "git cherry-pick --skip" to skip this patch)
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
 
 nothing to commit (use -u to show untracked files)
@@ -835,6 +838,7 @@ test_expect_success 'status while reverting commit (conflicts)' '
 On branch master
 You are currently reverting commit $TO_REVERT.
   (fix conflicts and run "git revert --continue")
+  (use "git revert --skip" to skip this patch)
   (use "git revert --abort" to cancel the revert operation)
 
 Unmerged paths:
@@ -855,6 +859,7 @@ test_expect_success 'status while reverting commit (conflicts resolved)' '
 On branch master
 You are currently reverting commit $TO_REVERT.
   (all conflicts fixed: run "git revert --continue")
+  (use "git revert --skip" to skip this patch)
   (use "git revert --abort" to cancel the revert operation)
 
 Changes to be committed:
@@ -887,6 +892,7 @@ test_expect_success 'status while reverting after committing conflict resolution
 On branch master
 Revert currently in progress.
   (run "git revert --continue" to continue)
+  (use "git revert --skip" to skip this patch)
   (use "git revert --abort" to cancel the revert operation)
 
 nothing to commit (use -u to show untracked files)
diff --git a/wt-status.c b/wt-status.c
index 9f6c65a580..ad6282c7f8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1433,6 +1433,8 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 		else
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git cherry-pick --continue\")"));
+		status_printf_ln(s, color,
+			_("  (use \"git cherry-pick --skip\" to skip this patch)"));
 		status_printf_ln(s, color,
 			_("  (use \"git cherry-pick --abort\" to cancel the cherry-pick operation)"));
 	}
@@ -1460,6 +1462,8 @@ static void show_revert_in_progress(struct wt_status *s,
 		else
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git revert --continue\")"));
+		status_printf_ln(s, color,
+			_("  (use \"git revert --skip\" to skip this patch)"));
 		status_printf_ln(s, color,
 			_("  (use \"git revert --abort\" to cancel the revert operation)"));
 	}
-- 
2.23.0.248.g3a9dd8fb08

