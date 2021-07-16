Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F82AC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B57C60230
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhGPVRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 17:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhGPVRI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 17:17:08 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798CDC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 14:14:12 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c197so12441705oib.11
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=bwYp734sLrdd/ABvC5j0u8q2IKxPK47H7+Ftd2Ah8Pg=;
        b=PogBIqbJITO3WXo2JmwTqf2I7U47LoERmaRe0tZjMFeoptMHv5qu1FVIOtaoJDe/XO
         JKY16VJfDNUqB6Mc3KB8VTMMqblE/fcjOYpOnEhPQsDfGpztUPriFyAtQNFsI+Suo1ZC
         6ReMVhz2es24EN9w7NP/5oPsH9JmWmV1p02GVwb98Sg1kRH8wbPiAhkxEH5SheuU68O9
         dslzuEcLD//DIwYYmwqoEiE7dafDjs8UgPGifnLxHqR7LIywXn+t96ASD/xp3zk8e1Uy
         T3yY7YCSbAoQ1oejQVzJLo3P1P1uI3uH8MoRrCZ8McUn+rTKflIBt/BiDvFVI3wx5X/+
         avKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=bwYp734sLrdd/ABvC5j0u8q2IKxPK47H7+Ftd2Ah8Pg=;
        b=r6dFuUiyCCz/+bRbS8OYW6CXd5nfv54c64cM5GHsOS9bLglAtbYgTqLZtpyLuOlDuS
         mY3fe2XSqMDRX4y6nnb/Rlwl8BT4OPbSKBES6txbC4jyV+fK3JDKw1yYCGihG1IC/ZNs
         oEdszIA1Y0MpGHxZsegD8K3XJfrWGHLWjCtbQ1tf1LgkZRTEjJuq762xfv6EgRA3GJbM
         uEjyr4esC4ILJicxrdSfd5NsQaOnziu182lCmagS6jZa4k78Y5DtNr/kshXS3zspgyJw
         LuukYXvUqQDzB8dkC5nzIrgsMUXZeQIXEVTWvAEAawu2bhyWuYHenqCXY2uVgC62oiAQ
         zn1w==
X-Gm-Message-State: AOAM531mLHtMkFgy1FDc8doTv5jUt0DxCT3O+zqVDHTo2EWvODNVA/4k
        yEqxk3ml3GGrEHXDVIKdglk=
X-Google-Smtp-Source: ABdhPJwSg7AYavs/YksVv/4Mpiz8j+uE9qxhTN6kDfgowhpKCaKbBGCp3g3FH6jo6fBI8CZGsMPMQA==
X-Received: by 2002:aca:3204:: with SMTP id y4mr9414812oiy.112.1626470051932;
        Fri, 16 Jul 2021 14:14:11 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 59sm2145455otp.68.2021.07.16.14.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 14:14:11 -0700 (PDT)
Date:   Fri, 16 Jul 2021 16:14:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60f1f6a22dc08_14cb20856@natae.notmuch>
In-Reply-To: <xmqqr1fyqbre.fsf@gitster.g>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
 <87czrl0wob.fsf@evledraar.gmail.com>
 <xmqqk0lrtuh4.fsf_-_@gitster.g>
 <xmqqv95aqeyh.fsf_-_@gitster.g>
 <87pmvivz8j.fsf@evledraar.gmail.com>
 <xmqqr1fyqbre.fsf@gitster.g>
Subject: Re: [PATCH v2] CodingGuidelines: recommend gender-neutral description
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> =

> > I'd be happy to re-arrange this, if I could only get the submitter of=

> > the series to respond to my E-Mails...
> =

> I'll do this only once to add missing but intended recipient to the
> to: line; you are both adults, don't assume malice but instead good
> intentions and talk to each other.

That's ironic, given that you don't talk to me, which is BTW against the
code of conduct:

 * Being respectful of differing opinions, viewpoints, and experiences

You clearly do not respect my differing opinions.

It's not about being adults, it's about being *tolerant* about other
people's opinions (I still insist "respect" is the wrong term).

Cheers.

-- =

Felipe Contreras=
