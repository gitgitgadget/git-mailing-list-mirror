Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2669C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 02:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826D76113D
	for <git@archiver.kernel.org>; Fri,  7 May 2021 02:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhEGCSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 22:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhEGCSb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 22:18:31 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05755C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 19:17:32 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso6718864otv.6
        for <git@vger.kernel.org>; Thu, 06 May 2021 19:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=R+GVd1LXpznJ4cuStMamn6w9kcCYkpSq83GdnoHGkio=;
        b=ps8I3edzbHlmiKWoaoMcdR6uSgKGBDyJYnf3CFts+n2RDtrgW3WYjVqksQ/RuPosy8
         AWKUoOV7Uz55/kZeCcU2wQzZT3rsLBKoA1LY1wC33n8APOw6Nhsgpt703PxpEPo7xyVk
         M0ldrfPiB8vOa5v9rFWZORqUyvlc2Sd+qWAlm+znImpi0ubPQknT4qp/SNokicxVin4M
         TOWhTjJrXAxJnTJPwEA3CmOmkzslQ7jH0h0DyLU6vMZO3Y1NWi1va8vmZnT1Q962rMNn
         4YtOnOjEUEHbdz3qdTaLmIpVwTzktcBYuQruCtOR48XUYroaPbhc7bxf9Y7Euh9j0ewU
         fudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=R+GVd1LXpznJ4cuStMamn6w9kcCYkpSq83GdnoHGkio=;
        b=rzvLVivsOhMriOB8yq6arHnLzaeQZ2Mc6o+vDxgKCn1WMXwJyzJLGqIenB4kOuIkD8
         owGsKXEJIo5Q1qMzA02kgY/8ySk1eXCATP7AB7CdedcOLjrhEsJO2hqOhLTir1ekNt79
         wnc/rMYzMbwziaKTz94Os2GI5gJtSCFfmPN9dHmkd/uouHYxeOVg3Fqh8zNM3xFZL9sJ
         GZfV+QUhe9xZr+qv5CiRHiccN2g3mqKMcDK8YmTAupdyXtpJGZUEvIl8JJkAI5cS5scb
         Lluwuw5k07JySojBPT16QdOHz2uUGPS9HiG0dLjcZq9XDwTwWjRwjHOpffmsj57HrSQ8
         Yyzw==
X-Gm-Message-State: AOAM532rMMGzrs1utBq4ws0vKQQX0oLmlUiOGjz0/EakGb5qOSPJRow8
        q1GMAlP+EeuzSD7c1iEmbVk=
X-Google-Smtp-Source: ABdhPJzCpX9tHlnEGeR7sNfs2BbVPNchsD8Lara7FLLRhgwmB4QYRauJ/+Ba6XIroSkgHykmrPHJIw==
X-Received: by 2002:a05:6830:711:: with SMTP id y17mr6280553ots.293.1620353850619;
        Thu, 06 May 2021 19:17:30 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x2sm864740ooe.13.2021.05.06.19.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 19:17:30 -0700 (PDT)
Date:   Thu, 06 May 2021 21:17:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <6094a335c22dc_8ee520860@natae.notmuch>
In-Reply-To: <xmqqfsyzwh7i.fsf@gitster.g>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
 <xmqqfsyzwh7i.fsf@gitster.g>
Subject: Re: [PATCH v1 00/43] completion: git-completion 1.3.1 patches
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > These patches represent what comprises git-completion 1.3.1, a friendly
> > fork I'm maintaining.
> >
> > Some of these have already been sent, and should be in "seen", but for
> > some reason they are not [1]. Others have been sent, but probably won't
> > receive any review soon.
> 
> This is not forgotten, I know they apply cleanly on top of the
> thirteenth batch of this cycle in 'master', but there are a few
> completion changes in flight between that base and 'seen' so after
> the dust settles, these patches may have to be rebased on top.

I just tested the patches from v2 of that series [1] against the latest
in seen 837d9f133b (Merge branch 'ab/perl-makefile-cleanup' into seen,
2021-05-07); they still apply cleanly.

Cheers.

[1] https://lore.kernel.org/git/20201223144845.143039-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
