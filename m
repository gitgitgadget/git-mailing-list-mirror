Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38711F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJZDIh (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:08:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38346 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZDIg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:08:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so9428178ede.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3V55C1wXZ80svkqkxYNfg8GPwe7nAP1eu6YRlnUXfs=;
        b=qebNbvNTzlg6tcj34YqMTBIEisRetjva0a4AZy2hhuDbKcRu/I5tf+pH0hNYLHgOhZ
         P0wTmALFop+p6wWy2HbPki9U9uzMzx0AIxbVki/6W9bPCYVlR5e1GHUtWfkC00CYehnD
         sh3BNQ+EF1vcYBIS8rGn/ptLyWbJtsx9JfRZ783pbUTUNiIv9e8BIEZeotCIDubiBIef
         ujk8567wl03XVic4bvLML888ZO0Pkp9hFvET/o6bb/WrmwUI+x/aKNgYCZuTqIbd3Yyw
         0E1/4EAQ10dR4EKobFOxZUapvQ27AH/e+0mOJm2ZntGSXEIAMU8xdkRyRAaHROkSIUXn
         v5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3V55C1wXZ80svkqkxYNfg8GPwe7nAP1eu6YRlnUXfs=;
        b=ETIXt0hRVbfdJkwg0shQ7LHky2DhHcSUoLqBzwoAJ1H8E9UlWqXXy1tMauFoJJkVlw
         xq1My5zqRRf2J2sfwlo/PyC1RSeW1VM1pccFODP9wHV6VB0LJ1DbeLh9lSBFY9lIlEbS
         h/3h1esWrwFa1VoaRnhKUWOKw4V0JeYX+q8M3zYOAMJISU6BwNBqxPT2I5YjTpchhhIb
         CDzrYB1tz+3zi3k9Y5GjaTSG/jl5tZi7IFxEUJM9EOOhufGpJDcT39Dnqb2LrZAre7lH
         bIpXxNL6AsG6+xkQ+geNWSsii0DOI94tHzEhC7vGmitNSfhGoQYjLCaZRupDD/bqAX3F
         Z0wQ==
X-Gm-Message-State: AGRZ1gLTJPrWZuc5SPM2Gjj+KJXQGz7aPLnXtpMlroER93jVvKzHe7wz
        PWiBA05CLgkbgyDu7uFxnItbumCn5l4BhENlnSAv5w==
X-Google-Smtp-Source: AJdET5e5uXCKK4Z2565nBb5fubU9t5azPSNy+ObO5uZUtKwKD47KE1gj2N+wDuPZ8cKMOVX+7ydZptckyG3AE8NOsbQ=
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr175709eji.67.1540492481324;
 Thu, 25 Oct 2018 11:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181019225404.34496-1-jonathantanmy@google.com>
 <xmqqwoqav8g6.fsf@gitster-ct.c.googlers.com> <xmqqpnvygzy6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnvygzy6.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Oct 2018 11:34:30 -0700
Message-ID: <CAGZ79kYoMOL-et63cky8LOxoT0yuuCo+7x=qjUcmBH_VZL+Y-w@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: be more precise in parsing v2 response
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 2:04 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Jonathan Tan <jonathantanmy@google.com> writes:
> >
> >> +    GIT_TRACE_PACKET="$(pwd)/log" test_must_fail git -C http_child \
> >> +            -c protocol.version=2 \
> >> +            fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
> >
> > Because test_must_fail is a shell function, the above is not a
> > correct way to say "I want GIT_TRACE_PACKET exported only while this
> > thing runs".
> >
> > I'll squash the following in.
> >
> >  t/t5702-protocol-v2.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> > index 51009ca391..d58fbfa9e5 100755
> > --- a/t/t5702-protocol-v2.sh
> > +++ b/t/t5702-protocol-v2.sh
> > @@ -555,7 +555,7 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
> >       printf "/acknowledgments/,$ s/0000/0001/" \
> >               >"$HTTPD_ROOT_PATH/one-time-sed" &&
> >
> > -     GIT_TRACE_PACKET="$(pwd)/log" test_must_fail git -C http_child \
> > +     test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
> >               -c protocol.version=2 \
> >               fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
> >       grep "fetch< acknowledgments" log &&
>
> I know it only has been a few days, but is there any other issue
> in the patch, anybody?

I have reviewed the patch and I think it is good with the squashed change above.

Thanks,
Stefan
