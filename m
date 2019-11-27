Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23472C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED38920871
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Czcgw+Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK0SBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:01:07 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:56076 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0SBH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 13:01:07 -0500
Received: by mail-yw1-f73.google.com with SMTP id x206so15679317ywa.22
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MmBii/78dVQJv0TMD/qigA288Xx5/oRBYcssZkd7mbA=;
        b=Czcgw+Amyri5+s2WPJJKdqjjeHbZMyef+g5fGFI2UMrdmcLO8AiqF72viUhviNQkes
         6dLgQz/q/U1NheO5Y0SqBQH3SkXQAqujGYQbpgksUSEAuk3nxqsisK+XLwEknpm2fCjO
         PwV80fKtVchozS7kxKaRneuALZwXew6Qwjqk77ieVxd23a7EJohzGCsrymruSeKIBNru
         PLmXXDRvhY9naUH8/EyVWC4NdVcArAeUKgMOKjoCxsBV9kMsNHddA1lvN4Q8211yQREu
         r/cFOwIkwOzWJNrC1VaKFVZ1VZD71T/EddDfAmy+DYNlW6dMvcnoXW4xkgBM/sz+NWKG
         RAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MmBii/78dVQJv0TMD/qigA288Xx5/oRBYcssZkd7mbA=;
        b=nL8JCU9GCRnzWs/QhyGovhtydfyPUCK8FfxDO7MXM9ZsQaWWyo0VDL5qAbE7USjSXR
         2MLBR9YTrvhMQKcTMIaL6escZRERpPhPNHF2SMhYlPlBh2PZXe+0cJdNBiqRk5h/INa0
         WkU6zHs3nMzPM0wKDMXAU+p9Y39XROEgGUw0OvgzfxWrFQIQv85Iay/HfSgWa4Gr2kAy
         C8JAvZBncZam5A8f2gPMqpkw9otAyw7ynX7Gv1d7R2p+3fNChH0cE7/RuOPWff1B8ob7
         SrWGAui5wfa1fl0lq573/I2XYT8qiPEHhNxlR/2Snudwgq+AooQiXPf2tszhmsFUL6ZZ
         UX2A==
X-Gm-Message-State: APjAAAXyfy8dF/Jpf98BphVxQYwTuv19Ajb28or33o2dzHkEg8yCwK/N
        0eV8Rq/RhtHNDcfpk6mEYtPUx3dQiKM+liYTf6Up
X-Google-Smtp-Source: APXvYqyM5cHO/dafKGrb8lCi0lmf6VVl+1BEaT8pVfYZ3xH1q2qWNAFudIAHrxVEI2fjLI+uWe28swuMmSBM0dj14dW4
X-Received: by 2002:a81:4d89:: with SMTP id a131mr3743624ywb.159.1574877665644;
 Wed, 27 Nov 2019 10:01:05 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:01:02 -0800
In-Reply-To: <20191112103821.30265-14-szeder.dev@gmail.com>
Message-Id: <20191127180102.167352-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191112103821.30265-14-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: Re: [PATCH v2 13/13] name-rev: cleanup name_ref()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     szeder.dev@gmail.com
Cc:     gitster@pobox.com, stolee@gmail.com, l.s.r@web.de,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Earlier patches in this series moved a couple of conditions from the
> recursive name_rev() function into its caller name_ref(), for no other
> reason than to make eliminating the recursion a bit easier to follow.
> 
> Since the previous patch name_rev() is not recursive anymore, so let's
> move all those conditions back into name_rev().

I don't really see the need for this code movement, to be honest. There
is no big difference in doing the checks in one place or the other, and
if you ask me, it might even be better to do it in the caller of
name_rev(), and leave name_rev() to handle only the naming.
