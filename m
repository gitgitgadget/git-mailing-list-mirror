Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E259202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 15:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdIUPGk (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 11:06:40 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:43363 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbdIUPGi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 11:06:38 -0400
Received: by mail-wm0-f44.google.com with SMTP id m72so1280357wmc.0
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HdYloK36DV++vW7M3Q6lBD8rISer5znUKO6CucDJseA=;
        b=fxuj79JKckrO8O/1Cl4693dkTtKoSnBPHsaEybMLp9RIxDcJPzzb2QB+RBH7kbqpdp
         +k3r8X8iz9hfUhWLM1HbjZWLNqSu/l/IzNLLC6bujzEAE7Kj1Aj0HFDtS6cUueWdFXQq
         VNS4kF81O9ZKoFHXH4UrGKGxg8bvV5gwFxKuvEFty8/njBv/i6PQa3Bx8hikgMX3nxqf
         reBWPOEtJCd8ZjUJaivkf4eEVJQRMJet6++DZolk0IIJtv36Bmi8unYzd6sdcW9P46jH
         5injtWCDsboCEMHJa9QqrLF7RpBCxJKxT81ZvW7UPaSjVfRpI+10liwO8CnaY7YW2Dom
         N+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HdYloK36DV++vW7M3Q6lBD8rISer5znUKO6CucDJseA=;
        b=KKVu5WpR6WRMDFyvvpItNHUjljO65GcC5VDXDJndRyvmmClIPh/3FTqilYRFPOMAT7
         jZO7pfrCHKXcyhK+H8GlGIIWmJwNbBjR3+Ehp2wodu9LgTBXT12uyG14PCO/ajmqdVG8
         0Gzhenek9YHt/L2JlLPoH/C/CMcgI6UmDcCh0sIs7ESWBhYgTge0W841fwEYbBIrcKGm
         ZZe+ejwtCZEWXviQbuv5GHIbPSsfV0ncop+33iPEtinAnpjvYx9nsE3atWLaJrwYJiZI
         yo7wRVtaF5NV45w6rjZA8+FYComI2e/xpC6DOtssQNJLODd/m5gR4KIT9b0VTX/0aFSi
         dLpw==
X-Gm-Message-State: AHPjjUi/gYTivkrYVAUvfbPGHwNOxMB4zXaBTXly2XqgkGpL0df6Iubx
        G69dpdHPPG0KZsd0+WAStfAiVA==
X-Google-Smtp-Source: AOwi7QD2FeMBhHQdxkuJGz9p8Ve7zxIxQ7Xk4pmVYObB05wxBst3P1NzJSJqGmRzexgrL6w7ZZEo7g==
X-Received: by 10.28.161.2 with SMTP id k2mr1236775wme.118.1506006396856;
        Thu, 21 Sep 2017 08:06:36 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id 61sm1354394wre.44.2017.09.21.08.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 08:06:35 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     pc44800@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com
Subject: [GSoC][PATCH v4 1/4] submodule--helper: introduce get_submodule_displaypath()
Date:   Thu, 21 Sep 2017 17:06:26 +0200
Message-Id: <20170921150626.4979-1-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170828115558.28297-2-pc44800@gmail.com>
References: <20170828115558.28297-2-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LGTM with nits.

+static char *get_submodule_displaypath(const char *path, const char *prefix)

this could do with a comment

  /* the result should be freed by the caller. */

+	} else if (super_prefix) {
+		int len = strlen(super_prefix);
+		const char *format = is_dir_sep(super_prefix[len - 1]) ? "%s%s" : "%s/%s";

what if len == 0? The handling of '/' looks like a change from the original.
