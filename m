Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3CDC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbhLIBAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbhLIBAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 20:00:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F8AC0617A2
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 16:57:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v11so6997266wrw.10
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 16:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B5rA49xJ57H+pHGjtnqZUNiYmzDUq2cOIZfSPmOB9X8=;
        b=OHPDa7R21+sEgsT8TGNynQswdlYzz19c0WLAx2H25UYJMmPH6QpEXPPCSY6Ry7obtt
         XLyTaqBHOSfLayxmShP0GK2bOCnWAxwmcncW5flh5fkk+WVnBsDwQS/XJ1aVoOSSIP1q
         ZNK+IGlZFUA7WZKAnd5JfkUn16ZHNYpnzuUotKF+QHClFOSXy+EeDe7pOwICMRWvdPwl
         lQDosV3hsY+0F8NObPzAKtG+PkNvUlr7HcP2vYfuDTBrDL5RH4QPqa25kEcRYnTVu2yq
         FtfLtGaR8s/1afd6NnYJQBCJfAhvs1QNm6/PjuKhBGzR8l+EKm8Hf6YnA5r7vJXzGE5V
         mpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B5rA49xJ57H+pHGjtnqZUNiYmzDUq2cOIZfSPmOB9X8=;
        b=3g3vshbdTk2cuunGJbOyR+4WwPy6QBibo6R8THcRTc/YwGKENm+iz+lWGOdTX6z3f+
         5jIYp737/CHhMACVf+UZzQmDYI9TL3y6SS1Ud8GH/HsQwoBAJ1+z/iP+eTWAOsilUnAm
         d8qdmFEWBk6mdxCSlUpBHlBDyv+TxQvHxWhoHu0HkyvmqxyVgBAlHWS/Tx9/WYGXjxWb
         DvUa6nAY/icVFKSkcXPE65AuHi/If+RTwqBhXgzZTqqxAu1Ac6UZVFOSeA6G0KqPZOxZ
         tNYoAqT4lIkQ0cK2Ah61ocCcva526bZglDIWQ1ePz/bJl+zwCiWv9JpGr4JCVE/aKLqU
         +VcA==
X-Gm-Message-State: AOAM533vKzEJuxLySYyw+fbDs+yra8XrLnowgjtQKQG2kCI7FeunY4cX
        4tjsoPJTnl2FLivgMPZ+Lq9zRbUeNSA=
X-Google-Smtp-Source: ABdhPJxjnAJ/habXAEbZpR4o+BAZ41AKSUQHn3fe0YAPxWalhuslPDbv7aK99E5YS1d98/zpN1r2Uw==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr2517031wrt.487.1639011435536;
        Wed, 08 Dec 2021 16:57:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm5102796wri.45.2021.12.08.16.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 16:57:14 -0800 (PST)
Message-Id: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
References: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 00:57:09 +0000
Subject: [PATCH v3 0/4] A design for future-proofing fsync() configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an implementation of an extensible configuration mechanism for
fsyncing persistent components of a repo.

The main goals are to separate the "what" to sync from the "how". There are
now two settings: core.fsync - Control the 'what', including the index.
core.fsyncMethod - Control the 'how'. Currently we support writeout-only and
full fsync.

Syncing of refs can be layered on top of core.fsync. And batch mode will be
layered on core.fsyncMethod.

core.fsyncobjectfiles is removed and will issue a deprecation warning if
it's seen.

I'd like to get agreement on this direction before submitting batch mode to
the list. The batch mode series is available to view at
https://github.com/neerajsi-msft/git/pull/1.

Please see [1], [2], and [3] for discussions that led to this series.

One major concern I'd voice that is adverse to this change: when a new
persistent file is added to the Git repo, the person adding that file will
need to update this configuration code and the documentation. Maybe this is
the right thing to always think about, but the FSYNC_COMPONENT lists will be
a single place that will receive a number of updates over time.

Note: There's a minor conflict with ns/tmp-objdir. In
object-file.c:close_loose_object we need to resolve it like this:

if (!the_repository->objects->odb->will_destroy)
fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd, "loose object
file");

V3 changes:

 * Remove relative path from git-compat-util.h include [4].
 * Updated newly added warning texts to have more context for localization
   [4].
 * Fixed tab spacing in enum fsync_action
 * Moved the fsync looping out to a helper and do it consistently. [4]
 * Changed commit description to use camelCase for config names. [5]
 * Add an optional fourth patch with derived-metadata so that the user can
   exclude a forward-compatible set of things that should be recomputable
   given existing data.

V2 changes:

 * Updated the documentation for core.fsyncmethod to be less certain.
   writeout-only probably does not do the right thing on Linux.
 * Split out the core.fsync=index change into its own commit.
 * Rename REPO_COMPONENT to FSYNC_COMPONENT. This is really specific to
   fsyncing, so the name should reflect that.
 * Re-add missing Makefile change for SYNC_FILE_RANGE.
 * Tested writeout-only mode, index syncing, and general config settings.

[1] https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.com/
[2]
https://lore.kernel.org/git/dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im/
[3]
https://lore.kernel.org/git/pull.1076.git.git.1629856292.gitgitgadget@gmail.com/
[4]
https://lore.kernel.org/git/CANQDOdf8C4-haK9=Q_J4Cid8bQALnmGDm=SvatRbaVf+tkzqLw@mail.gmail.com/
[5] https://lore.kernel.org/git/211207.861r2opplg.gmgdl@evledraar.gmail.com/

