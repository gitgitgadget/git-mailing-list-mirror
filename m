Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B823C433FE
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 23:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbhLNXpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 18:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbhLNXpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 18:45:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E31DC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 15:45:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t1-20020a5b03c1000000b005f6ee3e97easo39151065ybp.16
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 15:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uSArwPo2wZ9w3EGotwuoRmsdSDsqvrBBk35dNuN1De4=;
        b=ZakccvRQB3Y28GIcIBIpg46L4zBZDUXmNpGNPkOaOgYnJpTixXg/8VVcTIAQIoSuCX
         Qopo4L/Q156spIgRZ2kARmaodKcgZzTyPPQj3c94cR1EX85dqY0mJdM4KqoXIa13YY6l
         QnNSXTBiPDq//xruKKvXUAtwvgoF3i3rnXSDjeyswdsYu3XYfKBu+XF8S22byt5f8r0i
         ba7zOlpqkg+l3TXiKWE5TVfbeU+veneD7HanV8b5vbJpkhhwOECq+snQ22COuAPVfA4r
         5NG7+FH59StYKfc4atghQpOzpwNTRCKgpPbpVRVQ3KP1iHW9NSnzdkO3AQ06UjV1v0DF
         DhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uSArwPo2wZ9w3EGotwuoRmsdSDsqvrBBk35dNuN1De4=;
        b=N2G9Mka3Qk8bj/6Nh4PBvCBfsNQSfRqy77xrxwhQaWTd0AreLKGYKQ6sXVfv6/DTIo
         nYN58fS5m6F1Opa32NCC6b5r9pmGPs2Txxgwomw941iJn94S+MRxFYhpwcBO8eq++jVE
         m3H1NGwENwB1eto6+kIa/E07irRkiSWEysmLKeLMX+XkTIDedlp5ommJhqdrr9ZYCdDw
         QuIvE63sQt8XKZ0rxXOBdZb0JD9Mcjn5ao0Flck8fzQ6sFnkCtu+IanD99YXchEGNWTS
         dc91cJoZ1VtCJJhXNN0ei9184ilqFVb8dbslFThIqb/UFtS1EjXPBGwNPcc9BHMatLEb
         VsBg==
X-Gm-Message-State: AOAM531LzxZtYBsbhSJpw567VpUnmuBxxRk0dfNT4ZwMS1A8x2IMGBMF
        pdtrrO1TzOEs1sjN4VGhrm7ToBAdzOpz8ZMPU7qfP9cxmEJBobF0rE2evhv6SDy1X2LUx7o1vU8
        cLBACbWVF/Z9PcBTf41owOl1+n4GjvyIS47HlhJTBR4E9DiL7r2P5CHSnTZJp1xM=
X-Google-Smtp-Source: ABdhPJy+gz5D+wHNvRx+VtFIOG1BxvONa9Xmn1IutkHAUTYbx1q+THaX6icSyjO51T3WZZSp/u5ZVd/y9r4ubQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
 (user=steadmon job=sendgmr) by 2002:a25:6193:: with SMTP id
 v141mr2493312ybb.516.1639525505443; Tue, 14 Dec 2021 15:45:05 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:44:56 -0800
In-Reply-To: <cover.1639524556.git.steadmon@google.com>
Message-Id: <f79d27dc243dee281b879e358e8609aba39b3fe3.1639524556.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v6 3/3] config: require lowercase for branch.autosetupmerge
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although we only documented that branch.autosetupmerge would accept
"always" as a value, the actual implementation would accept any
combination of upper- or lower-case. Fix this to be consistent with
documentation and with other values of this config variable.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 152c94f29d..54c0e7d98e 100644
--- a/config.c
+++ b/config.c
@@ -1577,7 +1577,7 @@ static int git_default_i18n_config(const char *var, const char *value)
 static int git_default_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "branch.autosetupmerge")) {
-		if (value && !strcasecmp(value, "always")) {
+		if (value && !strcmp(value, "always")) {
 			git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
 		} else if (value && !strcmp(value, "inherit")) {
-- 
2.34.1.173.g76aa8bc2d0-goog

