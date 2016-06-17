Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4FB20179
	for <e@80x24.org>; Fri, 17 Jun 2016 16:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbcFQQBh (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 12:01:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35306 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcFQQBf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 12:01:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id k184so766507wme.2
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 09:01:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sQq/ha0zFw0DOjG9p5NzzZeqZSWod5aaCeVZ7ktKlcY=;
        b=PAfAAD+/KF9bS5NX4jfBX1Swl5ihpvai04CmpvcYa9EFDOpJfw40gbQ0qU5rmxgPLH
         +9Ao/L+ggx0Xl89uOyedex7og50loEu92ItAYQN1qIrhffX2y1SyFpeoRkDyT1EKuFb7
         gxAZtCDgmDS+T8EH01q0gLM5IF5c+bYP/P9FJnVhE95gtEqfjjqlYgw1lwtbhdDIXTR+
         QGEUkGVMTUNZAd46SDWvyXRL+B7Jdrjm9NPMpUvOSJRTs4d9DwQ0bQEuGNmCScz8Z0w8
         DOGgQhAu6hkACF3BbvtzSj14rnMluX+xqDNLzJO2UWPwqlIeeXD9FKvWaUyWpMd+jvTE
         RrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sQq/ha0zFw0DOjG9p5NzzZeqZSWod5aaCeVZ7ktKlcY=;
        b=B8VsmqGwXOkykYIqPSm8O7E+csTBwvc8HbuFiDKELN/rFT5hdVEESezM/X87R8Z78e
         yi9S6wmWco0KHHP/7r2v1TdvLam+FxQ+C/knUuWGrgoqR/llMCJbG/M4xGwv1qHNN8qj
         jkgTiA/G5hPlpvCA4dvbTkSeXfhDb8ENidIyOqnbuCMVG6GCiWJlvWJdp5qBtCFpjucT
         j1nXWE7JCjWi8pAal9+rAhZKHGXONO7TqZLsQuTLcOigGZGD0w9wxYDHQirG8vXz+yvY
         JaSVo8eyvFTC4RP5aF7agcMOKnR3lC75kQNy38KRRLwlTyRe8ry/vu7sUolKKB9bPT6n
         GiDA==
X-Gm-Message-State: ALyK8tJJ5T9wKjNtzgHJ9ybOXD8gbDJtqLKPdjm7+AjQiVLfEQpJKCaTIV4GHzepyOlMbd/IKyLMI59QrT2W2g==
X-Received: by 10.194.239.163 with SMTP id vt3mr3038470wjc.78.1466179294303;
 Fri, 17 Jun 2016 09:01:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Fri, 17 Jun 2016 09:01:33 -0700 (PDT)
In-Reply-To: <1463694357-6503-11-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-11-git-send-email-dturner@twopensource.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Fri, 17 Jun 2016 18:01:33 +0200
Message-ID: <CAP8UFD3ar3uZmrOtp9TUGGZpk6vMeJgZxmPmu8grENbaZwZETA@mail.gmail.com>
Subject: Re: [PATCH v12 10/20] watchman: support watchman to reduce index
 refresh cost
To:	David Turner <dturner@twopensource.com>
Cc:	git <git@vger.kernel.org>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>
> The previous patch has the logic to clear bits in 'WAMA' bitmap. This
> patch has logic to set bits as told by watchman. The missing bit,
> _using_ these bits, are not here yet.
>
> A lot of this code is written by David Turner originally, mostly from
> [1]. I'm just copying and polishing it a bit.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/248006
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Makefile           |  12 +++++
>  cache.h            |   1 +
>  config.c           |   5 ++
>  configure.ac       |   8 ++++
>  environment.c      |   3 ++
>  watchman-support.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  watchman-support.h |   7 +++
>  7 files changed, 171 insertions(+)
>  create mode 100644 watchman-support.c
>  create mode 100644 watchman-support.h
>
> diff --git a/Makefile b/Makefile
> index c8be0e7..65ab0f4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -451,6 +451,7 @@ MSGFMT = msgfmt
>  CURL_CONFIG = curl-config
>  PTHREAD_LIBS = -lpthread
>  PTHREAD_CFLAGS =
> +WATCHMAN_LIBS =
>  GCOV = gcov
>
>  export TCL_PATH TCLTK_PATH
> @@ -1416,6 +1417,13 @@ else
>         LIB_OBJS += thread-utils.o
>  endif
>
> +ifdef USE_WATCHMAN
> +       LIB_H += watchman-support.h
> +       LIB_OBJS += watchman-support.o
> +       WATCHMAN_LIBS = -lwatchman
> +       BASIC_CFLAGS += -DUSE_WATCHMAN
> +endif
> +
>  ifdef HAVE_PATHS_H
>         BASIC_CFLAGS += -DHAVE_PATHS_H
>  endif
> @@ -2025,6 +2033,9 @@ git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
>         $(VCSSVN_LIB)
>
> +git-index-helper$X: index-helper.o GIT-LDFLAGS $(GITLIBS)
> +       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) $(WATCHMAN_LIBS)
> +
>  $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
>         $(QUIET_LNCP)$(RM) $@ && \
>         ln $< $@ 2>/dev/null || \
> @@ -2164,6 +2175,7 @@ GIT-BUILD-OPTIONS: FORCE
>         @echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
>         @echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
>         @echo NO_MMAP=\''$(subst ','\'',$(subst ','\'',$(NO_MMAP)))'\' >>$@+
> +       @echo USE_WATCHMAN=\''$(subst ','\'',$(subst ','\'',$(USE_WATCHMAN)))'\' >>$@+
>  ifdef TEST_OUTPUT_DIRECTORY
>         @echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
>  endif
> diff --git a/cache.h b/cache.h
> index f10992d..452aea2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -696,6 +696,7 @@ extern char *git_replace_ref_base;
>
>  extern int fsync_object_files;
>  extern int core_preload_index;
> +extern int core_watchman_sync_timeout;
>  extern int core_apply_sparse_checkout;
>  extern int precomposed_unicode;
>  extern int protect_hfs;
> diff --git a/config.c b/config.c
> index 9ba40bc..e6dc141 100644
> --- a/config.c
> +++ b/config.c
> @@ -882,6 +882,11 @@ static int git_default_core_config(const char *var, const char *value)
>                 return 0;
>         }
>
> +       if (!strcmp(var, "core.watchmansynctimeout")) {
> +               core_watchman_sync_timeout = git_config_int(var, value);
> +               return 0;
> +       }
> +
>         if (!strcmp(var, "core.createobject")) {
>                 if (!strcmp(value, "rename"))
>                         object_creation_mode = OBJECT_CREATION_USES_RENAMES;
> diff --git a/configure.ac b/configure.ac
> index 0cd9f46..334d63b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1099,6 +1099,14 @@ AC_COMPILE_IFELSE([BSD_SYSCTL_SRC],
>         HAVE_BSD_SYSCTL=])
>  GIT_CONF_SUBST([HAVE_BSD_SYSCTL])
>
> +#
> +# Check for watchman client library
> +
> +AC_CHECK_LIB([watchman], [watchman_connect],
> +       [USE_WATCHMAN=YesPlease],
> +       [USE_WATCHMAN=])
> +GIT_CONF_SUBST([USE_WATCHMAN])
> +
>  ## Other checks.
>  # Define USE_PIC if you need the main git objects to be built with -fPIC
>  # in order to build and link perl/Git.so.  x86-64 seems to need this.
> diff --git a/environment.c b/environment.c
> index 6dec9d0..35e03c7 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -94,6 +94,9 @@ int core_preload_index = 1;
>   */
>  int ignore_untracked_cache_config;
>
> +int core_watchman_sync_timeout = 300;
> +
> +

Maybe remove one blank line above.

[...]

> +
> +       if (!connection) {
> +               warning("Watchman watch error: %s", wm_error.message);
> +               return -1;
> +       }
> +
> +       if (watchman_watch(connection, fs_path, &wm_error)) {
> +               warning("Watchman watch error: %s", wm_error.message);
> +               watchman_connection_close(connection);
> +               return -1;
> +       }
> +
> +

Here also.
