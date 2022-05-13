Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2884C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 01:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359833AbiEMBAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 21:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359831AbiEMBAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 21:00:35 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E6228BDCE
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:33 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b20so6062870qkc.6
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddn9cFEUNoGKdPrc1gPdTc0+DmS25Tvm9uG0ViP8VDg=;
        b=UpnRQPwyakrbrCKKEKyjw5Ff0rfyragATugoAwZD5kIAHG8OBo9FZpPXtlbe5gd4p4
         pB33AHrZ8t30CTgvaR7q7rbyhTNCCxjWEliEwX3UDF6HKXCoJnPxgGAPsfJ6nG7bIlU7
         f5NpSZxuVwNR12RnZNVNzLWDK398MqIcWmbThT9aAWtM37MksvZR0Q56aTwCQJHTsYlL
         2Jn0WVLJ3sKVoM72x3UJztaY3qKHHJ/kSgIyMxiZ3rbjJbZG2ZQeiHAPYwpyeRG5FCL+
         BUCMBSC0VJudCPK2esqXtQWTc91WHUegXfbmqoi6UMaihWNVyjiqSuq/GNurbzLRvDO/
         BGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddn9cFEUNoGKdPrc1gPdTc0+DmS25Tvm9uG0ViP8VDg=;
        b=ivwhkfLndB0XWJDnD7Hh2krDxkWNGNnP2m20Uc+kP1lhMEB2VTY7DceAc1RqoVWkJJ
         lnH+VmGIqDqxP4FV7ZIqB/dPgZEHi3o/7xwXi9j4KRbuezO8XdnHlqY+k+1jmafoduPy
         sEP+VUDvcQIFbLgeiJlqe78WZJp6JFGvkUSOPYTFVJs4ilThDl/yPfwRr3aqBf8jzcd7
         yMrtOoMk8utCTxat365ckrr+mv2WkCk0IqFjRtv6BV5TnvY2iCS09JnsQ3qGjqkAbtHu
         lA95zyWw0oWxHWoxdJYuqWxA+k2x0QLSdy4kWCtPFVVmLgYygiEjgUmvMzVcJVdKl+k/
         pKOA==
X-Gm-Message-State: AOAM5301+1Qze2+ybHffmhJR3wiXAP9RWXuTwY/aoyAafwFjUZLsd8xI
        OGtVpFINJmX+xvIq+VpMPdXUIibOB8w=
X-Google-Smtp-Source: ABdhPJzItVELaD1OxjSgkO/ql0r5s8uVu9ZYRN5bOkL6dEy3l1LmNC17sdUbESOMTpnNlVc6qOzw3Q==
X-Received: by 2002:a05:620a:45a7:b0:6a0:3399:c9ce with SMTP id bp39-20020a05620a45a700b006a03399c9cemr2045118qkb.590.1652403631898;
        Thu, 12 May 2022 18:00:31 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s202-20020a3745d3000000b0069fc13ce227sm583541qka.88.2022.05.12.18.00.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 18:00:30 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v5 0/4] fix `sudo make install` regression in maint
Date:   Thu, 12 May 2022 18:00:16 -0700
Message-Id: <20220513010020.55361-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220510174616.18629-1-carenas@gmail.com>
References: <20220510174616.18629-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A reroll for cb/path-owner-check-with-sudo which should hopefully cover
for all feedback plus an extra (optional) patch to implement a fix for
the "regression" that this introduces

A range-diff against v4 provided below to easy review but the only code
changes come from the 4th patch which might be ironically the less
controversial even if not strictly needed.

The tests are not enabled by default, but a run of this on top of seen
that had an extra patch to enable them shows no failures[1].  Either way
they are only expected to run in the macOS agents because of the sudo
configuration that is needed, and which will require additional changes
to improve coverage.

Carlo Marcelo Arenas Belón (4):
  t: regression git needs safe.directory when using sudo
  git-compat-util: avoid failing dir ownership checks if running
    privileged
  t0034: add negative tests and allow git init to mostly work under sudo
  git-compat-util: allow root to access both SUDO_UID and root owned

 Documentation/config/safe.txt  | 14 +++++
 git-compat-util.h              | 58 ++++++++++++++++++++-
 t/lib-sudo.sh                  | 15 ++++++
 t/t0034-root-safe-directory.sh | 93 ++++++++++++++++++++++++++++++++++
 4 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-sudo.sh
 create mode 100755 t/t0034-root-safe-directory.sh

