Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE1FC3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 01:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0E621D56
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 01:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efJFAPUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCCBlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:41:42 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40482 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCCBll (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 20:41:41 -0500
Received: by mail-oi1-f194.google.com with SMTP id j80so1357913oih.7
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 17:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c04MlRFfXjD3Eg6OJMMfgolC3BnVkCOsWuKqEz988/I=;
        b=efJFAPUCWUWwnXDFmQlv1xdqGk3xPh+TJldcvBFvJwM9G8ISUaLDHDTyIVa7mQWVWQ
         0SGcDFKkwTcj9tsG/iXmaGwMXfN2ULBmv8MiR+BcmC/WW8wF9WA0/c9b67FyDW8zbxZo
         Ty2P58C1wseSz2Hr6+8FsB8duoojts4h3geSanWCr4EztDKXlTBDx4+I+kqq4MFiDVwq
         Emcd5tudt1LvgMcKo2sLjj5z1gulz9/Yhqk0ww+3QdCIpnkM1atCidEp3w6NMr7pYO35
         60pHfQTnLlVMrmri4yFE1np+tvhfTSMR/uOWy+VsEa+08pbVQQBnVY8Q7RjL0NlA8gLa
         ctXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c04MlRFfXjD3Eg6OJMMfgolC3BnVkCOsWuKqEz988/I=;
        b=Yg5lO7wAQfW905LWPBxySaqyPiPLowz/BJEiWZ80RcmdRY8cdejnLR1GRpnrzg+Rdk
         OAYGv2etog7a9bQQxo8OP/a9r0JcndlQay18VtTM4DydmDXcxd/R43NNNBmzju0CAluI
         ySflUE1WLxBJSSsS8UzH8W7L8/OoNZpDpiD4JGKT2aUBzakf2DqKiCy1Aq2nJ4W1xgCW
         d5plveH5hVEiIMgL8uexbCsO1paY096N9QRXy4MqRLu0j1KAGU8YmkE8emQFuGRMsE1L
         LjoexdWHngDQ3JV1/QJY73gksNigr8q0ck9MO4OX1aQRA1yoTqRxHP0XcO9R0IzugE+R
         eJ5w==
X-Gm-Message-State: ANhLgQ1VoPGlc4ED5Pqpwb81Vy6pHd3OVGzCyY6M2h0QAKkhibofGXXY
        tdfdWZcpdw6JcbGuI6JOM9pQ/BmcVNjd1kxuByM=
X-Google-Smtp-Source: ADFU+vsi8PTnZTrXPp1BdvGcuRxXnJKLCK5S54sXmtE8nCIjmRqNlYowItAEWsbYdtLcNQVxUfzsQAlPn8Xhz9TCaK4=
X-Received: by 2002:aca:1b17:: with SMTP id b23mr930119oib.95.1583199700510;
 Mon, 02 Mar 2020 17:41:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
 <pull.559.v2.git.1582759438.gitgitgadget@gmail.com> <a5d980e7501b1e0ab6f20a97136cd3a58427a139.1582759438.git.gitgitgadget@gmail.com>
 <xmqqftevg9uz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftevg9uz.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Jorge_A_L=C3=B3pez_Silva?= <jalopezsilva@gmail.com>
Date:   Mon, 2 Mar 2020 17:41:29 -0800
Message-ID: <CAJyLMU99__oKfNufVQQP+zodPVJV0bhFbyQzbrjfF11+UKVOCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] http: add client cert for HTTPS proxies.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jorge Lopez Silva via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> You may copy around your ~/.gitconfig to multiple hosts, some may
> have newer and others may have older versions of libcurl, so it
> would be OK for a version of Git built with older libcurl to at
> least see and parse configurations meant for newer one, if only
> to ignore and discard.
> The only two effects these #if/#endif have are (1) they save a tiny
> bit of memory, code and runtime cycle on an older platform and (2)
> they make the resuting code ugly and harder to read.  I do not think
> that the tradeoff is worth it.

I agree, thanks for the input. I'll remove the #if/#endif from the variables.

>  This part is more or less straight-forward.
> This is a minor tangent, but I see many "var != NULL" instances used
> as the condition to if statements, which we tend to frown upon
> (instead just say "if (var) ...").  I know there are already many in
> the existing code in this file, but this patch is making it even
> worse.

Understood, will fix!


