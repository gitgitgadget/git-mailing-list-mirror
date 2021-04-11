Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5CEC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 02:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DA6610CF
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 02:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhDKCJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 22:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbhDKCJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 22:09:56 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23297C06138B
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 19:09:41 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id c3so1913912ils.5
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 19:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Ukl3323ODDZuP3Iw/0gUV+7SCPBRVz9UxnYgNfr30u4=;
        b=SOfi17HabJQMPqgnN5xVSVyrqXNRNkKDqhFMQY4AyTOjEEj3dCCVKG/odOtISyckST
         c3q0WI76bgGsOWo18Sb9Yewrn2zzL5qEmpVmxJ1DLj/cyJs0WaK8f4Z1N3wlaQZLmAho
         QH/6VlsV5bbcuS9zVFyMTDMxzQjAngwJubUQAQmz+dJyN+NyxDeKpflw4CiYBnHRIpO9
         +YKSjuPF4yHpe4P8m5Qw5y5ED4yPpToI6NPU5BpXEkQFHZVJEjIYbKviCshRRkaeLUL/
         kOkHuim64gYyBBRZwV274WAvoK3wiXzCTWnPq9Pfum6hdqMnqNQkX+uCe/foLiZtQGwp
         4aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ukl3323ODDZuP3Iw/0gUV+7SCPBRVz9UxnYgNfr30u4=;
        b=EFtb57mDD6AnsGDFjFv0xxuG8q1mYscVA2ZK6bsoaF6Fz0Sxyd3JxhK+2XGNQG/JoO
         OiHdXAipuWO0Fa6A3+bmFIcBTvYphyEHVF1OoAFmkPMer+8sZeAS452tj7Xvitw0/VwM
         kJPuO0WE+sqsO58J9ILEGTtjixMvhpUBBDSdaZrDk5j2bSCgpkmQRJhZttGg6JrhFrIO
         +s0LJHZZq73msV5VPdks5Oe4SvZQgFDnwXntrcMsEYph1q/ef7jGVQ6KlNi9/X6r9HBa
         B1OV0kHGTyj3paVxDUCztVxQ2bhdj0a1TLNrFagTYxMBoTuBcI9RE0M8XQvuxlDHP+DW
         JJIg==
X-Gm-Message-State: AOAM532fAjMvBt1usgjM6HcRme3AtUSVQekaTj6qlYofwY6cSqSHSjUw
        DdHDfbyYaAqwQ0zaDBIAk2Jn707NtODDs+74LjI=
X-Google-Smtp-Source: ABdhPJxO0s6BjFXgqW4fRzdoZy+EL5BdnJ3HNflTZrAT5hly49eGmPCvhCrFgwc4EQyCaCUSlo+lo6BknTpCxcznzCo=
X-Received: by 2002:a05:6e02:1a22:: with SMTP id g2mr18002130ile.231.1618106980079;
 Sat, 10 Apr 2021 19:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOTb1wef2w_H4mwMMwR4En8665GduAMoceL45+OYC4DSBPtozQ@mail.gmail.com>
 <YHJW4xCgw6GN0Rag@camp.crustytoothpaste.net>
In-Reply-To: <YHJW4xCgw6GN0Rag@camp.crustytoothpaste.net>
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Sat, 10 Apr 2021 19:09:29 -0700
Message-ID: <CAOTb1wftqhQSZ8KRyh0hXBE7enM8KG85H-UyxBObnsx8Ff8vvA@mail.gmail.com>
Subject: Re: question re: git show-ref and matching ref patterns from the front
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 10, 2021 at 6:54 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-04-11 at 01:24:57, Chris Jerdonek wrote:
> > However, is there a way to limit Git to showing refs starting with a
> > prefix, and that doesn't also require Git to iterate over all refs?
>
> I believe you can do this with git for-each-ref.  It accepts prefixes,
> and assuming you don't use a case-insensitive comparison, it will
> restrict itself to iterating over only those prefixes you specify, not
> all refs.

Thanks. One minor difference, though, seems to be that git
for-each-ref doesn't support including the HEAD ref, which you can do
with git-show-ref by passing ---head.

--Chris
