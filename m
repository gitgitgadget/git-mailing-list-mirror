Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D5BC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 09:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIGJpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGJpl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 05:45:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ADD32A82
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 02:45:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t14so12177004wrx.8
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date;
        bh=Gs/d39BOP8FsH01o53RaAIHQSYXWUesaCaYy5fbIJSs=;
        b=I1mtzrj4S6G21/rJOPnJpWLqI1f8cidqcDDVlC5X2H5/1LimGOc7xQdL/7wjyvpjTy
         RRBrsQgADMpdoJVgseKTj1IzSH5VLfCjzqpU82en1DQRVN60F1NkUKA6Dydv33pgOdQM
         OXXM3eQ1F5JgAZw9cSD0Rd5GVD6L7JOqxKZCH2VTOinVTPvGPyVPQ6d4v3EaOT7jIAJ0
         L/cdrdhvfaAEftAYnLNAy+2U4B0ZFtAdTe9jpdlp2tyXTm57YXmp56vO5ws1Ucm1w2MM
         VMUTSGlEysNUEfeI7Lvu24BHABDyrlqotg+oU3nJBRRbXxpTYCS78z+BJR99iVMGsrZi
         cKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Gs/d39BOP8FsH01o53RaAIHQSYXWUesaCaYy5fbIJSs=;
        b=TmtuE8XEVf8DGXgL6bUk9blDI53PaGBeH7I65xusUb4qrimeBe+Ln8l5wxbIBMIfRa
         teCR7kfrb2cXFgh3AcL/x/BOuLDvQwBs5k1H+SAWtPgDZa7OYVptud58E31J8Z/1K3y+
         cwdu4JaINTIlD1dmKJ1sD7d3pjPilIL3Xh9Q+dsGVW8V4auMUsk25Q1Bzw+ZobQTibYF
         RlHDtkRwNqiGktX2nTbjt0lXenKaRuTJ02cwE7NhcYxKR443F8S2DkujIz4R3/R1dwHk
         nZOF10Yl+3kZqmTDaUB2hoXzo745J7BYsMTkJseDhipeaAbE+WC+mkkBDAl767c/tjnB
         WHcA==
X-Gm-Message-State: ACgBeo3DeR9Zdw0FHMpWywufD6ZvW2/0788gXeg0eMnsWJafCaUULIrV
        Qe3FF4p1Cuv11a9Nqtjez1sMT31WlxQ=
X-Google-Smtp-Source: AA6agR6PFm7u7uUnax7PxhKVYbpJ0rQm8b+b/G7K7IiBOLPwNvCBEg2L/FYonG5EevR0x1GTtqTIhA==
X-Received: by 2002:a5d:47a6:0:b0:228:4760:cca with SMTP id 6-20020a5d47a6000000b0022847600ccamr1514858wrb.118.1662543938246;
        Wed, 07 Sep 2022 02:45:38 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d4304000000b002238ea5750csm19459702wrq.72.2022.09.07.02.45.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 02:45:37 -0700 (PDT)
Subject: [PATCH v2 0/2] branch: support for shortcuts like @{-1}, completed
To:     git@vger.kernel.org
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
Date:   Wed, 7 Sep 2022 11:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

branch options: "edit-description", "set-upstream-to" and "unset-upstream"
don't handle shortcuts like @{-1}.

This patch address this problem.

In v2 I've resolved some noise in the code, aggregated two tests in one with
some refactoring to do the test in a more simple way while covering the
functionality. Also changed the commit messages to better explain and
document the change.

Thanks


Rubén Justo (2):
  branch: refactor "edit_description" code path
  branch: support for shortcuts like @{-1} completed

 builtin/branch.c                      | 46 ++++++++++++++++++---------
 t/t3204-branch-name-interpretation.sh | 25 +++++++++++++++
 2 files changed, 56 insertions(+), 15 deletions(-)

base-commit: 795ea8776befc95ea2becd8020c7a284677b4161

Range-diff vs v1:

