Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772812FF9D
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824954; cv=none; b=BmNO17BWYpKpLGHl1gU8x5WP/uNu/h/WpCGSmFbhCfgdz0HU8u1e12IMn7lCV86CwGinSqvDfvlGbVmNgQ919PJUfu2th/85KlwKGq8weHEJ+OHZoKb8HZkwHG4sYT7Z23S+yNvMs70eVxkXNgmX1OYMNaP4fwzPS85f9NHixwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824954; c=relaxed/simple;
	bh=X/ufTnHQjPGHD0k+vB/FIiFeV7NovwqRzfoUajcbhzY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EQmci3PDBGxFsrGgBLB8ku6kQeBaT9t/Va3lS61X25SzZmZPWBabhZ9j2oXEEVoOkEHZ3oh2ArQqTqxUshMhsIQ7Jjpl2aJRa+DLWEMkgvOZrQz+TszUjtQa5vEuXVicfUlk43wpFFH34aJOr0HkDMnPQnNqJqcxZUFS3hwgUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6enQXln; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6enQXln"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d36736d4eso694841f8f.1
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 07:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709824951; x=1710429751; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo1jV/dYhctD1/a5cvr6xI4viazOG9wef/MoeNhIW0I=;
        b=j6enQXlnBJ3tk6xgHfVfmdHCRYA3xQFx4Y8wwlyhknyuEFS5vDUc0AsHXjaonYO65s
         o/yLb/GpfCG6V6FXPNnqG9R3Ji4jJ1aRy+KeI5UMaBys97xSvBhjE/4MO816XW8w1Faz
         0OmaPrMOLYxQXTacQ4vRluBeABFaN5O0KUw2BpC/O9vKXoQMc9IuFlihH0hzjLQ3CB6U
         tvh7yqA+Yhvtr70IOJs2/PNTv2NuHvTt0j+j3sfL2GOaHvaMWO0hBY/OABkS4jgu4B9q
         2tmwv/RXlzKaFNKiwZ3wo9j8PA/OSXePeA9kvv34+RMmNNMg5lW7P5l+25365WEm2wp1
         chHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709824951; x=1710429751;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo1jV/dYhctD1/a5cvr6xI4viazOG9wef/MoeNhIW0I=;
        b=NQ0yx7f8zUGls1gOocagPcpEtTMqiWB75ti9o0WjjiHiajkhJKfR34UkrIqpj8mM9Q
         L4/Q2jOYJsizlsl1gUJQFAU8ttMzhfQyZc1iXx4V92K8svEHgk/WThOlw2qqayn4eDTM
         QLab7Neu86RIGjbtQ50mUKzD5n5DpxqUYH8eUS5Tu1Kl08O8TC5wzVx4t7PNs+rFG/e1
         N1b+jNvW8UCLJn3A4HR+VuVREguiWCh9bC3awiFcrMUafAOyfl6OkhjeuYvvX6/tlwqI
         s5wGI3jYogvd+eZKD6txNjCyWSnFLJ1tU+yRmwxxYox8Qi73o5ZoQTNx+AdlRvNMGYaE
         Sp3g==
X-Gm-Message-State: AOJu0YxHWduI0XHBU/p4afD3GKtr0dw9JGXKjjZ0wKdpRNOB2Sxs7iAB
	jC7l4DKS3QbpEWHRVtHeX2/B4Y+gsSWAPGREK4BQ1ImR5rY+EU1Ugji+8ftY
X-Google-Smtp-Source: AGHT+IGBPhsUF9n5lIRGcPYQ9OLWbtMCLPp7Y/tKO3DAgXQbiRmxaA02sKAN0MAeMDu0PWQZg4sVGg==
X-Received: by 2002:adf:fecb:0:b0:33d:2d07:b567 with SMTP id q11-20020adffecb000000b0033d2d07b567mr12526399wrs.24.1709824950578;
        Thu, 07 Mar 2024 07:22:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d30-20020adfa41e000000b0033e73f09dffsm40109wra.25.2024.03.07.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:22:30 -0800 (PST)
Message-ID: <pull.1679.v2.git.1709824949.gitgitgadget@gmail.com>
In-Reply-To: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 Mar 2024 15:22:26 +0000
Subject: [PATCH v2 0/3] trace2: move generation of 'def_param' events into code for 'cmd_name'
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>

