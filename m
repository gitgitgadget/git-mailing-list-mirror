Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 796581F404
	for <e@80x24.org>; Thu, 25 Jan 2018 18:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeAYSxf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 13:53:35 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:45394 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeAYSxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 13:53:34 -0500
Received: by mail-pf0-f178.google.com with SMTP id a88so6420231pfe.12
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 10:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9FQFUpmPu2CtXkTnHenoaJYYrNDvyH9DmcsIO1dZhNM=;
        b=XaQfVYbl7hjiyRX1sNEwQv0hgGEs7Bvh2ZoOGFOzIaKmk7gaFD3ieUjMQlAi/xIJFI
         5jSHGZmhD4ffUbVnK8YNYkRAQymrlPa7A/kb2aLGvsriuPWH47Hruu5aRzWgvz2VhM+b
         nEmObq51DKUr5W4Nw36xyCRVH2RDbj4uIcGWqzm9imJU8GkEx9KnNf5AAc+pe7srEUXj
         G/V65Q3SQQ2eUGiccwSsbzyJO2b+OMWWC3iyDBlz7up9dMmf6AMp2Ac0LVChvJFbmMfL
         qOPdsVEvjSRYoYJoMNUMNJ2GiyykFvBABhYqjxD/xEIiUdJ8cOIue9tAsAjbwHDwZX3L
         fR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9FQFUpmPu2CtXkTnHenoaJYYrNDvyH9DmcsIO1dZhNM=;
        b=VzAYLttspGjwTuRJd0J+/8FqGYaZCHBg3vpzFg0BkcaGwwuK0KdNpMF3V8qiXSIHtf
         ErulsngtvQv2X6EzeKWUeMISU7WQDQNEXWy41zUNARJvlpP4tbtvuOncBlZUy2il5rVK
         ErggMF/UOIdiMQu42cuTbUnwIp5sGAdDRGTBEPMQJ3BHlLwmKtkdYL8rqkrCLjlE8cFp
         yMU5QrIZgXqIMQeOBaI/iAv1yRcbS5wkpNTPVwEUn1HyOHfiVt2Ns+WS6ldxitvlUN7R
         NiSWJqwTXZ9+H9Kh1DmBAI/IUjw43QA503OI9vh7StVl1mLGq5Crt0Ml1NRHQxcDwJ/p
         GT6A==
X-Gm-Message-State: AKwxytcPGDbZWhzTLaTBabwOQsx7gqWdpDNvn2VmviipxAlE+83Qvozf
        nDTbEHfcV/Y/uXf06sD+VHu8Hn7+O9o=
X-Google-Smtp-Source: AH8x226AQfDQ/yD28eTWczI3qVM7Cv8qlIBi4dq6aw+7WFZCcC4kqh5A7hXni6stgAVbHgWEdnfpfQ==
X-Received: by 2002:a17:902:9348:: with SMTP id g8-v6mr11838307plp.102.1516906413194;
        Thu, 25 Jan 2018 10:53:33 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id e3sm16236570pfb.143.2018.01.25.10.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2018 10:53:32 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] Docs: split out long-running subprocess handshake
