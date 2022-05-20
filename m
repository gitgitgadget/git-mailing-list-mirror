Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F77C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348088AbiETSkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiETSkt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:40:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D463A0
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso3030316wmn.4
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=CWWZtQdiMJirb7NrFDABV3ztiMWxVqhcLNMG18Gf1so=;
        b=aVVJ4b874QBTAQYIQI5QCMjKE+Ix+pYseOtUzzzAyPbx83oaFzZYOcV3TeFTdACp7M
         WsrUG5Sqlna3ikRFZFl94z1TBpknYYGh/c+AbGOa7ciRl0zwi9d2oG9niZJztwQSdQAt
         4Fpu/DXVsBECRkaVwFxr8rFi7DmNSJAKYhVYRrddkhE8vllMENFyKaG7C5ksnxaMz9w+
         oqkdLK5Rl3UbMrQEM6Wd6M8020nsmc+c5MgvURl3MAGzTSPEWuxNrr/FW20BROAOLNVy
         dFG5a2sEDRoP8p+pqs3D8RwkNtRswKK7ZbP6PndBNzxyqF0QQiKQAKu87nFjqoMPP22g
         FnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=CWWZtQdiMJirb7NrFDABV3ztiMWxVqhcLNMG18Gf1so=;
        b=e0ArQ2AtFR/bucSU+YYm62lNl4VVThN/EObwZ909MIkkj6wtPiCChVxC4BpIfLRp/k
         HZnhfDrNy0RcCmBkpuum+FHgXJ1yTNq7sB+as66uCJGvOxFyVF1BhoavZtUABUdR0hA/
         IWI2MbsziUyptnn6d6KGv5hjvPtRo4mS4uNPPljuB7NlJNtci4Pk0yxgC8gEWQeureXf
         jfc4JG08oL8T1174qARbllTV5MVxxne3/Fwi/q8V8LQz/IKyJ6mZRFRXYe3ZPz9I62Jw
         50+UNJJMjFPJBuoJTFrnky1Qw1zg0xNE8BnyqeJXQvRzc+3RcWqVZJ28Lu5uMAT8IfaY
         wRmg==
X-Gm-Message-State: AOAM533qgA/71xNYTiH/A3jcBQ6JawfLY+23bGCZg8ZDo6FHxc/6Sqmw
        rqfRQNw9B39T4Vp6JnXL1Rrh0oW8jKY=
X-Google-Smtp-Source: ABdhPJwzGve+qyn0PLs41EGYDj9crDlxRVYiYMhrmkVla+3aN5UYzWIFSB+OsoU9iLOrz9Tcgpu3Gg==
X-Received: by 2002:a7b:c74f:0:b0:394:1ce3:cc42 with SMTP id w15-20020a7bc74f000000b003941ce3cc42mr9637319wmk.153.1653072044485;
        Fri, 20 May 2022 11:40:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1-20020adf8901000000b0020c547f75easm2994251wrs.101.2022.05.20.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:43 -0700 (PDT)
Message-Id: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:18 +0000
Subject: [PATCH 00/24] [RFC] Bundle URIs Combined RFC
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the latest RFC round of Bundle URIs. It combines most of the ideas
from my previous RFC [5] and Ævar's latest RFC [7]. I'll start by talking
about the differences from those two approaches before going into the full
detail of the RFC (assuming no context of the previous discussion).

This series is based on ds/bundle-uri [8].


Comparison to Previous RFC Rounds
=================================

The two design documents from Ævar's latest RFC are combined into one and
are moved up to the first patch.

The "table of contents" concept is renamed to a "bundle list". When serving
from an HTTPS GET request, that still takes the form of a config file
format, but the exact same key=value pairs are also used in the bundle-uri
protocol v2 verb. Both use a common underlying logic for downloading from
lists that are found in either way. Since I modified Ævar's bundle-uri
protocol v2 logic to match this common model, I was able to preserve his
authorship on several patches, but some were different enough that I added
my co-authorship.

The bundle list has a new bundle.list.mode setting that can be all (get
everything) or any (get one). This allows the bundle-uri verb to advertise
multiple bundle servers where any one of them would be sufficient to get a
recent view of the repository.

The timestamp heuristic is removed from this series for the sake of brevity.
The logic for downloading the bundles can be modified in the future to take
advantage of such a heuristic if it is added in the future.

Ævar's use of shelling out to curl is completely removed. This was causing
test failures on Windows but also has no way of integrating with the
credential manager at the moment, which is critical to serving private
repository data via bundles. Similar to the timestamp heuristic, this "fetch
the headers first" heuristic can be added later.

Because these heuristics are removed, the incremental bundle fetches during
git fetch are also removed. This needs at least one heuristic, so is an
intended target after the git clone integration is more stable.

