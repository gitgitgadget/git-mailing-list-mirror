Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE76CC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhLIKUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbhLIKT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:19:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26C9C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:16:25 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x131so4950082pfc.12
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ClJQSGbNc/7fhs/oSfERswExaTNLWjxK64tda4v5SMY=;
        b=R9UT9t42V5t5hJlgwRjdR7Qa4YVoduv2KrSHDOwKVg/8pWjAtOY+sh1Ye6R0FP+6d7
         qY2evm8jgqbi5wq0OYI7Hx/uWSt+8Hges+r7ypm2wN9W06yUnMMNAx4kNbYQ3457UruL
         KINFjQIWAlJRX+JHX0/5Bdg5OVpKlUM0K9HbbuSA4BkUQgkG+BhA7CqO04QzoMNXUZZr
         k95qmyhA3u6TIuIenhORFhTA/RyaytquMSXW9dFCjPgSeH4IJP25TkJ8OMBx0kdUAQQJ
         hxw1OC7vQ2dr2FEgu2REuYw03P7S30z32fA+teQ0Jp4mj4JBnOx92re7kJ30q7DJrFyN
         ttaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClJQSGbNc/7fhs/oSfERswExaTNLWjxK64tda4v5SMY=;
        b=LvVy+/dxaHfPzuthoAoYw5Zu1deOd1nPj2Kp4PztTY0KlpKySF7psUXtheEoQ7xojF
         FnwbqSC5lgQSUUBK9WEGVulToAdwg3WINqUdsrEcBHqIdf99mt4d3CK9lTe7dgK7w6Bh
         PJB9C04JRtx8ddnCMJU9LigIhW+HveH6iNy8iDbgoUa/U/aY7WhOZOkfY4IW/giNbYxU
         AfA9Bmqr9Cpp66oGM/d9vG2qcVWoCMx3EkZZwuwaMYvgYkpGKebO23EAYT/zY2RgiHbA
         alpEpp/fD0xjqLsMyEffl7vUWXDrJ6HsZ4P4ZVz/PpuuCNsTi6jW0FCn5lexQOznfNCI
         K3gw==
X-Gm-Message-State: AOAM531lJiy8EojDzRHq3wSPkOEcdziMEgiYhmG0oSqm/u/0LKNNLt2i
        RKik7Zr7STOCejpb0GC5nzLg2WrpsXMTKQ==
X-Google-Smtp-Source: ABdhPJwOJ8WlABYvZXPfxn6Uyx3LksoNmaqKZYB3b8orjUxHIY0c76suTHroD40LBiA45cQaIC2Dng==
X-Received: by 2002:a63:ff57:: with SMTP id s23mr33522969pgk.176.1639044984734;
        Thu, 09 Dec 2021 02:16:24 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.157.96])
        by smtp.gmail.com with ESMTPSA id m6sm5236859pgs.18.2021.12.09.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:16:24 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/1] making --set-upstream have default arguments
Date:   Thu,  9 Dec 2021 15:45:49 +0530
Message-Id: <20211209101550.19582-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207182300.4361-1-chakrabortyabhradeep79@gmail.com>
References: <20211207182300.4361-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series tries to make the 'set-upstream' option for
'git push' have default arguments.

In v0: argumentless 'git push -u' was blindly passing default remote
name and current branch's name as argv[0] and argv[1] respectively.
This was affecting `push.default` setting.

From v1: The default remote is still used for the <repository> value.
But <refspec> depends on the current push configurations. If
`push.default`='matching', it pushes to the upstream as it should and
sets upstream respectively. For other values of 'push.default', it
pushes to the remote branch with the same name as the current
branch and sets that branch as the upstream.

In this version, the tests are improved.

Abhradeep Chakraborty (1):
  push: make '-u' have default arguments

 Documentation/git-push.txt | 10 +++++
 builtin/push.c             | 11 ++++-
 t/t5523-push-upstream.sh   | 87 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

