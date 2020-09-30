Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0E5C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2320719
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cztB01BA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgI3WBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgI3WBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:01:25 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59837C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 15:01:25 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id j12so897007ual.7
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4w5PykNudM+hd9pyOoOWhc+4dDdfzd7Yt5YkpksX3Dg=;
        b=cztB01BAmCqDziMaQQpwNG32qx2CRVldVncHSCf1rxM/aBy8x44WhwG35IYcIWnlWd
         HXzY9eNZcmJUx1EkL4aa/QPD0FMfUk1PEioLp77TTJZCQvWodamaKBLn6I8YbY7bLobo
         te+UAs0dVMmCWRk6pEyclbvOIUdLI2vCr9LIXvgAumchsRXF+UtiflXkcUuiQaaj5jGE
         6cl1bYDR/KquaMOJKMynx4HiiHP/fIVdSHHT/Me6z5kvbfLznnYlyNw5zMXASRGtzUqA
         gLwjPyBSDxACovAyLCfaBHB7djeKCZ9yQP6h9aO1ypYNegPIKYY4EN9wIa25lh5vFGAP
         w4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4w5PykNudM+hd9pyOoOWhc+4dDdfzd7Yt5YkpksX3Dg=;
        b=ui6kXQVoOC5qvXcU89+2uhCW4Rd9rCxw11NzV8VgZzFzPvzppF/4Ki2EH9sDF8qGFQ
         UGNcEey2TsM+xUNJ01jfgpw0nTh82W3CL01XPBBnkMo+QtUV803Cr0trtkiiMGOHjKJ2
         sGNhXA+wAuQ4TX2tAwguXtKSVzz/W2Q9CtYUKdXJL85xLzHlo/kn1NnW2vmGwx9WNjuy
         5mNgE7TFa0dlHB9X3TulGCmvO4Sv92RgVjID4hsRcrIWKWyTyNRotJQL0qulc91yyJbH
         QQTuHkoT9B9WdvDfjMRWI5PiRXFYxhzZHUBGi9J/Pad7QpXc6YAMp2t0Hqrwfp/Zaszu
         LkeQ==
X-Gm-Message-State: AOAM530qSAnosIvURURKWxsMCj2/ZCmhLkaUBfhLXafJ51PKlU6oFgHo
        V/lnq7KC0GkqRpDxpzYLzWaxbxk7N4bkWeItvqH/AbBK6ow=
X-Google-Smtp-Source: ABdhPJzt4TqYQAe5kwwDpHp0TDDVB9YsGbl8OC3KFBf0Q/giI6fwQlmXEEL4hZuBdO5E/NJKf4AHFeVki8gA5k/Vz0I=
X-Received: by 2002:ab0:4804:: with SMTP id b4mr3054350uad.140.1601503284558;
 Wed, 30 Sep 2020 15:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200930212529.100458-1-jacob.e.keller@intel.com>
 <CAPig+cQUeQV0=LDQ_tY43k6z7km4X6Fm9JJVPUBoG=wY3gxDfw@mail.gmail.com> <xmqqr1qjexmg.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1qjexmg.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 30 Sep 2020 15:01:13 -0700
Message-ID: <CA+P7+xqs4avU5y32jVMTRB8f0MJ8JjFoWE9mFffh7JrnCWaZMw@mail.gmail.com>
Subject: Re: [v4] refspec: add support for negative refspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 2:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Wed, Sep 30, 2020 at 5:26 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> >> Changes since v3
> >> * removed the ?: usage (for real this time)
> >>
> >> +               /* Note the reversal of src and dst */
> >> +               if (refspec->pattern) {
> >> +                       const char *key = refspec->dst ?: refspec->src;
> >
> > Blorp.
>
> Woof.
>
> Have squashed this in.
>
>  remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

I sent a v5 too.. Lol

Clearly just not my day today

Thanks,
Jake

> diff --git a/remote.c b/remote.c
> index 9f8b25674e..dad3b79332 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -750,7 +750,7 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
>
>                 /* Note the reversal of src and dst */
>                 if (refspec->pattern) {
> -                       const char *key = refspec->dst ?: refspec->src;
> +                       const char *key = refspec->dst ? refspec->dst : refspec->src;
>                         const char *value = refspec->src;
>
>                         if (match_name_with_pattern(key, needle, value, &expn_name))
