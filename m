Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B804C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 11:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E118C6112D
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 11:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbhHSL2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhHSL23 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 07:28:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807DC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 04:27:53 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n24so7193740ion.10
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=THWitiGLTnE1fPdiU/S1rzLvxMtZca5NaxJtKpTmNjU=;
        b=saNH5nI7eT3HPC+jAP5+XqQhg5JH7YlB+4xLlVzyy48YYHcz5KheizdbB1gnvTMq9K
         TaiW6qpW0Byy18qQjQkz+jc/g4ucpg4JNCMc4IqYX9UlwzW1vYK1i7hzJlVRL7Xv7gdH
         wfcWuB65eVddwt7Qu9RkA7o5Mwn+zRuPYr6+hE/7Blc7siGRWILG0/QrCPM5igev7EXa
         opO8bq+Mg4eGHOEv6ZWCl7zYsHgmVHf3bJiB0xNNBQY4Or7uVczz/hHmQ7eAYBoCVRlC
         +hciUW0muBmEc5cDIYSojnoyHk77+eDFPp7ilYXRtawfzlL5V8xqYuO1wL110jtWSDHB
         0UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=THWitiGLTnE1fPdiU/S1rzLvxMtZca5NaxJtKpTmNjU=;
        b=JF5EZoNPQ7bDSsI7/VZZuHiUYS/hp5sb1DzOQogMWmUd7BR2okX5gO2ZkJxl0aasfc
         uBn3q6B+k3QpnNM+j5cMBKEP4DdApSmvoZ5tVnhP7yCg2CA4OcqAQBkojdYWl1EzwJF9
         BTKPDJyv1qj8i/2ihFT7B6qX0wmy/8+yCZUrrRdc0gjUYOUV3w3c5NmU3++vDCWkhSZQ
         fA5ik/IriRwI/7eiL1t+BaS2vwrdtDFWGlbakWb7jHx0Iv2C/8ESOeBgAZy5kHwnZn4Q
         rYW+V/jW+SBnFOdLlPo59KEbhXiJTuFmdZsvHv44g9Q7PKhscDwNUomcQjWA6QqdNU7/
         ch7A==
X-Gm-Message-State: AOAM531xW7ly/MAmzQbSKdvcajoMrOXkymUFbtt4DNB09Pa6kzadp+lh
        F4RBjWwATesDsEAzaiMqczmmZdrwoq5nMY0fvBk=
X-Google-Smtp-Source: ABdhPJzWDLrdEvcUttnVqulA2pRPKu1/BDKQnZCEDOjGYVIf8eWusRnf0R2JilX6jphaSU2T1dhBrSWmlYjdqa++PXI=
X-Received: by 2002:a05:6602:3413:: with SMTP id n19mr10734901ioz.46.1629372472714;
 Thu, 19 Aug 2021 04:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com> <a097e447-28e7-d991-ac99-ce1ffdb3ead4@gmail.com>
In-Reply-To: <a097e447-28e7-d991-ac99-ce1ffdb3ead4@gmail.com>
From:   Xiaowen Xia <haoyurenzhuxia@gmail.com>
Date:   Thu, 19 Aug 2021 19:27:41 +0800
Message-ID: <CAHLXgnZQmLiLbGnbC-nouE6tTJam5ZmdRmj=8E+tmM1pNLVFXw@mail.gmail.com>
Subject: Re: [PATCH] add http.maxReceiveSpeed to limit git-receive-pack
 receiving speed
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        worldhello.net@gmail.com, Xia XiaoWen <chenan.xxw@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I mean "In some situations it is preferable to limit receiving speed of
> git clone/fetch due to network bandwidth constraint, otherwise other
> applications performance will suffer from degraded network performance.".
Thanks!

> Wouldn't it make sense for negative speed? Why don't just return error
> if negative speed is set?
You are right, negative speed doesn't make sense. but I prefer printf
a warning and continue work instead of returning an error, negative
speed seems not a fatal error.

