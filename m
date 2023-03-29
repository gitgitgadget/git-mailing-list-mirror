Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B906DC77B61
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 19:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjC2TWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjC2TWl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 15:22:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520555260
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 12:22:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h11so14616797lfu.8
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680117754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzO34ASFQZF/0JzovKovIQw7N3ZxzZC056t7CrlLc3Y=;
        b=auc91xGXJH33XNWtI7ljBaPUwllHQKxmI5XCXfnP7Jg9VlO5fZzzMnRPvrUwFdYxI1
         NgT5TFzxMjVeFYB8ZfudD3Sy7P5WvYdRh4ATAyYTYeiECbaNkgc66+CseKVcbXzaqpfh
         Sdl46wNa7tnNPDKSpCsBhUwSKYA97AP9OjzTP8lBJgb6YX5s/CGSfAY0SqJ8u/2jnQHG
         OKcpnmgxefZRQGdPlDsTvCNZ50Wd1gxyZadXUuRjd1Jl7pY2WUJa6x+EU0RK6wWJdKp9
         IgqRsq0E7f2up0o+RhIVpQmTwo3+ZMeZuGgv6VQWZkMGP5cbCHyf6KtqcZ/X1IAB8maM
         dvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzO34ASFQZF/0JzovKovIQw7N3ZxzZC056t7CrlLc3Y=;
        b=5VK4hL/8+shZjF5KBAz2JCZ+9/9QqVVBmG/5JbKB6O5H2qHB6KqdLNy+81qsVuHY5f
         46Bw/vap7TMprzH/yfXnIMI3qiBPxPg/UrGCyu2h78YJcKs1A73JLZnfLckQAyWNKdwE
         ii++9TfP1jpY7/4zHhMSmMBvuAIiGDIIisDwlJwyoFBOrahAwpx6ZaQu48XmBpy8xzlK
         uR9BlNvxDmCx2Zu3/lU76Rda4ENvMUpfhFYIhXCQe5Nar9COfAhhiOwYRpYmbmMp2eLQ
         OWzvHwO+mnOJCknj72N8uuzYQkqoX4/RtvqKk8b70WY+FcEfJ0UqjN45VaEgV0Po0+6Y
         nuBw==
X-Gm-Message-State: AAQBX9cYihMuj0hLn5CdTDK1MIPj3gY8PmPcCrHD5EyTx4aqexFiGmyJ
        OW4nDxcUSLG8ewyxvllHQhM8XTYk9gEJGsIY+mA=
X-Google-Smtp-Source: AKy350YCCrJLydJbsJ3i/jxdqP51XDmXLCkC1P5L9cyp9G+uTPRYBW2XlWfiuURyxvdS0hlj2zC9M9uSI79qwMlFVTo=
X-Received: by 2002:a19:5518:0:b0:4dd:a9e5:aa09 with SMTP id
 n24-20020a195518000000b004dda9e5aa09mr5936748lfe.11.1680117754386; Wed, 29
 Mar 2023 12:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
 <xmqqlejrmj4y.fsf@gitster.g> <20230321172223.GA3119834@coredump.intra.peff.net>
 <xmqqjzzahufj.fsf@gitster.g> <CAEpdKf=pMcMn6q0wGGcrFN1yi1duguSNLDkqhDmvMBeKQ--yuA@mail.gmail.com>
 <20230323180159.GA1015351@coredump.intra.peff.net> <CAEpdKfm0S4tkLz8DMnkJmhMmJk8Cj1tUm7NbMe7kpATq0bkxCw@mail.gmail.com>
 <xmqqfs9n9yp4.fsf@gitster.g>
In-Reply-To: <xmqqfs9n9yp4.fsf@gitster.g>
From:   Stanislav M <stanislav.malishevskiy@gmail.com>
Date:   Wed, 29 Mar 2023 22:22:22 +0300
Message-ID: <CAEpdKfnewLsUA37V1-mAW9T+LB1g-PkgjCHY1pxjsff+otZa-A@mail.gmail.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey types.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Stanislav Malishevskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes. If you set bogus strings  in the environment cURL should return
an error the same as if you set the wrong file for certificate or key.

So you can set

GIT_SSL_CERT=3Dsome_real_pem_file  - That should work (PEM type used by def=
ault)

GIT_SSL_CERT=3Dsome_real_pem_file  GIT_SSL_CERT_TYPE=3DPEM - That should wo=
rk too

GIT_SSL_CERT=3Dsome_real_pem_file  GIT_SSL_CERT_TYPE=3DBogus - That shouldn=
't work

GIT_SSL_CERT=3Dsome_real_der_file  GIT_SSL_CERT_TYPE=3DDER - I am not sure
about that, because as I far remember there issue with DER in openssl

I think that more detailed information there:
https://curl.se/libcurl/c/CURLOPT_SSLKEYTYPE.html

Basically that only a format of cert and key file or engine in case of
pkcs11 url instead of file in others cases.

So if you set it into right values, respect your ssl cert and ssl key
- https should work. But if not, error from curl should returned

=D1=81=D1=80, 29 =D0=BC=D0=B0=D1=80. 2023=E2=80=AF=D0=B3. =D0=B2 21:53, Jun=
io C Hamano <gitster@pobox.com>:
>
> Stanislav M <stanislav.malishevskiy@gmail.com> writes:
>
> [administrivia: do not top-post]
>
> >> Yes, but I'm not sure if there is a way for Git to trigger curl to loo=
k
> >> at the certificate that does not involve feeding it an https URL (and =
we
> >> want a valid one, because we want to see that it correctly speaks to t=
he
> >> server).
> > ...
> > In my opinion they need the same set of tests which is used as usual
> > for https. But use the right certificate and key.
> > But I don't have any idea how to do that with hardware usb eToken in my=
 case.
>
> OK, so where does this put us, with respect to the change?  We have
> some behaviour change that we do not know how to test?  How would we
> know when we break it in the future?  It is not like the new feature
> is not useful enough that nobody would care if it gets broken by
> accident or anything like that, so...?
>
> At least perhaps we can throw bogus strings in the environment and
> make sure cURL library gives complaints, or something?
>
> Thanks.
