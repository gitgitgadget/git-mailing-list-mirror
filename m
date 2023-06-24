Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5D0EB64DC
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 21:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjFXVXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXVXu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 17:23:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8ECF5
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4008b90d2f9so16104921cf.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687641828; x=1690233828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHBb8ZEDSw1rr4fwOl5lR6o6xnesXaD+GIfr+2r50FU=;
        b=cdnoG7fOBDx6TgX+M3sS9p4waSQhAJUx4JD/L/HnIiBMhWboOXpfRRHF9ArR1LE2sH
         6n0HPA1dkZtKBaR7PU/a3ri8DFJY57kG1ccNmVoGI49O2My8LxgRpSmN8cIUXSXWJ66q
         wQYGYrMkle/AOYpHDPM3IbrqfpfEwwShzU/nQdjy6+AAj285SU4i37aTjxcMqEpgTAqJ
         bH95uoekX/g1limTSK5V8ZCrbAiC4qaEs2Zwmaos3WucgDSDO0HrjCQObUEtoMduy2K9
         k8Mi6Hu3znuCWrmX6TXHXlj3MStHXrgeNUJUww4zNtoAQnjBuiZmL+KkvKZ3Qp4hzoZq
         zh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687641828; x=1690233828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHBb8ZEDSw1rr4fwOl5lR6o6xnesXaD+GIfr+2r50FU=;
        b=cNHeLjrJKHtQqp4qZFVI/iwG254spRfmC/F0/Eutd4O3vBbqwIVEgEwOE/+3cnEaNc
         bEizdT6QSzYNcyrwrpG5vNVC0TFoAJT0+WtKxOpNA/riEDyGxIOnDNApqO6FCuilrXFj
         4dadAKJKuwXwCxKLFeHWhYZWHnP0YtNbG7K9BWSa5zgTd/2PThuWsToHKfnek5+KIf2J
         luisQoUeKnmlmXjyr7YBwx4jMNQ9FqzLJjqB0vOy+Sv8xs03RER+7umOI7EcLMvT2yT0
         8Zx2Bn2zP83x6HekNC6c5zdGtAcklUPs7zPbgYdntjtSPOPMynbOPdrLZ11mkX/nPZlB
         xVVA==
X-Gm-Message-State: AC+VfDzUJb4mY+L2nAEr/21FkadmeCqgKcwfheU1qDIzajWUpgP8tknZ
        BIaTXav55KsG74oFKbmeTmMcNw4cruZXrw==
X-Google-Smtp-Source: ACHHUZ7HKxW+J8CInmNATCCzhxvvzuR3a6Epzv4Nt0P46cAK2JaPkNey9bqfy41yGBl7JMHA+CoIyQ==
X-Received: by 2002:a05:622a:1a24:b0:3ff:21f1:959 with SMTP id f36-20020a05622a1a2400b003ff21f10959mr22154297qtb.7.1687641828343;
        Sat, 24 Jun 2023 14:23:48 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id x15-20020ac87ecf000000b003fdd34c6babsm1118182qtj.76.2023.06.24.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 14:23:48 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
Date:   Sat, 24 Jun 2023 17:23:43 -0400
Message-ID: <20230624212347.179656-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-gui has many snippets of code guarded by an is_Cygwin test, all of
which target a problematic hybrid Cygwin/Windows 8.4.1 Tcl/Tk removed in
March 2012. That is when Cygwin switched to a well-supported unix/X11
Tcl/Tk package.  64-bit Cygwin was released later so has always had the
unix/X11 package. git-gui runs as-is on more recent Cygwin, treating it
as a Linux variant, though two functions are disabled.

The old Tcl/Tk understood Windows pathnames, so git-gui's Cygwin
specific code uses Windows pathnames. The unix/X11 code requires use of
unix pathnames, so none of the Cygwin specific code is compatible, and
all should be removed.

Fortunately, the is_Cygwin funcion in git-gui (on the git master branch)
relies upon the old Tcl/Tk and doesn't detect Cygwin. But, commit
c5766eae6f2b002396b6cd4f85b62317b707174e on the git-gui master branch
"fixed" is_Cygwin, enabling the incompatible code, so upstream git-gui
is now broken on Cygwin.

There is Cygwin specific code in the Makefile, intended to allow a
completely unsupported configuration with a Windows TclTk.  This code
misdetects the configuration, creating a non-portable installation. The
Cygwin git maintainer comments this code out. The code should be
removed.

The existing code for file browsing and creating a desktop icon is
shared with Git For Windows support, and uses Windows pathnames. This
code does not work on Cygwin, and needs replacement.  These functions
have not worked since 2012.

patch 1 removes the obsolete Makefile code
patch 2 removes all obsolete git-gui.sh code, wrapped in is_Cygwin...
patch 3 implements Cygwin specific file browsing support
patch 4 implemetns Cygwin specific desktop icon support

Patches 1/2 cause git-gui to function as it has for the last decade on
Cygwin, but without bugs masking bugs. Patches 3/4 restore functionality
lost with the Tcl/Tk switch in 2012.

Any argument for keeping the old Cygwin code must address who is going
to test and maintain that code, on what platform, and who the target
audience is. The old Tcl/Tk was only on 32-bit Cygwin and only supported
for the Insight debugger, 32-bit Cygwin is no longer supported, git-gui
is not supported on 8.4.1 Tcl/Tk, and the Windows versions targeted by
2012'ish 32-bit Cygwin are no longer supported.

Mark Levedahl (4):
  git gui Makefile - remove Cygwin modiifications
  git-gui - remove obsolete Cygwin specific code
  git-gui - use cygstart to browse on Cygwin
  git-gui - use mkshortcut on Cygwin

 Makefile                  |  21 +------
 git-gui.sh                | 126 ++++----------------------------------
 lib/choose_repository.tcl |  27 +-------
 lib/shortcut.tcl          |  31 +++++-----
 4 files changed, 31 insertions(+), 174 deletions(-)

-- 
2.41.0.99.19

