Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A684C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 17:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbhLURzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 12:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbhLURzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 12:55:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158AEC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 09:55:09 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id k64so12422693pfd.11
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 09:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjahPoxGgWXcqzhYYPSxfVOLLEv6zyyEEve8Kt2udhI=;
        b=LKR8BkHcKQ7gV5Tdib7yrzVvDrqeWR9rypGgDLLgHYasgRUeYA/YqeYXdfnSOtG6cx
         PiJxDTcobe85YjPiy8kBxsS8P89B2tOt5ksETjpgr1RtN656nyY9LPzxWlwlVBwSPrij
         8NUHv/fMsnmX4pyrx85ATcj+C8eO+Ybf1LBke4rjJwfLo5HAoST4OftbqsILSgdhaIEL
         CP049wPDv5kw1IpFhwF+uP7w73RXvUGEdSF+jdkSUIonQ/2LNnNYYZioO6/sMIo2ROwW
         ARbe/rc6jQT2/kOrwGuphXcqQFUqyET/nQNZ62ZIn5s8Kun0aB0y2SCVFwAycOKNkCt9
         TQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjahPoxGgWXcqzhYYPSxfVOLLEv6zyyEEve8Kt2udhI=;
        b=7yhnPGsCzyCUk7ixe7juw/uUgumIK70SmXmvdyQ8uHwG80NUH6zAZPkRbvYd7KoLbv
         XN7oYSNNdzDvI+nc3fHuW6qTEm04lK6USI5gTZv4t1pgWr+z8hgKLg2yGST7ZORh0jVF
         1gzESKBc188bMK8wjdj7Vrp+WcGPs46EYbjGBPrS+xJrQuStr+HW1GkmW1OgPIBDflc0
         lwQbmkf7fTjAhkLsMx+QXjoy3XT0+dIuqlbGVEFMaRjUrz7vJWg4Oc6fJfLQYdO9rnCh
         WBXpzZU8jc3mJzpY3JlBytHq1RRicCgvDhxwME33yhKZfTMvH2NU6kJPIui8TXe+TmUu
         fJrQ==
X-Gm-Message-State: AOAM53105VQ1eqb6DU00Af0TOL8UDkjit5d/+6JVt4PvuN8OTafv344x
        b5STyw1RqavcY8Ct6H9GrKkgV2B3ab2kPXoSHqbigX71
X-Google-Smtp-Source: ABdhPJwwuZZL2V4v8zJCLKJKvtVpTzpKxk9r1RIHH3eSVYimGGoq68pU4Zf4uuYi2HL/k3uWNoEwU808OPi2die9SEI=
X-Received: by 2002:a63:e657:: with SMTP id p23mr3868398pgj.337.1640109308543;
 Tue, 21 Dec 2021 09:55:08 -0800 (PST)
MIME-Version: 1.0
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
 <xmqqlf0dq3t3.fsf@gitster.g> <CALRdAffjmvHao8TRfB9YJez1acwHDAq2ZqiqaCRRr5MaWzhxig@mail.gmail.com>
In-Reply-To: <CALRdAffjmvHao8TRfB9YJez1acwHDAq2ZqiqaCRRr5MaWzhxig@mail.gmail.com>
From:   Daniel Vicarel <shundra8820@gmail.com>
Date:   Tue, 21 Dec 2021 12:54:57 -0500
Message-ID: <CALRdAffUTf46aU-=_xniKm0NAWE3OTFMFPhXNn669jHcq9dPrg@mail.gmail.com>
Subject: Re: Why does "merge --continue" expect no arguments?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eesh, I guess Gmail does top-posting using the entire conversation
thus far... Apologies for the noise!