Neeraj Singh (4):
  core.fsyncmethod: add writeout-only mode
  core.fsync: introduce granular fsync control
  core.fsync: new option to harden the index
  core.fsync: add a `derived-metadata` aggregate option

 Documentation/config/core.txt       | 35 ++++++++---
 Makefile                            |  6 ++
 builtin/fast-import.c               |  2 +-
 builtin/index-pack.c                |  4 +-
 builtin/pack-objects.c              |  8 ++-
 bulk-checkin.c                      |  5 +-
 cache.h                             | 49 +++++++++++++++-
 commit-graph.c                      |  3 +-
 compat/mingw.h                      |  3 +
 compat/win32/flush.c                | 28 +++++++++
 config.c                            | 90 ++++++++++++++++++++++++++++-
 config.mak.uname                    |  3 +
 configure.ac                        |  8 +++
 contrib/buildsystems/CMakeLists.txt |  3 +-
 csum-file.c                         |  5 +-
 csum-file.h                         |  3 +-
 environment.c                       |  3 +-
 git-compat-util.h                   | 24 ++++++++
 midx.c                              |  3 +-
 object-file.c                       |  3 +-
 pack-bitmap-write.c                 |  3 +-
 pack-write.c                        | 13 +++--
 read-cache.c                        | 19 ++++--
 wrapper.c                           | 64 ++++++++++++++++++++
 write-or-die.c                      | 10 ++--
 25 files changed, 354 insertions(+), 43 deletions(-)
 create mode 100644 compat/win32/flush.c


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1093%2Fneerajsi-msft%2Fns%2Fcore-fsync-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1093/neerajsi-msft/ns/core-fsync-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1093

Range-diff vs v2:

 1:  e79522cbdd4 ! 1:  15edfe51509 core.fsyncmethod: add writeout-only mode
     @@ Metadata
       ## Commit message ##
          core.fsyncmethod: add writeout-only mode
      
     -    This commit introduces the `core.fsyncmethod` configuration
     +    This commit introduces the `core.fsyncMethod` configuration
          knob, which can currently be set to `fsync` or `writeout-only`.
      
          The new writeout-only mode attempts to tell the operating system to
     @@ Commit message
          directive to the storage controller. This change updates fsync to do
          fcntl(F_FULLFSYNC) to make fsync actually durable. We maintain parity
          with existing behavior on Apple platforms by setting the default value
     -    of the new core.fsyncmethod option.
     +    of the new core.fsyncMethod option.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ compat/mingw.h: int mingw_getpagesize(void);
      
       ## compat/win32/flush.c (new) ##
      @@
     -+#include "../../git-compat-util.h"
     ++#include "git-compat-util.h"
      +#include <winternl.h>
      +#include "lazyload.h"
      +
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
      +		else if (!strcmp(value, "writeout-only"))
      +			fsync_method = FSYNC_METHOD_WRITEOUT_ONLY;
      +		else
     -+			warning(_("unknown %s value '%s'"), var, value);
     ++			warning(_("ignoring unknown core.fsyncMethod value '%s'"), value);
      +
      +	}
      +
     @@ git-compat-util.h: __attribute__((format (printf, 1, 2))) NORETURN
      +#endif
      +
      +enum fsync_action {
     -+    FSYNC_WRITEOUT_ONLY,
     -+    FSYNC_HARDWARE_FLUSH
     ++	FSYNC_WRITEOUT_ONLY,
     ++	FSYNC_HARDWARE_FLUSH
      +};
      +
      +/*
     @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
       	return fd;
       }
       
     ++/*
     ++ * Some platforms return EINTR from fsync. Since fsync is invoked in some
     ++ * cases by a wrapper that dies on failure, do not expose EINTR to callers.
     ++ */
     ++static int fsync_loop(int fd)
     ++{
     ++	int err;
     ++
     ++	do {
     ++		err = fsync(fd);
     ++	} while (err < 0 && errno == EINTR);
     ++	return err;
     ++}
     ++
      +int git_fsync(int fd, enum fsync_action action)
      +{
      +	switch (action) {
     @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
      +		 * on macOS, fsync just causes filesystem cache writeback but does not
      +		 * flush hardware caches.
      +		 */
     -+		return fsync(fd);
     ++		return fsync_loop(fd);
      +#endif
      +
      +#ifdef HAVE_SYNC_FILE_RANGE
     @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
      +		 * case, since callers asking for a hardware flush may die if
      +		 * this function returns an error.
      +		 */
     -+		for (;;) {
     -+			int err;
      +#ifdef __APPLE__
     -+			err = fcntl(fd, F_FULLFSYNC);
     ++		return fcntl(fd, F_FULLFSYNC);
      +#else
     -+			err = fsync(fd);
     ++		return fsync_loop(fd);
      +#endif
     -+			if (err >= 0 || errno != EINTR)
     -+				return err;
     -+		}
     -+
      +	default:
      +		BUG("unexpected git_fsync(%d) call", action);
      +	}
 2:  ff80a94bf9a ! 2:  080be1a6f64 core.fsync: introduce granular fsync control
     @@ config.c: static int git_parse_maybe_bool_text(const char *value)
      +
      +		if (!found) {
      +			char *component = xstrndup(string, len);
     -+			warning(_("unknown %s value '%s'"), var, component);
     ++			warning(_("ignoring unknown core.fsync component '%s'"), component);
      +			free(component);
      +		}
      +
 3:  86e39b8f8d1 = 3:  2207950beba core.fsync: new option to harden the index
 -:  ----------- > 4:  a830d177d4c core.fsync: add a `derived-metadata` aggregate option

-- 
gitgitgadget
