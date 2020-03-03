Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2649C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 01:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBA321D56
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 01:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TitsgU9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCCBrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:47:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41872 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCCBrd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 20:47:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id v19so1410514ote.8
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 17:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7oiC8SooGTBNmfjgs5+8ZBlYcd/H6W2Nr9cpswljXc=;
        b=TitsgU9DwBYbj5UxDGbpH7X0wql8toAFXLgc2PmGtYk9Fd4QvWSJ2LAzvd60AY1wcR
         Hx5hv5kzMCQKVZEBElRCBY0AUStZNWgRn8iAHHZRrRzzLFOoIn4IzwW16GDlPRGzrrq9
         TRdVOAXGknn6ZyfwL8NFmixRvF9o+k6DoT14oaQLijQCb2C3kI1sTmgTQXfbK5GzNttg
         rj/IOuAiIEgCa1jzjMIsicWo1xmEtIynsvIjC8yJ/XQFkeyUZuYW+pkxt0aLuxQ6k7xl
         FT37yTsF9i5F9+SUI1yXgxJtMDc0HOSgl/yV7pcv5JzK5wVGM09J3Vy/gOQj7lkQkTLm
         5hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7oiC8SooGTBNmfjgs5+8ZBlYcd/H6W2Nr9cpswljXc=;
        b=ExnktkXWb0nK764DiUlDnkyvI2sBDWY0WGK7C3GvjLjhvXS2GI/XIBY3Z3TkPP5h/Y
         hF2EbLIU1/gItNaAhFcwmtY9n0M4xdqkSYzN3CEoM5PlyCYWKMcwAz1Awb3nC2JWZ4Nf
         4KdbiOyK0I9UNelY7LRZIsksRkSlLjqI189m8j62PnOg6cO+OD4VydeZYIQyjExLOEZ0
         XMKciSXkHN7p6/6h8AxUcH/gwFUBKARRY9G01N1qUDpk8Qvc4o5oD/z/iEU0bzlcFbnw
         bmqvAIEK65PpZZyGI064UJcJHAUvBxVo5yjMXNv5CbAMskn+PBAwwINoCiY1ajp7woiM
         24GQ==
X-Gm-Message-State: ANhLgQ3Ui+6YR/9luxJy2NMusD4eY9XhwPHTTJZii9yZ9YVMA+hv07ku
        Qa49QH2d7Kw38ZLvsItYYXpT2+NvfTLqPmuKy0U=
X-Google-Smtp-Source: ADFU+vs+eY5U0hOnl2WAeb60+Z8B/QIH8gxARf6bNQlHXRK4P5UkwoSXExsjUbM20QznJ6In3AWdBD79/SpDuYXJjZE=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr1700117otl.110.1583200050663;
 Mon, 02 Mar 2020 17:47:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
 <pull.559.v2.git.1582759438.gitgitgadget@gmail.com> <c40207a3928f9cbc490b9ef2e99e7cba7788e7c0.1582759438.git.gitgitgadget@gmail.com>
 <xmqqblpjg8mf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblpjg8mf.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Jorge_A_L=C3=B3pez_Silva?= <jalopezsilva@gmail.com>
Date:   Mon, 2 Mar 2020 17:47:19 -0800
Message-ID: <CAJyLMU8-OUvOoP1hvgu4PC8iO7oynrvo2CW94HL-neu4RcZ=Ew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] config: documentation for HTTPS proxy client cert.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jorge Lopez Silva via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks, this should be part of the previous patch, as it was that
> commit, not this one, that adds 4 options ;-)

Haha, yeah, you're right. I'll collapse the commits into a single one.

>  I think these files not merely "indicate" but they themselves
> "hold", "contain" and/or "store" the certificate and key.  Perhaps
> more like...
>         The pathname of a file that stores a client certificate to ...
> Also, it is customary to camelCase the configuration variable names.
> As I understand http.proxykey is roughly corresponds to existing
> http.sslKey (the former is for proxy, the latter is for the target
> host), I'd expect these two to be spelled http.proxySSLCert and
> http.proxySSLKey respectively (without omitting "SSL", as that is
> the underlying cURL option name if I am reading the code in 1/2
> correctly).

Good point. Better descriptions and names will be added.

> It is possible that the answer to these questions are the same---an
> on-disk password is a bad idea, so we deliberately omit a config
> that gives value to CURLOPT_KEYPASSWD and instead use the credential
> subsystem (see http.c::has_cert_password() and its caller).  If so,
> I think it would be prudent to follow the same pattern if possible?


Excellent point. Will adjust to re-use the same pattern.


On Thu, Feb 27, 2020 at 10:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Jorge Lopez Silva <jalopezsilva@gmail.com>
> >
> > The commit adds 4 options, client cert, key, key password and CA info.
> > The CA info can be used to specify a different CA path to validate the
> > HTTPS proxy cert.
> >
> > Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
> > ---
>
> Thanks, this should be part of the previous patch, as it was that
> commit, not this one, that adds 4 options ;-)
>
> > +http.proxycert::
> > +     File indicating a client certificate to use to authenticate with an HTTPS proxy.
> > +
> > +http.proxykey::
> > +     File indicating a private key to use to authenticate with an HTTPS proxy.
>
> I think these files not merely "indicate" but they themselves
> "hold", "contain" and/or "store" the certificate and key.  Perhaps
> more like...
>
>         The pathname of a file that stores a client certificate to ...
>
> Also, it is customary to camelCase the configuration variable names.
> As I understand http.proxykey is roughly corresponds to existing
> http.sslKey (the former is for proxy, the latter is for the target
> host), I'd expect these two to be spelled http.proxySSLCert and
> http.proxySSLKey respectively (without omitting "SSL", as that is
> the underlying cURL option name if I am reading the code in 1/2
> correctly).
>
> > +http.proxykeypass::
> > +     When communicating to the proxy using TLS (using an HTTPS proxy), use this
> > +     option along `http.proxykey` to indicate a password for the key.
>
> And this would be "http.proxyKeyPasswd" for the same two reasons.
>
> There are a couple of curious things, though:
>
>  * Is it a good idea to use a keyfile that is encrypted, but leave
>    the encryption password on disk in the configuration file to
>    begin with?
>
>  * This teaches our system about PROXY_KEYPASSWD that protects
>    PROXY_SSLKEY, but why isn't there a similar configuration
>    variable for CURLOPT_KEYPASSWD that protects CURLOPT_SSLKEY?
>
> It is possible that the answer to these questions are the same---an
> on-disk password is a bad idea, so we deliberately omit a config
> that gives value to CURLOPT_KEYPASSWD and instead use the credential
> subsystem (see http.c::has_cert_password() and its caller).  If so,
> I think it would be prudent to follow the same pattern if possible?
>
> > +http.proxycainfo::
> > +     File containing the certificates to verify the proxy with when using an HTTPS
> > +     proxy.
> > +
> >  http.emptyAuth::
> >       Attempt authentication without seeking a username or password.  This
> >       can be used to attempt GSS-Negotiate authentication without specifying