Instead of creating git bundle fetch, I implemented the same functionality
into git fetch --bundle-uri=X, which is perhaps more understandable to
users. This command will allow users to fetch from bundles on their own
timeline if they don't want to rely on Git auto-discovering or auto-fetching
from bundles.

Both the git clone --bundle-uri and the discovery from the bundle-uri
protocol v2 system are provided.

The transport.injectBundleURI config option is removed. Instead, the
--bundle-uri command-line option is provided.

Ævar's series had some use of logic to feed the bundle ref advertisement
directly into the fetch negotiation. This is removed in favor of storing the
bundled refs in refs/bundles/ (along with
log.excludeDecoration=refs/bundles/) to automatically gain that benefit,
including when using --bundle-uri.

I kept and extended the tests that Ævar provided. There is a new test in the
end-to-end test that includes the server advertising multiple bundles. The
series as a whole is still light on tests, but I wanted to continue to focus
on the viability of the design before committing too much on tests. I've
marked commit messages with RFC-TODO comments which will be resolved before
sending any patches for full review.


Context-Free Description
========================

There have been several suggestions to improve Git clone speeds and
reliability by supplementing the Git protocol with static content. The
Packfile URI [0] feature lets the Git response include URIs that point to
packfiles that the client must download to complete the request.

Last year, Ævar suggested using bundles instead of packfiles [1] [2]. This
design has the same benefits to the packfile URI feature because it offloads
most object downloads to static content fetches. The main advantage over
packfile URIs is that the remote Git server does not need to know what is in
those bundles. The Git client tells the server what it downloaded during the
fetch negotiation afterwards. This includes any chance that the client did
not have access to those bundles or otherwise failed to access them. I
agreed that this was a much more desirable way to serve static content but
had concerns about the flexibility of that design [3]. I started
investigating this idea myself in December, resulting in an RFC in February
[5]. After some discussion, we agreed [6] that Ævar would combine my ideas
with his, including the patches that had not been shared publicly. Ævar's
latest RFC [7] includes the two implementations mostly side-by-side, with
some early refactoring patches that help both implementations. I submitted
those early patches for full review [8], now known as ds/bundle-uri.

Notable to this topic, although not used directly in this RFC, is the notion
of partial bundles [4] which landed as a feature in Git 2.36.0. This allows
us to create bundles that respect a partial clone filter. While this RFC
does not implement the awareness of filters when downloading bundles, it
would be relatively simple to modify the implementation to include those
checks. My previous RFC [5] had that integration, for reference.

The first patch of this series is a design document detailing how the bundle
URI feature works in its ideal, feature-complete state (along with ways it
can be extended with more features in the future). I focused on maximizing
flexibility for the service that organizes and serves bundles. This
includes:

 * Git servers can advertise bundle URIs using the Git protocol.

 * Users can set up bundle servers independent of the remote Git server if
   they specify the bundle URI via a --bundle-uri argument.

 * Bundle URIs work for full and partial clones.

 * Bundle URIs can assist with git fetch in addition to git clone.

The general breakdown is as follows:

 * Patch 1 adds documentation for the feature in its entirety.

 * Patches 2-8 add the git fetch --bundle-uri=<X> and git clone
   --bundle-uri=<X> functionality for a single bundle (no bunde lists).

 * Patches 9-15 add the bundle list data structures and basic parsing so
   that git clone --bundle-uri=<X> can download bundles based on a bundle
   list.

 * Patches 16-24 add the bundle-uri protocol v2 verb and allows git clone to
   discover and download a bundle list advertised by the server.

I consider the patches in their current form to be “RFC quality”. There are
multiple places where tests are missing or special cases are not checked.
The goal for this RFC is to seek feedback on the high-level ideas before
committing to the deep work of creating mergeable patches.

My previous RFC [5] included a running server prototype using static HTTPS
content that is generated by a daily job. I updated that prototype to use
the new bundle list format, but since this RFC does not include
understanding the timestamp heuristic or the partial clone filters, the RFC
isn't appropriate for performance testing with that data. The clones will
still work, but they will download extra data (both the full and partial
bundles).


Intended Focus of this RFC
==========================

This RFC is very large, and that's even with many patches not including full
documentation or tests. These commits are not intended to be reviewed as if
I intended to merge this as-is.

One thing this feature establishes is a new standard by which the Git client
will communicate with external servers. The goal of this RFC is to determine
if this standard is well designed, and whether we need to make it more
robust. Alternatively, the design might need to be changed for reasons I
cannot predict.

[0]
https://github.com/git/git/blob/master/Documentation/technical/packfile-uri.txt
The packfile URI feature in Git (Created June 2020)

[1]
https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
An earlier RFC for a bundle URI feature. (August 2021)

[2]
https://lore.kernel.org/git/cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com/
An earlier patch series creating a 'bundle-uri' protocol v2 capability.
(October 2021)

