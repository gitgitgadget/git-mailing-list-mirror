Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A25DC2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8122087E
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6RMx4XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgJ2Vcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgJ2Vcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:32:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA8AC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j10so4043609ybl.19
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to;
        bh=UQ+e3X7zc1/amHIYZgRBuk3LqB9tzEMIRruy9vAB9Zw=;
        b=b6RMx4XD8xt7+JPkuhJQChEywj0Ictcx5Rq3rftu0RzcvIF1QLFa8X4FsBLfLstEdA
         Y5lwMiZPX9L9N8ldDhfDkrJwDcZPtmp/SxSRs9kvni/65PpC1uep7lc27vyCAvNH2m3w
         GFSnOG+UHXeFAoLx5Rbs7WBMLkDQGJ5LZbMN+VweUJRdfxwFibJaOFVhCBcdztYX3fY3
         ZaE6TGoBR4VEWsUJWC1xqH15N7kUuDme0pggZv7y+z041pz65DANPU7RKUisobQHMIy7
         1fEyO/WDdjtnOGrPnZwxbv/y4Wl5d4EyO2lYZUzAq5J3k/94T83v0jXv56ZNTlTkSEXh
         kK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to;
        bh=UQ+e3X7zc1/amHIYZgRBuk3LqB9tzEMIRruy9vAB9Zw=;
        b=hKHARztnOus4jRCcxDAnx+EZU9c6+HVtoKM9z9Ff1OCJsImuVsysqCM5EPvnRAzDKS
         zKw44wpHpelU1TDlNUvomdEHGnSkeKTKU0eBnEGR9uuCW1AhiZTRi0eeTI1LwHiyPuNe
         27PZtuM2Px9Q2apEACWvpiwvEowC3UPxY4yXKNpXXVrwdqPpBRdTdvPjeTcubIsgPDuN
         D8XNnOmYlYTz3v8/ByLm7mL1ICXS/K48qUhuO9m2nnGiULdyE5VUeUfCJrrL9yb43snv
         Fw4IbAAmMhMCq6zOjq/19kBG9bRqkdPRtcuyd+ZYl8aCobUtlrXzPdI4Kz4pU+qFhH0K
         c0gQ==
X-Gm-Message-State: AOAM532aEJT2rWBcx4xNsXFdS1NfFT//5h4W2X/SJ9bpPXATpcq2be5u
        cTBdDHO2XWbbHaJlmDHQ8+G4ImZPryrUggZjAdU8GT63Lgm6BjnLrjdsAXlLV8ThJFkHi3by57X
        LfEbd6DOwIqjXRgcxVEJJHom23VRFSnBUFbH1qRNh317wTG7ulZze4bCvtw7IwtE=
X-Google-Smtp-Source: ABdhPJyfiUvJhhhKmoKlkJLlRAPT9J8V4aZq85xfn0/oz3i6pnpuQStLbsr4Cpoa1wy8v5PLfWdNykCJcEZX0Q==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a25:fc0c:: with SMTP id
 v12mr7938561ybd.351.1604007161924; Thu, 29 Oct 2020 14:32:41 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:30 -0700
Message-Id: <cover.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 00/10] Advertise trace2 SID in protocol capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to more easily debug remote operations, it is useful to be able
to inspect both client-side and server-side traces. This series allows
clients to record the server's trace2 session ID, and vice versa, by
advertising the SID in a new "trace2-sid" protocol capability.

Two questions in particular for reviewers:

1) Is trace2/tr2_sid.h intended to be visible to the rest of the code,
  or is the trace2/ directory supposed to be opaque implementation
  detail? If the latter, would it be acceptable to move tr2_sid_get()
  into trace2.h?

2) upload-pack generally takes configuration via flags rather than
  gitconfig. From offline discussions, it sounds like this is an
  intentional choice to limit potential vulnerability from malicious
  configs in local repositories accessed via the file:// URL scheme. Is
  it reasonable to load the trace2.announceSID option from config files
  in upload-pack, or should this be changed to a flag?



Josh Steadmon (10):
  docs: new capability to advertise trace2 SIDs
  docs: new trace2.advertiseSID option
  upload-pack: advertise trace2 SID in v0 capabilities
  receive-pack: advertise trace2 SID in v0 capabilities
  serve: advertise trace2 SID in v2 capabilities
  transport: log received server trace2 SID
  fetch-pack: advertise trace2 SID in capabilities
  upload-pack, serve: log received client trace2 SID
  send-pack: advertise trace2 SID in capabilities
  receive-pack: log received client trace2 SID

 Documentation/config/trace2.txt               |  4 +
 .../technical/protocol-capabilities.txt       | 13 ++-
 Documentation/technical/protocol-v2.txt       |  9 +++
 builtin/receive-pack.c                        | 16 ++++
 fetch-pack.c                                  | 11 +++
 send-pack.c                                   |  9 +++
 serve.c                                       | 19 +++++
 t/t5705-trace2-sid-in-capabilities.sh         | 79 +++++++++++++++++++
 transport.c                                   | 10 +++
 upload-pack.c                                 | 23 +++++-
 10 files changed, 190 insertions(+), 3 deletions(-)
 create mode 100755 t/t5705-trace2-sid-in-capabilities.sh

-- 
2.29.1.341.ge80a0c044ae-goog