Range-diff against v2:
1:  6567327900 ! 1:  376ba6cb8f push: make '-u' have default arguments
    @@ Documentation/git-push.txt: Specifying `--no-force-if-includes` disables this be
     +If `push.default` is set to `matching`, all remote branches to which
     +local branches pushed, will be set as upstream of respective local
     +branches. For all other values of `push.default`, current branch's
    -+`<refspec>` will be used as the `<refspec>`.
    ++refspec will be used as the `<refspec>`.
      
      --[no-]thin::
      	These options are passed to linkgit:git-send-pack[1]. A thin transfer
    @@ t/t5523-push-upstream.sh: test_expect_success 'push -u :topic_2' '
      '
      
     +default_u_setup() {
    -+	git checkout main
    -+	remote=$(git config --get branch.main.remote)
    -+	if [ ! -z "$remote" ]; then
    -+		git branch --unset-upstream
    -+	fi
    -+	git config push.default $1
    -+	git config remote.pushDefault upstream
    ++	git checkout main &&
    ++	test_might_fail	git branch --unset-upstream &&
    ++	test_config push.default $1 &&
    ++	test_config remote.pushDefault upstream
     +}
     +
    -+test_expect_success 'push -u with push.default=simple' '
    -+	default_u_setup simple &&
    -+	git push -u &&
    -+	check_config main upstream refs/heads/main &&
    -+	git push -u upstream main:other &&
    -+	git push -u &&
    -+	check_config main upstream refs/heads/main
    -+'
    -+
    -+test_expect_success 'push -u with push.default=current' '
    -+	default_u_setup current &&
    -+	git push -u &&
    -+	check_config main upstream refs/heads/main &&
    -+	git push -u upstream main:other &&
    -+	git push -u &&
    -+	check_config main upstream refs/heads/main
    -+'
    -+
    -+test_expect_success 'push -u with push.default=upstream' '
    -+	default_u_setup upstream &&
    -+	git push -u &&
    -+	check_config main upstream refs/heads/main &&
    -+	git push -u upstream main:other &&
    -+	git push -u &&
    -+	check_config main upstream refs/heads/main
    -+'
    ++for i in simple current upstream nothing
    ++do
    ++	test_expect_success 'push -u with push.default=$i' '
    ++		default_u_setup $i &&
    ++		git push -u &&
    ++		check_config main upstream refs/heads/main &&
    ++		git push -u upstream main:other &&
    ++		git push -u &&
    ++		check_config main upstream refs/heads/main
    ++	'
    ++done
     +
     +check_empty_config() {
    -+	test_expect_code 1 git config "branch.$1.remote"
    ++	test_expect_code 1 git config "branch.$1.remote" &&
     +	test_expect_code 1 git config "branch.$1.merge"
     +}
     +
    @@ t/t5523-push-upstream.sh: test_expect_success 'push -u :topic_2' '
     +	check_empty_config test_u
     +'
     +
    -+test_expect_success 'push -u with push.default=nothing' '
    -+	default_u_setup nothing &&
    -+	git push -u &&
    -+	check_config main upstream refs/heads/main &&
    -+	git push -u upstream main:other &&
    -+	git push -u &&
    -+	check_config main upstream refs/heads/main
    -+'
    -+
     +test_expect_success 'push -u --dry-run' '
     +	git checkout main &&
     +	git push -u upstream main:other &&
    @@ t/t5523-push-upstream.sh: test_expect_success TTY 'progress messages go to tty'
     +test_expect_success TTY 'progress messages go to tty with default -u' '
     +	ensure_fresh_upstream &&
     +
    -+	test_terminal git push -u >out 2>err &&
    ++	test_terminal git push -u 2>err &&
     +	test_i18ngrep "Writing objects" err
     +'
     +
    @@ t/t5523-push-upstream.sh: test_expect_success 'progress messages do not go to no
      	test_i18ngrep ! "Writing objects" err
      '
      
    -+test_expect_success 'progress messagesdo not go to non-tty (default -u)' '
    ++test_expect_success 'progress messages do not go to non-tty (default -u)' '
     +	ensure_fresh_upstream &&
     +
     +	# skip progress messages, since stderr is non-tty
    -+	git push -u >out 2>err &&
    ++	git push -u 2>err &&
     +	test_i18ngrep ! "Writing objects" err
     +'
     +
    @@ t/t5523-push-upstream.sh: test_expect_success 'progress messages go to non-tty (
     +	ensure_fresh_upstream &&
     +
     +	# force progress messages to stderr, even though it is non-tty
    -+	git push -u --progress >out 2>err &&
    ++	git push -u --progress 2>err &&
     +	test_i18ngrep "Writing objects" err
     +'
     +
    @@ t/t5523-push-upstream.sh: test_expect_success TTY 'push -q suppresses progress'
     +test_expect_success TTY 'push -q suppresses progress (with default -u)' '
     +	ensure_fresh_upstream &&
     +
    -+	test_terminal git push -u -q >out 2>err &&
    ++	test_terminal git push -u -q 2>err &&
     +	test_i18ngrep ! "Writing objects" err
     +'
     +
    @@ t/t5523-push-upstream.sh: test_expect_success TTY 'push --no-progress suppresses
     +test_expect_success TTY 'push --no-progress suppresses progress (default -u)' '
     +	ensure_fresh_upstream &&
     +
    -+	test_terminal git push -u --no-progress >out 2>err &&
    ++	test_terminal git push -u --no-progress 2>err &&
     +	test_i18ngrep ! "Unpacking objects" err &&
     +	test_i18ngrep ! "Writing objects" err
     +'
-- 
2.34.1

