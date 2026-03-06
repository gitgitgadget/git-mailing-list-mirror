Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E851225A34
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835283; cv=pass; b=l0SSLWJNEtcUJSB1QGL1XsjhKB/idtA2aUVIgUr/JoKQ17D9yil42G9FoiaR5GdgCP4m8V6fUNajNnconG49T0WXgsZtXphB86GWWWcpKESsqFG4XoVN3zh7x3RrTotyWvhAjVsaCyBOtTx34EEhvFDwvKlM+Bcnjpyy3M6toPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835283; c=relaxed/simple;
	bh=Iyleq5YRsYrXvtTPOoYsyczTX6ALfQgBCikqaGNhKPo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=n0HVZa6mqC+OKVCWmhKaI7/V5JE4NpCpHjO25LbdwyQhDwhVekpOViq8YPbTeSVkzBjIFj6jOuKzdZhfRLN8Eu5VDOocL9PsXmJkcOBAiHC48tOfEKesdbCWMj4ta5nnDOgA/BGTO+KjfYApRj8a94tUjNnYqmSx3+ikbN3naC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/vphKWN; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/vphKWN"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3505603a12.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 14:14:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772835280; cv=none;
        d=google.com; s=arc-20240605;
        b=ivgektN9FUVCxHwnmHhkovbUNEBZzPmreATWzR7uOLoxCo4ap2lE/jiwaZzIWSao5G
         xBrjV4nPMsEVYUIBc6x/Q8Mp0h7jgOmBfq9l6I50MlOKjNZWMTEUsQCmR7XEgAvUTv34
         3ZkAUZleeMPkei/bJ/eNxi3s8Dm004RI70OuhK0aAvxsjIFwLGyxP7q1wQUgkl9GaE4r
         9QGc/I8Y5S8vXN6SVA4lp4RdTqh1nMLBYeVue+QvWHA8f1khk/NFvYaO+vLpz9WdIzjT
         nKhiTTTON4bUmbDIkPodnuQrfo2alKPErl2kRDA2Uh6179yfQwfvWV6KPK4FZRdf5652
         7zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gFL1is1RQEB4+jEbs7HTvyvytbBoIO3SgcB96QvZJwA=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=gjTG3wWb3mY7yz+bujmv85VFXQ4PVur9p1ZsfxolV6aZfu/IkDcRiZfLi84WY/ybHB
         UCaiYRryN9VSNMdnaffQYglQIKTh2QLvRiTxhnyGYKVVwzTAp/ohz21qtktqYAopss6H
         HcLuxFBgCeBR8C/LuQUcoZGM0NRPfCDEX2D+BfdDSFfIYGXGCyoJeSxv24uQJzT0oxOE
         /6BgQTWrLsTS/eVwMz8WvV3wu+GU6q6cF/wJ64rZBpPRMyub7u85043r4EYYU6uR1RlS
         vCzoMTF3k+KCwjuiXh7hndTBnLKUD44vBD0RwOXfpaEC4zOxYWbG+J4JCwtPOneTlYB9
         tStA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772835280; x=1773440080; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gFL1is1RQEB4+jEbs7HTvyvytbBoIO3SgcB96QvZJwA=;
        b=f/vphKWNv70X0byfXF8rwA66/OLK4FjI4Z5SqVVyvgoQDD1Uh2ZknyAYHgK6Q+ecZu
         +4KlYjM/ojty5D3wwtE1QBLdDjQBQaHvG1NzQlyFgELAwI7qbvaNc/zVyhiTdgv6FLik
         5jrjPi26TE0sm1Z7t2xPCnA0xi3YRgZbCHAGEOVgA4kD5yFyqDCeT2I7yoe69fmCROwC
         rSqkulY14/wJ/M1aV274pZQ8SBw3SX6MC+4nNitw/ESVZl8UR91dMxaLXyxfSxLSs55T
         TiHQ6T39D4N7i0rATi3H7OzrtTNnUKZ2ra/HA2K+bMfV7vJbe5uga8OGUYvbDe2e2+rR
         0hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835280; x=1773440080;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFL1is1RQEB4+jEbs7HTvyvytbBoIO3SgcB96QvZJwA=;
        b=YovUYrmu6fSH25zUpJZA8hHy+3VqFeHy6kvWkG+U+0nmr9rHYG3jfmwc96mz+TgEeP
         WCf77c91Rjr7gcJUF8hAYf+jOuVaSf9CqGhl0iOik7aNhsoHiwcl2iCXeIVQDL9fw2M6
         udvIvpXdreG/pmPWlqwOzGWWjgV6AzjbmI/03es04TEFs9eYcJzeWUFabslhKu3i9nw9
         bF7lZe9u0UHAttH4R5TQeFufKHo7TYRp0IULQ2hW2CeuKQDguzSv7/6rTmgrpUh2OUn1
         GV21X+dQoX3Rp8UynE8dOYY6iABX8l7UV0zfusDGGtdCjPeLuAndIRSPPXZp619gh7k8
         A3PA==
