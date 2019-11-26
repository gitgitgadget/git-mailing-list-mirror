Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C6C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 19:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4C92073F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 19:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uozp7iZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfKZTJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:09:58 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:42490 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfKZTJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 14:09:58 -0500
Received: by mail-il1-f176.google.com with SMTP id f6so14674312ilh.9
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AE0CQancsYOoLPo1CgXSIkKtNzuDV5sWvC1j69uWRus=;
        b=uozp7iZMtr3J3bn/pW4C3pnZFiWAmw/TU8b2WyNbmRvMFeRwZj3SqMQODwwgWYuyXx
         7eJFGHJans2M7iTkiT2g5TRHHhHQNkO6a9cdCWS5Dghes4WQGJ33ZzT7y+Kaphl806E/
         EhIZoMUPZFh79i/GxMzfZetQ+E2ll1TVuKrU7VLhw1SQBru64JLhD9ExWuhNoSk5jXZr
         UGEdp6MqcQJEfgGSR85oQ5uuMXzwGxv1N6nO8BjI6+725zayZ8ym4fcOBQHV09+xP789
         FOd3RzIeq5RsFnTqCmrXuUx14lmukYsZpAEjlY37abScfom14tdsBPODVPaeNwSr4jV2
         uqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AE0CQancsYOoLPo1CgXSIkKtNzuDV5sWvC1j69uWRus=;
        b=bcTjyMPj9eoQmMhO7RpfBbOwWNUPRkbRXq65/cNcl9Ojpkr+F7Ncioyft/tIqZ1hdD
         N8Ev2smZPwtdMeBeJWNQ8KelaXKYwwLMT54GceWhpUj6oaXOP4X2oRgzolb1p4MH+vIt
         /+6UKxUJ5gBHbT+ct6hKlOq/yoh7/dGfJTlCfJ9zsTsK2Z8w2lWVZX2c54cz7TAYQpal
         UGbh2tjQPh+JeTFzMb+6qJiQrj+C6KxMeF38ywc4U8Ez5JxOaDPivJiFnNJ4p/cQH9Ws
         r5437LkQiwL7y8wMqFjsd1AdBsVMVudAnmHhalpZz0HujoSUkgaaN2T1CxqOdxHX9jHj
         oO9w==
X-Gm-Message-State: APjAAAWttcVHzWoJo8RR6qOPUILunjjUd+oZQj3yVE87DkG5GoPHJiix
        wELpRlfMuDqaA98mdVWrZmA1BnlAAHDmAa2sgF31MTWSK4I=
X-Google-Smtp-Source: APXvYqz6TD6Jk7g/u9EGmuyBXNDtYAZrc9/5iY7WaYifaYQ79mZSMbf43p/jjkghRyqwHwbdxhOiy0chpvXeIJ8lkJY=
X-Received: by 2002:a92:320f:: with SMTP id z15mr21859526ile.252.1574795396079;
 Tue, 26 Nov 2019 11:09:56 -0800 (PST)
MIME-Version: 1.0
References: <2d7f373f-5cf5-a956-53d7-1e67ba157e9d@suse.cz> <94b6452d-9888-a129-78f9-38eb0f03eea3@suse.cz>
In-Reply-To: <94b6452d-9888-a129-78f9-38eb0f03eea3@suse.cz>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Nov 2019 02:09:50 +0700
Message-ID: <CAPUEsph-sP79ov0DoTj9vfhFeD_dt=FpPWgk78syX+qKeVBT3Q@mail.gmail.com>
Subject: Re: Failing tests on s390x and aarch64 architectures
To:     Marketa Calabkova <mcalabkova@suse.cz>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

is this failing only in factory? couldn't find any failing logs going
through the links in the original email but while I don't have
OpenSUSE with me right now, I hadn't been able to reproduce the
problem with an aarch64 chromebook and its emulated Linux runtime
(based on Debian 9)

my question about factory is because I'd seen reports of other
problems with it and pcre2 because the system library was compiled
with the experimental selinux aware allocator (--enable-jit-sealloc)
by mistake that might be also the source for this issue.

Carlo
