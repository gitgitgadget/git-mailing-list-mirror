Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111FC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 09:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6002061921
	for <git@archiver.kernel.org>; Tue, 11 May 2021 09:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhEKJGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 05:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhEKJGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 05:06:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B6AC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 02:04:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l14so19330020wrx.5
        for <git@vger.kernel.org>; Tue, 11 May 2021 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=P7aGPITgrqxJdR3DOtribumiz73x7neCou28UUSKQ8I=;
        b=ZDhDVrAIi9EodXwvbotoKYiOhZofaVEPdy4bE21pBeaEBY21LcHqmBoTnxs5IGBm3X
         ZZxCwDwiVPanImwusxDBFUTYNiuch0/w/sjBpOMq4Ns7k/EBXTp0lWygW/Q+8sB+x48P
         scYb+kn6ts4v/6ZE8X4xcJGm5d4oD7nWOX8wittwdA9OJPeSZFL309Dgw05O591cAP4X
         CAlmY6wckewWEQQ2XDwNm0M85R4rIXzXkVwBe2Bisqx82Vr71tITYeWxp2YhXE2RYX46
         Ha760Q1PzLkhRTS5e4N9vKg8iI2BHSbvN6b4kzSKhGT677bhp43372e8nnncbMtZfPER
         yRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P7aGPITgrqxJdR3DOtribumiz73x7neCou28UUSKQ8I=;
        b=T5Yvcmw9q9wwLOPfal6XakkFehYBXhSi84ATOLOeg0kPPnix7K5k35G/r+9bEJhSs8
         RY6sBc6t7oFwJ85n/Jem1/aoAOZ18Zk+NtfH7DabDHktx1zETuSIV8C3jgks9FQz9kiO
         7AYkfg+HlDhocCHR0m2g6dAXZ4yIO/aNnNvTTx0NUb1OQaU6T07ejv2Asx2KPSP0FiUl
         6egqDCAkENexuaS0W/J+gRzpRWYHdfMsIDpbVvEFauRJ+q+A51sd02gAkt6iAlTXJU4W
         3Ta2nAU6/MHTwj7oLeoHJL95RzThl1NBtt5eCmdXZ5ANF3gqpvKWlg8KitoV8UxYH4OJ
         X3XQ==
X-Gm-Message-State: AOAM533TrxiZO07vDOhNW221m7NOZ63Qdnp4zxpD0Tb+fKOKFkvidbpv
        7H9Ik11mXwM/100XO0KL+a1DGkfaxKKTgQ==
X-Google-Smtp-Source: ABdhPJwt7LzL/eaNE8VESGWbDVyulrU0Et3E3UuQsISNMfCrjhOxp4LLjAJAUnzV24JYGqTgpo8DuQ==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr36007123wrt.365.1620723892381;
        Tue, 11 May 2021 02:04:52 -0700 (PDT)
Received: from [192.168.3.105] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id e12sm1080135wrm.80.2021.05.11.02.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 02:04:51 -0700 (PDT)
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Message-ID: <0fd3182c-3805-ee1b-5a35-e0c9a67892ab@gmail.com>
Date:   Tue, 11 May 2021 11:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/05/2021 at 10:20, Martin Ågren wrote :
>
> I tend to think asciidoctor even renders our manpages *better* than
> asciidoc does. Not by a huge margin, but a few things here and there.
> Some time around the Python 2 EOL, I was about to propose flipping the
> default, but then I went to look up the asciidoc EOL schedule, and like
> you, I noticed that it was a lot more alive and kicking than I thought
> it was. So it's not so much "we should flip to avoid a bitrotting
> dependency" as it is "asciidoctor is arguably nicer" or "it's the way
> forward".

If we start to change the documentation format to "the way  forward", we
may soon end up with a format which is no longer handled by the legacy
asciidoc.py

As stated on https://github.com/asciidoc-py/asciidoc-py :

"AsciiDoc.py is a legacy processor for this syntax, handling an older
rendition of AsciiDoc. As such, this will not properly handle the
current AsciiDoc specification. It is suggested that unless you
specifically require the AsciiDoc.py toolchain, you should find a
processor that handles the modern AsciiDoc syntax."


So, as soon as the asciidoc format formal specification will gain
traction in the public, we can expect asciidoc to be abandoned for new
projects and receive minimal maintenance only for compatibility with
legacy documentation.

One argument in favor of Asciidoctor is that it's delivered "with
batteries", meaning that you can generate manpages, html and even pdf
with the same tool, without requiring secondary or even tertiary
toolchains, which should ease usage on a broader range of platforms.

FWIW, we are already using Asciidoctor for publishing the manpages to
https://git-scm.com

JN


