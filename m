Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA2520248
	for <e@80x24.org>; Wed, 13 Mar 2019 22:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCMWnC (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 18:43:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37763 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMWnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 18:43:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15so3774560wro.4
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Z1bxmLwyVy37W7TZ4UEx/AaT6ymbmKD4kffBRhGPF1Y=;
        b=NpxmeIcEFgvIWrBsFmO8sE0TGxXM2DIvg0SzCDz06BvF+w/kPDHRy4IC3GpV81gBRb
         eOpSNntI1LDspo0CAE8wu6wX+2+LOO0GtIYJDPvmHu3qmAEIgKNRkWusSWn6t9/1YjDQ
         IRTLQBlK22FOVPH/v+IYoCIOihjgIOLOe8WnhZIoEMkKQB8J8sTBQ0Q7IiC6YUaXJE3j
         cF8BB5VVFi8vxERHwHIEYMeRd1Hj8YCQvjUvvIxNAROySDWVgIE/WHkHQHHnzkEEgl8d
         rnKVVQoNnkugnTujRHmKsVdxk8X49zCL2ZHu5FbvPLUktRCrwb0SDTVOHlkE1y+Xq6cr
         7lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Z1bxmLwyVy37W7TZ4UEx/AaT6ymbmKD4kffBRhGPF1Y=;
        b=ROlZOiqXUn5cl+l2VvksNv+v+wY6CHDjDZTIn1jinqcjvjwjRiZ8jYCn/o//nQRWTF
         s+DNq9E1kL3dnwsic/r1aRyycVi8l/niW+bVvTDUcLiiD3gBrWMFvUYvFMMb5HScruK6
         R+F5O8ZUxy5w9E5z9fYWY8dBpSlZheX9esy+kYK7u7whymDoqXg4oIguqpYgjLLADS0k
         pZeE32VooQPZtkPhZdBoNexWin3Fl1fgyOUfVWqznT+4wpafd/0CHH7hrhvB/hisHHNm
         NtqKxWlwiLmfe9zuZGd7fJOFK+f7vNcHUI+xlAIqS+jyNy/8Xzn+gss+fWIAyJuXrL5+
         dcIg==
X-Gm-Message-State: APjAAAVhcMJW41BCpTbc+K82U/JAN8Qy7zcTM0pAONAtDBn5HlD0CQjc
        JvdV+k+GQljQldWttLcG4ys=
X-Google-Smtp-Source: APXvYqxYzFJfSjurB1piOekNcFmId+OQWHyBf4oAhDzlsOylndWkpvQ3Nt9jSKKRfGUzp8nSG+rfBg==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr30034609wrg.88.1552516980501;
        Wed, 13 Mar 2019 15:43:00 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x11sm20077699wrt.27.2019.03.13.15.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 15:42:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] restore: add --worktree and --index
References: <20190308101655.9767-1-pclouds@gmail.com>
        <20190308101655.9767-7-pclouds@gmail.com>
        <CABPp-BFv-a3Uw1g+ebLqTHRbCedsv1akZxxJ7QfeyXtXBdQuOw@mail.gmail.com>
Date:   Thu, 14 Mar 2019 07:42:59 +0900
In-Reply-To: <CABPp-BFv-a3Uw1g+ebLqTHRbCedsv1akZxxJ7QfeyXtXBdQuOw@mail.gmail.com>
        (Elijah Newren's message of "Sat, 9 Mar 2019 10:52:02 -0800")
Message-ID: <xmqqva0mcs5o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> +               /*
>> +                * NEEDSWORK: if --worktree is not specified, we
>> +                * should save stat info of checked out files in the
>> +                * index to avoid the next (potentially costly)
>> +                * refresh. But it's a bit tricker to do...
>> +                */
>> +               rollback_lock_file(&lock_file);
>
> A total tangent: I see both FIXME and NEEDSWORK in the codebase.
> Are there other 'keywords' of this type that we use?  Is there a
> preference for how they are used?

If it makes it simpler, I can easily declare that NEEDSWORK is the
preferred one (I do not think I ever wrote anything else) to avoid
wasting list bandwidth ;-)

