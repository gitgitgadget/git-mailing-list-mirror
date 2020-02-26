Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E20C4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A406024672
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4IE8wyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBZVFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:05:12 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36725 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgBZVFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 16:05:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so1022881oic.3
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 13:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPifuz6XP5b8dhKYzhlZE9KTLgSJ45tZp7hr0Z34VBo=;
        b=A4IE8wyY+wQwTqVOOF1SIh+t9M5LUaZPcCviP+pHiap6FD/dUVR3315/t5FQ2NmFlb
         ksKaEJH0L7PM31lCirJlWx7e43MBYlHIAPq4Pa8O+CCRnaUjWm/MhGi/L7BHahSCqzZQ
         8Ph9MeOXWYDB9m4OWMTi+yI7GAyp79DzocxgXrxBeO5FS0wuyy5K2SyI+JKskpsc/wJv
         RVLvrKbG4oKpbP4qgGv0YYEiEHrCg3izQI+IUzsTVCALmbyGOkhbVpxXm7MhZfZkxlsO
         YXAJnmhpJFobAsRq94RBGqN/CHs4YT7ac4hI6NqYAvcTqVJXN3m3tg1mPKqKDwfUev/j
         caJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPifuz6XP5b8dhKYzhlZE9KTLgSJ45tZp7hr0Z34VBo=;
        b=I21/DJpLS1zP01oLqRMBGRQt2CJxz9gTh/UG0A2OXa8K3KFFPUutZz/CISD0fJ0hKi
         Fa6VclLsS6nZJ/4NGARjMCJ3ultnUMiSdO9znOMLCgivEjZ50P7SYxzdrKCDSKM80LXR
         RcT9h5Bd3T+2UhUFMGVM/TkaYk3PrnJuhYsK6Gz604gdeK7MzthPhwboIGLCt0kpDJOI
         SEYdnJwPmSFxNHOOYBG1hSv+5aepEQOALhVnB4yxFRU2oCSTTuRYISDWiI1kX3N1Yi/r
         kCAM9kyY8gsjaTs8q4Q6VdEwhhuirVMQzrq9BmLfEF6emdTVxF5yjiWip2+C+bZOF+9w
         wgzQ==
X-Gm-Message-State: APjAAAXos/lXeteNNOaXRjKLV1hK5KC9eLv+ivHClx5hF+rOMRuCdWHV
        OsPU1s4uZkwaBvYNGzh1DAH0JJBIioWp4fIqtS8gEjNE
X-Google-Smtp-Source: APXvYqwvenUZXiPAWFBMPkoIpA8IJ8ffOlVdLw2BaKkaPdx0uOTPp+zR9w4K6/ECWjNDQWqOPo31ez/P2JMOhE7M2kg=
X-Received: by 2002:aca:5844:: with SMTP id m65mr769389oib.136.1582751111503;
 Wed, 26 Feb 2020 13:05:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
 <3cf866d0384a0743e6625dd4e5124f00a5db5e7d.1582321003.git.gitgitgadget@gmail.com>
 <CAPig+cRYCC9MvAgVecEuvK1wqvWpVWS0ipmKPMKSctFbjHThvQ@mail.gmail.com>
In-Reply-To: <CAPig+cRYCC9MvAgVecEuvK1wqvWpVWS0ipmKPMKSctFbjHThvQ@mail.gmail.com>
From:   =?UTF-8?Q?Jorge_A_L=C3=B3pez_Silva?= <jalopezsilva@gmail.com>
Date:   Wed, 26 Feb 2020 13:05:00 -0800
Message-ID: <CAJyLMU9yKZQ673PTopxVcyx-OAk2kVSAt8nYLYYQw9-GFF00ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] http: add client cert for HTTPS proxies.
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jorge Lopez Silva via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Eric for the feedback. I'm addressing your comments and sending a v2.


On Fri, Feb 21, 2020 at 2:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Feb 21, 2020 at 4:37 PM Jorge Lopez Silva via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Git currently supports performing connections to HTTPS proxies but we
> > don't support doing mutual authentication with them (through TLS). This
> > commit adds the necessary options to be able to send a client
> > certificate to the HTTPS proxy.
> > [...]
> > Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
> > ---
> > diff --git a/http.c b/http.c
> > @@ -1018,9 +1046,23 @@ static CURL *get_curl_handle(void)
> >  #if LIBCURL_VERSION_NUM >= 0x073400
> > -               else if (starts_with(curl_http_proxy, "https"))
> > +               else if (starts_with(curl_http_proxy, "https")) {
> >                         curl_easy_setopt(result,
> >                                 CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
> > +
> > +                       if (http_proxy_ssl_cert != NULL) {
> > +                               curl_easy_setopt(result,
> > +                                       CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
> > +                               }
> > +                       if (http_proxy_ssl_key != NULL) {
> > +                               curl_easy_setopt(result,
> > +                                       CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
> > +                               }
> > +                       if (http_proxy_ssl_key_passwd != NULL) {
> > +                               curl_easy_setopt(result,
> > +                                       CURLOPT_PROXY_KEYPASSWD, http_proxy_ssl_key_passwd);
> > +                               }
> > +                       }
> >  #endif
>
> All the closing braces in this hunk seem to be over-indented. Also,
> all of the braces for the one-liner 'if' bodies can be dropped, thus
> making it less noisy.