> Why is there boilerplate #if #endif block for libcurl 7.15.5?
The speed limit depends on the `CURLOPT_MAX_RECV_SPEED_LARGE` provided
by libCURL, and libCURL added `CURLOPT_MAX_RECV_SPEED_LARGE` in
7.15.5: https://curl.se/changes.html#7_15_5 .

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8819=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On 19/08/21 16.14, Xia XiaoWen wrote:
> > Sometimes need to limit the receive speed of git `clone/fetch`
> > because of the limited network bandwidth, otherwise will prevent
> > other applications from using the network normally.
> >
> I mean "In some situations it is preferable to limit receiving speed of
> git clone/fetch due to network bandwidth constraint, otherwise other
> applications performance will suffer from degraded network performance.".
>
> > Add `http.maxReceiveSpeed` to limit `git-receive-pack` receiving
> > speed, Can be overridden by `GIT_HTTP_MAX_RECEIVE_SPEED` eivironment
> > variable.
> >
> s/eivironment/environment/
>
> > The default is unlimited, same if the value is 0 or negative. The
> > default unit is Bytes/s, common unit suffixes of k, m, or g are support=
ed.
> >
>
> Wouldn't it make sense for negative speed? Why don't just return error
> if negative speed is set?
>
> > this configuration is valid for `clone`, `fetch`, `pull` commands of th=
e
> > https protocol, and only supports libcurl 7.15.5 and above.
> > ---
> >   http.c | 24 +++++++++++++++++++++++-
> >   1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/http.c b/http.c
> > index 8119247149..12030cf3bc 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -83,6 +83,9 @@ static const char *ssl_pinnedkey;
> >   static const char *ssl_cainfo;
> >   static long curl_low_speed_limit =3D -1;
> >   static long curl_low_speed_time =3D -1;
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +static ssize_t curl_max_receive_speed =3D -1;
> > +#endif
> >   static int curl_ftp_no_epsv;
> >   static const char *curl_http_proxy;
> >   static const char *http_proxy_authmethod;
> > @@ -361,7 +364,12 @@ static int http_options(const char *var, const cha=
r *value, void *cb)
> >               curl_low_speed_time =3D (long)git_config_int(var, value);
> >               return 0;
> >       }
> > -
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +     if (!strcmp("http.maxreceivespeed", var)) {
> > +             curl_max_receive_speed =3D git_config_ssize_t(var, value)=
;
> > +             return 0;
> > +     }
> > +#endif
> >       if (!strcmp("http.noepsv", var)) {
> >               curl_ftp_no_epsv =3D git_config_bool(var, value);
> >               return 0;
> > @@ -974,6 +982,12 @@ static CURL *get_curl_handle(void)
> >                                curl_low_speed_time);
> >       }
> >
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +     if (curl_max_receive_speed > 0)
> > +             curl_easy_setopt(result, CURLOPT_MAX_RECV_SPEED_LARGE,
> > +                              curl_max_receive_speed);
> > +#endif
> > +
> >       curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
> >   #if LIBCURL_VERSION_NUM >=3D 0x071301
> >       curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> > @@ -1105,6 +1119,9 @@ void http_init(struct remote *remote, const char =
*url, int proactive_auth)
> >   {
> >       char *low_speed_limit;
> >       char *low_speed_time;
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +     char *max_receive_speed;
> > +#endif
> >       char *normalized_url;
> >       struct urlmatch_config config =3D { STRING_LIST_INIT_DUP };
> >
> > @@ -1196,6 +1213,11 @@ void http_init(struct remote *remote, const char=
 *url, int proactive_auth)
> >       low_speed_time =3D getenv("GIT_HTTP_LOW_SPEED_TIME");
> >       if (low_speed_time !=3D NULL)
> >               curl_low_speed_time =3D strtol(low_speed_time, NULL, 10);
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +     max_receive_speed =3D getenv("GIT_HTTP_MAX_RECEIVE_SPEED");
> > +     if (max_receive_speed && !git_parse_ssize_t(max_receive_speed, &c=
url_max_receive_speed))
> > +             warning("failed to parse GIT_HTTP_MAX_RECEIVE_SPEED: %s",=
 max_receive_speed);
> > +#endif
> >
> >       if (curl_ssl_verify =3D=3D -1)
> >               curl_ssl_verify =3D 1;
> >
>
> Why is there boilerplate #if #endif block for libcurl 7.15.5?
>
> --
> An old man doll... just what I always wanted! - Clara
