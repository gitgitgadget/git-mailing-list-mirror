Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EAEC433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CBC61432
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhEHGT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 02:19:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53037 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhEHGT1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 May 2021 02:19:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id E83AA5C012E
        for <git@vger.kernel.org>; Sat,  8 May 2021 02:18:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 08 May 2021 02:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=from:to:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm3; bh=DR8oh+bwyHy0k
        b2VmM8h+VRXrsBahOB37oiXZPmAfZg=; b=g9dvxkeW0DnfIljFO/na9W5MDUNnB
        5AYfNJnz/gV16n0lrYAMZmtPfDz3Mbk8nwo3kBPgj8mY8ToggmX6msbxhP3ioJ5v
        V22pWO9pusOImOoEcJXzmj4ZqUWvmxbVeDWkq/ZTA6Ke1+bauoOZUzCPkN42y8t1
        XMxLF96nfC+PYZrPaYzywLSnPx6iP/bkw1nCHWflZSoib7zRqI0nHDl507YGmoGu
        +w8RDXuVRWhsgTxgJsd6uOeOtn94tp3nXlrJRsD6CQIGN7iDLeNeUx68g0u9F+oi
        /DGptPm2ZIgTTW/e5SeoxrzxJXj7/O6oOEWFnJXV9QhnYTJncelZegWvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DR8oh+bwyHy0kb2Vm
        M8h+VRXrsBahOB37oiXZPmAfZg=; b=OnFsQQMk7OB3i3fBYeh+glu6S/S4wU5BX
        qtzU+7zpCeHCpnzfD66sC0v/jadrWlxh2+VOywVwd9VyN5SF+seObsgW0FJ0b/71
        FGmQGzREU/xv2lW9wn34y9KDNJrLW9e8TpmsbwEruUC1N3CN10x7ILANTnYYLOeu
        L6y7aTXVLsVhXYVIkk7Dj0CsPuINd2DeEv6FmQ8dDBhF5Z71PTIxwhwY0hui6D7+
        l7VVzNOf2kAthL0aGLu7LAcEIwJ3tbQpec2sUlUaqnfXO2M8x1DTK6B08jXNzwGh
        H/YfA815xDZ7/VKRd3RqD2rDl0H5mYbhkimh6LXW+6R8ear4krQmQ==
X-ME-Sender: <xms:MS2WYHs4b8tt0753mue31IHL-Hp732krokYO_4PN1IbWkFIXcj71Pw>
    <xme:MS2WYIeqc46rVwOaYEdudNkFrDBbZQnbVW1WLzFJq9EZENrkPwpVq1Y2NTVIwXQkO
    YRK1pu5vdnp5BmN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegfedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghvvgcujfhushgvsgihuceougifhheslhhinhhugihprhho
    ghhrrghmmhgvrhdrohhrgheqnecuggftrfgrthhtvghrnhepvdffgffgteeuteefleegff
    fghfehieefveeigffgudfhgeeguddutdfhvdelvdehnecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhenucfkphepieekrddvvdegrdeikedrheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhm
    vghrrdhorhhg
X-ME-Proxy: <xmx:MS2WYKw9SdDwUw__GW9Yf_ow5ypDkzVbr-dfPLOhdGbv-1mNGdCI_w>
    <xmx:MS2WYGM2C8QLdk8_MhiJFcEJLR2ZNifkOHYwxAxwTgqproVx8sXXyA>
    <xmx:MS2WYH_eKsWs-hklRCEpiHYVcSF2TIwX8mkcJrJ4eg1GCErLGycCjg>
    <xmx:MS2WYFcEHpcgNRUIpuTba7ZMDtcXXo-n7Pu2YLARAB0y1seQ9Hw7ag>
Received: from linuxprogrammer.org (ip68-224-68-5.lv.lv.cox.net [68.224.68.5])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Sat,  8 May 2021 02:18:25 -0400 (EDT)
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     git@vger.kernel.org
Subject: [RFC PATCH v1 0/1] Universal cryptographic signing
Date:   Fri,  7 May 2021 23:18:22 -0700
Message-Id: <cover.1620454449.git.dwh@linuxprogrammer.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC patchset is the beginning of a project generously sponsored by
Google and the Linux Foundation to modify Git to have universal
cryptographic signing capabilities. Curently Git only supports gpg and
gpgsm and the primary goal is to create the ability to use any
signing/verification tool to sign Git commits, tags, mergetags, and
pushes with a specific emphasis on supporting OpenSSH.

