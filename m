Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993CDC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbiHINMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiHINMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:12:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561713E09
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:12:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l22so14291086wrz.7
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=BCVimh2NsqEfa+eiWDs1bVC13jZzxZtecwWwJV6hOx4=;
        b=GgGSogq9VzjuZyvom0Z6l74gXhIYbeghhNg7TTawcc7uY3zZisW7meY75BYaI2eEnJ
         g6QACKhGGhXurbcZ/EGNDmN4YXcoDJ0PhlZ6cuVn2PGY+nT9wzhrE5L3KpoSeDdnBpFN
         aRSTDnNCEabsKsMiMzb4MQsy/d3iH2O4iDbDIMLRkNsMgLo1dQ2giXYDVXHVNL8ee0OQ
         LlDcF0WJMCKXDU6dlNQwdgqyFq3sZsjN3Y1VK8rMQlwzPNVUSndFWraHc66YYmJjlyqA
         Lun3zlYOoBkNTUJmkFCsh1TDcN32pxidJHFDkT8kfXx0EErYtnbYwfr9CXAMeJZWLLEU
         2dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=BCVimh2NsqEfa+eiWDs1bVC13jZzxZtecwWwJV6hOx4=;
        b=WCx/DjBnTqfGn/4xLuyb4Ln6Z8CiWVYzaTr7MkMxTyInJ4j4k6UIH2UTirnLceJ3lz
         qGy5VOElyj9//x1Eej6w4xBI8QZtrbJeklr8EcKEFvTErtRcU8IAneRZQIxAPXZK3fY/
         0250mdYJOCRiLJalzZ/7neu4k65HMFAlPCoG1aKvIsDgXfsRxksy42bPLMdTRb7DUbXk
         20dR432QeroWZ9lRhVj480jsT0tUkMWHCwVRsx8mL/wLFPnpyAxx2VSFtEwzeDRI66fF
         KFzw/bTqJBA3WeiUfhRdCfwyn7QVCw7Bm3M5+ehEFtnGh5JjlSGpE1xNVwuMnIwWwNDH
         VvEA==
X-Gm-Message-State: ACgBeo1/2ct4y8yk3xkpQb4ZUWoM4M5POwOrls6yd/TmS/QOj+o0v8nK
        FI8eqS6qKqg4nj1+yZ3yrrPaFK5iAfs=
X-Google-Smtp-Source: AA6agR7xWxPPChwDSy2LFSJ7X9EBgfqab/ORoC3tNe5sy4AqK999Dkbzczi4u8ZwdxbXIavXsaih+g==
X-Received: by 2002:a5d:6b12:0:b0:21f:1568:c7e1 with SMTP id v18-20020a5d6b12000000b0021f1568c7e1mr14338912wrw.532.1660050763223;
        Tue, 09 Aug 2022 06:12:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020adfeb4b000000b0021f15514e7fsm16022670wrn.0.2022.08.09.06.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:12:42 -0700 (PDT)
Message-Id: <pull.1248.v4.git.1660050761.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
References: <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Aug 2022 13:12:39 +0000
Subject: [PATCH v4 0/2] bundle URIs: design doc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first of series towards building the bundle URI feature as
discussed in previous RFCs, specifically pulled directly out of [5]:

[1]
https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/

[2]
https://lore.kernel.org/git/cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com/

[3]
https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com

[4]
https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/

[5]
https://lore.kernel.org/git/pull.1234.git.1653072042.gitgitgadget@gmail.com

THIS ONLY INCLUDES THE DESIGN DOCUMENT. See "Updates in v3". There are two
patches:

 1. The main design document that details the bundle URI standard and how
    the client interacts with the bundle data.
 2. An addendum to the design document that details one strategy for
    organizing bundles from the perspective of a bundle provider.

