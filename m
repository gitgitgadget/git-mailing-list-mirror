Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B0AC432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0F42075E
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSK0dpr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfKXUZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 15:25:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38613 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfKXUZx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 15:25:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so15030780wro.5
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 12:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9JiwC5o3pqxHKY8aavxib8NUMz4owBsgmrnm0C68wn8=;
        b=ZSK0dpr0lZmJ3h7K+f7LDZgY6JZtv2D9BxueKtYN8YBlMEmWC56btnDUbulQIBSFqU
         ZO+hp4qhAode3+VJ6GI+EA/tP6JEmbP3l9EpKUjbUeFCR7v//oJkAMeegFMarl+biE9j
         faTtX2B7wNTjpWXWX3+mElSyvnS3PB3LLwQS6ShmF7iSiiTW14TreWpeZyjgwLQO1moC
         IBGwXEOlyrKrFp6wOsYKVkppNNW2wsAiz03jGu9EbQiKrO19kGR6J9CyMOjhjf4fCK6a
         jSiR0fHLjJj9G2ifzSg0FENzHc08U8fgl2dgTAq3yf7uSgD7biXsGKQUy98T1N3k8kpa
         3tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9JiwC5o3pqxHKY8aavxib8NUMz4owBsgmrnm0C68wn8=;
        b=mSG31AYli2WXNlgSyX2db7chAytU/b/dv/cB+kgtxF+FIoD/dGDU2M0B+LYOrcYByf
         lVEkvt3uSmdmuaXmvaB6Hb9UXIFXOzpLOSAeTUBFN45ruUZw5CUmimWG5GpEMdov3JwH
         AxfDBb9wSpX3CwGOtmFwh0EOExAgPRhh56243JaRlcBYCHO/4pt/SFDWUXd6AblWzUAq
         8+esJGprD7mXFS01vACf1hPgYO67Gv1KI7fBC/uQE6c6eERanIaNInHNDwqXPCyhAAgT
         hPRtIhOGZlOZTkrXUyc+YRbj64qEf5Q8sU1LcKQxDoqTRw+dGvOy6wvBO/xGtK54EebT
         vUyg==
X-Gm-Message-State: APjAAAWiC3zmbUdBsFuBtVBSbvt0zZnvSm44HiscmCN49p0FtPFPUifK
        NmwSC4NUtUZGW4waB/0gb7TMrdwY
X-Google-Smtp-Source: APXvYqxrtjdQltPym+AjmZn51wyUnMdYRQJk++vrnOPJdlmIH/DP+9XgONhKRRFYfb3J2k0JFe+xug==
X-Received: by 2002:adf:fecf:: with SMTP id q15mr22560581wrs.75.1574627151078;
        Sun, 24 Nov 2019 12:25:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm7387215wrp.64.2019.11.24.12.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 12:25:50 -0800 (PST)
Message-Id: <pull.474.v2.git.1574627149.gitgitgadget@gmail.com>
In-Reply-To: <pull.474.git.1574538937.gitgitgadget@gmail.com>
References: <pull.474.git.1574538937.gitgitgadget@gmail.com>
From:   "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 20:25:48 +0000
Subject: [PATCH v2 0/1] reset: parse rev as tree-ish in patch mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nika Layzell <nika@thelayzells.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows passing a tree-ish git reset -p without specifying a pathspec.
Requiring a commit in this situation appears to be an oversight, and support
for a tree-ish is documented by git-reset's manpage. (
https://github.com/git/git/blob/d9f6f3b6195a0ca35642561e530798ad1469bd41/Documentation/git-reset.txt#L12
)

An alternative implementation of this change would move the if (patch_mode)
{ ... return; } check before the rev parsing logic, offloading validation of
the rev argument when in patch mode to the git-add--interactive logic. This
would be possible as the parsed oid is not passed to git-add--interactive. (
https://github.com/git/git/blob/d9f6f3b6195a0ca35642561e530798ad1469bd41/builtin/reset.c#L341-L346
)

Nika Layzell (1):
  reset: parse rev as tree-ish in patch mode

 builtin/reset.c        |  2 +-
 t/t7105-reset-patch.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-474%2Fmystor%2Freset-interactive-treeish-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-474/mystor/reset-interactive-treeish-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/474

Range-diff vs v1:

 1:  338c2777f7 ! 1:  a608dc8368 reset: parse rev as tree-ish in patch mode
     @@ -2,12 +2,22 @@
      
          reset: parse rev as tree-ish in patch mode
      
     -    Relaxes the commit requirement for the rev argument when running
     -    git-reset in patch mode without pathspec.
     +    Since 2f328c3d ("reset $sha1 $pathspec: require $sha1 only to be
     +    treeish", 2013-01-14), we allowed "git reset $object -- $path" to reset
     +    individual paths that match the pathspec to take the blob from a tree
     +    object, not necessarily a commit, while the form to reset the tip of the
     +    current branch to some other commit still must be given a commit.
      
     -    The revision argument to git-reset is parsed as either a commit or
     -    tree-ish depending on mode. Previously, if no pathspec was provided,
     -    the rev argument was parsed as a commit unconditionally.
     +    Like resetting with paths, "git reset --patch" does not update HEAD, and
     +    need not require a commit. The path-filtered form, "git reset --patch
     +    $object -- $pathspec", has accepted a tree-ish since 2f328c3d.
     +
     +    "git reset --patch" is documented as accepting a <tree-ish> since
     +    bf44142f ("reset: update documentation to require only tree-ish with
     +    paths", 2013-01-16). Documentation changes are not required.
     +
     +    Loosen the restriction that requires a commit for the unfiltered "git
     +    reset --patch $object".
      
          Signed-off-by: Nika Layzell <nika@thelayzells.com>
      
     @@ -37,6 +47,20 @@
      +	verify_saved_state bar &&
      +	test_i18ngrep "Apply" output
      +'
     ++
     ++test_expect_success PERL 'git reset -p HEAD^:dir/foo (blob fails)' '
     ++	set_and_save_state dir/foo work work &&
     ++	test_must_fail git reset -p HEAD^:dir/foo &&
     ++	verify_saved_state dir/foo &&
     ++	verify_saved_state bar
     ++'
     ++
     ++test_expect_success PERL 'git reset -p aaaaaaaa (unknown fails)' '
     ++	set_and_save_state dir/foo work work &&
     ++	test_must_fail git reset -p aaaaaaaa &&
     ++	verify_saved_state dir/foo &&
     ++	verify_saved_state bar
     ++'
      +
       # The idea in the rest is that bar sorts first, so we always say 'y'
       # first and if the path limiter fails it'll apply to bar instead of

-- 
gitgitgadget
