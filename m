Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B751C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 18:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCTSa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjCTS36 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 14:29:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3829ED7
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:22:38 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g18so13122854ljl.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSY1TVzqO0JkF5elDdngTbA4hcXJOVdwNr160zl59qk=;
        b=obEQHuS5d3CJE0+sOX52UEt6FoImQKslkoojCzD3epqAGVg7GLid0qn7SQv/iyRgJF
         U9fjIFVFYZ6X0/00OCIpsOBwjybuJZS9g0joYO28uf7ovW8pzObnOUgA2VG/2XPdTVVq
         5zoY+nWryoifxFQ/Rlnmu0/gT1Mfc6nkfdPsau+9IwvTB8RHclQFaLIk00mffqh4XobI
         unmT0P+/Ch5uWs5CFrt8WxanIGSFuo1eAxIBupeqEis8sHKITecEerydHPNUIvQosOp7
         Gc8p6rCrRkL9WEd5e2TAw3l1Gtb4CfHqYv2tb/S1FsHI2qvpn/XIOXWGpHlGEN9+M8Q3
         e+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSY1TVzqO0JkF5elDdngTbA4hcXJOVdwNr160zl59qk=;
        b=TJVXac5VINeONGMnZYT9qNBYniyGNNWi9EtgR4anWL4FKNU0VLCFHNlc/CCDbgkPIZ
         rAXaQpmf1WU9YJT7AxR7iaVb5/drUawIl64qT6SKkP+TSeatQH66DM14fnS2Rdz9p/xF
         0YIDttR4094EIfsoN98wMu1iXr6Vo/rmjsQebsJpc7sBATvZ3FlBNn2hWau7SIXP94kn
         qdMWtMBPk+ZBphaDcbFtF4NIfTXlDejMhctKhzk3XY6AnSEfPfGxnBfmlqxursD7hR9O
         KFGSUSFTH+aT1brqDjzp6dd0TXxH/pA2ZvuHV8mPEB0+eSgavHKqTfN6moZzlXB9uHiR
         Bxrg==
X-Gm-Message-State: AO0yUKVOlvmjUQLvcoyZq94O4mP1gt6ahY2I5GB4HpecszB1JQKExZXa
        PaqCb3P7P6KN6fGVw7ecUgX7ydkIJg2xL3/bHmA=
X-Google-Smtp-Source: AK7set9qaE6c5A8NkkR9kMr/oRrq3b8X56aAk2U5piUhY1LfgxzsjEuS6PaUTedP+jez5b4smYrPO8Im+EXPTW1s5Cw=
X-Received: by 2002:a2e:740d:0:b0:299:ac1c:d8b3 with SMTP id
 p13-20020a2e740d000000b00299ac1cd8b3mr40673ljc.9.1679336515487; Mon, 20 Mar
 2023 11:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com> <20230320171051.GA2615782@coredump.intra.peff.net>
In-Reply-To: <20230320171051.GA2615782@coredump.intra.peff.net>
From:   Stanislav M <stanislav.malishevskiy@gmail.com>
Date:   Mon, 20 Mar 2023 21:21:44 +0300
Message-ID: <CAEpdKf=THU=sc3S3W4azBmYp7+J945GxFqhh_i-5kV0kunMdNw@mail.gmail.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey types.
To:     Jeff King <peff@peff.net>
Cc:     Stanislav Malishevskiy via GitGitGadget <gitgitgadget@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -1014,10 +1020,14 @@ static CURL *get_curl_handle(void)
> >
> >       if (ssl_cert)
> >               curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
> > +     if (ssl_cert_type)
> > +             curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_cert_ty=
pe);
>
> We're just feeding curl whatever string the user gave us (which is good,
> since we don't know which ones are valid). But what happens with:
>
>   GIT_SSL_CERT_TYPE=3Dbogus git fetch ...
>
> Should we check for an error here, or will the actual request later
> complain properly?


Curl itself validates that string. And if we pass the wrong type or
not pass 'ENG' in case of pkcs11: curl will return an error. In that
case git do the same if GIT_SSL_CERT passed wrong ss 'ENG' in case of
pkcs11: curl will return an error. In that case git do the same if
GIT_SSL_CERT passed wrong


=D0=BF=D0=BD, 20 =D0=BC=D0=B0=D1=80. 2023=E2=80=AF=D0=B3. =D0=B2 20:10, Jef=
f King <peff@peff.net>:
>
> On Mon, Mar 20, 2023 at 03:48:49PM +0000, Stanislav Malishevskiy via GitG=
itGadget wrote:
>
> > From: Stanislav Malishevskiy <s.malishevskiy@auriga.com>
> >
> > Basically git work with default curl ssl type - PEM. But for support
> > eTokens like SafeNet tokens via pksc11 need setup 'ENG' as sslcert type
> > and as sslkey type. So there added additional options for http to make
> > that possible.
>
> Seems like a reasonable thing to want, and the patch looks pretty clean.
> Two small points:
>
> >  http.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
>
> There are no tests here. I think it might be possible to add them, but
> our https test support is currently optional, and has bit-rotted a bit
> over the years. There's some discussion here:
>
>   https://lore.kernel.org/git/Y9s7vyHKXP+TQPRm@pobox.com/
>
> So I don't think it makes sense to block this patch over the lack of
> tests, but it's something we might keep in mind to add if the test
> situation improves.
>
> > @@ -1014,10 +1020,14 @@ static CURL *get_curl_handle(void)
> >
> >       if (ssl_cert)
> >               curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
> > +     if (ssl_cert_type)
> > +             curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_cert_ty=
pe);
>
> We're just feeding curl whatever string the user gave us (which is good,
> since we don't know which ones are valid). But what happens with:
>
>   GIT_SSL_CERT_TYPE=3Dbogus git fetch ...
>
> Should we check for an error here, or will the actual request later
> complain properly?
>
> -Peff