X-Gm-Message-State: AOJu0YxwMWp1FI9itI5t7ukkq+ij0xeHdVvVmWBfcWt35e420pKXmjcp
	b2zuKgLnHluAeznDtgQ5O6ii4YoavlEBPkLzJhFB3YK4Qh+UHO9hY7ikB8l7HeNYUNCnaafW6yD
	mqecFy9imvemJFss8EwyE0GKMhGh74VM5uZAOFPrigQ==
X-Gm-Gg: ATEYQzygF7jh8HKJBnzcZXsRMODosyaILE+Rad7DIGEWZDj2lyYNeJ/mOAPh29uC9Kq
	byTenuA0N36YvKyyFN+hkn0npYW/rivEiTb/9xbP8NA1ITMvEAgnWt5JEMPxGMXSnz61CTAxBUO
	INrbrAAIoPsDQKRPlaKSac3zcabE2A/ZvepRKjta4mhesQZUdl2heZLZhgWuG6Wewq/IqR0d8v9
	fd9ZBRl1ZfDmp8G0TR6DByfJ6PpjF1VyYwb5IOfZSFFYPMj70EgZX3e/XAelZekYlKo5R99ZVd/
	CUpS85u72pAAiGXNcPkUjtllsA339EomEp0hNhEkv1pjkb8TQL2YbK+xCc/mJFivCzLi
X-Received: by 2002:a05:6a20:43ac:b0:35d:d477:a7f3 with SMTP id
 adf61e73a8af0-39858fdbb32mr3696338637.20.1772835280350; Fri, 06 Mar 2026
 14:14:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Banon <mikebdp2@gmail.com>
Date: Sat, 7 Mar 2026 01:14:28 +0300
X-Gm-Features: AaiRm51tj6b1m2rj3Hykd1BrA8dFQqqEQ7Z-GoNrurVkex4n5TZNZqlqDAz7eCs
Message-ID: <CAK7947msLiGgrYTcg1m3ew+bP0F+VNbRaTy=ZW7zkkHh69bN0Q@mail.gmail.com>
Subject: [PATCH] clone, progress: add --no-turtle-speed option to abort slow clones
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When cloning large repositories from a website with multiple Git servers,
the client may be directed to a "turtle-slow" server, causing the transfer
to proceed at an unusably slow speed. This can lead to stalled downloads,
particularly problematic for automated scripts that clone many
repositories. This option makes Git abort the clone if the download rate
falls below 128 KiB/s while receiving objects, typically catching slow
servers early in the transfer, enabling scripts to retry the clone until
they obtain a fast connection.

Signed-off-by: Mike Banon <mikebdp2@gmail.com>

diff --git a/builtin/clone.c b/builtin/clone.c
index fba3c9c508..a9ed2c193d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -94,6 +94,13 @@ static int recurse_submodules_cb(const struct option *opt,
     return 0;
 }

