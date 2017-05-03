Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C3C1F829
	for <e@80x24.org>; Wed,  3 May 2017 18:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbdECSJD (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 14:09:03 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33729 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdECSJB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 14:09:01 -0400
Received: by mail-pf0-f169.google.com with SMTP id q20so16258222pfg.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OtEfi7GCYUWLnaIJqet8W1Qjjk+RuGIgU/kTAnjh1IQ=;
        b=nfWJaDUE9En1KtDtZtKHwsX+XxHrtcAWkZuxKqOMSsuYY6DvfDsxW0OhwQ7YwjD2Kh
         Zznc6jQaf1l+pFAfIIDlQSqQuYDTMXnHWghCxKQJ7QMh7rZ65SpxYNg9P25JokLr33fS
         fE7Gsp+G4uHO0dlp9G30raTdHl0sMC8vVvlBLdIfR8L3Ep36Y1aPEXpmw9D1HoQFt9mT
         NZGV9a/Z5e0DMLeU3xbJxfuFzgpsoisH6p5gCbO29HJRfQXGH/pvgEqTWBuHmJErIVZL
         gABNs9cB1SNVNhft/qGL4OHsAfQ4doAy6k8MyUR8mghAqAY2pc//k/fQqp9rSK0SSWZB
         0eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OtEfi7GCYUWLnaIJqet8W1Qjjk+RuGIgU/kTAnjh1IQ=;
        b=mKBj/myGF7g5QOjtQoPj5/VHtikf9mBV/lvAGr5I0MTRbTu5djhGnTM9kwOaqeAiGt
         yjMh+D9BjXX2HZ0aX24MfJdMJccV3ZFMPuf8Up2B8jRUVg5qDK6f7fP60qwjpsPac2BV
         HXGQRCMRMSUuo2fuHiN4zruQcpXbBmxqIW/vihPyL//fGaVnqc3FxTRoArQmQ1tvaWHa
         FsdkM7V/faw50/NOOiwFx4TTfRihA3BAHHrbE+mcqe1PYjAjsMVV4pr/LXeFNgKPxdwc
         weO2D08BSVP39d1vMxw04VXYQJyrgSktqAY/lMhc1wWsM5YbUNSAik7XXlQe1xMDwKsC
         tcKQ==
X-Gm-Message-State: AN3rC/5fjdxFXV2tg/HSpks9AvOn43BiiKeiXIy5Ix2eipz1jKZazgdu
        mXbU3FzseOTv1bACCyAW4yqATFoI55Em
X-Received: by 10.98.90.6 with SMTP id o6mr6278433pfb.101.1493834940558; Wed,
 03 May 2017 11:09:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 3 May 2017 11:09:00 -0700 (PDT)
In-Reply-To: <20170503032932.16043-4-sxlijin@gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com> <20170503032932.16043-1-sxlijin@gmail.com>
 <20170503032932.16043-4-sxlijin@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 May 2017 11:09:00 -0700
Message-ID: <CAGZ79kYie6F29R7HP0+MSpkHqSE7Cn=55EhGsNjoKxA_9Esz5Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] dir: add method to check if a dir_entry lexically
 contains another
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 8:29 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> Introduce a method that allows us to check if one dir_entry corresponds
> to a path which contains the path corresponding to another dir_entry.
> ---
>  dir.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/dir.c b/dir.c
> index 6bd0350e9..25cb9eadf 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1852,6 +1852,14 @@ static int cmp_name(const void *p1, const void *p2)
>         return name_compare(e1->name, e1->len, e2->name, e2->len);
>  }
>
> +// check if *out lexically contains *in

Thanks for adding a comment to describe what the function ought to do.

However our Coding style prefers

/* comments this way */

/*
 * or in case of multi-
 * line comments,
 * this way.
 */

I think one of the ancient compilers just dislikes // as comment style.

> +static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
> +{
> +       return (out->len < in->len) &&
> +                       (out->name[out->len - 1] == '/') &&
> +                       !memcmp(out->name, in->name, out->len);
> +}
> +
>  static int treat_leading_path(struct dir_struct *dir,
>                               const char *path, int len,
>                               const struct pathspec *pathspec)
> --
> 2.12.2
>
