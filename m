Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8944C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFF52084D
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ+3q5k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfK1MD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:03:27 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:36262 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:03:27 -0500
Received: by mail-oi1-f176.google.com with SMTP id c16so966466oic.3
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 04:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dpeBM90XIl+O2U/D5wnL1IFd49CcWm/cscLfcVDnMAI=;
        b=AJ+3q5k8YGJ9wkPuzBs9ix6sxTPuYA2pTsIemwPDc5M7XZArdRQEkeXs9v/DpqJLsJ
         JLBsPK8eCAMoerLoFpfs9QV+LM6PCKAGyfQlw2lhrqjDtndaWZU+t+9PFu3QMvzfJK3r
         z2qQ39W2DKqBDPocofzmRIXb+45dRZ5ZySRAk9G+cuK8DTqWXXuRl0k2tqmudOcHUIZC
         5DsopEeNMJA61CSNrt1SINVo8WhW7nLvFjvpz1U3O/BtSI1z4BZkqxRlSa6EkB7kTNyb
         +yanxTcAyM23/ieQa/XxmhiDI5zL5wEIj0iMqKgj2pavOOgvwxm+qtZkg5GB8r5o3E7B
         8nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dpeBM90XIl+O2U/D5wnL1IFd49CcWm/cscLfcVDnMAI=;
        b=IhyaAe7g8CCf+E3+/jvO3J7JMZVOrmbCNeOtpuE3B3Ji1eKmJKMlmkLsVjQPRuPSGy
         QG+eutEWtCLp16mjnllQCuA8vuU6ucfBsxvyLzEV4NEQebP6knLv/x5DdeYypCSN9LLC
         LMmYQbAuBwK474SduFmh7vqcaELAy+aFqANzUyVx/9GXN4ap8EbrWOIGm0N9ZVYjNe0x
         b4EOAONJCk7YiJcrbgdJEmjeppXDexhBsOgbdK7iZjmuR1IwJ7i74gCaZRMjO25PeCOf
         YSWpV00+4qnjAo5NArDHQxmNa6fz+3UWQzNLZce3me+N5cODldiTU+In2MwOWr+uAuDy
         tbWQ==
X-Gm-Message-State: APjAAAVDvSwDTG1/gyoRx6DdQUwU2SnIjamK1JWGKvTaSitU7HV8EDK7
        ruVS4IpSSW4McMOkGlatlJpIG7Y++9+I4gK5WgQyD3n7JqQ=
X-Google-Smtp-Source: APXvYqy9qZFvNUyBy8ZuGYSyZVAX8qbLIcNieV6S8fsCp2RJxuFEL/Bg3Mjh79PwlZ8CP76tlx830W6Os9LnZzBhOTk=
X-Received: by 2002:aca:d904:: with SMTP id q4mr8336049oig.21.1574942606304;
 Thu, 28 Nov 2019 04:03:26 -0800 (PST)
MIME-Version: 1.0
From:   Anupam Singh <anupamsingh610@gmail.com>
Date:   Thu, 28 Nov 2019 17:33:15 +0530
Message-ID: <CAJz+0yYpv55j0gmMDO3MfbJXzrfT5BJ7vKk9hzr_u3CLtM+WLw@mail.gmail.com>
Subject: Question about recurse-submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have been facing an issue when recursing over submodules during git clone.

TLDR : Create a project with multiple submodules with different access
rights for different users. When a user clones the main project she
should get only the submodules she is allowed to access.

Consider following example :

I want to make a repo named MainProject with submodules Sub1 and Sub2 as shown
MainProject (Accessible)
      |-> Sub1 (Accessible)
      |-> Sub2 (Inaccesible)
      |-> README.md

Where I have rights to MainProject and Sub1 but not Sub2. What I want
is when I clone MainProject with --recurse-submodules it recurse
through all the submodules and try to clone it. If it fails it should
move to next submodule, but what happens is that it fails and exits.

Also I know that I can pass the submodules' pathspec that I want to
recurse after the commit clone: teach --recurse-submodules to
optionally take a pathspec to https://github.com/git/git.git. But I
dont want to specify this because there may be multiple submodules and
clone command can get lengthy. Also the user will have to know what
folder she has rights to.

I am kind of stuck and need assisstance. Is there another way to achieve this?
Any assistance would be appreciated.

PS : I'm a fan of GIT :)

Regards,
Anupam
