Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8D81F461
	for <e@80x24.org>; Wed, 17 Jul 2019 00:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfGQAmg (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 20:42:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37288 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfGQAmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 20:42:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so10994481plr.4
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H/XAAytDE81mEJgrihmmrxF90L4Og4JVu//n9qtcRtc=;
        b=BP+m2XB85afgv/GQTUD1pI0pMk13ZNS3kv1UbL86WI/rQ1gezBBnwZASlzv98SXa9N
         YIAbd753PrcRspKG4eVfh/DxtCN+pQqAJknxWFBVnNEBBi7qu+xNYB6NP7UvRMhNVN4v
         4Ft5RUsl5U7hbrpM4Xf76TznkjX0VU1Zu1mr7bCxtxaaSX0YoXUV0n+YafjcMN1VFg8U
         P5eJCQtXprICYTyuaoY/nry6QylqLvo7odv2lfqJ7uRc9TOXQEtri0XJx2ePZOBfemSS
         qm6NESM65fMQRcIlb0nusanzG2o5I6IRr5G4/5sJlT1/2YeVyZY3y4h5xtNQryTgtzwC
         FnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H/XAAytDE81mEJgrihmmrxF90L4Og4JVu//n9qtcRtc=;
        b=SMlDGAByg2epvWTdzriABLLPo0QC3jYFVqR/Pbkmk+REksfWhydvihs0sCMelcMqIY
         4xLRtTuJOVUnE9d0EAFbiAslm8eRwtGkvNnZOUSBOxQGoLa17b0g6EBvgqduhcCBX0Bb
         3rGAlaSaxbBme79JYBEYlxUICe5M59CiIu6qRlNT5igW/HfSw4s5iDcukgLqriCsneGW
         Ad+pRcSDGqR33zozlMoXuVQVDAbARvdCpKp/KkI0DfoxZrQI6XFI4PSueNc90BzgKAxJ
         tKIaGO2WVJ2JmK3jORotZsBzyan5MlRAR1KMc7odNK3hxABAuOIXJU+0ZHxPY4bS/ElU
         ek/Q==
X-Gm-Message-State: APjAAAUUx8QjbZLifpRHwOhlMjHc+MxQvkW2/95ad9JQ9RyrD15ShOfe
        0TkB60q5TtmeEEJVKmR81UQ=
X-Google-Smtp-Source: APXvYqz4vWabv4oTp+cIbAM9eLq9iJ6vnP7QpCFbNoQwvUycGJQ5MtwspLVmULRlKiwKx9onB4yKRA==
X-Received: by 2002:a17:902:9896:: with SMTP id s22mr37645235plp.4.1563324154975;
        Tue, 16 Jul 2019 17:42:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id x67sm24897675pfb.21.2019.07.16.17.42.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 17:42:34 -0700 (PDT)
Date:   Tue, 16 Jul 2019 17:42:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: avoid var decl in for () loop control
Message-ID: <20190717004231.GA93801@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com>
 <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
 <xmqq36j53esa.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq36j53esa.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> We do allow a few selected C99 constructs in our codebase these
> days, but this is not among them (yet).
>
> Reported-by: Carlo Arenas <carenas@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  transport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Yes, gcc 4.8 fails to build without this:

 transport.c:1234:4: error: ‘for’ loop initial declarations are only allowed in C99 mode
     for (struct ref *it = remote_refs; it; it = it->next)
     ^
 transport.c:1234:4: note: use option -std=c99 or -std=gnu99 to compile your code

Arguably it would be nice to use -std=gnu99 for better consistency
between gcc versions, but it's moot here: avoiding the declaration in
for loop initializer is more consistent with
-Wdeclaration-after-statement anyway.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.
