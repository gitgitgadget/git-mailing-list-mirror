Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266BCC433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 19:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJETpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJETo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 15:44:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538961AF1B
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 12:44:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a23so8459876pgi.10
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nx0w2/ytVQCkAvvw9bZ7iTXn09cv2g/Sj0kQkuLtNJ8=;
        b=BO5x82fMEBhYZkGr+WLygJBBINw4QwhJbj+pIaTtyvN45DouQ4wmqk+8chauLbfuYj
         Hrz1td4ElWTe2HafT53gRUaTcmUtpkmDhFMw0x02RA1AKlynzH34kUgZZAnWymR2o9U3
         9A23kEfdouTYqgqM2Cq+mlS33JdDy8vWrhj4BMUq10oGHwhIRcuiXXY0LeP+9IbSGZ6e
         SjBkdeVuS84ANszArRLmc6fWdQEJrNctmRIRmjyRYQcMl4MgynwjlHFpdc+iHG8u4mAW
         c2TOJ1mthlEft3xj1YreVH7NTHyTMxhhgM+SdiOqSyJhgEcQ9sCRf7fUKbrqbma37Oy0
         wKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx0w2/ytVQCkAvvw9bZ7iTXn09cv2g/Sj0kQkuLtNJ8=;
        b=hoPuYoc+cZT4OBs9szIDWEnWjSYOxu7gXHBjeS0S+iGXIaNda90DcjmfQzjVyFBGLV
         As9hPDSjAd4lzXeoCLJwdvT1wod/0tZjD18ddJsImA2PNBgYjjkHnQC3cqmJOtvPf7+8
         PGwERR5jy9geH8dUqctyQvS6cVxbLymccIOs0PXIaoD7F2KlkBaaNLTKOHZze5nD93du
         TFRo37ErVvyVQfZUNFAv/QwOKnVTH0B9mvA2SeEDnKvKNkTKHq7cnjWZRlRV+3wNqpEI
         EpnwaQMllJCEpkw/uP6C/8D6xoJaj4pC6zyAQoBT2ZLdMoCE+jUYP48ng+BhI9Zze/T5
         7sqw==
X-Gm-Message-State: ACrzQf0ZJTaH0YU3elF6LYAxc/ml8pi0oNlPqGko5uIkfz6jNObtfZg6
        RV3HZYyu9U3FcxdW0ew6xDQ=
X-Google-Smtp-Source: AMsMyM5ztTPZGGMmfcRYaRsMNOICdAohjN8Z4YMAu+l04EzXsyjx36eNX/3qJ6kKVQI9wGRW+BlwkA==
X-Received: by 2002:a62:1791:0:b0:562:2298:b33c with SMTP id 139-20020a621791000000b005622298b33cmr1002920pfx.25.1664999094764;
        Wed, 05 Oct 2022 12:44:54 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a3d0800b001fd76f7a0d1sm1495580pjc.54.2022.10.05.12.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:44:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: PATCH] bisect--helper: plug strvec leak in bisect_start()
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
        <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
Date:   Wed, 05 Oct 2022 12:44:54 -0700
In-Reply-To: <221005.8635c2u3k5.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 05 Oct 2022 09:29:13 +0200")
Message-ID: <xmqqy1tunjgp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But I don't get it in this case, why not just:
> 	
> 	diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> 	index 4e97817fba5..f9645a9d0df 100644
> 	--- a/builtin/bisect--helper.c
> 	+++ b/builtin/bisect--helper.c
> 	@@ -763,11 +763,9 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
> 	 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
> 	 		strbuf_trim(&start_head);
> 	 		if (!no_checkout) {
> 	-			struct strvec argv = STRVEC_INIT;
> 	+			const char *argv[] = { "checkout", start_head.buf, "--", NULL };
> 	 
> 	-			strvec_pushl(&argv, "checkout", start_head.buf,
> 	-				     "--", NULL);
> 	-			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> 	+			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
> 	 				res = error(_("checking out '%s' failed."
> 	 						 " Try 'git bisect start "
> 	 						 "<valid-branch>'."),
>
> The common pattern for run_command_v_opt() callers that don't need a
> dynamic list is exactly that.

I think you answered it yourself.  start_head.buf is not known at
compilation time, and there may be some superstition (it may not be
a mere superstition, but conservatism) about older compiler not
grokking it.
