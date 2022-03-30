Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EC3C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351646AbiC3Wfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiC3Wfm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:35:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353BC2F02C
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:33:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h4so18350985edr.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JPATzPOznZcsdICKMLKJlyuZ17bs5oihI6yUaDJ0ZXA=;
        b=YS9GiEHbq9oPKLMy1dUYw/FaGNnozIDvh8ydpoq3BBfqDF6ObOKlnyr/clk3ku7IqJ
         +dOUPyG6IpdjiJPz2kcmWMbFoHJ6ZwaayPbaFznZG6EIxcR8W4zj7L0cfKhmYdKhpbLj
         iH91PBQwSn/+4d1qptZYs+b22JT3uKUuDIiYXnnKQKWcG7sFWApcpCuEHKV03ZVUwO2j
         zpE2rhX6LiCWLall0Lqamod/AnsFWTwmy8OgGFCPrhRoEDy6hTfLjIcHB+Ercc8ijH2/
         RDzNOVuGTaR76FUaY1PD6Ym2uJp1ZCAsuq40aa0gJFis9Lwi5K86jF7ihUkM5M2QJ5OW
         Un0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JPATzPOznZcsdICKMLKJlyuZ17bs5oihI6yUaDJ0ZXA=;
        b=0Nc403rO4e9Ujd9YJQEt4KUDaGBIUPIhDKHTJjDjVzK4LySzpq7dXjIm7TKvn6NJ+o
         lhSvLDNl8eYGeiaE57QPAafiKe1J8CLlDzrhK4PfzXpIL4vGxCJF2CjvjKyMlbN1Wv1I
         wxysXq3pdZA4SicsrrvI5JHb1l7qfnh/cSMRHi1D1XV5HMbWgtfX9nOezIfMLB8z/o5E
         WM+FclbfEiZC+1TgG8DKiiAVsGun7+OfxMzYLfsLxpe65TkePWBcs3JSkuNpiAgp9zzn
         NwZoljHFAM3NU/40IAYTifIv46hGxxl9/83BxP72nRge5pnaUAaxjZu+KN5ve+zmZK34
         E2sA==
X-Gm-Message-State: AOAM532BTsjqFxwsP1vcUbMe0TB4QIw/fN4uynx0fAPiXdiwyOOjqWOW
        sSGIdgFAYu6u8ED2LtzLolDaChk6Xr4=
X-Google-Smtp-Source: ABdhPJzZq8E5EyI+xksTrd9Ev++tVkUq8AJwukJ46uzQV5WgdqdEQmSHEEl4IuyMwgrx7M0+3izSOA==
X-Received: by 2002:aa7:cb93:0:b0:415:d57a:4603 with SMTP id r19-20020aa7cb93000000b00415d57a4603mr13381896edt.62.1648679634623;
        Wed, 30 Mar 2022 15:33:54 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b8-20020a056402350800b00419407f0dd9sm10333775edd.0.2022.03.30.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 15:33:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZgsz-0003pE-Gx;
        Thu, 31 Mar 2022 00:33:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 3/4] branch --set-upstream-to: be consistent when advising
Date:   Thu, 31 Mar 2022 00:28:17 +0200
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
 <8e6ea3478b376b24835f3a3fef7fca39bed0afec.1648584079.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8e6ea3478b376b24835f3a3fef7fca39bed0afec.1648584079.git.gitgitgadget@gmail.com>
Message-ID: <220331.867d8bt6i6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 29 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> "git branch --set-upstream-to" behaves differently when advice is
> enabled/disabled:
>
> |                 | error prefix | exit code |
> |-----------------+--------------+-----------|
> | advice enabled  | error:       |         1 |
> | advice disabled | fatal:       |       128 |
>
> Make both cases consistent by using die_message() when advice is
> enabled (this was first proposed in [1]).
>
> [1] https://lore.kernel.org/git/211210.86ee6ldwlc.gmgdl@evledraar.gmail.com

Thanks for following up on this :)

> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  branch.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 133e6047bc6..4a8796489c7 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -389,9 +389,10 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
>  	if (get_oid_mb(start_name, &oid)) {
>  		if (explicit_tracking) {
>  			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
> -				error(_(upstream_missing), start_name);
> +				int code = die_message(_(upstream_missing),
> +						       start_name);
>  				advise(_(upstream_advice));
> -				exit(1);
> +				exit(code);
>  			}
>  			die(_(upstream_missing), start_name);
>  		}

This is really close to being much better, i.e. we can now just do this
(this is on top of your branch):
	
	diff --git a/branch.c b/branch.c
	index eb231b950bb..5b648cb27ed 100644
	--- a/branch.c
	+++ b/branch.c
	@@ -342,8 +342,6 @@ static int validate_remote_tracking_branch(char *ref)
	 
	 static const char upstream_not_branch[] =
	 N_("cannot set up tracking information; starting point '%s' is not a branch");
	-static const char upstream_missing[] =
	-N_("the requested upstream branch '%s' does not exist");
	 static const char upstream_advice[] =
	 N_("\n"
	 "If you are planning on basing your work on an upstream\n"
	@@ -388,13 +386,11 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
	 	real_ref = NULL;
	 	if (get_oid_mb(start_name, &oid)) {
	 		if (explicit_tracking) {
	-			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
	-				int code = die_message(_(upstream_missing),
	-						       start_name);
	-				advise(_(upstream_advice));
	-				exit(code);
	-			}
	-			die(_(upstream_missing), start_name);
	+			int code = die_message(_("the requested upstream branch '%s' does not exist"),
	+					       start_name);
	+			advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
	+					  _(upstream_advice));
	+			exit(code);
	 		}
	 		die(_("not a valid object name: '%s'"), start_name);
	 	}
	
I.e. the only reason we needed to mention upstream_missing multiple
times is because we didn't have something like die_message() before, now
we can just skip that other "die" entirely.

The advise_if_enabled() might be worthwhile to change while at it, maybe
not.

But also useful, is that we can now simply inline the "upstream_missing"
string, which will give us type checks for the printf format. The reason
we had a variable before was also because of the lack of die_message()>

I notice that we can do likewise with the advice itself, and with
"upstream_not_branch" if we either make that a "goto", or add a trivial
helper function.
