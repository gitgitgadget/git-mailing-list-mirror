Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E463AC61DA4
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 18:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBRSfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 13:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBRSfh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 13:35:37 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A046CDFF
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 10:35:36 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-53687ec9de9so9780227b3.5
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 10:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PMpVa9ePDpfikhLQvZc0d+eoRj4RiH8WsAFdLk4Ze4g=;
        b=NQO06eF0hCvrSb68s+8ZyAWecHJzyxBiL5uvXRhTf5zhDvjI6TT+KjK+8VeU9tf7KD
         9gRrbJJMTWPvsDW3n0LVDPZTH+MfIZELTQWs7azGL6pAhWmVcUpN611jUi6Hi4w2N0Uw
         i+OP6Z+Eo1I9hlQBAy0loZ+ZQWMOzF9/z0+B2dO67ITGjJut5GBCKtk1fu7YKWKIh/YT
         1MBDec9sIoK0TtgRee75RuwQvsOroDCkCGkNS83CYScwmLy7I/JXr+xktx2VRW9GZ2ML
         6EudiCEVRxotP6kmtWmRc1SdBAkT6Q9Inna/i3oAzTiscsrYN1I7aL5u0VpbEQRbcCz4
         ABzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMpVa9ePDpfikhLQvZc0d+eoRj4RiH8WsAFdLk4Ze4g=;
        b=PcDxZn//aQZaf9A+TLZ1OgUKa67lKs7NXQO9YsHk8n6SmFghPqOVfGiQwHlKcFjCXT
         srXzztdw3whWNHDmCagSP5YhCv86s3/8W6UZa8stzrePAN2xZPLoiPPjTy1b9ynJRJpp
         fgY8bq7TVDo7L0fEI2w4ILg/Z/Ht9l0jIrlvAjOrQkoGrPxyh9vNAAlN3B3RZkwdlpt0
         cDgyWJ6rKFJV6Cyv7i87BldN7rZ40GztUJxOAJCl2z6yw2k5Ihv/1Xf0mXqYGqMyN99L
         pXeETQBa69MrF5lgWeLtw24p7wjnesLtS1ydJhFwBw4hLBXpqxSk/KYks0NuNJaA8u57
         lGkA==
X-Gm-Message-State: AO0yUKWxAqO+bbqso7GwqWD5l4AS4S3qavLUlcM5ldz9pho4/rOT5grg
        T9XhKeeY7fLWHLyuAtdLLNqRlG0lhOYRKk1s944=
X-Google-Smtp-Source: AK7set/w2l/0JcxG18vzMrvHhFAlgoRJMzxRNtvQ1ZBCxwK92IWF/rKlD881B6WyLyT8YViM8v/CowgZ9+/Ix7RXD78=
X-Received: by 2002:a81:4a02:0:b0:52e:e6ed:3097 with SMTP id
 x2-20020a814a02000000b0052ee6ed3097mr439090ywa.535.1676745335482; Sat, 18 Feb
 2023 10:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20230215104246.8919-1-mcsm224@gmail.com> <20230215231428.68040-1-mcsm224@gmail.com>
In-Reply-To: <20230215231428.68040-1-mcsm224@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 18 Feb 2023 19:35:24 +0100
Message-ID: <CAP8UFD2=6CarUN1v-vavEJza0PyzZLt3xjVS0BubYUD9=fy46w@mail.gmail.com>
Subject: Re: [PATCH 1/1] trace.c, git.c: remove unnecessary parameter to trace_repo_setup
To:     Idriss Fekir <mcsm224@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, cheskaqiqi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 12:36 AM Idriss Fekir <mcsm224@gmail.com> wrote:
>
> From: idriss fekir <mcsm224@gmail.com>

I think the subject could be improved a bit more, and it looks like
it's the second version of the patch, so something like the following
might have been better:

[PATCH v2 1/1] trace: remove unnecessary parameter to trace_repo_setup()

(Please use "v3" if you resend it with some changes.)

> trace_repo_setup of trace.c is called with the argument 'prefix' from
> only one location, run_builtin of git.c, which sets 'prefix' to
> the return value of setup_git_directory or setup_git_directory_gently
> (a wrapper of the former).

It might be a bit easier to read when functions names have "()" after
them like "trace_repo_setup()" instead of "trace_repo_setup".

Otherwise your patch looks good to me. Thanks!
