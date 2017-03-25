Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4ED61FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 00:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935821AbdCYAgW (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:36:22 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34294 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934689AbdCYAgU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:36:20 -0400
Received: by mail-pf0-f169.google.com with SMTP id p189so2335921pfp.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 17:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BUSp6Xk4flzYojK+KT7TtAZLdtGlE6IHxAwP+ifWnJU=;
        b=eAypm5pbTJVZiBJSL+rqcyUOa3F8xalr9B96AuScNX2Ft0avDupNOZ8q6FyNSHqJiU
         i+o5sTmf7fgmCMCz22GTE2mDtRYoFi1oil+zsfQbpkOagFFMxojKjircA3us8F7o/BoP
         3RScLw0XeZJxZncueG4Jbn/eqjXOD82/uMD2/IpdXJuiZ/Hn9tTtt/Jarcm9oF9RklpV
         m3h/KTWR4n9uU2UcjF4P9gLABCj/OAkGI93kEgoaaJAfwkFUHwVkhMicL0bcG0kEfqgn
         zv4n7zJ1RRf6A47kLT7qSl/0o9rS0vPS97YDX4dj2HlGqOSEQybq3yREfHdQ6e3VBf8G
         mbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BUSp6Xk4flzYojK+KT7TtAZLdtGlE6IHxAwP+ifWnJU=;
        b=osifspmlNzTpFkshf/afh7U9LrGmDPHPymHchBStjsyBdzxaUAVFjsDzZCUByXttka
         t0owArIApTDyR7DGgWc8DgJGoQ0nta4On+MzlF/cQVet93rnJB3K10t67kTNaqiosjik
         URQSDqfse8BzRh4C9xhN1eEZe5j9O8o7OQG76bZQfNrHdvE/tMztpMHGi2v3dHpslyV1
         NKHCmuw9EhrEE6yZtKnPFDqO9t48ahKHrnDRIHa7B2ZMJUg4PRKEBGgRLJJBa39sfrH2
         E7DHgT4i0UWcoS9OxWaFlSDnMDOefg0MLZANMea3GHpF5kWgC0w7rAARXx4viUD+wqox
         PoSg==
X-Gm-Message-State: AFeK/H3BuP+Eym4cC37yRFt8UGFQCJN2cFYFnIpHwsFWjlhPL5TM2YYkhNg+mP6GPcPCs2lO
X-Received: by 10.84.129.2 with SMTP id 2mr14120265plb.119.1490402179039;
        Fri, 24 Mar 2017 17:36:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id v143sm2191011pgb.57.2017.03.24.17.36.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 17:36:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v7 0/7] short status: improve reporting for submodule changes
Date:   Fri, 24 Mar 2017 17:36:03 -0700
Message-Id: <20170325003610.15282-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.gdeb397943c.dirty
In-Reply-To: <20170324182902.19280-1-sbeller@google.com>
References: <20170324182902.19280-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v7:
* taken all of Jonathan minor nits, so patch 1..6 should be good to go
* patch 7 lacks tests and documentation (according to Jonathan...)
  but as it is the last patch, just fixing a minor detail we can leave it off.

Junio, please take patch 1-6 as usual, I will be out until next Wednesday.


Thanks,
Stefan

v6:
* kill the child once we know all information that we ask for, as an optimization
* reordered the patches for that
* strbuf_getwholeline instead of its _fd version.

v5:
* fixed rebase error in the first 2 patches
* the last 3 patches introduce behavior change outside the scope of is_modified_submodule
  whereas the first 4 ought to just be local changes.
  
Thanks,
Stefan

v4:
* broken down in a lot of tiny patches.

Jonathan wrote:
> Patch 1/3 is the one that gives me pause, since I hadn't been able to
> chase down all callers.  Would it be feasible to split that into two:
> one patch to switch to --porcelain=2 but not change behavior, and a
> separate patch to improve what is stored in the dirty_submodule flags?

This part is in the latest patch now.

Thanks,
Stefan


v3:
This comes as a series; first I'd like to refactor is_submodule_modified
to take advantage of the new porcelain=2 plumbing switch to check for changes
in the submodule.

On top of the refactoring comes the actual change, which moved the
rewriting of the submodule change indicator letter to the collection part.

Thanks,
Stefan

Stefan Beller (8):
  submodule.c: port is_submodule_modified to use porcelain 2
  submodule.c: use argv_array in is_submodule_modified
  submodule.c: convert is_submodule_modified to use
    strbuf_getwholeline_fd
  submodule.c: port is_submodule_modified to use porcelain 2
  submodule.c: factor out early loop termination in
    is_submodule_modified
  submodule.c: stricter checking for submodules in is_submodule_modified
  short status: improve reporting for submodule changes
  submodule.c: correctly handle nested submodules in
    is_submodule_modified

 Documentation/git-status.txt |  9 +++++++
 submodule.c                  | 56 ++++++++++++++++++++-----------------------
 t/t3600-rm.sh                | 18 ++++++++++----
 t/t7506-status-submodule.sh  | 57 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 13 ++++++++--
 5 files changed, 116 insertions(+), 37 deletions(-)

-- 
2.12.1.438.gb674c4c09c

