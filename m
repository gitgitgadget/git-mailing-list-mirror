Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F644C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiEJRue (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348388AbiEJRua (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:50:30 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014785677E
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x22so14091278qto.2
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnCXjzT3mL7d0lWqpoxHUE0+yFiyx6uTsex0G26Sw4s=;
        b=cJ/U6HGxS9wOyrXY7kKDHhqCDen2/A8ikVFxJVKrba/6TVdPWtIIDsP7h0WF4lbqpH
         X0J8ZjGmV5V58A9j0qK5BqH4feV7BfEszJVWEhxevzVE6gejXuQ+7BjclqDGThjX7vqK
         evZ9GwHlJPIBtWebZPKerg8dEMujC53PAZJT/Qbjau1Zp1VZbqXCxGHGOWU3cPXVdU4l
         r0+t8COie8qBj//TW2pCuPzGHwmX9ROFrovNWuxollnnuo+E9Oz7MwX4Xzl0aaFEp4ad
         MJ22FVucoXQC5ppXSHkH7QDmHINwS7z+tZ1tuIIacNc+7KK8knLGdFlNUQBf2ldoVGQB
         3GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnCXjzT3mL7d0lWqpoxHUE0+yFiyx6uTsex0G26Sw4s=;
        b=eANmMdvCCdM3FS/AOjR0R2+PQLfYGX0DHHTbO/JhirwtQudddArkUJezXXEaGFJtS7
         i2n8V8P8+jeodCCyVPGc+aocDRgYjqRS1ZoDHDsAY4WA6jr2SHIcoZW8hD30kHAGMPoz
         ZIXE1QgicbCIFa3Ab5DuUB9wym7/UZgkrEjaAu8unbCS4dPFvfPYACsaiUiLhtUTpz6F
         Ia70+I7cK0+C1cNN8W61KgbezpGfDt/9AyW1pLnDQ+Oo+CjNsZenTB6wFI09lT0Gm/qh
         JydlxGjN1eooy3RcmQvBbI0wcyZF06LWOBqwsELI90C88bJYSS6hYkNDbn0ZSkggRz/7
         oy1w==
X-Gm-Message-State: AOAM531CXycm7DWuz1OyWocRrMacc8rb/onay32DceMoLCHBRy+aro8a
        AkcmE9wrmW6Bn2DI7PtiOVP1PJZtX20=
X-Google-Smtp-Source: ABdhPJwBUPU79Gmk3B5atEX4U8Dv1lP5txYHQDxHdNfvM7ROGsTIdO9h4JofBj9tybvMloxbMmXVdQ==
X-Received: by 2002:a05:622a:6083:b0:2f1:d380:1fad with SMTP id hf3-20020a05622a608300b002f1d3801fadmr21149866qtb.4.1652204789776;
        Tue, 10 May 2022 10:46:29 -0700 (PDT)
Received: from localhost.localdomain (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h191-20020a379ec8000000b0069fc347ef5dsm8719280qke.74.2022.05.10.10.46.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2022 10:46:29 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 0/3] fix `sudo make install` regression in maint
Date:   Tue, 10 May 2022 10:46:13 -0700
Message-Id: <20220510174616.18629-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220507163508.78459-1-carenas@gmail.com>
References: <20220507163508.78459-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A reroll for cb/path-owner-check-with-sudo with all the suggestions by
Junio since RFC v4 and that only include a small code change in patch 2
to get rid of the maligned and probably buggy `(uid_t)-1` which is not
needed and making sure the code would most likely work (ad discussed)
even when uid_t is signed, sudo behaves and git is running as root.

Range-diff provided below to make easier to spot all the other changes
in documentation and commit messages as well.

Carlo Marcelo Arenas Belón (3):
  t: regression git needs safe.directory when using sudo
  git-compat-util: avoid failing dir ownership checks if running
    privileged
  t0034: add negative tests and allow git init to mostly work under sudo

 Documentation/config/safe.txt  |  10 ++++
 git-compat-util.h              |  54 ++++++++++++++++-
 t/lib-sudo.sh                  |  12 ++++
 t/t0034-root-safe-directory.sh | 103 +++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-sudo.sh
 create mode 100755 t/t0034-root-safe-directory.sh

--
1:  4d078785cb ! 1:  8296d93ec0 t: regression git needs safe.directory when using sudo
    @@ Commit message
     
         The test file also uses at least one initial "setup" test that creates
         a parallel execution directory, while ignoring the repository created
    -    by the test framework, and special care should be taken when invoking
    -    commands through sudo, since the environment is otherwise independent
    -    from what the test framework expects.  Indeed `git status` was used
    -    as a proxy because it doesn't even require commits in the repository
    -    to work.
    +    by the test framework.
    +
    +    Special care should be taken when invoking commands through sudo, since
    +    the environment is otherwise independent from what the test framework
    +    setup and might have changed the values for HOME, SHELL and dropped
    +    several relevant environment variables for your test.  Indeed `git status`
    +    was used as a proxy because it doesn't even require commits in the
    +    repository to work and usually doesn't require much from the environment
    +    to run, but a future patch will add calls to `git init` and that will
    +    fail to honor the default branch name, unless that setting is NOT
    +    provided through an environment variable (which means even a CI run
    +    could fail that test if enabled incorrectly).
     
         A new SUDO prerequisite is provided that does some sanity checking
         to make sure the sudo command that will be used allows for passwordless
    @@ Commit message
         execution path.  This matches what is provided by the macOS agents that
         are used as part of GitHub actions and probably nowhere else.
     
    -    Most of those characteristics make this test mostly suitable only for
    +    Most of those characteristics make this test mostly only suitable for
         CI, but it might be executed locally if special care is taken to provide
    -    for some of them in the local configuration and maybe making use of the
    +    for all of them in the local configuration and maybe making use of the
         sudo credential cache by first invoking sudo, entering your password if
         needed, and then invoking the test with:
     
           $ GIT_TEST_ALLOW_SUDO=YES ./t0034-root-safe-directory.sh
     
         If it fails to run, then it means your local setup wouldn't work for the
    -    test and things that might help is to comment out sudo's secure_path config
    -    and make sure your account has similar privileges than what the CI
    -    provides (for example an entry in /etc/sudoers for the user marta like)
    +    test because of the configuration sudo has or other system settings, and
    +    things that might help are to comment out sudo's secure_path config, and
    +    make sure that the account you are using has no restrictions on the
    +    commands it can run through sudo, just like is provided for the user in
    +    the CI.
    +
    +    For example (assuming a username of marta for you) something probably
    +    similar to the following entry in your /etc/sudoers (or equivalent) file:
     
           marta ALL=(ALL:ALL) NOPASSWD: ALL
     
         Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## t/t0034-root-safe-directory.sh (new) ##
     @@
2:  073b73eb26 ! 2:  e3efd6a178 git-compat-util: avoid failing dir ownership checks if running privileged
    @@ Commit message
         privileges didn't track the original id in a sudo compatible way.
     
         Because of compatibility with sudo, the code assumes that uid_t is an
    -    unsigned integer type, but adds additional logic to protect itself
    -    against possibly malicious ids outside the expected range and ignore
    -    them.
    -
    -    A warning should be generated if uid_t is signed and the code would
    -    need to be locally patched to work correctly, but this is also a
    -    weather balloon of sorts so we will then now which systems those are
    -    and whether we should accommodate for their portability in our codebase.
    +    unsigned integer type (which is not required by the standard) but is used
    +    that way in their codebase to generate SUDO_UID.  In systems where uid_t
    +    is signed, sudo might be also patched to NOT be unsigned and that might
    +    be able to trigger an edge case and a bug (as described in the code), but
    +    it is considered unlikely to be triggered, and even when it does the code
    +    would just safely fail, so there is no attempt either to detect it or
    +    prevent it in the code, which might need to be changed in the future.
     
         Reported-by: Guy Maurel <guy.j@maurel.de>
         Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
    @@ Commit message
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/config/safe.txt ##
     @@ Documentation/config/safe.txt: directory was listed in the `safe.directory` list. If `safe.directory=*`
    @@ Documentation/config/safe.txt: directory was listed in the `safe.directory` list
     +obviously do so with the uid of the user that is running git itself,
     +but if git is running as root, in a platform that provides sudo and is
     +not Windows, it will check first if it might have been started through
    -+it, and if that is the case, will instead use the uid of the user that
    -+did invoke that instead.
    ++it, and if that is the case, will use the uid of the user that invoked
    ++sudo instead.
     +If that is not what you would prefer and want git to only trust
     +repositories that are owned by root instead, then you should remove
     +the `SUDO_UID` variable from root's environment.
    @@ git-compat-util.h: static inline int git_offset_1st_component(const char *path)
     +#endif
     +
     +/*
    -+ * this helper function overrides a ROOT_UID with the one provided by
    ++ * This helper function overrides a ROOT_UID with the one provided by
     + * an environment variable, do not use unless the original user is
    -+ * root
    -+ * WARNING: this function assumes uid_t is unsigned, if you got here
    -+ *          because of a warning or a bug will need a patch and would
    -+ *          be nice if you let us know
    ++ * root or could be used as means to escalate to root privileges.
    ++ *
    ++ * PORTABILITY WARNING:
    ++ * This code assumes uid_t is unsigned because that is what sudo does.
    ++ * If your uid_t type is signed and all your ids are positive then it
    ++ * should all work fine, but need to make sure sudo never generates a
    ++ * value higher than what can be represented by your uid_t type or a
    ++ * negative value or it will trigger wraparound bugs.
    ++ *
    ++ * If that happens the uid used might be incorrect and then trigger
    ++ * an access error from the filesystem itself.
    ++ *
    ++ * In the unlikely scenario this happened to you, and that is how you
    ++ * got to this message, we would like to know about it by letting us
    ++ * now with an email to git@vger.kernel.org indicating which platform,
    ++ * you are running on and which version of sudo you used to see if we
    ++ * can provide you a patch that would prevent this issue in the future.
     + */
     +static inline void extract_id_from_env(const char *env, uid_t *id)
     +{
     +	const char *real_uid = getenv(env);
     +
    -+	/* discard any empty values */
    ++	/* discard anything empty to avoid a more complex check below */
     +	if (real_uid && *real_uid) {
     +		char *endptr = NULL;
     +		unsigned long env_id;
     +
     +		errno = 0;
    ++		/* silent overflow errors could trigger a bug below */
     +		env_id = strtoul(real_uid, &endptr, 10);
    -+		/*
    -+		 * env_id could underflow/overflow in the previous call
    -+		 * and if it will still fit in a long it will not report
    -+		 * it as error with ERANGE, instead silently using an
    -+		 * equivalent positive number that might be bogus.
    -+		 * if uid_t is narrower than long, it might not fit,
    -+		 * hence why we  need to check it against the maximum
    -+		 * possible uid_t value before accepting it.
    -+		 */
    -+		if (!*endptr && !errno && env_id <= (uid_t)-1)
    ++		if (!*endptr && !errno)
     +			*id = env_id;
     +	}
     +}
3:  e772e4d128 ! 3:  1b8003c599 t0034: add negative tests and allow git init to mostly work under sudo
    @@ Commit message
     
         Note that the specific test that documents that after the previous
         changes, it is no longer possible for root (if obtained through sudo)
    -    to NOT add an exception or need a "workaround" to be able to run git
    +    to NOT add an exception or NOT need a "workaround" to be able to run git
         commands in a repository owned by thyself, is marked as a regression
         and is expected to be fixed with a future change, which hasn't been
         provided yet and that is not part of this series.
     
    +    As described in the comments from the test itself, at least one of the
    +    documented workarounds could fail if sudo doesn't allow root to call sudo
    +    or if root is not in sudoers, but that is very unlikely, and more
    +    importantly actually not what is provided by the currently supported sudo
    +    configuration this test already relies on and therefore adding a way to
    +    validate it works in the prerequisite has been punted for now.
    +
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## t/lib-sudo.sh (new) ##
     @@
    @@ t/t0034-root-safe-directory.sh: test_expect_success SUDO 'sudo git status as ori
     +'
     +
     +test_expect_success SUDO 'can access with sudo using a workaround' '
    -+	# run sudo twice; would fail is root is not in the sudoers
    ++	# run sudo twice; would fail if root is not in sudoers
     +	(
     +		cd root/p &&
     +		sudo sudo git status
-- 
2.36.1.371.g0fb0ef0c8d

