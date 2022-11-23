Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C69C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 07:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiKWHE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiKWHEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 02:04:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17235F2406
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:04:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so2208325wmi.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6od7bynYWCfEXCNdv4y3MNZaBpARnG+GXZwBXyF369g=;
        b=mL4QPkTbDu6djV1PHKRJWZ0fq3WbXw6D2yA5koA/Ij8xUX1njIRbdDOCFf7ARmAFaQ
         5x2qtr7WbAIp+yCbLfDGVAMqxB3NarbUsMV1NMLAoyX7anpiVk8w9vQ7Rq77GAP20JvB
         ynAtxmFzHZZglUdhAj4IHAlnwkMiI1aaIS7YZ+25MZnXn5Z1c4XVuH/OVt6YvYCDV4sv
         Z8RDF8AxsZlLNkqHcifQaaQmBbksD4GlYxGTFoZn5ISfTep+wYC7RYFF0BF/fqKL2uTI
         oB9DVhEpjClV1pzS2uBrmCd2shqjY72lUO45SrbFgAocv3xdmuJ7e/ny/hs5pzt2fEAs
         mf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6od7bynYWCfEXCNdv4y3MNZaBpARnG+GXZwBXyF369g=;
        b=ocmecKOcbK5Oqp2MkmcABRJ3TgQjIuWhAttmZcWobfRS3LadzGfYDnnM5MKSh2Cob7
         bn7dFqDsk9tUryamjEA4SzDBAqE54oSU2g0eHtQInfYRLp+SOzYHcjluJToRV+MuF2y8
         7T/Uy4DVN8rXWCsur4LkpqTHYJ7L5idNQ3/qZ6VUI/7LvGkLbFXR2ShCwlWQCoDmT/Rv
         O/kgQ6a8ifJ2CqhtTQMtoSRE3k6I6izqeF0CmgABMOZly7j8h0Qw/J9vTW570kxifphS
         3uDaqfVz5jotWgq420iACTkaGIomX4PnWNI3DXLAC8ygEXxzIAQUGG9Xh1jwyZBMDDfj
         zxOw==
X-Gm-Message-State: ANoB5pkEPEvjlKcSwh76i1XjEJvnzMJOPRmNZPVqPzHht5SlaWl1DsxI
        gCW5KLxVW7fQqT8aefrNpwDAPkpxeAo=
X-Google-Smtp-Source: AA0mqf7gtjb/FqbMaR+UKj8xtg5kxC+u/oC7nG30nZAu6v1Bef6RewrV3yJRM2cwt0moCmPWbg3lIQ==
X-Received: by 2002:a1c:ed04:0:b0:3cf:d08d:3eb2 with SMTP id l4-20020a1ced04000000b003cfd08d3eb2mr19052684wmh.129.1669187055221;
        Tue, 22 Nov 2022 23:04:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6101000000b002365cd93d05sm15471359wrt.102.2022.11.22.23.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:04:14 -0800 (PST)
Message-Id: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
References: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
From:   "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 07:04:10 +0000
Subject: [PATCH v5 0/3] git-jump: support Emacs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an optional argument 'stdout' to print the quickfix lines to standard
output. It can be used with M-x grep on Emacs.

Detect emacsclient by GIT_EDITOR and invoke the function. Tested with
EDITOR="emacsclient" and EDITOR="emacsclient -t".

Jeff King (1):
  git-jump: move valid-mode check earlier

Yoichi Nakayama (2):
  git-jump: add an optional argument '--stdout'
  git-jump: invoke emacs/emacsclient

 contrib/git-jump/README   | 10 ++++++++-
 contrib/git-jump/git-jump | 45 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 4 deletions(-)


base-commit: eea7033409a0ed713c78437fc76486983d211e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1423%2Fyoichi%2Fgit-jump-emacs-support-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1423/yoichi/git-jump-emacs-support-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1423

Range-diff vs v4:

 1:  446777d300d = 1:  446777d300d git-jump: add an optional argument '--stdout'
 2:  2f0bffb484b ! 2:  972d51888ba git-jump: invoke emacs/emacsclient
     @@
       ## Metadata ##
     -Author: Yoichi Nakayama <yoichi.nakayama@gmail.com>
     +Author: Jeff King <peff@peff.net>
      
       ## Commit message ##
     -    git-jump: invoke emacs/emacsclient
     +    git-jump: move valid-mode check earlier
      
     -    It works with GIT_EDITOR="emacs", "emacsclient" or "emacsclient -t"
     +    We check if the "mode" argument supplied by the user is valid by seeing
     +    if we have a mode_$mode function defined. But we don't do that until
     +    after creating the tempfile. This is wasteful (we create a tempfile but
     +    never use it), and makes it harder to add new options (the recent stdout
     +    option exits before creating the tempfile, so it misses the check and
     +    "git jump --stdout foo" will produce "git-jump: 92: mode_foo: not found"
     +    rather than the regular usage message).
      
     -    Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
     +    Signed-off-by: Jeff King <peff@peff.net>
      
       ## contrib/git-jump/git-jump ##
     -@@ contrib/git-jump/git-jump: open_editor() {
     - 	eval "$editor -q \$1"
     - }
     - 
     -+open_emacs() {
     -+	# Supported editor values are:
     -+	# - emacs
     -+	# - emacsclient
     -+	# - emacsclient -t
     -+	editor=`git var GIT_EDITOR`
     -+	# Wait for completion of the asynchronously executed process
     -+	# to avoid race conditions in case of "emacsclient".
     -+	eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"cat $@\\\" 'grep-mode)) (delete-other-windows) (while (get-buffer-process (current-buffer)) (sleep-for 0.1)) (select-frame-set-input-focus (selected-frame)))\""
     -+}
     +@@ contrib/git-jump/git-jump: if test $# -lt 1; then
     + 	exit 1
     + fi
     + mode=$1; shift
     ++type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
      +
     - mode_diff() {
     - 	git diff --no-prefix --relative "$@" |
     - 	perl -ne '
     -@@ contrib/git-jump/git-jump: tmp=`mktemp -t git-jump.XXXXXX` || exit 1
     - type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
     + if test "$use_stdout" = "t"; then
     + 	"mode_$mode" "$@"
     + 	exit 0
     +@@ contrib/git-jump/git-jump: fi
     + 
     + trap 'rm -f "$tmp"' 0 1 2 3 15
     + tmp=`mktemp -t git-jump.XXXXXX` || exit 1
     +-type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
       "mode_$mode" "$@" >"$tmp"
       test -s "$tmp" || exit 0
     -+if git var GIT_EDITOR | grep emacs >/dev/null; then
     -+	open_emacs "$tmp"
     -+	exit 0
     -+fi
       open_editor "$tmp"
 -:  ----------- > 3:  ad7c299cb0f git-jump: invoke emacs/emacsclient

-- 
gitgitgadget
