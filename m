Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A25C433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 00:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJHAfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 20:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHAfH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 20:35:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE3A2F391
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 17:35:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so3423700wmb.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 17:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WZ0pnRprRHUfhU1B0R2tdozbhNW7bNv4wF9a1dIN4I=;
        b=giBN13iEfYU+WqWDqo2DFoXO3ewa4KNfR9V59wQW8fy3fl/CDeQjkqwb5gWHuIrURt
         oHitxOqsLRnP+XrCfp0FZ1yUzvKGo7i+NCoaXX+PQx15v017z8HsMSBZuYGqsB55N0df
         0NHHGOLjjial3klHvF0t3YwCDfo8Ed5DB1+JFgzPV+BZ4g0RbrB+KIP6nT3NsKGUhaUK
         jV/oSw94cK6EhZ+hPsRnfwPkQJquw4imU2fHa6cgxSJ5hmHeJUWxwNs+oMPNYyUFWuWy
         gYqUshIodqT5fa/dw5mY3KkHPX4OeEcIdSGap5QZuuH7bsoVoICCgzThddf2HXzUnNF7
         VciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WZ0pnRprRHUfhU1B0R2tdozbhNW7bNv4wF9a1dIN4I=;
        b=3oSojtt6S4RAuaFkgKj6Tf39ZYlvcF43tPZJIGdQpTj4jCL5WYY8WZs4zLEytqALSF
         k3rYm16Fl/4gufh1RLLDeRLll4Ut3AJZhQjFhNAy+sL3Ven96ROhbNXJawdvQZG1gfqM
         tmHbnkuXYZ06PP/VsnK7Btg/YEqqiNxos+uCfomnbtpgw3kZYdRaRLtvvvQJWzt+mmpV
         boBmRV6NS7+3P0o0BbfuZ75N5xuwyWq8rqCL95aLN1AzoF40X2HD/9+IHdR/DOF0hzw0
         5s+BSCb8cRrVea5IF8NMw1g0L0VBfzcy9OVil6XtIudiIIisdWwzyGvWXzCPG2nt3vPe
         EdZg==
X-Gm-Message-State: ACrzQf34B90eTBvMB6eOf6RrtZnEjI0Voz3uadorI1U4cbCeTuKBgZpT
        Fal1lVjAZy8679aEcRbFBIE=
X-Google-Smtp-Source: AMsMyM6idDvQ2aH6uIcIwvMe9suGFAOrIyt2ljzK8FprSk6LHA42ylkOD0N9pNvywLgcRgHZ0bWpBg==
X-Received: by 2002:a05:600c:2b88:b0:3b4:8680:165b with SMTP id j8-20020a05600c2b8800b003b48680165bmr12638437wmc.113.1665189304526;
        Fri, 07 Oct 2022 17:35:04 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003c3c2df83ddsm2000625wmo.26.2022.10.07.17.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 17:35:04 -0700 (PDT)
Subject: Re: [PATCH v2] wt-status: using of wt_status_state_free_buffers
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
Message-ID: <b6be0af4-8b47-d89d-13fe-a307c0e96797@gmail.com>
Date:   Sat, 8 Oct 2022 02:35:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2708ce62d2 (branch: sort detached HEAD based on a flag, 2021-01-07) a
call to wt_status_state_free_buffers, responsible of freeing the
resources that could be allocated in the local struct wt_status_state
state, was eliminated.

That introduced a leak that occurs with "branch list" in a detached HEAD
state.  The number of leaks depends on the references to "refname" in
--sort and --format.  With defaults, 3 are leaked: default sort is by
"refname" and default format needs two references of "refname":
%(refname:lstrip=2) and %(refname:rstrip-2).

This doesn't leak:
    $ git branch --sort objectname --format '%(objectname)'

This leak once:
    $ git branch --sort refname --format '%(refname)'

This leak twice:
    $ git branch --sort refname --format '%(refname:lstrip=2)'

