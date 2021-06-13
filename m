Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB8C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C58661107
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 17:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhFMRPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 13:15:34 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:41623 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhFMRPd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 13:15:33 -0400
Received: by mail-oi1-f177.google.com with SMTP id t40so11889051oiw.8
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=I6rIhvUkpM5JeDCHHAwVNlsx1QHrOtdL+9CXBr7nkoM=;
        b=HCWiDJYGTIAcFvAuC3iYcGomE6AbxE6+2o9Mn9uBk8nAlrYwibmKlUFU3PC/9jx5z9
         hdxPYiCf9SjkVLfE05IbPfvLD6SFCDVPEzB/vzfFYr1OE1qBJ9M8pf5UpXTjGVqIl8zo
         /Sb7+v7Vp+rDAf7pKjxkAiaK2BgYcYhDgoaRfEna+laKao5n6coEmTZVO1O4/4vj1ZkL
         OXYHSYos3LOURI5iImhZNklDWlovmYvcInXAE8Uz/D6xpPR+ddN8q8Ykv4bfLpXO5m30
         xOpgW2WXSgwo4U6GUQCM1NvztV2cad30FXFpIxcBqQS5D9NpdUQzkKJ4EF/g90nv42XA
         oaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=I6rIhvUkpM5JeDCHHAwVNlsx1QHrOtdL+9CXBr7nkoM=;
        b=OnDf34EY12iMu6AO8bbDHywYlDWCivFpANKoqWvqFmKjz6BcRK7/EwZUeJqxhIFiKn
         G7UIJeu8j2/CnhWCqQmSjaZIDEm4P7G4Jw/Zis+cPoHS/Zze7Tyw3YXnU12uEU/wzKKY
         fyIGAgBDGIPpmPTClpBCVsBYd1tcNKOeD4EPHgnz9uX2Yy+f9p+TK1aGe0iFdsqVB82H
         x6MIazCZS8EsOhzscQ6aFT3DGjlozIisugTIYnYJL7/o/QeenH8zP6UVj27Gh/p+5DAR
         PAGdQza2mb4rL2jBlrOTakhDPPDz3y16YFWO+0SSDlAFsQ9rNSe2a0seRnh7+nQSLYvT
         Zf1Q==
X-Gm-Message-State: AOAM532seuKMfe1eUo9kvKmt/1av8XEhz3phAT9AgOFA8XMYGHJkYbbh
        5fXgY7lTiyC+Bt10jdEyaNY=
X-Google-Smtp-Source: ABdhPJy2VRApJUz6wEYpFEaUCJJwollHnQFC1psykv7Lf1lFl6Mkqd9cgpAGHU7TTeHtTZR/wtSvyA==
X-Received: by 2002:aca:6207:: with SMTP id w7mr19697924oib.177.1623604338390;
        Sun, 13 Jun 2021 10:12:18 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id i5sm863560oov.21.2021.06.13.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 10:12:17 -0700 (PDT)
Date:   Sun, 13 Jun 2021 12:12:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>, git@vger.kernel.org
Message-ID: <60c63c70c7cbe_41f4520874@natae.notmuch>
In-Reply-To: <20210613162802.GG8544@kitsune.suse.cz>
References: <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
 <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
 <20210527114629.GD8544@kitsune.suse.cz>
 <60afa7d9d4ca_2056d208d9@natae.notmuch>
 <20210527143541.GH8544@kitsune.suse.cz>
 <CAD2i4DC0zH8WQvfZiHJA7f+DXubZjG6fKSuMbXdaztDC_PU4ZA@mail.gmail.com>
 <20210613114007.GF8544@kitsune.suse.cz>
 <60c610f04b288_41f2b208ce@natae.notmuch>
 <20210613162802.GG8544@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Sun, Jun 13, 2021 at 09:06:40AM -0500, Felipe Contreras wrote:
> > Michal Such=C3=A1nek wrote:

> > > We already received such reviews as response to your patch. It's no=
t
> > > what-if.
> > =

> > In case you haven't been following this thread closely, you are the o=
nly
> > person that says the use of "impact" is OK. One person said "impact" =
was
> =

> Apparently you have not followed this thread closely yourself.

I have. If you think you have, then list all the people that agree with
you that there's no problem with "impact" for the general population.

> > It's OK to merge patches where one person objects.
> =

> Apprantly you also missed that I am not opposed to the patch.

Good. So some people are in favor of the patch, and nobody is against
it.

-- =

Felipe Contreras=
