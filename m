Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A8AC433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 20:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKXUWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 15:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKXUWx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 15:22:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22855C0DE
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:22:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i12so4029031wrb.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SC7k22OF4Y1q/uhfbZuDsXwEjWAZ+ypY63d2OodiJ8g=;
        b=hzMNqe7p+Waz9BquNKJ44cf2UkYUgzl7Y2ZYMohtWwW0t+9VISf9uAYNVePifnW+Rr
         1fkzgf9EFSi4I8ODNQMHYct3TbebhJ0uSNIEhP2+lAAH4F605ZnNpA51nAVRx6+mc7Xy
         RDmkD+kW6+jve0/ZIJsBuWJ3Tw/Zr+2CNYLt3u0Zb8fv75bQ0Hjy7pK9mvFV5OZMh5Qo
         UaoIpRIH712LX1UiT0Tm+cchdGNr67skS0kybh1gie7rsQqXJKZ9ZDBH7vcnLXac/uux
         qW35BrZDSxsTTH2fX1Sc4i7jfDSwa/3z+rVqnRNgAmbDJ1baZfLkss+G/PGpIWkURM7R
         gN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SC7k22OF4Y1q/uhfbZuDsXwEjWAZ+ypY63d2OodiJ8g=;
        b=EvPPRPHNDkjFc0DWerTySn5gK8aM1xJ+uAgPG8YJ8qjBIpxV+AGm5mariM0zs2CkEE
         8YhulGDDwy/6HaEKtr7YbUksV70QZ3vMtQ8fsD5Vezl1YdGHZZGkI9ApW/BjUDGyHoeQ
         5HWGSSBpUvlAQ9aRnM5rr0cBXjELkTMnktjt7qthLfPI3daL7WGVrulbZboTnNPxxgGK
         +dcyxWXbOxuIKVVoduVoct9PSPtzqvcPavWVNyrOMDMxwZ5fgPQf/C9HiDf3dKEZ8pXr
         wn0cCI6K5njLKvIvE+W8sgQCo+Nw5JU2f7BcvSegY6sdWHfhc1kxIxo5MrGYHCIyaam6
         8L0A==
X-Gm-Message-State: ANoB5pkYi34Hr1zmdaT0PCbLfOg99rxTdUj4KjadIRGbgjybFw7EbNKi
        EOPNOHrWJfS5TTGzuZ740hCKGICnHMo=
X-Google-Smtp-Source: AA0mqf7bOQcPpfcNHh0qj+zxBYN0v6sv9CbkQdg19L79kAviF9hcTUZAMWPOQqmETVmVcFQW1AT2Ww==
X-Received: by 2002:a5d:690d:0:b0:242:2ee:a6d6 with SMTP id t13-20020a5d690d000000b0024202eea6d6mr1204664wru.108.1669321370060;
        Thu, 24 Nov 2022 12:22:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d4e51000000b0023c8026841csm2180202wrt.23.2022.11.24.12.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 12:22:49 -0800 (PST)
Message-Id: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 20:22:45 +0000
Subject: [PATCH 0/3] Improve consistency of git-var
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series makes a few distinct improvements to git-var to support
the change to git_editor() prompted here
[https://lore.kernel.org/git/xmqq1qpwwwxg.fsf@gitster.g/] and ultimately
support that patch to introduce GIT_SEQUENCE_EDITOR as a handled logical
variable.

We first have to pull apart the errors of 'the given logical variable is
unknown/meaningless' and 'the given logical variable is known, but its value
is undefined'. For example, if GIT_EDITOR (and its fallbacks) was completely
unset, git var GIT_EDITOR would end up inappropriately printing a usage
message. This is fixed in var.c by returning the git_var struct itself in
the search on git_vars (to see if the variable is known) and then calling
git_var->read() -- allowing us to handle the cases of 'git_var is null' and
'read() returned null' separately.

After this is done, we're able to remove the handling in var.c:editor()
that's been duplicated in editor.c -- allowing editor() to return NULL and
follow the logic prepared above.

Sean Allred (3):
  var: do not print usage() with a correct invocation
  var: remove read_var
  var: allow GIT_EDITOR to return null

 Documentation/git-var.txt |  3 +-
 builtin/var.c             | 26 +++++++--------
 t/t0007-git-var.sh        | 69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 15 deletions(-)


base-commit: a0789512c5a4ae7da935cd2e419f253cb3cb4ce7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1434%2Fvermiculus%2Fsa%2Fvar-improvements-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1434/vermiculus/sa/var-improvements-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1434
-- 
gitgitgadget