[1] https://github.com/carenas/git/actions/runs/2316684806
-- 
1:  0096bb0968f ! 1:  2f17307e1a9 t: regression git needs safe.directory when using sudo
    @@ Commit message
           $ sudo rm -rf trash\ directory.t0034-root-safe-directory/
     
         The test file also uses at least one initial "setup" test that creates
    -    a parallel execution directory, while ignoring the repository created
    -    by the test framework.
    +    a parallel execution directory under the "root" sub directory, which
    +    should be used as top level directory for all repositories that are
    +    used in this test file.  Unlike all other tests the repository provided
    +    by the test framework should go unused.
     
         Special care should be taken when invoking commands through sudo, since
         the environment is otherwise independent from what the test framework
    @@ t/t0034-root-safe-directory.sh (new)
     +test_expect_success SUDO 'setup' '
     +	sudo rm -rf root &&
     +	mkdir -p root/r &&
    -+	sudo chown root root &&
     +	(
     +		cd root/r &&
     +		git init
2:  7ba248dace4 ! 2:  ccaa3f3c71d git-compat-util: avoid failing dir ownership checks if running privileged
    @@ Commit message
         that way in their codebase to generate SUDO_UID.  In systems where uid_t
         is signed, sudo might be also patched to NOT be unsigned and that might
         be able to trigger an edge case and a bug (as described in the code), but
    -    it is considered unlikely to be triggered, and even when it does the code
    -    would just safely fail, so there is no attempt either to detect it or
    -    prevent it in the code, which might need to be changed in the future.
    +    it is considered unlikely to happen and even if it does, the code would
    +    just mostly fail safely, so there was no attempt either to detect it or
    +    prevent it by the code, which is something that might change in the future,
    +    based on expected user feedback.
     
         Reported-by: Guy Maurel <guy.j@maurel.de>
         Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
    @@ Documentation/config/safe.txt: directory was listed in the `safe.directory` list
      initialize your list with an empty value before listing the repositories
      that you deem safe.
     ++
    -+When git tries to check for ownership of git repositories, it will
    -+obviously do so with the uid of the user that is running git itself,
    -+but if git is running as root, in a platform that provides sudo and is
    -+not Windows, it will check first if it might have been started through
    -+it, and if that is the case, will use the uid of the user that invoked
    -+sudo instead.
    ++As explained, Git only allows you to access repositories owned by
    ++yourself, i.e. the user who is running Git, by default.  When Git
    ++is running as 'root' in a non Windows platform that provides sudo,
    ++ however, git checks the SUDO_UID environment variable that sudo creates
    ++and will allow access to the uid recorded as its value instead.
    ++This is to make it easy to perform a common sequence during installation
    ++"make && sudo make install".  A git process running under 'sudo' runs as
    ++'root' but the 'sudo' command exports the environment variable to record
    ++which id the original user has.
     +If that is not what you would prefer and want git to only trust
    -+repositories that are owned by root instead, then you should remove
    -+the `SUDO_UID` variable from root's environment.
    ++repositories that are owned by root instead, then you must remove
    ++the `SUDO_UID` variable from root's environment before invoking git.
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: static inline int git_offset_1st_component(const char *path)
    @@ git-compat-util.h: static inline int git_offset_1st_component(const char *path)
     +#endif
     +
     +/*
    -+ * This helper function overrides a ROOT_UID with the one provided by
    -+ * an environment variable, do not use unless the original user is
    -+ * root or could be used as means to escalate to root privileges.
    ++ * Do not use this function when
    ++ * (1) geteuid() did not say we are running as 'root', or
    ++ * (2) using this function will compromise the system.
     + *
     + * PORTABILITY WARNING:
     + * This code assumes uid_t is unsigned because that is what sudo does.
     + * If your uid_t type is signed and all your ids are positive then it
    -+ * should all work fine, but need to make sure sudo never generates a
    -+ * value higher than what can be represented by your uid_t type or a
    -+ * negative value or it will trigger wraparound bugs.
    -+ *
    -+ * If that happens the uid used might be incorrect and then trigger
    -+ * an access error from the filesystem itself.
    -+ *
    ++ * should all work fine.
    ++ * If your version of sudo uses negative values for uid_t or it is
    ++ * buggy and return an overflowed value in SUDO_UID, then git might
    ++ * fail to grant access to your repository properly or even mistakenly
    ++ * grant access to someone else.
     + * In the unlikely scenario this happened to you, and that is how you
    -+ * got to this message, we would like to know about it by letting us
    -+ * now with an email to git@vger.kernel.org indicating which platform,
    -+ * you are running on and which version of sudo you used to see if we
    -+ * can provide you a patch that would prevent this issue in the future.
    ++ * got to this message, we would like to know about it; so sent us an
    ++ * email to git@vger.kernel.org indicating which platform you are
    ++ * using and which version of sudo, so we can improve this logic and
    ++ * maybe provide you with a patch that would prevent this issue again
    ++ * in the future.
     + */
     +static inline void extract_id_from_env(const char *env, uid_t *id)
     +{
    @@ git-compat-util.h: static inline int git_offset_1st_component(const char *path)
     +		unsigned long env_id;
     +
     +		errno = 0;
    -+		/* silent overflow errors could trigger a bug below */
    ++		/* silent overflow errors could trigger a bug here */
     +		env_id = strtoul(real_uid, &endptr, 10);
     +		if (!*endptr && !errno)
     +			*id = env_id;
3:  1ed06acc93c ! 3:  2a9c0c20e08 t0034: add negative tests and allow git init to mostly work under sudo
    @@ Commit message
         Add additional negative tests as suggested by Junio and that use a
         new workspace that is owned by root.
     
    -    Note that the specific test that documents that after the previous
    -    changes, it is no longer possible for root (if obtained through sudo)
    -    to NOT add an exception or NOT need a "workaround" to be able to run git
    -    commands in a repository owned by thyself, is marked as a regression
    -    and is expected to be fixed with a future change, which hasn't been
    -    provided yet and that is not part of this series.
    +    Document a regression that was introduced by previous commits where
    +    root won't be able anymore to access directories they own unless
    +    SUDO_UID is removed from their environment.
     
    -    As described in the comments from the test itself, at least one of the
    -    documented workarounds could fail if sudo doesn't allow root to call sudo
    -    or if root is not in sudoers, but that is very unlikely, and more
    -    importantly actually not what is provided by the currently supported sudo
    -    configuration this test already relies on and therefore adding a way to
    -    validate it works in the prerequisite has been punted for now.
    +    The tests document additional ways that this new restriction could
    +    be worked around and the documentation explains why it might be instead
    +    considered a feature, but a "fix" is planned for a future change.
     
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
    @@ t/lib-sudo.sh (new)
     +	local ret
     +	local RUN="$TEST_DIRECTORY/$$.sh"
     +	write_script "$RUN" "$TEST_SHELL_PATH"
    ++	# avoid calling "$RUN" directly so sudo doesn't get a chance to
    ++	# override the shell, add aditional restrictions or even reject
    ++	# running the script because its security policy deem it unsafe
     +	sudo "$TEST_SHELL_PATH" -c "\"$RUN\""
     +	ret=$?
     +	rm -f "$RUN"
    @@ t/t0034-root-safe-directory.sh: test_expect_success SUDO 'sudo git status as ori
     +	)
     +'
     +
    -+test_expect_failure SUDO 'can access with sudo if root' '
    ++test_expect_success 'can access if addressed explicitly' '
     +	(
     +		cd root/p &&
    -+		sudo git status
    ++		GIT_DIR=.git GIT_WORK_TREE=. git status
     +	)
     +'
     +
    -+test_expect_success SUDO 'can access with sudo using a workaround' '
    -+	# run sudo twice; would fail if root is not in sudoers
    ++test_expect_failure SUDO 'can access with sudo if root' '
     +	(
     +		cd root/p &&
    -+		sudo sudo git status
    -+	) &&
    -+	# provide explicit GIT_DIR
    ++		sudo git status
    ++	)
    ++'
    ++
    ++test_expect_success SUDO 'can access with sudo if root by removing SUDO_UID' '
     +	(
     +		cd root/p &&
     +		run_with_sudo <<-END
    -+			GIT_DIR=.git &&
    -+			GIT_WORK_TREE=. &&
    -+			export GIT_DIR GIT_WORK_TREE &&
    ++			unset SUDO_UID &&
     +			git status
     +		END
    -+	) &&
    -+	# discard SUDO_UID
    ++	)
    ++'
    ++
    ++test_lazy_prereq SUDO_SUDO '
    ++	sudo sudo id -u >u &&
    ++	id -u root >r &&
    ++	test_cmp u r
    ++'
    ++
    ++test_expect_success SUDO_SUDO 'can access with sudo abusing SUDO_UID' '
     +	(
     +		cd root/p &&
    -+		run_with_sudo <<-END
    -+			unset SUDO_UID &&
    -+			git status
    -+		END
    ++		sudo sudo git status
     +	)
     +'
     +
-:  ----------- > 4:  8486777a417 git-compat-util: allow root to access both SUDO_UID and root owned
--
2.36.1.371.g0fb0ef0c8d

