Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD372C4332D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 00:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6667B64F91
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 00:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCQApp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 20:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhCQApP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 20:45:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD85AC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 17:45:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 20so327312lfj.13
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 17:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZH9pXF6+3ttMx69S6FLSrGXaan8vmCyGzs3SSGTsVpA=;
        b=IuIugct1t/rTvZQ6vueQV/UGLUzdOccJoq8b+6U1yCW1ugKochS/sXiSXm2fBPqZoA
         7RatxGj+PHiImSBZuRUU+rNinomziyLtRbHErCNy2MbXqVXAl/M1zQP8cC5MsZPg4zXV
         Zy34CyjeKikacFkaB/ftwzcKCfded4jrYkgZW4NeGjUSDiHCSHS3T2l8HjHwraeKCrG+
         MQKty7EmhJuu/u5E/aC0FaBdyQQS/eyeNBEjMH6GHCJXSasILzOssVn8uf0arfpIbb0P
         7q9F87vtu2gyjuuaWsbwFdMK9O2t6MCoPG+08MKIENSxX7RHCiWagOh/eTyQ1MiiALxM
         L25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ZH9pXF6+3ttMx69S6FLSrGXaan8vmCyGzs3SSGTsVpA=;
        b=GdhdOHY6tn3EmwayAJHCi4X7ktcei7EQI01b7ZxCaryHxPXoxKm7lb6TGgKsUKRoBs
         62fAtVqvJpA7wUg0Uje62whfSB6jMt/9b2dHkMHpdM18Jy2vGlUDM2yZ2WyYcuJ7X2JA
         Eqb/YsMx1AG/6I4YerQm8OFt7S/T82IeUSh8T0nMgJe9itDIF58GkTZmOeLIP7d1y52G
         nkhGmbv6k7u+sLCmF4RE5p9K9QUW1tjRrCBIdeNrJDHeDbeNnM/feEf5cDpxZsxc+5TE
         IUKMZmfNtobarPFabtl7HjNZM7Ve48Veq8TZe3Khj+mYW+f6PPrJgd62uAYtVdPHTpvR
         6kfg==
X-Gm-Message-State: AOAM530f9dQmEx9jri5jjZu4v32WWSK29VO6OpDnxezhLV60t12uM3s2
        3Mdn/GtA0YSYQf7EcSL6FqE1pIiyJkUe0g==
X-Google-Smtp-Source: ABdhPJzKIfNmZ/41y+8DJejLi4hDfugiow2WfZ2OsQjIsgvqLMK7uQ41zZxPwd7ot1/gor7C23mNRw==
X-Received: by 2002:a19:ed0e:: with SMTP id y14mr802053lfy.440.1615941913104;
        Tue, 16 Mar 2021 17:45:13 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id w28sm3211448lfk.185.2021.03.16.17.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 17:45:11 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eli Schwartz" <eschwartz@archlinux.org>,
        "Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
        <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
        <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
        <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
        <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
        <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
        <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga>
Date:   Wed, 17 Mar 2021 01:45:09 +0100
In-Reply-To: <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga> (Drew DeVault's message of
        "Tue, 16 Mar 2021 10:21:13 -0400")
Message-ID: <85r1kewqui.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:
> On Tue Mar 16, 2021 at 7:54 AM EDT, brian m. carlson wrote:

>> I believe this construct is nonstandard. It is better to use standard
>> URL syntax when possible because it makes it much, much easier for
>> people to use standard tooling to parse and handle URLs. Such tooling
>> may have special cases for the HTTP syntax that it doesn't use in MAILTO
>> syntax, so it's important to pick something that works automatically.
>
> It is standard - RFC 3986 section 3.1 permits the + character in
> URI schemes. The use of protocol "composition", e.g. git+https, is a
> convention, but not a standard.

All right, that is true... but the Git itself and Git--related tools do
not usually employ the full-fledged URI parser, as far as I know.  They
just check for the few schemas they support if the repository location
is given as an URI / URL.

That said, if the RFC states it, then it is a standard construct.

>> So I'm very much opposed to adding, expanding, or giving any sort of
>> official blessing to this syntax, especially when there are perfectly
>> valid and equivalent schemes that are already blessed and registered
>> with IANA.
>
> This convention is blessed by the IANA, given that they have
> accepted protocol registrations which use this convention:
>
> https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml

Well, thara is a total of one protocol (CoAP) that uses '+' based
schemas, namely: coap+tcp, coap+ws, coaps+tcp, coaps+ws (well at least
out of those protocols that made it into IANA).

Though it in this case neither of those parts of schema joined by the
'+' sign is an application name...

>> It's difficult enough to handle parsing of SSH specifications and
>> distinguish them uniformly from Windows paths (think of an alias named
>> "c"), so I'd prefer we didn't add additional complexity to handle this
>> case.
>
> There's no additional complexity here: git remotes are URIs, and any
> implementation which parses them as such already deals with this case
> correctly. Any implementation which doesn't may face all kinds of
> problems as a consequence: SSH without a user specified, HTTPS with
> Basic auth in the URI username/password fields (or just the password,
> which is also allowed), and so on. Any sane and correct implementation
> is pulling in a URI parser here, and if not, I don't think it's fair for
> git to constrain itself in order to work around some other project's
> bugs.

The Git documentation explicitly enumerates all possible URL types that
you can use with Git.

On the other hand Git-related tools can support more types of URL, for
example ones for AWS S3 buckets.

>
>> Lest you think that only Git has to handle parsing these
>
> I don't, given that my argument stems from making it easier for
> third-party applications to deal with git URIs :)
>
>> Despite the fact that ssh+git is specified as deprecated, we had
>> people expect it to magically work and had to support it in Git LFS.
>
> Aye, people do expect it to work. The problem is not going to go away.

To reiterate, the idea of "prefixed URLs", that is using git+https://
and git+ssh:// is to denote that said URL is only usable by Git, without
any additional out-of-band information (like other attributes on <a>
element or its encompassing element)?

Best,
--
Jakub Nar=C4=99bski