As outlined in [5], the next steps after this are:

 1. Add 'git clone --bundle-uri=' to run a 'git bundle fetch ' step before
    doing a fetch negotiation with the origin remote. [6]
 2. Allow parsing a bundle list as a config file at the given URI. The
    key-value format is unified with the protocol v2 verb (coming in (3)).
    [7]
 3. Implement the protocol v2 verb, re-using the bundle list logic from (2).
    Use this to auto-discover bundle URIs during 'git clone' (behind a
    config option). [8]
 4. Implement the 'creationToken' heuristic, allowing incremental 'git
    fetch' commands to download a bundle list from a configured URI, and
    only download bundles that are new based on the creation token values.
    [9]

I have prepared some of this work as pull requests on my personal fork so
curious readers can look ahead to where we are going:

[6] https://github.com/derrickstolee/git/pull/18

[7] https://github.com/derrickstolee/git/pull/20

[8] https://github.com/derrickstolee/git/pull/21

[9] https://github.com/derrickstolee/git/pull/22

As mentioned in the design document, this is not all that is possible. For
instance, Ævar's suggestion to download only the bundle headers can be used
as a second heuristic (and as an augmentation of the timestamp heuristic).


Updates in v4
=============

 * Whitespace issue resolved.
 * Example bundle provider setup now uses the 'bundle-uri' protocol v2
   format when describing how the origin Git server advertises the static
   bundle servers.


Updates in v3
=============

 * This version only includes the design document. Thanks to all the
   reviewers for the significant attention that improves the doc a lot.
 * The second patch has an addition to the design document that details a
   potential way to organize bundles from the provider's perspective.
 * Based on some off-list feedback, I was going to switch git fetch
   --bundle-uri into git bundle fetch, but that has a major conflict with
   [10] which was just submitted.
 * I will move the git bundle fetch implementation into [6] which also has
   the git clone --bundle-uri implementation.

[10]
https://lore.kernel.org/git/20220725123857.2773963-1-szeder.dev@gmail.com/


Updates in v2
=============

 * The design document has been updated based on Junio's feedback.
 * The "bundle.list." keys are now just "bundle.".
 * The "timestamp" heuristic is now "creationToken".
 * More clarity on how Git parses data from the bundle URI.
 * Dropped some unnecessary bundle list keys (*.list, *.requires).

Thanks, -Stolee

Derrick Stolee (2):
  docs: document bundle URI standard
  bundle-uri: add example bundle organization

 Documentation/Makefile                 |   1 +
 Documentation/technical/bundle-uri.txt | 573 +++++++++++++++++++++++++
 2 files changed, 574 insertions(+)
 create mode 100644 Documentation/technical/bundle-uri.txt


base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1248%2Fderrickstolee%2Fbundle-redo%2Ffetch-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1248/derrickstolee/bundle-redo/fetch-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1248

Range-diff vs v3:

 1:  e0f003e1b5f ! 1:  1bfac1f492a docs: document bundle URI standard
     @@ Documentation/technical/bundle-uri.txt (new)
      +	work well with incremental `git fetch` commands. The heuristic signals
      +	that there are additional keys available for each bundle that help
      +	determine which subset of bundles the client should download. The only
     -+  heuristic currently planned is `creationToken`.
     ++	heuristic currently planned is `creationToken`.
      +
      +The remaining keys include an `<id>` segment which is a server-designated
      +name for each available bundle. The `<id>` must contain only alphanumeric
 2:  a933471c3af ! 2:  a22c24aa85a bundle-uri: add example bundle organization
     @@ Documentation/technical/bundle-uri.txt: error conditions:
      +	[bundle]
      +		version = 1
      +		mode = any
     -+		
     ++
      +	[bundle "eastus"]
      +		uri = https://eastus.example.com/<domain>/<org>/<repo>
     -+		
     ++
      +	[bundle "europe"]
      +		uri = https://europe.example.com/<domain>/<org>/<repo>
     -+		
     ++
      +	[bundle "apac"]
      +		uri = https://apac.example.com/<domain>/<org>/<repo>
      +

-- 
gitgitgadget