[3]
https://lore.kernel.org/git/e7fe220b-2877-107e-8f7e-ea507a65feff@gmail.com/
My earlier thoughts on the previous RFCs, many of which are integrated into
this RFC (August 2021)

[4]
https://lore.kernel.org/git/pull.1159.git.1645638911.gitgitgadget@gmail.com/
Add object filters to bundles (February 2022)

[5]
https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com
[RFC] Bundle URIs (February 2022)

[6]
https://lore.kernel.org/git/ddebc223-1e13-e758-f9b1-d3f23961e459@github.com/
Summary of my conversation with Ævar (March 2022)

[7]
https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/
[RFC PATCH v2 00/36] bundle-uri: a "dumb CDN" for git + TOC format (April
2022)

[8]
https://lore.kernel.org/git/pull.1233.git.1652731865.gitgitgadget@gmail.com/
[PATCH 0/8] Bundle URIs: Prepatory patches (May 2022)

Thanks, -Stolee

Derrick Stolee (18):
  docs: document bundle URI standard
  remote-curl: add 'get' capability
  bundle-uri: create basic file-copy logic
  bundle-uri: add support for http(s):// and file://
  fetch: add --bundle-uri option
  fetch: add 'refs/bundle/' to log.excludeDecoration
  clone: add --bundle-uri option
  clone: --bundle-uri cannot be combined with --depth
  bundle-uri: create bundle_list struct and helpers
  bundle-uri: create base key-value pair parsing
  bundle-uri: limit recursion depth for bundle lists
  bundle-uri: parse bundle list in config format
  bundle-uri: fetch a list of bundles
  bundle-uri: serve URI advertisement from bundle.* config
  bundle-uri: allow relative URLs in bundle lists
  bundle-uri: download bundles from an advertised list
  clone: unbundle the advertised bundles
  t5601: basic bundle URI tests

Ævar Arnfjörð Bjarmason (6):
  bundle-uri: create "key=value" line parsing
  bundle-uri: unit test "key=value" parsing
  protocol v2: add server-side "bundle-uri" skeleton
  bundle-uri client: add minimal NOOP client
  bundle-uri client: add "git ls-remote-bundle-uri"
  bundle-uri client: add boolean transfer.bundleURI setting

 .gitignore                                 |   1 +
 Documentation/config/transfer.txt          |   6 +
 Documentation/fetch-options.txt            |   6 +
 Documentation/git-fetch.txt                |   1 +
 Documentation/git-ls-remote-bundle-uri.txt |  62 ++
 Documentation/git-ls-remote.txt            |   1 +
 Documentation/gitremote-helpers.txt        |   6 +
 Documentation/technical/bundle-uri.txt     | 477 +++++++++++++++
 Makefile                                   |   3 +
 builtin.h                                  |   1 +
 builtin/clone.c                            |  45 ++
 builtin/fetch.c                            |  10 +
 builtin/ls-remote-bundle-uri.c             |  71 +++
 bundle-uri.c                               | 663 +++++++++++++++++++++
 bundle-uri.h                               | 139 +++++
 command-list.txt                           |   1 +
 connect.c                                  |  47 ++
 git.c                                      |   1 +
 remote-curl.c                              |  32 +
 remote.h                                   |   5 +
 serve.c                                    |   6 +
 t/helper/test-bundle-uri.c                 |  92 +++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/lib-t5730-protocol-v2-bundle-uri.sh      | 294 +++++++++
 t/t5601-clone.sh                           |  59 ++
 t/t5701-git-serve.sh                       |  40 +-
 t/t5730-protocol-v2-bundle-uri-file.sh     |  36 ++
 t/t5731-protocol-v2-bundle-uri-git.sh      |  17 +
 t/t5732-protocol-v2-bundle-uri-http.sh     |  17 +
 t/t5750-bundle-uri-parse.sh                | 195 ++++++
 t/t6021-fetch-bundle.sh                    |  23 +
 t/test-lib-functions.sh                    |  11 +
 transport-helper.c                         |  18 +-
 transport-internal.h                       |   7 +
 transport.c                                |  87 +++
 transport.h                                |  23 +
 37 files changed, 2503 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/git-ls-remote-bundle-uri.txt
 create mode 100644 Documentation/technical/bundle-uri.txt
 create mode 100644 builtin/ls-remote-bundle-uri.c
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh
 create mode 100755 t/t5750-bundle-uri-parse.sh
 create mode 100755 t/t6021-fetch-bundle.sh


base-commit: 89c6e450fe4a919ecb6fa698005a935531c732cf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1234%2Fderrickstolee%2Fbundle-redo%2Frfc-3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1234/derrickstolee/bundle-redo/rfc-3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1234
-- 
gitgitgadget
