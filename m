Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51ADC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 21:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhLNVb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 16:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhLNVb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 16:31:56 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172D2C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 13:31:56 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id s22-20020a056a00179600b004b31f2cdb19so3706978pfg.7
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/5V6mEv8I6Xjpf4DrMEVVK9zc0H71B81xpRwiGVkjC8=;
        b=b5nrzpOeAtZUtOYvNgYG+m8CQhfcxA8TogLi/z9ciAq0fmS6gglDM/LJiDOr0CBvbR
         WS0xtJNcmU0JED7vjwfoSHC+NK6QDlGfoKNLEyLHYgoGgqT3fzFVyE1wkGwLojy7mQEj
         /beLiZH5EkMZSSuPe4RemSxDzTdN69Be7XEFF5I6aSMQCNYHH/etvOjKkqd1rLGIWYiz
         kOxiytx5drzIpJEcsTepZWO6b3ZP9O0Qhm+UZ3eXWMKejX6dEfc6ftQHo4W6yjyNPYJx
         hbmBOdvp1GnAIj+LqdY1uY84pE4V/CeZv5r0NrQVt5Bv9Ub3STqzXOFX/E10t7i6dhKa
         C1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/5V6mEv8I6Xjpf4DrMEVVK9zc0H71B81xpRwiGVkjC8=;
        b=S9M1j6mQ2dJXCZYx5f/2kZCMhMZ+PvXGF4AgOoMUFNEZUlN8a3YRxVpI+t4/GmfBYE
         UpHfLRkWd+DjiK5eBowqEJpQAzBjPzNrIiECKayK4mNHDmJDuFCnHrGHcKsL7Xxt7P8F
         BKopWNtzwLKCt5BZNR8c+a7AgpM8JH5LqVqK6XN1L4wpE/ZN4Z6GKTT1pIhLOS2ZtVBa
         rnUNKsCBm04bNyPgANkuCKOWp3od2tqkXzDwAl7e+ZvItOaoI+YJrfO5Db9GOLKAjkO2
         XAddlOIOpVFvrVUxRySzvg+olutc9LHR1O7QqHAgiZ9CuLrwYw1gVmOpP1dzMEXCu1wc
         XEfQ==
X-Gm-Message-State: AOAM532lVGG+V2YrWbOxJC/A3xPvBvZa90UVd+qKK57yZWbXXdOwyOWS
        32H6oWdeFx7/9HF4XzvnbJUaEijBrqmRwZsXYfEhodO/+KbIsQjjNNlb+kojub8325wZUrVB3j4
        AL8PQGneGkx6Ci90JJTAE9PjQpmD3O7iS8YiEOOZRfqrEVspEbGTT0mNSiwdySMZj17Fmaequzl
        i6
X-Google-Smtp-Source: ABdhPJxqicRM4cCKJfv3pQ1lu9HvoC3RAFZRI6J0AjFjCiM+r4OCMJlHQzRzIT+zsn7MRQquLrgOTYSqNoB4mDMM8BT4
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:3d42:: with SMTP id
 o2mr22103pjf.1.1639517514902; Tue, 14 Dec 2021 13:31:54 -0800 (PST)
Date:   Tue, 14 Dec 2021 13:31:48 -0800
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <cover.1639509048.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v7 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, everyone, for your comments. I've followed Glen's code
suggestion and Junio's documentation suggestion, as you can see in the
range-diff.

Jonathan Tan (2):
  config: make git_config_include() static
  config: include file if remote URL matches a glob

 Documentation/config.txt |  27 ++++++++
 config.c                 | 132 ++++++++++++++++++++++++++++++++++++---
 config.h                 |  46 ++++----------
 t/t1300-config.sh        | 118 ++++++++++++++++++++++++++++++++++
 4 files changed, 282 insertions(+), 41 deletions(-)

Range-diff against v6:
1:  b2dcae03ed = 1:  b2dcae03ed config: make git_config_include() static
2:  de2be06818 ! 2:  7c70089074 config: include file if remote URL matches a glob
    @@ Documentation/config.txt: all branches that begin with `foo/`. This is useful if
     +Files included by this option (directly or indirectly) are not allowed
     +to contain remote URLs.
     ++
    -+This keyword is designed to be forwards compatible with a naming
    -+scheme that supports more variable-based include conditions, but
    -+currently Git only supports the exact keyword described above.
    ++Note that unlike other includeIf conditions, resolving this condition
    ++relies on information that is not yet known at the point of reading the
    ++condition. A typical use case is this option being present as a
    ++system-level or global-level config, and the remote URL being in a
    ++local-level config; hence the need to scan ahead when resolving this
    ++condition. In order to avoid the chicken-and-egg problem in which
    ++potentially-included files can affect whether such files are potentially
    ++included, Git breaks the cycle by prohibiting these files from affecting
    ++the resolution of these conditions (thus, prohibiting them from
    ++declaring remote URLs).
    +++
    ++As for the naming of this keyword, it is for forwards compatibiliy with
    ++a naming scheme that supports more variable-based include conditions,
    ++but currently Git only supports the exact keyword described above.
     +
      A few more notes on matching via `gitdir` and `gitdir/i`:
      
    @@ config.c: static int git_config_include(const char *var, const char *value, void
     +		if (inc->opts->unconditional_remote_url)
     +			inc->fn = forbid_remote_url;
      		ret = handle_path_include(value, inc);
    -+		if (inc->opts->unconditional_remote_url)
    -+			inc->fn = old_fn;
    ++		inc->fn = old_fn;
     +	}
      
      	return ret;
-- 
2.34.1.173.g76aa8bc2d0-goog

