Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CF11F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeIKV5H (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:57:07 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53115 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeIKV5H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:57:07 -0400
Received: by mail-wm0-f50.google.com with SMTP id y139-v6so1747496wmc.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bkVmDrg6g8N7VyiHd3wnXLFC9Ap6O3eudHgn6EaArao=;
        b=hQQAVL6EGqRCr+TFJnH1+MdSU0TQ2uF4qWu7B7Dt1xcawK3PlkVnmGmI5UWEj7EEEh
         wHkI+nEYKG1H5yYBPne2010ZQ+u7rLqCWeeSvWTzH+ENtfSBwmehdJ3UOXwbb9908K+4
         B5xmnQRvcYYMQ0ONHNDB/xKmcwE3DOu6XIKV7rYHkB9SzkUe2lbz/3eV3hGnZLgxNfcR
         dTBlUFXeaol5qU7RvaLMTxyxqcJW71OFrFyadgxoRpjEqhGSKGBBuoQbz2ylUL4o+bKA
         NYS1BviyoN4nsUqS1wsjjkye1ZvfiRcgzkaEhLRKvK2avgPW3YQ1FQh2fYPzW739LVYb
         2XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bkVmDrg6g8N7VyiHd3wnXLFC9Ap6O3eudHgn6EaArao=;
        b=EmsJ6Uv9JzS98qXZ98kH4kfZXwPMZty2HIx+JpXPQNLBq3vSUVBRsSdg+MFni9EvgE
         z4vVgqDyKEA86eK4wCk2wL/nzj3Z4wsz+GyvBEhyZYu2hpa+1KrmZjqwp9z0PVF621oT
         9Bso+Ij4SmrAGWJY2f0OpRvo0nqJWbXS8HzwMO1vEiw9zfWly5Kqx4Ft6wAoBBHhtcDL
         bSerDrmTlC2IJ9QvttktLt6MJM4ZxKG4JP5wHx3w+8+Xdm3Z+hxrCyAzITaGPz5xoeXL
         EEpPYLHxSx/KqfBS2Sim/inesEDNvuF/bsrJNv5aIUeiumqVh0Y2EGr5yuitW8OyBxOY
         ON3g==
X-Gm-Message-State: APzg51CDSpSfIpi9KEaSeSVBGmmafPCh52FCZyVcZ5YumSiol2DQhszw
        FfZ2FuyUtFndE3AqiF58dIldzvWG
X-Google-Smtp-Source: ANB0VdbK+oB4Dd6KTc43Y/fypHxis5c3Cw6PATlQpnEzvfkul9R0GWt2JJytwAi07AF7JRCuN2+UNA==
X-Received: by 2002:a1c:3503:: with SMTP id c3-v6mr2007370wma.46.1536685014339;
        Tue, 11 Sep 2018 09:56:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t131-v6sm2465471wmg.10.2018.09.11.09.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 09:56:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 11/23] ll-merge.c: remove implicit dependency on the_index
References: <20180903180932.32260-1-pclouds@gmail.com>
        <20180909085418.31531-1-pclouds@gmail.com>
        <20180909085418.31531-12-pclouds@gmail.com>
Date:   Tue, 11 Sep 2018 09:56:53 -0700
In-Reply-To: <20180909085418.31531-12-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 9 Sep 2018 10:54:06 +0200")
Message-ID: <xmqq5zzcq8fe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> ---
>  apply.c            |  9 ++++++---
>  builtin/checkout.c |  3 ++-
>  diff.c             |  2 +-
>  ll-merge.c         | 17 +++++++++--------
>  ll-merge.h         |  5 ++++-
>  merge-blobs.c      |  3 ++-
>  merge-recursive.c  |  3 ++-
>  notes-merge.c      |  3 ++-
>  rerere.c           | 10 ++++++----
>  9 files changed, 34 insertions(+), 21 deletions(-)

This one looks good to me.  The only reason why low-level merge
needs to care about the index is the renormalization, and the
updated code seems to correctly carry around the istate in question.
