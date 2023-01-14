Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D31BC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 01:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjANBM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 20:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjANBM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 20:12:27 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE337EC84
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 17:12:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u9so56161500ejo.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 17:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuOAKUwsklx6EGLQWkYj5KMRYfl2CCWqj2FWV6dpVgo=;
        b=BAA/pve74KT3MSnvN/OInLj1KhQrKMWGEhpMi5fgldxI5WBlcGMERAzl7B8LZi49rk
         YpkwefiWZfdJ0c+2dIMLm0OFSuq2T2vwHO6B8n5S61OQTzU4FAiJzycD8ex1v8dvhNbd
         cQkJkFGN2BsJhLa6/So/lWSooHRiJz++6lCYIJlTsG3THcZUBDh3wNODm7NcP+rzmcO5
         bohW+oFlEQB8fgqaOrTOQtMGr67uhIQADvbHarYcrCxxuacIqgNsa7O9Nw6k5qFzb7jj
         GD3goL92qwP///H+d18sshq0pigIfTJCC6JkXd0pEAjxHaqhrh1s6PTuP/6BdkakYcQJ
         aafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuOAKUwsklx6EGLQWkYj5KMRYfl2CCWqj2FWV6dpVgo=;
        b=Pk0vAEg2RSzisOAw1Ac9GwkIcRu3fm79wQy3ZjTNfw64jmLMLKM8sIrcxHGvMZfhoA
         FcJo6iw+A+AwKQgDxZQLlHvaN15RqjsAJ+8eQIw4FUmByeA/lxrWmQe3XRDShuEELy/K
         o3x/3iM0M/5L9cgDK/hgSXWFii9yqxlFStPEronrQhzpiUM/av4njTBj06ilODBKYa0W
         WwCPX3OAvFhIaRFq0mq6OB8PpbjdSJPyxm3Wv08dfX0bnXjt11+vaiMh+05DQLXJYJBU
         G+NKWcRvK3WYuy7pdhUuD4e+8GIujqtoTCtXJN6Swn5c6ixRemeJihgrROhS0XtZjuiT
         e4KA==
X-Gm-Message-State: AFqh2kr5SjnrRMXB9rJZmf40DD6ZrQeK/kuS5n+SbLbRCj/ancAcsweF
        c+xNGJH/SP/+iCXdwa5U4O0W8sslIwU/FBmakvhEaEkjsDc=
X-Google-Smtp-Source: AMrXdXtPnxQ5H2tjUKI2yabupI+rDZG/sDX0BJkq64fOEpKzz2Zt48pKfdSyNxHCA8W1scWZLqywK8fe38PO08OZk/g=
X-Received: by 2002:a17:907:6294:b0:85e:ed5:6b60 with SMTP id
 nd20-20020a170907629400b0085e0ed56b60mr1429732ejc.761.1673658744450; Fri, 13
 Jan 2023 17:12:24 -0800 (PST)
MIME-Version: 1.0
References: <CAEg0tHSLyaewkgGs0dEXfwQhKmbiO65bXZVU8t7Kn4WwJ1p0Fw@mail.gmail.com>
 <xmqqfsclzlqx.fsf@gitster.g> <CAEg0tHT5PD4K89E3fcNq_WbaLPHozLi-PsJFDsQrzkGi7Na9jg@mail.gmail.com>
 <CAEg0tHQtf9G0N24Xfe-gvRM1AFaiS_ApcuQ8hZtsZAeMhhVWAQ@mail.gmail.com> <xmqqo7r248x9.fsf@gitster.g>
In-Reply-To: <xmqqo7r248x9.fsf@gitster.g>
From:   muzimuzhi Z <muzimuzhi@gmail.com>
Date:   Sat, 14 Jan 2023 09:12:12 +0800
Message-ID: <CAEg0tHSZi22RUBREJB=Cfy6O72cicv9FTkgo_Z=gvGRdPK1acw@mail.gmail.com>
Subject: [PATCH v2] doc: fix non-existent config name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Clemens Buchacher <drizzd@gmx.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From c879cb10f61afc361c484267f498d5815bc1b932 Mon Sep 17 00:00:00 2001
From: muzimuzhi <muzimuzhi@gmail.com>
Date: Mon, 9 Jan 2023 06:37:47 +0800
Subject: [PATCH v2] doc: fix non-existent config name

Replace non-existent `branch.<name>.fetch` to `remote.<repository>.fetch`, in
the first example in `git-fetch` doc, which was introduced in
d504f6975d (modernize fetch/merge/pull examples, 2009-10-21).

Rename placeholder `<name>` to `<repository>`, to be consistent with all other
uses in git docs, except that `git-config.txt` uses `remote.<name>.fetch` in
its "Variables" section.

Also add missing monospace markups.

Signed-off-by: Yukai Chou <muzimuzhi@gmail.com>
---

Changes compared to PATCH v1:
 - Use real name in sign-off
 - Update commit reference in a non-shallow clone, resulting in longer
   <abbrev-hash>
 - Use word "non-existent" in commit message uniformly
 - Rebase to latest master a38d39a4c5 (The sixth batch, 2023-01-08)

 Documentation/git-fetch.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 63d9569e16..fba66f1460 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -251,10 +251,10 @@ EXAMPLES
 $ git fetch origin
 ------------------------------------------------
 +
-The above command copies all branches from the remote refs/heads/
-namespace and stores them to the local refs/remotes/origin/ namespace,
-unless the branch.<name>.fetch option is used to specify a non-default
-refspec.
+The above command copies all branches from the remote `refs/heads/`
+namespace and stores them to the local `refs/remotes/origin/` namespace,
+unless the `remote.<repository>.fetch` option is used to specify a
+non-default refspec.

 * Using refspecs explicitly:
 +
-- 
2.39.0
