Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ECDC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E54D2082E
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it2/82Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLRRPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:15:47 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46173 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRRPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 12:15:47 -0500
Received: by mail-ot1-f48.google.com with SMTP id c22so3305041otj.13
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJUs2IVeeGudMULatIBraKfeG3YaqsRz1yJcxvQKUBU=;
        b=it2/82Xb+EwAN0/xFQ5suMimQkgDb6Z/JxZwINKdi6uHl0DOO7KPYEBfNy7lJEkI+b
         Dc1kziq9vg/k6warS/yyYHiTJrXyNOrVDm5PZaIvnsFWNLszt1OAl2roFqYPLY05DgYm
         XTc6NLdCtHtS0jfRPgsQLAL/CJY+M1wfE+bl7AVkMtjHJMKVTBekrI8FS3kH1uNRDfV8
         yRJkSKM8mmR9FWw4k9E2oQRzTQbyRYmKtLWxcvVa0FHTpdIJQnSr2hcb858cyzk/Ek7/
         IhS6eMxc+VbWgEKh+TkdyafqXNG3xJjEjHw3jsyHncogJe4Qta6va0cQAmlLO6Ugg0BS
         GSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJUs2IVeeGudMULatIBraKfeG3YaqsRz1yJcxvQKUBU=;
        b=G8/kVF9QBprTRExafinAYvrSNbtmK2bXVhIMJTbeEcT0XOW7Bl1VhlBC7+u/xZb8BL
         zxird2UVY4onPl5ya816jwERkDyvDqw5LdodYSjn+CKoMk/qbNV4p76wREuvGYi9AS/2
         mkahyXBecFHbyEL6X+nSO5VnwiKljvtkPEdO2GUUHiT3eBE1jy28/k12JJvhX9G8SCFt
         t2netBPJzNtZeQirVslZUuP1UfAkemkzyYL0tlTa/F5eykE04qkgeQNqEi7GxVk/Gex+
         fG2rS6Flhy6luzkJvFxWILBLxLOCD5Y3zEvCm5N3MKt7ZqAQ4Cas/7ORP/tfLpUHoH9P
         1pHA==
X-Gm-Message-State: APjAAAWUbtUS3JZlMf82Cx2Jt1QNS1X80Ga69opW+ghRqBidl4SFWgfl
        e0K9Od8X3d4xBqjfZIQ7Fyq7+TaDZiRbnYnev4A7VA==
X-Google-Smtp-Source: APXvYqxFqSTXBNgt/d82HDdsblbrO+Gntf7FbIO7I5FVn5bWtgoCv8TB/vfd1wG63/MOxoxdjMVPWHXGS+PE9B0gIcs=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr3782474otp.316.1576689346095;
 Wed, 18 Dec 2019 09:15:46 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa77qfw99.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa77qfw99.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 18 Dec 2019 09:15:35 -0800
Message-ID: <CABPp-BGRjewgHtFQ7F_isrqnC25EQyWoPbpdyVJeDzfVEysiCg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2019, #04; Tue, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 2:03 PM Junio C Hamano <gitster@pobox.com> wrote:

> * en/fill-directory-fixes (2019-12-11) 8 commits
>  - dir: consolidate similar code in treat_directory()
>  - dir: synchronize treat_leading_path() and read_directory_recursive()
>  - dir: fix checks on common prefix directory
>  - dir: break part of read_directory_recursive() out for reuse
>  - dir: exit before wildcard fall-through if there is no wildcard
>  - dir: remove stray quote character in comment
>  - Revert "dir.c: make 'git-status --ignored' work within leading directories"
>  - t3011: demonstrate directory traversal failures
>
>  Assorted fixes to the directory traversal API.
>
>  Will merge to 'next'.

Please hold; even if you are willing to accept a manufactured dirent,
the discussion did highlight two bugs in this series:

1) I shouldn't assume dirent has a d_type member; my one access to it
should be guarded with a !defined(NO_D_TYPE_IN_DIRENT).

2) I should allocate my dirent on the heap (with some extra buffer
space) rather than the stack, because if dirent has a "char d_name[]"
rather than a "char d_name[BIG_ENOUGH]" declaration, then my
stack-based allocation followed by writing to d_name will smash the
stack.

I'll submit a re-roll with those two things fixed.
