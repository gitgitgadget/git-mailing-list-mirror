Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2F9C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiHMPiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 11:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiHMPh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 11:37:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2472558D
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 08:37:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 73so3125762pgb.9
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Jc7kLp1cKwc5QuROv7CgSXG7niGKc7zoeNIiXLOC9+s=;
        b=KRLG3b9wq07fvu+/neb3Qn2WI05WQMAiKVsqviV1Lyjx/k54g0zQaD4a3zRQjP2vjP
         Qlkzzl2gnr7K+QIKBHCologhE3rF2ln0hXZvHOJv9iMAi6Ch2bnfNCPxBjBcKvSjHd1e
         AVryX9YKgAwZJ35nmY7YNYyuLS6gAdiicKJt5Sti2JsQoLUjKRWwNBpnoGYC0eOpEv+j
         9NvEBhIQ/ko9az2Jk4gxf50SF2VSpkcHAjBSGO7/kCE0AoOVluGUVqGGGy2Cl1qZx9JG
         4qlsU6WAw0bYO0YCykKCg56aRb7iPa9xHN0KtffP+a6hCSoJ59IdQdlJlrNGH5IceUgz
         38LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Jc7kLp1cKwc5QuROv7CgSXG7niGKc7zoeNIiXLOC9+s=;
        b=l8Lcagayoj9THcQdpu+yB8mnteUb20xbusxdGnABwrSxi2zLhX3VxBz1cp4QU2+Qm7
         0jEn9aRuWbe1mi3pGs1qzYLFg1zHLejgojTajxjSSvHZETnUEBfcFyXn0tJCUf9QP6r0
         AvtXsy3GC49+1kx+XGzkWML5Chy7apn9b/5R2u9KGnB/fsR5fhSaivHWKDllH8eaOIj1
         Hmsm09K4kOE+jm0SInNhXQApCw7IYYUzxAgaQsVcU+zgIRFK7eVb88VaHApr19L3eqcJ
         SEAw7xza+vTgQcFm+tDqfjdWmAqB7lgn0T+ftmb3OwNmyf2btDCWhR/aDVzlRyVl7frz
         vOig==
X-Gm-Message-State: ACgBeo26Ly5TQEPL3ZmP/rkjf8tNh6vV9yR6fkznOOB98DSSi7ChrYdD
        CGDK+U+53xnFlJHkjAbauqUI6bch2bg=
X-Google-Smtp-Source: AA6agR6o7um7sLHCwrMNl9pjG6VSsJD6eK5148d4z586Ay7BHbDSyDwzxkBLu8/G+zQpUjHL69e3Xw==
X-Received: by 2002:a65:5504:0:b0:41d:271:4929 with SMTP id f4-20020a655504000000b0041d02714929mr7156485pgr.606.1660405078511;
        Sat, 13 Aug 2022 08:37:58 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a3fc100b001f334aa9170sm1711143pjm.48.2022.08.13.08.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 08:37:58 -0700 (PDT)
Date:   Sat, 13 Aug 2022 22:37:54 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Renato Botelho <garga@freebsd.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git maintenance broken on FreeBSD
Message-ID: <YvfFUuuydtYeuvRx@danh.dev>
References: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
 <YvZnQFVMZZmz9TIX@danh.dev>
 <YvcdskzUkocUv/d7@pobox.com>
 <xmqqczd4ag8f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqczd4ag8f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-08-12 22:02:08-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
> > If a change like this is made, aren't we trading one group
> > of broken users for another?  It would fix users of newer
> > systems at the expense of those on older systems, I would
> > suspect.
> 
> So, it is fairly clear that "crontab" wants a real file.  Somebody's
> POSIX compliant "crontab" can be fed "-", attempt to read from a
> file with such a name, and legitimately fail.  And on such a system,
> the proposed patch causes a regression.

Then, we are getting back to point #0, we don't have universally way
to specify stdin as input file for crontab(1) and "crontab -e" is
optional.

Perhaps, FreeBSD needs to carry this patch downstream; or
we will invent new preprocessor, let's say CRONTAB_DASH_IS_STDIN
which is defined in FreeBSD, and another config, let's say
crontab.dashIsStdin (in order to allow users swap their default
cron) which is default to 1 if CRONTAB_DASH_IS_STDIN is defined,
and 0 otherwise.  So, everyone will be happy.  Thought?

-- 
Danh
