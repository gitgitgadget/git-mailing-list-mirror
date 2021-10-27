Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE940C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB74D60EFE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbhJ0TiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbhJ0TiE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 15:38:04 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D8EC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:35:39 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o14-20020a05622a138e00b002a79da5b350so2679004qtk.15
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bvFpNQj4Msfv+wv2qyzayNU6/iXvaB29d+DYAwDdHhQ=;
        b=o55HPrkOEpTLxV4trhOBwT9VA/taZ3jU+mazVg+bIf1q1nJw5UP4P0tINUwakVVKCL
         uqZBm/pv94obZvRjIIar9UveategFS4pPMek3ZGxqNFTtKCIo8oIiibMNDsNt97uUaJl
         vNdWRhr1pC9B26tFtdUPubDoEmxtFxfWhMTblugqHbciskYeT6V4Qzy/PCnLu9gHlC1+
         4HZJD8WsPIwT/gNtnfJ+nKRQH4vcwgjV7H7ZsfwRH8E8l0DQd7Z78seWBnrwkDJ6AEYV
         0Q2lo0hK63N0SCh+XGzrwfbnuCQvCXlrqweJjh9CNzxDGoe9RLn4bDBIwF016UZYeczN
         NZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bvFpNQj4Msfv+wv2qyzayNU6/iXvaB29d+DYAwDdHhQ=;
        b=kVdplEcSkhksuoURTZKPZR5JCiroMufkJnYP1ic1LlcLLNzTg+EzF2dvAScUagSgaR
         IcXv9byc4m38mkJL2RliozZVpY7+pr+OqDn4MbJ7MNxUFb350BxJdI9GITyV6/mzdDKp
         7j4VDsHEkAMfU5cBhJYqXVfSKvaucLxYvSs2ku3m2FT4MNZfn0ToELk6YTL8NkWiQ/Yh
         ythp+W2k2VrK8qaNKNXFDkaDIU5uDNFKT2e8rZvaroSyg9SkcSFoxejfYYRLOXdxznfE
         qj11qjqx4AS6eznsdfJRA92BCnnqoxSxc8koSVt1yJ8mZTfGHiR+htU4bPpB/sDIt24N
         wFwQ==
X-Gm-Message-State: AOAM532PJZXCHioaViS96TtS9V0aTq6HtnrpeDtry1GmFpNbxXT2BQ4c
        +Rqi8E9NFl3jed7M+/jOVVEyUkAJrHzILL0DAxG8CN1d76RtoaPtXJQB+aTRMkK29KzEZxt2ETB
        dRybtyq/HI0UDenBjbqlfn1UCFmRue8ebA/lA9k8kQ+MwB9kXNQY0wXMo3xtwMGWxdg==
X-Google-Smtp-Source: ABdhPJwzMygDWnYOtPJlhbZ8e3TvocK1wKzsTKJmHjhnxyCv/0aMqd9C3cLRk0tm84yqJuB+UqiIbp6+EWOtdRI=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:ac8:1e0b:: with SMTP id
 n11mr33098613qtl.274.1635363338341; Wed, 27 Oct 2021 12:35:38 -0700 (PDT)
Date:   Wed, 27 Oct 2021 19:35:01 +0000
In-Reply-To: <20211027193501.556540-1-calvinwan@google.com>
Message-Id: <20211027193501.556540-2-calvinwan@google.com>
Mime-Version: 1.0
References: <20211027193501.556540-1-calvinwan@google.com>
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: [RFC PATCH 1/1] protocol-v2.txt: align delim-pkt spec with usage
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, Ivan Frade <ifrade@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

move delim-pkt from command-args to command-request

Signed-off-by: Calvin Wan <calvinwan@google.com>
Reported-by: Ivan Frade <ifrade@google.com>
---
 Documentation/technical/protocol-v2.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 21e8258ccf..1e75863680 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -125,11 +125,11 @@
     empty-request = flush-pkt
     command-request = command
 		      capability-list
-		      [command-args]
+			  delim-pkt
+		      command-args
 		      flush-pkt
     command = PKT-LINE("command=" key LF)
-    command-args = delim-pkt
-		   *command-specific-arg
+    command-args = *command-specific-arg
 
     command-specific-args are packet line framed arguments defined by
     each individual command.
-- 
2.33.0.664.g0785eb7698