Here is version 2 of this series. The only change from V1 is to combine the
last two commits as discussed.

Thanks Jeff

----------------------------------------------------------------------------

Some Git commands do not emit def_param events for interesting config and
environment variable settings. Let's fix that.

Builtin commands compiled into git.c have the normal control flow and emit a
cmd_name event and then def_param events for each interesting config and
environment variable. However, some special "query" commands, like
--exec-path, or some forms of alias expansion, emitted a cmd_name but did
not emit def_param events.

Also, special commands git-remote-https is built from remote-curl.c and
git-http-fetch is built from http-fetch.c and do not use the normal set up
in git.c. These emitted a cmd_name but not def_param events.

To minimize the footprint of this commit, move the calls to
trace2_cmd_list_config() and trace2_cmd_list_env_vars() into
trace2_cmd_name() so that we always get a set of def_param events when a
cmd_name event is generated.

Users can define local config settings on a repo to classify/name a repo
(e.g. "project-foo" vs "personal") and use the def_param feature to label
Trace2 data so that (a third-party) telemetry service does not collect data
on personal repos or so that telemetry from one work repo is distinguishable
from another work repo in database queries.

Jeff Hostetler (3):
  t0211: demonstrate missing 'def_param' events for certain commands
  trace2: avoid emitting 'def_param' set more than once
  trace2: emit 'def_param' set with 'cmd_name' event

 git.c                  |   6 --
 t/t0211-trace2-perf.sh | 231 +++++++++++++++++++++++++++++++++++++++++
 trace2.c               |  15 +++
 3 files changed, 246 insertions(+), 6 deletions(-)


base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1679%2Fjeffhostetler%2Falways-emit-def-param-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1679/jeffhostetler/always-emit-def-param-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1679

Range-diff vs v1:

 1:  b378b93242a = 1:  b378b93242a t0211: demonstrate missing 'def_param' events for certain commands
 2:  65068e97597 = 2:  65068e97597 trace2: avoid emitting 'def_param' set more than once
 3:  9507184b4f1 ! 3:  178721cd4f0 trace2: emit 'def_param' set with 'cmd_name' event
     @@ Commit message
          the "trace2_cmd_name()" function to generate the set of 'def_param'
          events.
      
     -    We can later remove explicit calls to "trace2_cmd_list_config()" and
     -    "trace2_cmd_list_env_vars()" in git.c.
     +    Remove explicit calls to "trace2_cmd_list_config()" and
     +    "trace2_cmd_list_env_vars()" in git.c since they are no longer needed.
      
     +    Reviewed-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
     + ## git.c ##
     +@@ git.c: static int handle_alias(int *argcp, const char ***argv)
     + 			strvec_pushv(&child.args, (*argv) + 1);
     + 
     + 			trace2_cmd_alias(alias_command, child.args.v);
     +-			trace2_cmd_list_config();
     +-			trace2_cmd_list_env_vars();
     + 			trace2_cmd_name("_run_shell_alias_");
     + 
     + 			ret = run_command(&child);
     +@@ git.c: static int handle_alias(int *argcp, const char ***argv)
     + 		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);
     + 
     + 		trace2_cmd_alias(alias_command, new_argv);
     +-		trace2_cmd_list_config();
     +-		trace2_cmd_list_env_vars();
     + 
     + 		*argv = new_argv;
     + 		*argcp += count - 1;
     +@@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
     + 
     + 	trace_argv_printf(argv, "trace: built-in: git");
     + 	trace2_cmd_name(p->cmd);
     +-	trace2_cmd_list_config();
     +-	trace2_cmd_list_env_vars();
     + 
     + 	validate_cache_entries(the_repository->index);
     + 	status = p->fn(argc, argv, prefix);
     +
       ## t/t0211-trace2-perf.sh ##
      @@ t/t0211-trace2-perf.sh: test_expect_success 'expect def_params for normal builtin command' '
       # Representative query command dispatched in handle_options()
 4:  e8528715ebf < -:  ----------- trace2: remove unneeded calls to generate 'def_param' set

-- 
gitgitgadget
