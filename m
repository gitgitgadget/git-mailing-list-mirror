Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85592C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 22:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346688AbjD1WDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 18:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346676AbjD1WDv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 18:03:51 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C8640F9
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 15:03:46 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-51bb4164162so250229a12.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 15:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682719426; x=1685311426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+IYsXxp4XZ+m7MjNfb2TGaC07hYaXXgFEaWMd7nqnk=;
        b=Ldc42TcybKrK3BgndoGiVsGKGfVzlWZn3qn90Kb8PWG1zOjrGwd5j31Ybg1+o4GBo7
         cBVJ1hdTtQZF/hO1G+8X2RSmCWCrvMFbPd7aSvtJMgwmWds1lmlVIUQ3T5j8hRwPB+QC
         Dk4HUsTRjsPVNxOk9RqVWc7FgwYNjX4IbSoeXBozjfS4lTlyUHau3JBXQzaVyTdx27+A
         1bmmszwED+JzVF+VkwhZ9AjjlDV0dW8IvctiwHEn74UF2kOjKjXb5j701L4u2uce7Cyy
         ex6CN7OEvc+8UiCW3cv/dKbTVNv7/fjq+2XlxFACgKERahzaXQgkU/Nda2tZeSejXfA8
         GNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682719426; x=1685311426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+IYsXxp4XZ+m7MjNfb2TGaC07hYaXXgFEaWMd7nqnk=;
        b=XgqkrbuvNE94biv3Sew1k20gIinDZbhJUgW/74Mx8q0SqyfuQscqeOej9un5/G1UIF
         k0fzzUEtROXDjFbVIQtFRmnROl8sKcKd/30c5+lvZeXr8kD0cV+FsNipAcqlFWucYxyM
         YfQi9OccsvMlVN973qz5UrJlTG6HTTCDpZFK2INT/NEcEWdxEPOolnOgTden3jhL+NJi
         unk//d+TN7W1PAU1s3LIiNJBNKuak9gMsB10HkF3Kx1iXRQOv7pkiBXYkkEqebNcW4sZ
         9Ie/G2uzJ0XjrNnpdoNoeOOzXa7ppQEXzpmMh7EYwK4GCfmQDFHZ+tsCcbV1a/pdF7q8
         6rtg==
X-Gm-Message-State: AC+VfDxxtZMOaqr6wta7bHJ/3HGAEHLB3IfCZuwdQcrTesYqEVGOn35a
        4ZLOoXU9JIuFMk6MEPge7s6OakpFtItZHQ==
X-Google-Smtp-Source: ACHHUZ7+NsYLUTyAcFWzaMPRO2r8aj8r6QZle6H/vycyvKOV9W/TcWV75lDqkVj0aTlIAyQKGm2wo/R0lyYHnA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:69c2:0:b0:514:2206:4f71 with SMTP id
 e185-20020a6369c2000000b0051422064f71mr1719722pgc.6.1682719425837; Fri, 28
 Apr 2023 15:03:45 -0700 (PDT)
Date:   Fri, 28 Apr 2023 15:03:43 -0700
In-Reply-To: <xmqq8redhtn6.fsf@gitster.g>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1682593865.git.ps@pks.im>
 <0335e5eeb4ded336c5ff7c8888c8aab9dfed2505.1682593865.git.ps@pks.im> <xmqq8redhtn6.fsf@gitster.g>
Message-ID: <kl6l8reb3br4.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 7/8] fetch: introduce new `--output-format` option
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if
>
> 	static const char *const display_format[] = {
> 		[DISPLAY_FORMAT_UNKNOWN] = NULL,
> 		[DISPLAY_FORMAT_FULL] = "full",
> 		[DISPLAY_FORMAT_COMPACT] = "compact",
> 	};
>
> would be easier to maintain?

It's easier to read, so I'd think so.
