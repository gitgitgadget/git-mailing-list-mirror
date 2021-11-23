Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B0EC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbhKWQGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhKWQGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:06:36 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFE3C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:03:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o20so49742742eds.10
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Xjo5iF3X5cj1oQLoXR6+oBbGLk/nvh3cB8I5h9z4AjY=;
        b=UaAl4i8Bc/6CFgkqdbvJQUrAvJCxUxdyj3qOguWAtn0jWx8WXywZraDEEaqE4/y261
         5M2ieA1fTVHakumKBJ5C9sOX2i86kFGAov3nz/w9/0M46PzwxpCdPKGebpVaQcN+NzPP
         Az+hOaQq2U2jDR6bR1E6aJyCnO+geYAnWbwbase7JkOnmybTt2mfGZepWl6kMCVAbZe5
         B2o5PN5kdbffTywGrhJ4nFRBCw06pjT4WHJ/2HQ8jS087wED8tootJUIpoK1ZM+ONEjK
         2QUN0oGWN64ExEsAW8C5a1CxzlkUkFA4UlmZckpYBKtd/0RCh/VTC/PgMTgeUK0DM/R8
         laNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Xjo5iF3X5cj1oQLoXR6+oBbGLk/nvh3cB8I5h9z4AjY=;
        b=SH2WNqydO5hzmMzB5BASjCwkihlWRirWrOcdQFHENRODpfV/8MQ/NxJMGGY2dSjz/E
         aalEp8UQLFYlVcJ/OgIlM7HfZQzgWjZ7C6owETi7CusdNZ43yi61AvjEN9Toel7fvz9b
         6JfL6aB0PMPVHxkZ/HTk01MPlzBXvIMd5vGGMrAJTb0E+Vp6A1WKFAgj5Pp2ffKjJiIk
         etLDPDjlo1toc8H/2XcLrYijZxT2hqs1tgrZ1/6JLCAHgGTM6aFr3+3n0ImYMzfjrat/
         qmYrHmn0wLjq8gIc/ilNxu1vALKZ1Qxj05RBWpeJxkuGux4wpOexZwp9HWdEvjxdPVJz
         h/Aw==
X-Gm-Message-State: AOAM530ywsO2fSekC67oDkWzPwv0Sbx8ln7gbuutaoSQ8uIXOFgYFb7h
        wt2mS4MH5a0fYyKnVUUdqFp4uMRep3uJqA==
X-Google-Smtp-Source: ABdhPJxX07cD60/J6aiRT9wFeeJAnxyf6Dr/loCGCho7PXnf5sjUGHMVhMvVP3I1NrjCDr5lbnLDZA==
X-Received: by 2002:a17:907:d90:: with SMTP id go16mr8877555ejc.137.1637683406995;
        Tue, 23 Nov 2021 08:03:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c7sm5570094ejd.91.2021.11.23.08.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:03:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpYGT-001QMN-Hx;
        Tue, 23 Nov 2021 17:03:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Marcos Alano <marcoshalano@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "format-patch" command doesn't support SSH signing
Date:   Tue, 23 Nov 2021 17:02:07 +0100
References: <710dc612-0e3f-bf10-b123-f9443e605d00@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <710dc612-0e3f-bf10-b123-f9443e605d00@gmail.com>
Message-ID: <211123.86wnkyuaeq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Marcos Alano wrote:

> Hello,
>
> I was trying to generate a patch to send to a project (Linux
> specifically) but when I generate the patch using "format-patch" I saw 
> there was no "Signed-Off" line, but my commit is signed using SSH. My
> git version is the latest, 2.34.

The Signed-off-by in commit messages doesn't have anything to do with
SSH, GPG etc. signing, it's just a way of signaling that you're the
author of the change, and/or can certify it as being includable in the
project for authorship & copyright reasons. It's mostly used in
linux.git and git.git, see a "git grep Signed-off-by" in those for more
details.