Date:   Thu, 25 Jan 2018 10:53:24 -0800
Message-Id: <20180125185324.115317-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc2.37.ge0d575025.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Separating out the implementation of the handshake when starting a
long-running subprocess (for example, as is done for a clean/smudge
filter) was done in commit fa64a2fdbeed ("sub-process: refactor
handshake to common function", 2017-07-26), but its documentation still
resides in gitattributes. Split out the documentation as well.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is extracted from my patch from July 2017 [1], which later got
superseded by another patch set that no longer used a long-running
subprocess.

I think this patch (or something similar) is something we'll need sooner
or later, but I'm also OK if we wait until we have a second usage of the
long-running subprocess to merge it in.

[1]
https://public-inbox.org/git/eadce97b6a1e80345a2621e71ce187e9e6bc05bf.1501532294.git.jonathantanmy@google.com/#t
---
 Documentation/Makefile                             |  1 +
 Documentation/gitattributes.txt                    | 54 ++++------------------
 .../technical/long-running-process-protocol.txt    | 50 ++++++++++++++++++++
 sub-process.h                                      |  4 +-
 4 files changed, 61 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/technical/long-running-process-protocol.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4ae9ba5c8..6232143cb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -72,6 +72,7 @@ TECH_DOCS += SubmittingPatches
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
+TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/pack-format
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/pack-protocol
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81..c21f5ca10 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -392,46 +392,14 @@ Long Running Filter Process
 If the filter command (a string value) is defined via
 `filter.<driver>.process` then Git can process all blobs with a
 single filter invocation for the entire life of a single Git
-command. This is achieved by using a packet format (pkt-line,
-see technical/protocol-common.txt) based protocol over standard
-input and standard output as follows. All packets, except for the
-"*CONTENT" packets and the "0000" flush packet, are considered
-text and therefore are terminated by a LF.
-
-Git starts the filter when it encounters the first file
-that needs to be cleaned or smudged. After the filter started
-Git sends a welcome message ("git-filter-client"), a list of supported
-protocol version numbers, and a flush packet. Git expects to read a welcome
-response message ("git-filter-server"), exactly one protocol version number
-from the previously sent list, and a flush packet. All further
-communication will be based on the selected version. The remaining
-protocol description below documents "version=2". Please note that
-"version=42" in the example below does not exist and is only there
-to illustrate how the protocol would look like with more than one
-version.
-
-After the version negotiation Git sends a list of all capabilities that
-it supports and a flush packet. Git expects to read a list of desired
-capabilities, which must be a subset of the supported capabilities list,
-and a flush packet as response:
-------------------------
-packet:          git> git-filter-client
-packet:          git> version=2
-packet:          git> version=42
-packet:          git> 0000
-packet:          git< git-filter-server
-packet:          git< version=2
-packet:          git< 0000
-packet:          git> capability=clean
-packet:          git> capability=smudge
-packet:          git> capability=not-yet-invented
-packet:          git> 0000
-packet:          git< capability=clean
-packet:          git< capability=smudge
-packet:          git< 0000
-------------------------
-Supported filter capabilities in version 2 are "clean", "smudge",
-and "delay".
+command. This is achieved by using the long-running process protocol
+(described in technical/long-running-process-protocol.txt).
+
+When Git encounters the first file that needs to be cleaned or smudged,
+it starts the filter and performs the handshake. In the handshake, the
+welcome message sent by Git is "git-filter-client", only version 2 is
+suppported, and the supported capabilities are "clean", "smudge", and
+"delay".
 
 Afterwards Git sends a list of "key=value" pairs terminated with
 a flush packet. The list will contain at least the filter command
@@ -517,12 +485,6 @@ the protocol then Git will stop the filter process and restart it
 with the next file that needs to be processed. Depending on the
 `filter.<driver>.required` flag Git will interpret that as error.
 
-After the filter has processed a command it is expected to wait for
-a "key=value" list containing the next command. Git will close
-the command pipe on exit. The filter is expected to detect EOF
-and exit gracefully on its own. Git will wait until the filter
-process has stopped.
-
 Delay
 ^^^^^
 
diff --git a/Documentation/technical/long-running-process-protocol.txt b/Documentation/technical/long-running-process-protocol.txt
new file mode 100644
index 000000000..aa0aa9af1
--- /dev/null
+++ b/Documentation/technical/long-running-process-protocol.txt
@@ -0,0 +1,50 @@
+Long-running process protocol
+=============================
+
+This protocol is used when Git needs to communicate with an external
+process throughout the entire life of a single Git command. All
+communication is in pkt-line format (see technical/protocol-common.txt)
+over standard input and standard output.
+
+Handshake
+---------
+
+Git starts by sending a welcome message (for example,
+"git-filter-client"), a list of supported protocol version numbers, and
+a flush packet. Git expects to read the welcome message with "server"
+instead of "client" (for example, "git-filter-server"), exactly one
+protocol version number from the previously sent list, and a flush
+packet. All further communication will be based on the selected version.
+The remaining protocol description below documents "version=2". Please
+note that "version=42" in the example below does not exist and is only
+there to illustrate how the protocol would look like with more than one
+version.
+
+After the version negotiation Git sends a list of all capabilities that
+it supports and a flush packet. Git expects to read a list of desired
+capabilities, which must be a subset of the supported capabilities list,
+and a flush packet as response:
+------------------------
+packet:          git> git-filter-client
+packet:          git> version=2
+packet:          git> version=42
+packet:          git> 0000
+packet:          git< git-filter-server
+packet:          git< version=2
+packet:          git< 0000
+packet:          git> capability=clean
+packet:          git> capability=smudge
+packet:          git> capability=not-yet-invented
+packet:          git> 0000
+packet:          git< capability=clean
+packet:          git< capability=smudge
+packet:          git< 0000
+------------------------
+
+Shutdown
+--------
+
+Git will close
+the command pipe on exit. The filter is expected to detect EOF
+and exit gracefully on its own. Git will wait until the filter
+process has stopped.
diff --git a/sub-process.h b/sub-process.h
index 49701998c..71b18ad5a 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -73,8 +73,8 @@ static inline struct child_process *subprocess_get_child_process(
 }
 
 /*
- * Perform the version and capability negotiation as described in the "Long
- * Running Filter Process" section of the gitattributes documentation using the
+ * Perform the version and capability negotiation as described in the
+ * "Handshake" section of long-running-process-protocol.txt using the
  * given requested versions and capabilities. The "versions" and "capabilities"
  * parameters are arrays terminated by a 0 or blank struct.
  *
-- 
2.16.0.rc2.37.ge0d575025.dirty

