Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1276ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 19:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIPTyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 15:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIPTxo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 15:53:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BBDB8A60
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:53:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso451570wmq.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=7obFbJDviaFapjlXClaZE4EyGR7aV2qXxFbzI7Wn3Kk=;
        b=pS+Ra6aqcNYJtG3Rx/d+3fGZNFEiAq6QoQNvqAsRRztlefXsATnXLb0MKGBxfukcuS
         vmBns27JmMF6ddTmwVi3Knl5VcNaXEMRA/0w4Yop4av2f6zMXpLDcTkooVmSpjaHEvxD
         T3hp6pUw1fbQcwAiNie8vbTxhcWzt5r/HgF+aSt9N7QS0Mht3xTSvHRJpYRuJIJePlub
         K41tlW2dOzKkGXJVTdkUaI1GEbfkBKv49pahe4OXorq7FV1RxoOKk0TZDrNXhxosVVFe
         mMvpoOaKaKcbAlDQGrIA9FFph11TvwbHUSc2/RnopvFp9IjOUbwst6o2OQHITA5k2Fj1
         Pq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7obFbJDviaFapjlXClaZE4EyGR7aV2qXxFbzI7Wn3Kk=;
        b=yoedeDKyGUX2JyVpbcvuwIG8HF9HPIuOJSqecaS7T4QkNMgZt5amNpqtrXKC4q7tJV
         mliJoX7bb1+kAoAO/iBvAoPoEvQn0Js49YXgQYQT0wkcJkEpyMMZzBgaw+PVQ+OJ9gZh
         1u24mgy0DClGygASqNr9L8TPGE9S6P53Hi6uvmo/AazMcrNmF6xI2pHFJiFXctG/I1E0
         8SRi1JhgpttaTMJq11H/YBvru4V2brbiqgY3NTt9LVClzRbQZnAuK1YRL+tBPOb6PDdl
         S0ws0UIHyXUswBSHf+Vxi6UQPNCsOUHRGpjm9lbKE8QahaGjg0XZgHAnTlFfhJ0FKS9T
         rGjw==
X-Gm-Message-State: ACrzQf2pNeVeZOKghQl2ZTy5A7GuHUN1k8zDtUmYCxZ/SmbT89rxHbGz
        07v0Y5B6X952ZFzjYJPnOEUJBl84xbc=
X-Google-Smtp-Source: AMsMyM5KYbxS3fsnf3qdqTZL+YMzlZKg1Ix/cmy/xaY3M3A4xRZ9MrBnNrHS82jv/WttFH3cDh/NFw==
X-Received: by 2002:a05:600c:1990:b0:3b4:c326:d099 with SMTP id t16-20020a05600c199000b003b4c326d099mr217511wmq.19.1663358021567;
        Fri, 16 Sep 2022 12:53:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020adfef88000000b002250c35826dsm5824937wro.104.2022.09.16.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:53:41 -0700 (PDT)
Message-Id: <4d00adb1deb61c3af58bed81271dd3337db7037e.1663358014.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 19:53:33 +0000
Subject: [PATCH v7 5/6] fsmonitor: deal with synthetic firmlinks on macOS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Starting with macOS 10.15 (Catalina), Apple introduced a new feature
called 'firmlinks' in order to separate the boot volume into two
volumes, one read-only and one writable but still present them to the
user as a single volume. Along with this change, Apple removed the
ability to create symlinks in the root directory and replaced them with
'synthetic firmlinks'. See 'man synthetic.conf'

When FSEevents reports the path of changed files, if the path involves
a synthetic firmlink, the path is reported from the point of the
synthetic firmlink and not the real path. For example:

Real path:
/System/Volumes/Data/network/working/directory/foo.txt

Synthetic firmlink:
/network -> /System/Volumes/Data/network

FSEvents path:
/network/working/directory/foo.txt

This causes the FSEvents path to not match against the worktree
directory.

There are several ways in which synthetic firmlinks can be created:
they can be defined in /etc/synthetic.conf, the automounter can create
them, and there may be other means. Simply reading /etc/synthetic.conf
is insufficient. No matter what process creates synthetic firmlinks,
they all get created in the root directory.

Therefore, in order to deal with synthetic firmlinks, the root directory
is scanned and the first possible synthetic firmink that, when resolved,
is a prefix of the worktree is used to map FSEvents paths to worktree
paths.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 fsmonitor--daemon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index e24838f9a86..98cbb430083 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -170,5 +170,8 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
  */
 void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
 
+char *fsmonitor_resolve_alias(const char *path,
+	struct alias_info *alias);
+
 #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 #endif /* FSMONITOR_DAEMON_H */
-- 
gitgitgadget