+static int set_turtle_speed_env(const struct option *opt UNUSED,
+                const char *arg UNUSED, int unset UNUSED)
+{
+    setenv(NO_TURTLE_SPEED_ENVIRONMENT, "1", 1);
+    return 0;
+}
+
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
     static const char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -946,6 +953,16 @@ int cmd_clone(int argc,
             .callback = recurse_submodules_cb,
             .defval = (intptr_t)".",
         },
+        {
+            .type = OPTION_CALLBACK,
+            .long_name = "no-turtle-speed",
+            .value = NULL,
+            .argh = NULL,
+            .help = N_("abort clone if speed drops below 128 KiB/s"),
+            .flags = PARSE_OPT_NOARG,
+            .callback = set_turtle_speed_env,
+            .defval = 0,
+        },
         OPT_ALIAS(0, "recursive", "recurse-submodules"),
         OPT_INTEGER('j', "jobs", &max_jobs,
                 N_("number of submodules cloned in parallel")),
diff --git a/environment.h b/environment.h
index 123a71cdc8..cb316cf321 100644
--- a/environment.h
+++ b/environment.h
@@ -24,6 +24,7 @@
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
 #define NO_LAZY_FETCH_ENVIRONMENT "GIT_NO_LAZY_FETCH"
+#define NO_TURTLE_SPEED_ENVIRONMENT "GIT_NO_TURTLE_SPEED"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
diff --git a/git.c b/git.c
index 744cb6527e..d0c4909fef 100644
--- a/git.c
+++ b/git.c
@@ -40,9 +40,9 @@ const char git_usage_string[] =
     N_("git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]\n"
        "           [--exec-path[=<path>]] [--html-path] [--man-path]
[--info-path]\n"
        "           [-p | --paginate | -P | --no-pager]
[--no-replace-objects] [--no-lazy-fetch]\n"
-       "           [--no-optional-locks] [--no-advice] [--bare]
[--git-dir=<path>]\n"
-       "           [--work-tree=<path>] [--namespace=<name>]
[--config-env=<name>=<envvar>]\n"
-       "           <command> [<args>]");
+       "           [--no-turtle-speed] [--no-optional-locks]
[--no-advice] [--bare]\n"
+       "           [--git-dir=<path>] [--work-tree=<path>]
[--namespace=<name>]\n"
+       "           [--config-env=<name>=<envvar>] <command> [<args>]");

 const char git_more_info_string[] =
     N_("'git help -a' and 'git help -g' list available subcommands and some\n"
@@ -206,6 +206,10 @@ static int handle_options(const char ***argv, int
*argc, int *envchanged)
             setenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 1);
             if (envchanged)
                 *envchanged = 1;
+        } else if (!strcmp(cmd, "--no-turtle-speed")) {
+            setenv(NO_TURTLE_SPEED_ENVIRONMENT, "1", 1);
+            if (envchanged)
+                *envchanged = 1;
         } else if (!strcmp(cmd, "--no-replace-objects")) {
             disable_replace_refs();
             setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
diff --git a/progress.c b/progress.c
index 8315bdc3d4..b30c9f11d3 100644
--- a/progress.c
+++ b/progress.c
@@ -195,6 +195,7 @@ void display_throughput(struct progress *progress,
uint64_t total)
     struct throughput *tp;
     uint64_t now_ns;
     unsigned int misecs, count, rate;
+    const char *turtle_env = getenv(NO_TURTLE_SPEED_ENVIRONMENT);

     if (!progress)
         return;
@@ -245,6 +246,13 @@ void display_throughput(struct progress
*progress, uint64_t total)
     tp->last_misecs[tp->idx] = misecs;
     tp->idx = (tp->idx + 1) % TP_IDX_MAX;

+    if (turtle_env &&
+        *turtle_env == '1' &&
+        rate < 128 &&
+        progress->title &&
+        strstr(progress->title, "Receiving objects"))
+        die(_("stopping due to a <128 KiB/s turtle speed: %u KiB/s"), rate);
+
     throughput_string(&tp->display, total, rate);
     if (progress->last_value != -1 && progress_update)
         display(progress, progress->last_value, NULL);
