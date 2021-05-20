Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEB7C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79606124C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhETAlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 20:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhETAlj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 20:41:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8C6C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:40:18 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id d21so14799721oic.11
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wBfCmdVrAQ6KlbhGX/ueuudfvUFE0P6uzGQ75q5deak=;
        b=FLloqLvVMNhfRPWtN1Kr5Jc7X8n8O3qT0dGldU8A5oiFIr3veKpvQ5N+BsTQdnjkeu
         ox7LevsMKmi5mpm8uq4XIDGY+PokqXYlvouz/o0XAxxcispLEp3ELUi5bGEh1mL9kx4y
         8mbEwjsKLilusONMD75Xiy1E/jTuNGAVRBECSYqntvkXysYPEUieIy/ho0gqlLL8rA6f
         Cj/ns9jLVfMo258J3xAldWP/EwfZZ0n3k1OLp956iEklGpFGEnr7b7zDBz3cEJRRpIXj
         h+7uvRraBPIt+FFZMExbiiDX/y6wNXYBhUFwYn+2jARmi/s+e3+29sLRhq4+G37KytEH
         7Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wBfCmdVrAQ6KlbhGX/ueuudfvUFE0P6uzGQ75q5deak=;
        b=YlxLPcGhfXoaYmokofKnuVkAyE9XChSHDsfBYoPALJzxq5WT86w2I3tzn6Xj/Jz2by
         VlIB9iWKWtFN3fmFaMLNEoaYrUuK2WUJ3Ur5rQRTpku3cZp94qaKvFhV4NElgU9x8D2B
         V0F70sBhC7EwQkYI2s1tu2AQRU4Nc008FqC8b4xh1NZaAZpesp6XwJPz9uBAL795/ioj
         PVfYYlD9H70rdSSuthM5SD9rOmc+mfMuEmP1gc2VH1BNDEj/uderGNinTAv0MnpnMJq4
         v96SAyidQBVWQlf9ywXAr5hC+Z1L0ZcDAYv/OiaM7yfB948lB0AB/qjaYfvO65vlCOQj
         HDKw==
X-Gm-Message-State: AOAM53187I+UJT+hPHWJXSO2sGNzuPTamX70ywwhnPC4KUUamDPIC3Ur
        vALHURp7fVgTkq1JZQgfKrE=
X-Google-Smtp-Source: ABdhPJziY00nORunsDJFNED7AEMA4Lxo5WMMwevY9r5X+fgrlZrPAZKIxWYPvUJQPpZT31I5Jw8QEg==
X-Received: by 2002:aca:d616:: with SMTP id n22mr1434472oig.76.1621471217188;
        Wed, 19 May 2021 17:40:17 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id t14sm231638ooh.39.2021.05.19.17.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 17:40:16 -0700 (PDT)
Date:   Wed, 19 May 2021 19:40:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
In-Reply-To: <YKWggLGDhTOY+lcy@google.com>
References: <YKWggLGDhTOY+lcy@google.com>
Subject: RE: RFC: error codes on exit
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> The API could look something like
> 
> 	--- a/cache.h
> 	+++ b/cache.h
> 	@@ -590,6 +590,15 @@ int is_git_directory(const char *path);
> 	  */
> 	 int is_nonbare_repository_dir(struct strbuf *path);
> 
> 	+enum git_error_code {
> 	+	/*
> 	+	 * Not an error (= HTTP 200)
> 	+	 */
> 	+	OK = 0,

It's good to not include many initial codes, but I would start with at
least three:

  OK = 0,
  UNKNOWN = 1,
  NORMAL = 2,

die() could be mapped to UNKNOWN.

> 	+};
> 	+NORETURN void fatal(enum git_error_code code, const char *err, ...)
> 	+	__attribute__((format (printf, 2, 3)));
> 	+

fatal() for me sounds 1) very dramatic, 2), not a verb, 3) and not a
complete thing (fatal what?)

I would prefer "fail", or "fault", or anything that is a verb.

> Thoughts?  Good idea?  Bad idea?

Great idea.

-- 
Felipe Contreras
