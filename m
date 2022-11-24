Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA80C43217
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 15:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKXPjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 10:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXPjl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 10:39:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56D30562
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:38 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n17so1819973pgh.9
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjIBdx8w5coPECEV21lKVgSpoWO+3ixUOvM2WdLBQqc=;
        b=UsEE2Y+sT9nJdUftJeyXr/SLIUrg91IO48dFbs+PMbDjRynyU5+RoVWP5xnDGi0fB9
         k19XDIe15swqjbCefF8aDtbsJt0HjZKo43M4O8Vxboaq/6QAWa/Ffwo4iKhpAkNacohc
         sYoyD9lKb2vuDaEInC4uqo16x4Y3ILT+JrGFOR46WCKHzcUHKOgqDpDIJg65qAFLEeIp
         Ya2Zo/mx3FyUTp4s7oZXTlcgdObaK7NlTIZZElktLRYIxu5vfF1iNdUL8Kovjo2JJ340
         MJlAAjnTRYYg+NGXu6nF45H/TAQH+4g6eWbWB/Fw+EeIt9dNDfMM+C9N2ftyujhjH6hI
         E0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjIBdx8w5coPECEV21lKVgSpoWO+3ixUOvM2WdLBQqc=;
        b=GQDAWLSjWHv1Q5slCCgnyuah6kBKWn3qwbor8qrOwQEWjxBDx5ABZmdQDwYa45QAQW
         vVoOd/cGpIYim41zuAXjnZVeo74Rucq7XtS6kwi09NTI42UlgkFYkOVPBWcE8PD7trFe
         Ctu22BwmCC8OC5+mW+bupsVtxOUiwU8yRAdfNsUkIAOjddJHK9wI1XexKyVHHUknaHYS
         5bmNOwzWvVnrwNYTkaZTOlHyOhlfAyJ/pptY2L2IqSvcqvPEPEvJY0XY0se64i97bTJS
         OQHddSLVewCZB8Jvk0BH7zoQ7cEhAEb+dIuDqAKOVEH+psppWqZJ/5yNkZvYt0CIVAAH
         t+bw==
X-Gm-Message-State: ANoB5plPo4b0qmoM4Paq4HAz09NHQS9BcjLWN/wdY3+paWEFumS4Y1tD
        4H7jHfw4kL14ZgPi11IsmmbBxl0VBp8=
X-Google-Smtp-Source: AA0mqf7aUmq8VUy2NNK6ZzkRK6nawPe7sbUTzp8r2ieAt5hAlnIUocjet19k5QKH7EgiOnfyN0vUOA==
X-Received: by 2002:a63:2117:0:b0:474:f7bd:9462 with SMTP id h23-20020a632117000000b00474f7bd9462mr13764542pgh.189.1669304378111;
        Thu, 24 Nov 2022 07:39:38 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0017f48a9e2d6sm1413089pln.292.2022.11.24.07.39.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2022 07:39:37 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 0/4] Fix broken CI on newer github-actions runner image 
Date:   Thu, 24 Nov 2022 23:39:30 +0800
Message-Id: <20221124153934.12470-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221124090545.4790-1-worldhello.net@gmail.com>
References: <20221124090545.4790-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

# Changes since v2

1. Split patch 2/3 of v2 into two patches:

   patch 2/4: ci: show error message of "p4 -V"
   patch 3/4: ci: p4 on Linux has the same version as on macOS

2. In patch 3/4, remove variable "LINUX_P4_VERSION" and use
   a fixed version "21.2" for p4 on both Linux and macOS.

3. For patch 4/4, follow Ævar's suggestion to make the code simpler.


# Range-diff v2..v3

1:  79c851529c ! 1:  1c0d639487 github-actions: run gcc-8 on ubuntu-20.04 image
    @@ Commit message
         In this way, we can change the "ubuntu-latest" runner image to any
         version such as "ubuntu-22.04" to test CI behavior in advance.
     
    +    Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## .github/workflows/main.yml ##
2:  faa5076fe0 ! 2:  fed880b8bd ci: upgrade version of p4 to 21.2
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    ci: upgrade version of p4 to 21.2
    +    ci: show error message of "p4 -V"
     
    -    There would be a segmentation fault when running p4 v16.2 on ubuntu
    -    22.04 which is the latest version of ubuntu runner image for github
    -    actions.
    +    When installing p4 as a dependency, we used to pipe output of "p4 -V" to
    +    validate the installation, but this would hide potential errors of p4.
    +    E.g.: A broken p4 installation fails to run.
     
    -    By checking each version from [1], p4d version 21.1 and above can work
    -    properly on ubuntu 22.04. But version 22.x will break some p4 test
    -    cases. So p4 version 21.x is exactly the version we can use.
    -
    -    In addition to upgrade p4 from version 16.2 to 21.2, also add some
    -    instructions to show errors of command "p4 -V", so we can see why the
    -    command output doesn't match.
    -
    -    [1]: https://cdist2.perforce.com/perforce/
    +    Add some instructions to show errors of command "p4 -V", so we can see
    +    why the command output doesn't match.
     
    +    Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## ci/install-dependencies.sh ##
    @@ ci/install-dependencies.sh: esac
      else
      	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
      fi
    -
    - ## ci/lib.sh ##
    -@@ ci/lib.sh: ubuntu)
    - 	# were recorded in the Homebrew database upon creating the OS X
    - 	# image.
    - 	# Keep that in mind when you encounter a broken OS X build!
    --	export LINUX_P4_VERSION="16.2"
    -+	export LINUX_P4_VERSION="21.2"
    - 	export LINUX_GIT_LFS_VERSION="1.5.2"
    - 
    - 	P4_PATH="$HOME/custom/p4"
-:  ---------- > 3:  da2f516fc9 ci: p4 on Linux has the same version as on macOS
3:  f080b2fdcd ! 4:  bd1850cc93 ci: install python on ubuntu
    @@ Commit message
         Since the "ubuntu-latest" runner image has a higher version, so its safe
         to use "python2" or "python3" package name.
     
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## ci/install-dependencies.sh ##
    @@ ci/install-dependencies.sh: case "$runs_on_os" in
     
      ## ci/lib.sh ##
     @@ ci/lib.sh: ubuntu)
    - 	if [ "$jobname" = linux-gcc ]
    + 		break
    + 	fi
    + 
    +-	if [ "$jobname" = linux-gcc ]
    ++	PYTHON_PACKAGE=python2
    ++	if test "$jobname" = linux-gcc
      	then
    - 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
    +-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
    +-	else
    +-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
     +		PYTHON_PACKAGE=python3
    - 	else
    - 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
    -+		PYTHON_PACKAGE=python2
      	fi
    ++	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
      
      	export GIT_TEST_HTTPD=true
    + 

--

Jiang Xin (4):
  github-actions: run gcc-8 on ubuntu-20.04 image
  ci: show error message of "p4 -V"
  ci: p4 on Linux has the same version as on macOS
  ci: install python on ubuntu

 .github/workflows/main.yml | 16 ++++++++++++----
 ci/install-dependencies.sh | 16 ++++++++--------
 ci/lib.sh                  | 15 +++++++--------
 3 files changed, 27 insertions(+), 20 deletions(-)

-- 
2.39.0.rc0