The goals of this project are:

- maintain full backwards compatibility without intervention. if it
  works today, it will work after these patches land without any
  modification to configs or support scripts.
- remove all tool-specific code and replace it with a protocol driver
  for using a standard protocol to talk to external signing and
  verification tools.
- normalize all of the command line switches so that they are the same
  for all tools that support signing and they are no longer tool
  specific (e.g. --sign instead of --gpgsign).
- add a new sign.* configuration structure for specifying tool specific
  configuration options (e.g. sign.openpgp.program) and deprecate all of
  the signing related config options that are no longer needed (e.g.
  user.signingKey).
- make Git completely agnostic to the details of any signing regime by
  storing signature data and options verbatim inside of signed objects
  that it later passes to the associated verification tool.
- add new tests needed to cover the new functionality while keeping all
  of the old tests passing to verify backwards compatibility.

The proposed protocol for talking to signing/verification tools is a
pkt-line based protocol inspired by the Assuan protocol used by GPG for
IPC between its component executables. The full write-up on the proposed
protocol is here:

https://github.com/TrustFrame/git-cryptography-protocol/blob/main/Git%20Cryptography%20Protocol.md

Like I said, this patchset is just the start of the project and all I
have done here is gone through all of the existing documentation and
updated it to reflect the normalized command line and config options as
well as documented the new sign.* config options and the proposed
signature format.

I am especially looking for feedback on the proposed protocol, signature
format and config structure. I have plans to follow up this project with
another project to add support for config directories (e.g.
.gitconfig.d) so that package maintainers will have an easier time of
adding sign.* config values for arbitrary signing tools.

As of right now, I have only grok'ed the handling of signed objects and
I have ignored signed pushes. I will be updating this patchset with
changes to the documentation for supporting universal signed pushes.

There's some sticky details around the transition to SHA256 that I think
I have worked out well enough that it won't get in the way. That is
documented in the hash-function-transition.txt file.

I know there is a lot here, this project cuts deep and will require tons
of test driven development to avoid killing the patient during surgery.
I look forward to the many long conversations on details ;)

Cheers!

Dave Huseby (1):
  Modifies documentation for universal cryptographic signing

 Documentation/config.txt                      |   2 +
 Documentation/config/commit.txt               |  23 +-
 Documentation/config/gpg.txt                  |  36 +--
 Documentation/config/push.txt                 |  18 +-
 Documentation/config/sign.txt                 |  72 ++++++
 Documentation/config/tag.txt                  |  27 +-
 Documentation/config/user.txt                 |  12 +-
 Documentation/git-am.txt                      |  43 +++-
 Documentation/git-cherry-pick.txt             |  43 +++-
 Documentation/git-commit-tree.txt             |  44 +++-
 Documentation/git-commit.txt                  |  43 +++-
 Documentation/git-fast-import.txt             |   2 +-
 Documentation/git-for-each-ref.txt            |   2 +-
 Documentation/git-mktag.txt                   |  32 ++-
 Documentation/git-rebase.txt                  |  44 +++-
 Documentation/git-revert.txt                  |  44 +++-
 Documentation/git-tag.txt                     | 102 +++++---
 Documentation/git-verify-commit.txt           |   8 +-
 Documentation/git-verify-tag.txt              |   8 +-
 Documentation/merge-options.txt               |  40 ++-
 Documentation/pretty-formats.txt              |   2 +-
 Documentation/pretty-options.txt              |   2 +-
 .../technical/hash-function-transition.txt    |  31 ++-
 .../technical/signature-format-v2.txt         | 232 ++++++++++++++++++
 Documentation/user-manual.txt                 |  40 +--
 25 files changed, 747 insertions(+), 205 deletions(-)
 create mode 100644 Documentation/config/sign.txt
 create mode 100644 Documentation/technical/signature-format-v2.txt

-- 
2.20.1

