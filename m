Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E5C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 12:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhLPMUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 07:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhLPMUv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 07:20:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B781C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 04:20:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so85348866eda.12
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 04:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bOVN3mO8elOzaW4YMQ8nqFFCy15aKuaBwl8bRDY6lgA=;
        b=iddSn55Tbo00mqFpYw+RwCTNSgXcO94AkU+4kbTwG6cL3xx3mF4fM+2bthgQn62T4G
         ff1HmgkTokD/jvRwb7l3DbLVEYORZF6giWPIK+3AFscWqAGB9Aiz/0boVxc5GV+mfGs1
         181HnikcKLUgLx+ZdFc5cbb4DhPvVqRy16vqug2ELeJJdlW6ivQseo8zv4wLMu39Ogob
         RD9rbeY0xbi1Zhj9NfGV9GYUTNyej2EqUnpWufxuDVr7RuTXBBMZB5EwItBR1tB8nLCg
         JIoTS3lxYmPspfTMtb9fxAibvf8bbEtM5NHbQZloK7HEb57sBqQ1XMaUN9qVyr1na+7x
         siUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bOVN3mO8elOzaW4YMQ8nqFFCy15aKuaBwl8bRDY6lgA=;
        b=SfX6cE0ro8NZlXFqCf9YY6EtAWZXr04UwZ6sk7HKajt0xyy4JKZAnMIZTh8J8fm9JA
         AXHwzitMyUx394wrBjW/Omjj0eZndiUVvDx8wwFSvRpJyknMQeX23OG1RKSrQl8Xz+VO
         xD/A/6AJwub5LmecWb4wnKHSj8t2O+NVLuZvAcsgLHS3chq8SDva31MWmCP7fu2FA6Zr
         PyTbAGdQ/SCNuOChlvNAUH8DeImuhN43H1SFoeJlWQ42H7dAiH1lToK3zB69EKeYQTzn
         BuFsKyIWUNV7k+dp3GoMNVzjUpRygkDx74b3zSIlX+fZW+VwGiyVqgRmZdjdsgZ8V8v+
         C0cg==
X-Gm-Message-State: AOAM533KckfrmHGn78d/0r2H+BJD7vdybICLOahhn6rqvnoEiIwAv9Bt
        rvdc/mPvJjki6hLQ3TXneFiGULsf0bQ=
X-Google-Smtp-Source: ABdhPJy1HK2iVB29dDvTQ/VRyuBfkdpX+XD2J3sOLLEDiQd49ANOZu201SBNJqjDoaKZW0tRhMNa/Q==
X-Received: by 2002:a17:906:9d03:: with SMTP id fn3mr15420671ejc.742.1639657249744;
        Thu, 16 Dec 2021 04:20:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j4sm2361259edk.64.2021.12.16.04.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 04:20:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mxpke-000MqD-MH;
        Thu, 16 Dec 2021 13:20:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/run-command (was: What's cooking in git.git (Dec 2021, #04; Wed,
 15))
Date:   Thu, 16 Dec 2021 12:51:55 +0100
References: <xmqq8rwlz3cq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq8rwlz3cq.fsf@gitster.g>
Message-ID: <211216.868rwkbv1b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 15 2021, Junio C Hamano wrote:

> [Graduated to 'master']
> [...]
> * ab/run-command (2021-11-25) 9 commits
>   (merged to 'next' on 2021-12-07 at 5c0bedf853)
>  + run-command API: remove "env" member, always use "env_array"
>  + difftool: use "env_array" to simplify memory management
>  + run-command API: remove "argv" member, always use "args"
>  + run-command API users: use strvec_push(), not argv construction
>  + run-command API users: use strvec_pushl(), not argv construction
>  + run-command tests: use strvec_pushv(), not argv assignment
>  + run-command API users: use strvec_pushv(), not argv assignment
>  + upload-archive: use regular "struct child_process" pattern
>  + worktree: stop being overly intimate with run_command() internals
>
>  API clean-up.
>  cf. <211130.86k0gpcpy2.gmgdl@evledraar.gmail.com>
>  cf. <CAPig+cSvFgJTiq8pXrWy_7ukQwE1y9ZGwMgKmyjWuQHdNGxiDQ@mail.gmail.com>
>  source: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>

Thanks! FWIW the tip commit mentioned that renaming "env_array" to "env"
probably wasn't worth it, but having tried it just now I think it's
probably a worthwhile follow-up at some point. The diff is just:
	
	diff --git a/run-command.h b/run-command.h
	index 2be5f5d6422..c5d44cc9a5c 100644
	--- a/run-command.h
	+++ b/run-command.h
	@@ -73,7 +73,7 @@ struct child_process {
	 	 * The memory in .env_array will be cleaned up automatically during
	 	 * `finish_command` (or during `start_command` when it is unsuccessful).
	 	 */
	-	struct strvec env_array;
	+	struct strvec env;
	 	pid_t pid;
	 
	 	int trace2_child_id;
	@@ -147,7 +147,7 @@ struct child_process {
	 
	 #define CHILD_PROCESS_INIT { \
	 	.args = STRVEC_INIT, \
	-	.env_array = STRVEC_INIT, \
	+	.env = STRVEC_INIT, \
	 }
	 
	 /**

Followed by a rather large mechanical change, but that change can almost
entirely be done with this cocci rule:
    
    @@
    struct child_process E;
    @@
    - E.env_array
    + E.env
    
    @@
    struct child_process *E;
    @@
    - E->env_array
    + E->env

The "almost" being that we'll also need this on top:
    
     builtin/submodule--helper.c |  2 +-
     run-command.c               |  6 +++---
     run-command.h               | 10 +++++-----
     sequencer.c                 |  6 +++---
     submodule.h                 |  4 ++--
     5 files changed, 14 insertions(+), 14 deletions(-)

Which changes comments and function/variable names that refer to
"env_array" to refer to "env".

I won't submit it now because we've got some "env_array" in
master..seen, but there'll probably be a time when there'll be none
which might make it trivial.

Or maybe you're not interested in either case, which is also fine. It's
really not needed for anything other than to resolve the minor oddity
that we have two "struct strvec"'s, "args" and "env_array". It's just a
bit odd to have one with "_array" in the name, which is only because the
now-removed "env" was taken at the time.