Note that each different "atom" is only resolved once (see ref-filter.c).

The call to wt_status_state_free_buffers was introduced in 962dd7ebc3
(wt-status: introduce wt_status_state_free_buffers(), 2020-09-27).
Bring back that call in get_head_description.

Ævar Arnfjörð pointed out [1] that a similar leak is present in
builtin/checkout.c:die_if_some_operation_in_progress(void), since
c45f0f525de (switch: reject if some operation is in progress,
2019-03-29).  The leak occurs once with "switch" while bisecting.

Lets call to wc_status_state_free_buffers() there too.

[1] 220926.86bkr24kjw.gmgdl@evledraar.gmail.com

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

Changes since v1:
	- Add details about the leak
	- Fix the leak in builtin/checkout.c


Range-diff:
1:  86b7803955 ! 1:  3fa1ddbb30 ref-filter.c: fix a leak in get_head_description
    @@ Commit message
         resources that could be allocated in the local struct wt_status_state
         state, was eliminated.
     
    +    That introduced a leak that occurs with "branch list" in a detached HEAD
    +    state.  The number of leaks depends on the references to "refname" in
    +    --sort and --format.  With defaults, 3 are leaked: default sort is by
    +    "refname" and default format needs two references of "refname",
    +    %(refname:lstrip=2) and %(refname:rstrip-2).
    +
    +    This doesn't leak:
    +        $ git branch --sort objectname --format '%(objectname)'
    +
    +    This leak once:
    +        $ git branch --sort refname --format '%(refname)'
    +
    +    This leak twice:
    +        $ git branch --sort refname --format '%(refname:lstrip=2)'
    +
    +    Note that each different "atom" is only resolved once (see ref-filter.c).
    +
         The call to wt_status_state_free_buffers was introduced in 962dd7ebc3
    -    (wt-status: introduce wt_status_state_free_buffers(), 2020-09-27).  This
    -    commit brings back that call in get_head_description.
    +    (wt-status: introduce wt_status_state_free_buffers(), 2020-09-27).
    +    Bring back that call in get_head_description.
    +
    +    Ævar Arnfjörð pointed out [1] that a similar leak is present in
    +    builtin/checkout.c:die_if_some_operation_in_progress(void), since
    +    c45f0f525de (switch: reject if some operation is in progress,
    +    2019-03-29).  The leak ocurrs once with checkout while bisecting.
    +
    +    Lets call to wc_status_state_free_buffers() there too.
    +
    +    [1] 220926.86bkr24kjw.gmgdl@evledraar.gmail.com
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
    + ## builtin/checkout.c ##
    +@@ builtin/checkout.c: static void die_if_some_operation_in_progress(void)
    + 		      "or \"git worktree add\"."));
    + 	if (state.bisect_in_progress)
    + 		warning(_("you are switching branch while bisecting"));
    ++
    ++	wt_status_state_free_buffers(&state);
    + }
    + 
    + static int checkout_branch(struct checkout_opts *opts,
    +
      ## ref-filter.c ##
     @@ ref-filter.c: char *get_head_description(void)
      	} else

 builtin/checkout.c | 2 ++
 ref-filter.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a132392fb..659dd5c430 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1470,6 +1470,8 @@ static void die_if_some_operation_in_progress(void)
 		      "or \"git worktree add\"."));
 	if (state.bisect_in_progress)
 		warning(_("you are switching branch while bisecting"));
+
+	wt_status_state_free_buffers(&state);
 }
 
 static int checkout_branch(struct checkout_opts *opts,
diff --git a/ref-filter.c b/ref-filter.c
index fd1cb14b0f..914908fac5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1722,6 +1722,8 @@ char *get_head_description(void)
 	} else
 		strbuf_addstr(&desc, _("(no branch)"));
 
+	wt_status_state_free_buffers(&state);
+
 	return strbuf_detach(&desc, NULL);
 }
 
-- 
2.32.0
