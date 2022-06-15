Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15260C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347266AbiFOKoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348090AbiFOKoV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:44:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D7E4ECF7
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:44:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k19so14772086wrd.8
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOHM+rG7N8zGKgF9x533ZZqwQXai3RS83bhrdSeRGZY=;
        b=hBwwMvUZGTRnKilH8PPvSvXU2hBNessMtuFhhfW/fXTJZ8bP8gvak5h1/RnRro7ZcO
         7xXRCOHUb3wsL9Hwkt/1IlOdqSWm1Jk0mmJIhQYHLFHnbe7ipy8HRs3/nXPDM7w8N/tC
         y77HNu7aNEKIsv5TYdZ1UBa1FkQWQYaEt4xZgOjSpyft12KPgCU+YepMvO+At2DuLbUL
         vhcMIGXk1yp8lZLhmZshGoxqiDpIz9QcIpkvCTpfqcPztm3/Jb7qoXQBDshMTfMfh2QS
         qHIqR3ZiAE7m9oZvMqX/cHwmyyQnDZogzm4qyV6D1DxnaREeaTlfN6ugVxK0zxukqoIM
         5CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOHM+rG7N8zGKgF9x533ZZqwQXai3RS83bhrdSeRGZY=;
        b=ZPy4qIEZoNng2tuVtd+IUwJym6Hu2ryx/xRsaWeUpzMcCnDopEpTTenDTQSuwmvgdi
         v7hUz5lInKW+GRdN/0G8suJ+twM45N22D6QKD8NYcGXdWgf/ygEH5qImGV6Z+QKrpwiw
         bS7DhtfersOaOuD9uWHctyz1uJ/RL9xz5mvDvHLdJIgkscGbz9DDLKj4DS4/vL27noyR
         l2E/1H7lxGEm7Fp4uL1Df8NltnS5Ft9l9f9NJ1ts4kzz0HUrLRJh5Y3T6unZXIrrVJW2
         4w4RDiP66+UAcwildSRSAgVYYz0ARJSHSFoPXfkS5Ji3v303Wo1srInOW9UVrdXXgqez
         26rA==
X-Gm-Message-State: AJIora9OEPdaoLIiWlY8a345YvaYbSHNeTHs9UgB/Y40Vp8t0NacL4qD
        vkD2L1BhgtzLXkSXODqfVQQN3F9g36bTIQ==
X-Google-Smtp-Source: AGRyM1vilF0W0nJKSV7vTpNRm+EZLQZrZeVRCk4lnt30SU62yzeTMEzWynFnjHB7+Zs1bWDLKFd/UQ==
X-Received: by 2002:a5d:5004:0:b0:21a:14a0:da9e with SMTP id e4-20020a5d5004000000b0021a14a0da9emr8947105wrt.687.1655289858554;
        Wed, 15 Jun 2022 03:44:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q1-20020adff501000000b002117ef160fbsm14487620wro.21.2022.06.15.03.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:44:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] fetch doc: note "pushurl" caveat about "credentialsInUrl", elaborate
Date:   Wed, 15 Jun 2022 12:44:11 +0200
Message-Id: <patch-1.2-b6631cd839c-20220615T103852Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the documentation and release notes entry for the
"fetch.credentialsInUrl" feature added in 6dcbdc0d661 (remote: create
fetch.credentialsInUrl config, 2022-06-06), it currently doesn't
detect passwords in `remote.<name>.pushurl` configuration. We
shouldn't lull users into a false sense of security, so we need to
mention that prominently.

This also elaborates and clarifies the "exposes the password in
multiple ways" part of the documentation. As noted in [1] a user
unfamiliar with git's implementation won't know what to make of that
scary claim, e.g. git hypothetically have novel git-specific ways of
exposing configured credentials.

The reality is that this configuration is intended as an aid for users
who can't fully trust their OS's or system's security model, so lets
say that's what this is intended for, and mention the most common ways
passwords stored in configuration might inadvertently get exposed.

1. https://lore.kernel.org/git/220524.86ilpuvcqh.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/RelNotes/2.37.0.txt |  4 +++-
 Documentation/config/fetch.txt    | 34 +++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/RelNotes/2.37.0.txt b/Documentation/RelNotes/2.37.0.txt
index 8f1ff3a5961..39ca3606dec 100644
--- a/Documentation/RelNotes/2.37.0.txt
+++ b/Documentation/RelNotes/2.37.0.txt
@@ -55,7 +55,9 @@ UI, Workflows & Features
  * Update the doctype written in gitweb output to xhtml5.
 
  * The "fetch.credentialsInUrl" configuration variable controls what
-   happens when a URL with embedded login credential is used.
+   happens when a URL with embedded login credential is used on either
+   "fetch" or "push". Credentials are currently only detected in
+   `remote.<name>.url` config, not `remote.<name>.pushurl`.
 
 
 Performance, Internal Implementation, Development Support etc.
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 0db7fe85bb8..827961059f8 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -98,12 +98,34 @@ fetch.writeCommitGraph::
 	`git push -f`, and `git log --graph`. Defaults to false.
 
 fetch.credentialsInUrl::
-	A URL can contain plaintext credentials in the form
-	`<protocol>://<user>:<password>@<domain>/<path>`. Using such URLs
-	is not recommended as it exposes the password in multiple ways,
-	including Git storing the URL as plaintext in the repository config.
-	The `fetch.credentialsInUrl` option provides instruction for how Git
-	should react to seeing such a URL, with these values:
+	A configured URL can contain plaintext credentials in the form
+	`<protocol>://<user>:<password>@<domain>/<path>`. You may want
+	to warn or forbid the use of such configuration (in favor of
+	using linkgit:git-credential[1]).
++
+Note that this is currently limited to detecting credentials in
+`remote.<name>.url` configuration, it won't detect credentials in
+`remote.<name>.pushurl` configuration.
++
+You might want to enable this to prevent inadvertent credentials
+exposure, e.g. because:
++
+* The OS or system where you're running git may not provide way way or
+  otherwise allow you to configure the permissions of the
+  configuration file where the username and/or password are stored.
+* Even if it does, having such data stored "at rest" might expose you
+  in other ways, e.g. a backup process might copy the data to another
+  system.
+* The git programs will pass the full URL to one another as arguments
+  on the command-line, meaning the credentials will be exposed to oher
+  users on OS's or systems that allow other users to see the full
+  process list of other users. On linux the "hidepid" setting
+  documented in procfs(5) allows for configuring this behavior.
++
+If such concerns don't apply to you then you probably don't need to be
+concerned about credentials exposure due to storing that sensitive
+data in git's configuration files. If you do want to use this, set
+`fetch.credentialsInUrl` to one of these values:
 +
 * `allow` (default): Git will proceed with its activity without warning.
 * `warn`: Git will write a warning message to `stderr` when parsing a URL
-- 
2.36.1.1239.gfba91521d90