1:  aaa2f3ec31 ! 1:  ce14194187 branch: refactor edit_description command switch case
    @@ Metadata
     Author: Rubén Justo <rjusto@gmail.com>
     
      ## Commit message ##
    -    branch: refactor edit_description command switch case
    +    branch: refactor "edit_description" code path
     
    -    Minor refactoring to reduce the return exits in the switch case
    -    handling the edit_description command, so the calls to strbuf_release
    -    can also be reduced.
    +    Minor refactoring to reduce the number of returns in the switch case
    +    handling the "edit_description" option, so the calls to strbuf_release
    +    can also be reduced.  New resources to be added also do not need to be
    +    released in multiple places.
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
2:  321854e118 ! 2:  3a591cab8a branch: support for at-refs like @{-1}
    @@ Metadata
     Author: Rubén Justo <rjusto@gmail.com>
     
      ## Commit message ##
    -    branch: support for at-refs like @{-1}
    +    branch: support for shortcuts like @{-1} completed
     
    -    branch command with --edit-description, --set-upstream-to and
    -    --unset-upstream options expects a branch name. A branch can be
    -    specified using at-refs like @{-1}, so those references need to
    -    be resolved.
    +    branch command with options "edit-description", "set-upstream-to"
    +    and "unset-upstream" expects a branch name.  Since ae5a6c3684
    +    (checkout: implement "@{-N}" shortcut name for N-th last branch,
    +    2009-01-17) a branch can be specified using shortcuts like @{-1}.
    +    Those shortcuts need to be resolved when considering the
    +    arguments.
    +
    +    Usage examples:
     
         We can modify the description of the previously checked out branch
         with:
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
     +		else if (argc == 1) {
     +			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
     +			branch = branch_get(buf.buf);
    -+		}
    -+		else
    ++		} else
      			die(_("too many arguments to set new upstream"));
      
    -+
      		if (!branch) {
    - 			if (!argc || !strcmp(argv[0], "HEAD"))
    - 				die(_("could not set upstream of HEAD to %s when "
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
      		dwim_and_setup_tracking(the_repository, branch->name,
      					new_upstream, BRANCH_TRACK_OVERRIDE,
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
     +		else if (argc == 1) {
     +			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
     +			branch = branch_get(buf.buf);
    -+		}
    -+		else
    ++		} else
      			die(_("too many arguments to unset upstream"));
      
      		if (!branch) {
    @@ t/t3204-branch-name-interpretation.sh: test_expect_success 'checkout does not tr
     +	test_cmp expect EDITOR_OUTPUT
     +'
     +
    -+test_expect_success 'modify branch upstream via "@{-1}@{upstream}"' "
    -+	cat >expect <<-\EOF &&
    -+	warning: not setting branch 'upstream-branch' as its own upstream
    -+	EOF
    ++test_expect_success 'modify branch upstream via "@{-1}" and "@{-1}@{upstream}"' '
     +	git branch upstream-branch &&
     +	git checkout -b upstream-other -t upstream-branch &&
     +	git checkout - &&
    -+	git branch --set-upstream-to upstream-branch @{-1}@{upstream} 2>actual &&
    -+	test_cmp expect actual
    -+"
    -+
    -+test_expect_success 'unset branch upstream via "@{-1}"' "
    -+	test "$(git config branch.upstream-other.remote)" = "." &&
    -+	test "$(git config branch.upstream-other.merge)" = "refs/heads/upstream-branch" &&
    -+	git checkout upstream-other &&
    -+	git checkout - &&
    ++	git branch --set-upstream-to @{-1} @{-1}@{upstream} &&
    ++	test "$(git config branch.upstream-branch.merge)" = "refs/heads/upstream-other" &&
     +	git branch --unset-upstream @{-1} &&
    -+	test_must_fail git config branch.upstream-other.remote &&
     +	test_must_fail git config branch.upstream-other.merge
    -+"
    ++'
     +
      test_done

-- 
2.36.1
