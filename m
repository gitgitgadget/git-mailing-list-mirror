Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A98C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 15:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiJSPP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiJSPOt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 11:14:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02261C840F
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 08:07:52 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 187so14674437iov.10
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 08:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtAgMSiVRN5K7c5va7Nxp6UxLr9xcLcruKL/LSp4sk0=;
        b=mK1aqs2w0wtT/KvQbSLzZD0ehovZ13M314NfaGWaKMqEhxXAxLDg6DuVwGu9lbq/A+
         cKzxyatVCt4OwO+CgwhFAvMUSeY8oBF02TZULqgZBy+ZuxDkhfpyy4OuNAA6vadvoE/4
         AF+0dQR/2t2HwZ6dEWPWg2utWFLaVSbresuGiJ+VCHi9RUnd2TcfuNbTdiciWS5t2I9h
         gOPKLlZmsgPqyG2Xofir1aOXJW1li7WXMg9dRyb41MzQ6njmsETleLj3R2ICm/uSzhMy
         rDwQtSBv6uDOp9YCfehQwNspUMYf0o3JDs5ucT/UdX4q7iPTaCICvg2fwSxcFsu3/nm8
         hsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtAgMSiVRN5K7c5va7Nxp6UxLr9xcLcruKL/LSp4sk0=;
        b=L+mArg0LjX+7ZW3r4R4BQ/6GC1/ELfpZdA9KCruqlgjU1AhGlqNI5d9jLhiecQjrgh
         U2hhX5IzbFvCrgb7xlMrdbnS20nlFdscyH8BnirnScdtwfBaj+ECrMP8jWD19NCKkrIv
         XOyIQPakMT5TufdwrdefbUOVxzqMgUvGkpKFS94YkbO5uzial0N7n1JKBZ0nT9ss9hiY
         bobFtxjIVVF7IyunBfs94Az1fIl7o7jfzARPGGR3ayQ/1Z5B7PbnT4e7eAAh1rfrCquA
         6hD4/7qsiTSW/GDMRGkYGEimdokxkXPAcDfcd4hm/yCAAiviLU3G2kIsDUBQNVNUxk8d
         PydQ==
X-Gm-Message-State: ACrzQf2zaxdnx0LQOenfLuK3bxqssR3vCzCPKunNu2rLQaruJrMys1im
        wMZNcDu0mG6PvjQIsg0nhcNpvjc5anlMMeeU
X-Google-Smtp-Source: AMsMyM6lKmWjT/I1L4c4JUfDrNzuhaAhfvRKC/8DoCaWuvUvelAH44T+hqoRT4MsQCviBXfNjEFR0Q==
X-Received: by 2002:a05:6638:d04:b0:363:ec0b:8d7d with SMTP id q4-20020a0566380d0400b00363ec0b8d7dmr6944301jaj.169.1666191973066;
        Wed, 19 Oct 2022 08:06:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c28-20020a02331c000000b00349be1ef390sm2225948jae.121.2022.10.19.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 08:06:12 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:06:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: 2.38.1 Build Version Confusion
Message-ID: <Y1ASY4aQfW4n8xA8@nand.local>
References: <01cd01d8e3c7$e93bff50$bbb3fdf0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01cd01d8e3c7$e93bff50$bbb3fdf0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2022 at 10:34:30AM -0400, rsbecker@nexbridge.com wrote:
> Hi Team,
>
> When I build 2.38.1, I'm ending up with GIT-VERSION-FILE as follows:
>
> $ cat GIT-VERSION-FILE
> GIT_VERSION = 2.38.GIT
>
> $ ./git version
> git version 2.38.GIT
>
> This seems a bit different from past patches. Is this intended?

If you're building on the current tip of 'master' (at the time of
writing: 9c32cfb49c (Sync with v2.38.1, 2022-10-17)), then yes.

In d5b41391a4 (Git 2.38.1, 2022-10-05), the contents of GIT-VERSION-GEN
contained "DEF_VER=v2.38.1", but it was reset in 9c32cfb49c to
"v2.38.GIT" to indicate that we are in a development cycle.

You can see where Junio resolved the merge conflict more clearly with:

    $ git show --remerge-diff 9c32cfb49c60fa8173b9666db02efe3b45a8522f

Thanks,
Taylor
