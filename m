Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5291C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B10560FE6
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhFOS7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhFOS7r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 14:59:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2424C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:57:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d7so4452988edx.0
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=N0MTVqTmDwurLuGeS44APh5yr8hznz5pGuJRkUu5DMY=;
        b=AwSytCb1GTrmCtshC0JfpQzN0NHcXz+OcnZmBNF8NEVEyokk4JTwy+pnGcX9/bkvzo
         sEA+05W504lf/CXnIiUHJURVdpjuLrDXBtFpwLXdB7WpYh7P5U2I7mTJ9hr1WoKdavVI
         QHTcxISmOerPLGb41v9avMVfHV798RN/vIQyuBeUIJNMf3wfTLuDp1bIEoxOkWQ+c/Ld
         5w9b6ITA8+S5+btJAurXOD8bDYktVdPNf1k8MKKjsST6Y+JcMvB+esQWkizMxyCLiwdw
         qrGuwfDENgFn+Hr/f2QJN6HV6RptYB5N8uVoquLHmz8xbzkwkh9uS9rC4IH4cPG6Xrqx
         XtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=N0MTVqTmDwurLuGeS44APh5yr8hznz5pGuJRkUu5DMY=;
        b=d7ya5+Ekxaa0TmfiGgTLTxzBA1tXDwJab8xvNfDqLRgudKI92bVuR/vuPKJYOFwjMw
         e4bqaKph21/Mzm1Iplg9Z5E4WBIEK9i8XM6yQZ6QIiho8kVJtvKxNB7MuHklj4UN6ij2
         7G7tUybGFGSoOdNvrsKF2WcuaZnSFthfY9ObSHqjH+hBNrkramxg1hT1u//e7m6L7W6+
         YVAijzB2VuFExVuLcjc5tSzDWGw5DepD6p8Q74WCfyPD2yGorQIhN9p/AZDZFZWppXea
         xAbFsZGepOeA2VNiDLpF1DfOZkysLodvis1lM0eCU5fwkN/IYJ6g2vvUJTtsp6aKXkkH
         HZkw==
X-Gm-Message-State: AOAM533LK8Xfo0LsseoUbN9XpSwt+jBTqOc9CKmVVg1duk4kkbdiRLlA
        Gmri/G8Vou+RCPuE2xu4hLM=
X-Google-Smtp-Source: ABdhPJxzlYUZ69sjQNhAiU2VOdoVszdchV/wB12lNLRaRlURiAKhlQXZNFzwor6xMH+0ytwFnabdzg==
X-Received: by 2002:aa7:d344:: with SMTP id m4mr1230764edr.281.1623783460219;
        Tue, 15 Jun 2021 11:57:40 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f10sm12757434edx.60.2021.06.15.11.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:57:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
Date:   Tue, 15 Jun 2021 20:45:33 +0200
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <18b53cae-6da9-c970-b994-caee11c5baf9@crashcourse.ca>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <18b53cae-6da9-c970-b994-caee11c5baf9@crashcourse.ca>
Message-ID: <874kdzymzh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Robert P. J. Day wrote:

> On Tue, 15 Jun 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I suggested in [1] that the "alice" and "bob" examples in our
>> documentation would be better written without a reference to such
>> fictional characters, for reasons that have nothing to do with trying
>> to bend over backwards to avoid any reference to people's gender. It
>> just makes for better documentation.
>
>   no, it doesn't ... and wikipedia explains it nicely:

It doesn't make for better documentation? Maybe not, but can you comment
on specific parts of the changes in this series that make it worse?

> https://en.wikipedia.org/wiki/Alice_and_Bob
>
> "In cryptography, Alice and Bob are fictional characters commonly used
> as placeholders in discussions about cryptographic protocols or
> systems, and in other science and engineering literature where there
> are several participants in a thought experiment. The Alice and Bob
> characters were invented by Ron Rivest, Adi Shamir, and Leonard
> Adleman in their 1978 paper "A Method for Obtaining Digital Signatures
> and Public-key Cryptosystems".[1] Subsequently, they have become
> common archetypes in many scientific and engineering fields, such as
> quantum cryptography, game theory and physics.[2] As the use of Alice
> and Bob became more widespread, additional characters were added,
> sometimes each with a particular meaning. These characters do not have
> to refer to humans; they refer to generic agents which might be
> different computers or even different programs running on a single
> computer."
>
>   if you want to make the docs better, have at it, but please don't do
> something as meaningless as replacing "bob" and "alice" because you're
> feeling politically correct, or woke, or whatever the hell the kids
> call it these days.
>
>   jesus ...

I believe that the commit message of 1/6 addresses the point you're
raising here:
http://lore.kernel.org/git/patch-1.6-abbb5b9ba13-20210615T161330Z-avarab@gm=
ail.com
