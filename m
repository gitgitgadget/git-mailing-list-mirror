Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE87C33CA3
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 12:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7581C2072A
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 12:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VByK2/Ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgAJMJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:09:33 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36044 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgAJMJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 07:09:33 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so1324953edp.3
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 04:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/lllftJ8RlvwFAH/8XnxqoI58judwS95VVpsvvZVOs=;
        b=VByK2/EwNUjEIp3CH7ORNABaK88G4J9rnO0yZbXDfJx+NsM2V1CYlw+hbrInPbdrkd
         B7PG6NQI1QPckM/hYMbnqhWLIzCbOWW+OPm31Ta9Cm/56M+fahCs+X0MdPJdVkDxm/IS
         l1gz/aTB9mdx7wAkPM0OrEBHnmC3t3wvIYhs9FKinuPiAxkGfbEeD+cmWdD20OxayxLY
         0XPkipHuCD6se4iVLJsZlW6SExkxhBR4rxTuOAK540TlVd++DYP1acsZ/hCxiSPVAvze
         09FHfvDrG83bFnl7CFZMsKEA4EfqRoVVQzvC6ThKLCZsKgE3pXrjXnMGh5Bj4h2vzNA/
         K//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/lllftJ8RlvwFAH/8XnxqoI58judwS95VVpsvvZVOs=;
        b=hmix9Bqqz2gGjdMiyS55V1jogZkNfGpRGUqC1WnhxTj9vtSkCDMYglhpg07wxajjvk
         DzkgiJTLRRimHlePQzyBa5Rfl4AbEmAA+bhf8pPIHbmN9cysK19O2KWpDWoY5adxPEmK
         9h0B/mcqlwfnUZV247czoWjj7BVr50YH8W6HbdiN03xuT8/tB5wDhReE/ZqLXM0/jZJ+
         F0htaoc97FR42URG89OnDxuvsFIH3pHS3/Jb0j40+OCJ+/xnbEkjyJ/NtgXHI98oBZh8
         daGdtn798Ak/eoyRagTfcJvG4X5vdH5PyE4+E8ZeOFj8G4fD28ThcA4nT1ec6blJL4JU
         tg9A==
X-Gm-Message-State: APjAAAWq7ROyUYrreNAN/OEuLAlbnIz7Jj05BPVcbe70b2qll9SS6xnZ
        tpOCxhwaB63ICsmf86R1xaRbXcbeuFPT/1jU1DiY8z0h
X-Google-Smtp-Source: APXvYqzeDDsesaOev1OmBqtVNF56QnOQT4pd+6K+bVU9iZKRPVlb0XwhkZa4iYJKGIDy4QUgWC4/AXwOg7wFvHDln64=
X-Received: by 2002:a17:906:9603:: with SMTP id s3mr2815026ejx.116.1578658171216;
 Fri, 10 Jan 2020 04:09:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
 <pull.507.v2.git.1578370226.gitgitgadget@gmail.com> <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
 <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
 <CACg5j26jyWnAtM+mZ-FuN7OQWHpKk5nADG+7J-=metJMdO6+2Q@mail.gmail.com> <CAPig+cTDayF0hHn7wSPGNS8h2qPUYhhg9Z8fY_rLQnWmAg-NKQ@mail.gmail.com>
In-Reply-To: <CAPig+cTDayF0hHn7wSPGNS8h2qPUYhhg9Z8fY_rLQnWmAg-NKQ@mail.gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sat, 11 Jan 2020 01:09:19 +1300
Message-ID: <CACg5j27Cj75W=95-4T8bv351xD8K5SiyA6-9JvS-n2NmR-0z+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different
 branch before deleting
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 8, 2020 at 10:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> My own feeling is that this level of hand-holding is unnecessary, at
> least until we a discover a good number of real-world cases in which
> people are baffled by how to deal with this situation. Adding the
> advice seems simple on the surface, but every new piece of advice
> means having to add yet another configuration variable, writing more
> code, more tests, and more documentation, and it needs to be
> maintained for the life of the project. So what seems simple at first
> glance, can end up being costly in terms of developer resources. For a
> bit of advice which doesn't seem to be needed by anyone (yet), all
> that effort seem unwarranted. Thus, my preference is to see the patch
> dropped.

That's Ok. We can drop it.

Thanks,
Heba
