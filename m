Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E1C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B3561351
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhFIEsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhFIEsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:48:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99078C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 21:46:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z3-20020a17090a4683b029015f6c19f126so705219pjf.1
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 21:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U/InoDrpI5L2bJV3uObz0d0Ixec7aqvjOFRwLHc1+W4=;
        b=qhoyQJv47MbsbLkvY3cPVQ70O6jYd26joi+uigY+z9gBWnu2N4zxyv/Iu0ks/UweI+
         xbUWhJAq8l2b4IEiZgUcnvs17fv2cjoVcz4rNiMpbB43i9iuvHJAkfqilrRPCoeDmFZC
         LkNTSehtHI4tOH+O1SAn2OoGXZrNZf6oTFl/TKzZC0yVuAXbbHdwjZVniU9+RjVJg3K3
         M/9+5hKdr51nTGzD17leoLJgOSFosM8pipfnH3lYjTh1q/347rru8pV0c0+9tj4xmIZA
         BDyLS4+tW1lGD8MIYyM4K70l794UjPqQXK+V6AwC/b7QIcYiVrKnykpcb98bY80y2Er7
         KfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U/InoDrpI5L2bJV3uObz0d0Ixec7aqvjOFRwLHc1+W4=;
        b=RUThNbfK+pXX8td9+0zLMaRCMeYNExSCuoO5ZYyjQKnPysMZ9jKU3b+RMwErZF3wju
         WjytQ0M+jbOZNqGdLeTK+SrpwB+x3NNHILk2N5cQkl6efdnGYgdsfX7RjDkwR3GTkMFO
         rxxuFmgM4LJlB/jfmP2YVCyy7kktg/njNeb86HawTJ/P5L2vnnqDFR8jiG4+ALbDniN8
         n3/kYU2qvSMVc7feneExQZ8HXkl7UphtXPOJLonHJbdUmxd2LPqtAh9BJMXEjKJiTuvD
         MIceFe1UIhcYqRSd13xlWuD4lEea0qFDxxyWtikQwDmPXHj5IxsSXeks6lROvx7j0Z5t
         LPVA==
X-Gm-Message-State: AOAM532CjcZxqKRLNkWMrz79XQksyV0K180HQh9iy3Vl4k8HZDmy9boI
        ItZ/mIQvSqqVx49de+ytUCzh4m8kPDdaAsdpTWG6
X-Google-Smtp-Source: ABdhPJyO4jE6JE/fFMpnNcdlZd4iQ6XcdWRIFYC+/2ax9FcaKrai4Sqta92vyT9lFhrwNtCNBk4dP8HJA0DguKYVi6dy
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:5444:0:b029:2e9:c69d:dc64 with
 SMTP id i65-20020a6254440000b02902e9c69ddc64mr3459347pfb.32.1623213967985;
 Tue, 08 Jun 2021 21:46:07 -0700 (PDT)
Date:   Tue,  8 Jun 2021 21:46:06 -0700
In-Reply-To: <CABPp-BGG7tKq6D-4mo+Lakrihrz=35EVT2SMLUWx0z1BZdxd-w@mail.gmail.com>
Message-Id: <20210609044606.2327088-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGG7tKq6D-4mo+Lakrihrz=35EVT2SMLUWx0z1BZdxd-w@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 4/4] promisor-remote: teach lazy-fetch in any repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Jun 7, 2021 at 5:26 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > This is one step towards supporting partial clone submodules.
> >
> > Even after this patch, we will still lack partial clone submodules
> > support, primarily because a lot of Git code that accesses submodule
> > objects does so by adding their object stores as alternates, meaning
> > that any lazy fetches that would occur in the submodule would be done
> > based on the config of the superproject, not of the submodule. This also
> > prevents testing of the functionality in this patch by user-facing
> > commands. So for now, test this mechanism using a test helper.
> 
> I wonder if this commit message is a good place to call out that we
> also want to eventually audit codepaths using the old
> has_promisor_remote() wrapper function (particularly the ones
> protected by a repo == the_repository check) as well.

Sounds good. I think we will need to check uses of all wrappers.
