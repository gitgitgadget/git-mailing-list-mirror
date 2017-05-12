Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDC21FF34
	for <e@80x24.org>; Fri, 12 May 2017 17:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757613AbdELR1D (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 13:27:03 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34132 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755666AbdELR1B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 13:27:01 -0400
Received: by mail-pg0-f49.google.com with SMTP id u28so33203998pgn.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=URDe87oQyy3Bt8P+ksop4q3tElnm/hkDu5tJtxuvHVM=;
        b=MYoW0QFke7IAM022545keAWN18K/LzgIho6HdOfdlddk9SeHKeGGaZiVNIe9x/6uPC
         GM+p3cpCunSJMwr28l4/rxkmrVZJCvg2fkZZRpOFrz33RrtOi9k8gDtt0/neBcfPOzK/
         qeCZPo0Z8w6ipGhhv3nlWGJsVWvrKMsC8yghVgmswD7yZqO0KOmRP1K9XfWB6bJ6mZ3q
         V0cL5cEVZ3cbYUwyTVVtThB6ireYqnHjuCox0ORYIFsrAeJa/Eds0talqrbjWgPWfU9f
         XXSLKybY/9YMXUXgPUa9tYZy2W+MhZisJfXGvrPtXdnVrVR4XhDVA+CUZ0ifkhchJGW3
         3Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=URDe87oQyy3Bt8P+ksop4q3tElnm/hkDu5tJtxuvHVM=;
        b=ui4OaAi2bGp18k1Qo8G6rZIpZuPpjm9crVUuw4GmSsSyRk9A/tdnaduE63WTr/Unq7
         QGhP0vHViWYaPONOxm3Fkhs0KXbxwub20AGPyETq48WEqq7feMRNLPbjE7q08eewJLgD
         EXBZER4pMuN+Xjs33BN2G759YdFY5ssxSDBwvUORJ7s2wjdaW68sTM0x5szKSHL7nV1E
         uSp82vLqp5W6xdVvLuD/5WxxY5sjh/ijikQ7scm7zlzMeUNTAy7qGfePXsg1rCeLVlej
         UAoFG5M/HVBuzHvuRE5/a0nvdg/P90NkV9ltmbjc9X432mp+HOLXPZCWyS72430wufse
         d/vQ==
X-Gm-Message-State: AODbwcCy6p59m8ix84/JLW+SXYKITiUNimyyinCOXFNzYSW1CtRw9Gd7
        Nx88y7D0ZJfCyI8rYnre8Q==
X-Received: by 10.99.108.133 with SMTP id h127mr5676700pgc.9.1494610020438;
        Fri, 12 May 2017 10:27:00 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4e0:75e9:f5fc:bc05])
        by smtp.gmail.com with ESMTPSA id 138sm6124687pgc.32.2017.05.12.10.26.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 10:26:59 -0700 (PDT)
Date:   Fri, 12 May 2017 10:26:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     paul@myitcv.io
Cc:     gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
Message-ID: <20170512172657.GA98586@google.com>
References: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com>
 <20170512162109.49752-1-paul@myitcv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170512162109.49752-1-paul@myitcv.io>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12, paul@myitcv.io wrote:
> > ...
> 
> I'm nowhere near up to speed with the entire history of this chain so
> please excuse me if I've missed some detail somewhere.
> 
> As of b06d3643105c8758ed019125a4399cb7efdcce2c, the following command
> "hangs" at near 100% CPU in a repo of mine:
> 
> git ls-files --recurse-submodules
> 
> The "hang" appears to be an explosion of subprocesses (snipped the
> COMMAND detail from ps):
> 
> git ls-files --recurse-submodules
> git --super-prefix=g/_vendor/src/github.com/ramya-rao-a/go-outline/ ls-files --recurse-submodules --
> git --super-prefix=g/_vendor/src/github.com/ramya-rao-a/go-outline/g/_vendor/src/github.com/ramya-rao-a/go-outline/ ls-files --recurse-submodules --
> ....

Yeah the way the recursion works as of 2.13 is that a new process is
spawned for each submodule.  This really is kind of clunky and I'd like
to move to an implementation which doesn't require spawning a ton of
processes, so that's a goal of mine I'm trying to work towards.  This is
still a relatively new feature so I expect there's still a lot of bugs to
iron out.

> 
> In v2.11.0 I simply get a fatal error (this repo doesn't actually
> contain any submodules):
> 
> fatal: can't use --super-prefix from a subdirectory
> 
> I haven't yet been able to work out what's special about the
> subdirectory g/_vendor/src/github.com/ramya-rao-a/go-outline/
> 
> Is this expected? (I'm guessing not)
> 
> How can I help diagnose what's going on here?

Looking at this it appears to me that you have a submodule loop, either
directly or indirectly.  That is if you have a repo 'a' which contains a
submodule 'b' and repo 'b' happens to contain 'a' as a submodule you'd
find yourself with an infinite loop.  But that's what I'm guessing
based on that output you've shown me.

But you're saying that this repo doesn't actually contain submodules?
Hmm then I'm at a loss...unless!

The directory 'go-outline' is a place holder for a submodule so ls-files
spawns a process in that directory. But since its not populated, during
the gitdir discovery it falls back to the superproject's gitdir,
restarting the whole process and creating an infinite loop...

Welp that's a pretty terrible bug which stems from
missing a check to see if a submodule is initialized, and not explicitly
setting GIT_DIR=.git (theres cases where we don't want this but turns
out we probably should do that here).  Let me know if this fixes the
problem:


diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a6c70dbe9..b0796fc10 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -206,7 +206,6 @@ static void show_gitlink(const struct cache_entry *ce)
 	char *dir;
 
 	prepare_submodule_repo_env(&cp.env_array);
-	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
 
 	if (prefix_len)
 		argv_array_pushf(&cp.env_array, "%s=%s",
@@ -242,6 +241,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
 	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
+	    is_submodule_initialized(ce->name) &&
 	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
 		show_gitlink(ce);
 	} else if (match_pathspec(&pathspec, name.buf, name.len,
@@ -611,8 +611,10 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	if (recurse_submodules)
+	if (recurse_submodules) {
+		gitmodules_config();
 		compile_submodule_options(argv, &dir, show_tag);
+	}
 
 	if (recurse_submodules &&
 	    (show_stage || show_deleted || show_others || show_unmerged ||

-- 
Brandon Williams
