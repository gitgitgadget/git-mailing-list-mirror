Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E24DC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F79220708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="UyGfKgx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgA3UdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:33:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42676 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgA3UdO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id q15so4293755qke.9
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upPJQ5vxCPpK76IkBKnWioVHa9izKUgbMq6QuhnuQXE=;
        b=UyGfKgx6mztRwKwOOUi6COGRCf2zfIn6EJqfLm2fYa+zLfj7vlQslM8Crdb+/1oGFm
         t8JFPp5CQufvjxh10YG7okEqi3B5CqDFqN6jKQNmNBDsH+gpRYXgiBeSbG2WHlcvrAX8
         nmjXngdHiLX5T5xdxczHX5GbrUPUueBKUuJk0KYYuETky4/d8js+f7yVsOqUHQcYJ21W
         EQijcUKNBno6/6ZTnRA/+e8rEjMQD2Q4lQY9WCsLfITw/PqXt4CoT6KvCW7e/membh47
         CpkYLg5P4IDZ0zXJ2XDxQia4S1VtZ+sx3W91J61L9IQjhRGPtN2JZAyXr1E+1Iec3P9+
         U6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upPJQ5vxCPpK76IkBKnWioVHa9izKUgbMq6QuhnuQXE=;
        b=OXf2DmKaGTci+ZTb5PJXcMu1NAu9jJPw1hiVjLffA7o5Q+ExOV08nDZ2hdVjiZyDFO
         Wc+kr8hWe2L7nFSzm0bCRk7oGa3jQcTwLMq12TNLGVZFcEmHCUZA1ffnHrQYj4XL01ar
         g5mh17ENMFA3YNP5mJwe24miPj+wNTZL1uZEkbP37uSzuh37qgnU+MzhdNWZ3RdFnh5k
         mYhOPu4E5UK/s0gH0SV6geIZTdvx9q5BpBF7R4Z70NBiI992lIuP1NUKIVmsyAf6j3ap
         pgtAyG57bXCI+nRdkROvH1ho0cPqh4thDcaXiO1QwcwLBLAaIT2kz8z9bXkrk4nf9307
         S21Q==
X-Gm-Message-State: APjAAAXLDa/xvOLe/m6Ru2RBlwpMOvVIEGyZtcVDwRLjkuluwYxlM/O6
        IHb2Ucvz2iQyTKqgBbLAVGMPK4VVAHk=
X-Google-Smtp-Source: APXvYqzlVxFV1oCiJfeT05ypZH7l0+sucRzSeaJBXlIe8nMff91QTiMESiLR7oxSAI6mu76jr0Gw8w==
X-Received: by 2002:a05:620a:1102:: with SMTP id o2mr7222743qkk.278.1580416393073;
        Thu, 30 Jan 2020 12:33:13 -0800 (PST)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o12sm3436514qke.79.2020.01.30.12.33.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:12 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 0/7] fix inconsistent uses of the_repo in parse_object()'s call chain 
Date:   Thu, 30 Jan 2020 17:32:16 -0300
Message-Id: <cover.1580413221.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The motivation for this patchset is another series I'm working on, to
make git-grep stop adding submodules' odbs to the alternates list. With
that, parse_object() will have to be called with the subdmodules' struct
repository. But it seemed that this function doesn't pass on the
received repo to some inner calls, which, instead, always use
the_repository. This series seeks to fix these inconsistencies.

Note: I also tried to replace some uses of the_hash_algo with the struct
git_hash_algo from the received repository, for consitency. (In
practice, I'm not sure if this is very useful right now, but maybe it
will be relevant for the change to SHA256?) Still, many functions in
parse_object()'s call chain call oid_to_hex(), which uses the_hash_algo.
Since changing this would require a much bigger operation, I decided to
leave it as is, for now.

Note II: Despite receiving a repo through the apply_state struct,
apply.c:apply_binary() call functions which uses the_repository
internally. Because of that, I used the_hash_algo in this function in
patch 6. Should I change it to use apply_state->repo->hash_algo
anyway?

travis build: https://travis-ci.org/matheustavares/git/builds/644022000

Matheus Tavares (7):
  diff: make diff_populate_filespec() honor its repo argument
  cache-tree: use given repo's hash_algo at verify_one()
  pack-check: use given repo's hash_algo at verify_packfile()
  streaming: allow open_istream() to handle any repo
  sha1-file: pass git_hash_algo to write_object_file_prepare()
  sha1-file: pass git_hash_algo to hash_object_file()
  sha1-file: allow check_object_signature() to handle any repo

 apply.c                  |  6 +++--
 archive-tar.c            |  6 ++---
 archive-zip.c            |  3 ++-
 builtin/fast-export.c    |  3 ++-
 builtin/index-pack.c     | 10 +++++---
 builtin/mktag.c          |  7 +++--
 builtin/pack-objects.c   |  3 ++-
 builtin/replace.c        |  3 ++-
 builtin/unpack-objects.c |  3 ++-
 cache-tree.c             | 11 +++++---
 cache.h                  |  3 ++-
 convert.c                |  2 +-
 diff.c                   |  2 +-
 diffcore-rename.c        |  4 +--
 dir.c                    |  4 +--
 log-tree.c               |  3 ++-
 object-store.h           |  5 ++--
 object.c                 |  5 ++--
 pack-check.c             | 12 ++++-----
 sha1-file.c              | 55 ++++++++++++++++++++++------------------
 streaming.c              | 28 ++++++++++----------
 streaming.h              |  4 ++-
 22 files changed, 106 insertions(+), 76 deletions(-)

-- 
2.25.0