On Thu, Feb 27, 2020 at 10:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +#if LIBCURL_VERSION_NUM >= 0x073400
> > +static const char *http_proxy_ssl_cert;
> > +static const char *http_proxy_ssl_key;
> > +static const char *http_proxy_ssl_keypasswd;
> > +#endif
> > +static const char *http_proxy_ssl_ca_info;
> > +
> >  static struct {
> >       const char *name;
> >       long curlauth_param;
> > @@ -365,6 +373,20 @@ static int http_options(const char *var, const char *value, void *cb)
> >       if (!strcmp("http.proxyauthmethod", var))
> >               return git_config_string(&http_proxy_authmethod, var, value);
> >
> > +#if LIBCURL_VERSION_NUM >= 0x073400
> > +     if (!strcmp("http.proxycert", var))
> > +             return git_config_string(&http_proxy_ssl_cert, var, value);
> > +
> > +     if (!strcmp("http.proxykey", var))
> > +             return git_config_string(&http_proxy_ssl_key, var, value);
> > +
> > +     if (!strcmp("http.proxykeypass", var))
> > +             return git_config_string(&http_proxy_ssl_keypasswd, var, value);
> > +
> > +     if (!strcmp("http.proxycainfo", var))
> > +             return git_config_string(&http_proxy_ssl_ca_info, var, value);
> > +#endif
>
> You may copy around your ~/.gitconfig to multiple hosts, some may
> have newer and others may have older versions of libcurl, so it
> would be OK for a version of Git built with older libcurl to at
> least see and parse configurations meant for newer one, if only
> to ignore and discard.
>
> The only two effects these #if/#endif have are (1) they save a tiny
> bit of memory, code and runtime cycle on an older platform and (2)
> they make the resuting code ugly and harder to read.  I do not think
> that the tradeoff is worth it.
>
> >       if (!strcmp("http.cookiefile", var))
> >               return git_config_pathname(&curl_cookie_file, var, value);
> >       if (!strcmp("http.savecookies", var)) {
> > @@ -924,8 +946,14 @@ static CURL *get_curl_handle(void)
> >  #if LIBCURL_VERSION_NUM >= 0x073400
> >               curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
> >  #endif
> > -     } else if (ssl_cainfo != NULL)
> > -             curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
> > +     } else if (ssl_cainfo != NULL || http_proxy_ssl_ca_info != NULL) {
> > +             if (ssl_cainfo != NULL)
> > +                     curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
> > +#if LIBCURL_VERSION_NUM >= 0x073400
> > +             if (http_proxy_ssl_ca_info != NULL)
> > +                     curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, http_proxy_ssl_ca_info);
> > +#endif
> > +     }
>
> On this codepath, unlike the config and variable definitions,
> #if/#endif is absolutely necessary.
>
> In any case, the code around here is messy, but it is mostly due to
> the fact that the existing #if/#endif with if/elseif/... cascade was
> messy.  The general idea is
>
>  * We want to honor ssl_cainfo and http_proxy_ssl_ca_info, and use
>    CAINFO when set, but
>
>  * When http_schannel_use_ssl_cainfo is not in effect and
>    http_ssl_backend is schannel, ssl_cainfo/http_proxy_ssl_ca_info
>    business is completely skipped, and these two CAINFO are cleared
>    instead.
>
> I do not know if the above is the best code structure to express
> that, but at least the way this patch adds code is the least noisy,
> I guess.
>
> > @@ -1018,9 +1046,19 @@ static CURL *get_curl_handle(void)
> >                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
> >  #endif
> >  #if LIBCURL_VERSION_NUM >= 0x073400
> > -             else if (starts_with(curl_http_proxy, "https"))
> > -                     curl_easy_setopt(result,
> > -                             CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
> > +             else if (starts_with(curl_http_proxy, "https")) {
> > +                     curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
> > +
> > +                     if (http_proxy_ssl_cert != NULL)
> > +                             curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
> > +
> > +                     if (http_proxy_ssl_key != NULL)
> > +                             curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
> > +
> > +                     if (http_proxy_ssl_keypasswd != NULL)
> > +                             curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, http_proxy_ssl_keypasswd);
>
> This part is more or less straight-forward.
>
> This is a minor tangent, but I see many "var != NULL" instances used
> as the condition to if statements, which we tend to frown upon
> (instead just say "if (var) ...").  I know there are already many in
> the existing code in this file, but this patch is making it even
> worse.
>
> > +             }
> >  #endif
> >               if (strstr(curl_http_proxy, "://"))
> >                       credential_from_url(&proxy_auth, curl_http_proxy);
