Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CCDC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C3E613D9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFJOWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:22:22 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37684 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFJOWW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:22:22 -0400
Received: by mail-ot1-f50.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso4637074otj.4
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vsWZB0pNVvdt3T1nQ7zVHmEd5NHtUHpnPCoubbHEDT8=;
        b=Si24KmkDQ6LLptreT3BDP08ye6LEou/dvAb90Opnxae3fp7MwM62CvC6uiEOkt/5uy
         M8MNQKbgET54vP4qGDfEfZwEXUB8kOPIXTXrioNuoD507JSBgk/dNYf9mVdEO0zsaZ8L
         coHz9ILc1v+pW/iOO564uLu3crKcMJIuq2clyVSdarr6LPEAIvcgJF9Y8/HIW+dyJrau
         vq7DhtfiiixbRlFA812NuwcXR8/vdXXurAJtr6rb/4+DxJtimyoci7d25S5dgSrAI5Im
         g6+vXp/glzRA+mQKMX1chHblyd0Z7UA3DYAr0Yts21AxvabLuPIa2nrjMIdAzQFAtIgu
         zVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vsWZB0pNVvdt3T1nQ7zVHmEd5NHtUHpnPCoubbHEDT8=;
        b=Z5ReRbkfb9aRXlrTeqNItM3zBRTyGtQYDNx2v4hKSzgaQlI3yeCeLIhRRMaysHsDY8
         eksubxmbW75wMbO/QBUtrMEKo54YR1Ry7UnoDqNrBGbsVTe58KtsjMxp9j46e7VDA8Xo
         xoPzrZz9yd+RhG6WzBbcBgWtfoNz22ynQT8X/UXQ80ylBxjP3cPHhOuCxo6hTC+oU8M7
         4uu6RyCzyA8/bCMHyqC8kq2cS8LsBhjyMFWlQDHlLdJJuk9pAjQPbKmXssYHFqT3cfdD
         ikuWiB3lAaltE0/D/J3zHJzsmgLQcwgjj11dJGYHsXU6BFKIc1B6PIYk49CI0SEoi/Yb
         l84Q==
X-Gm-Message-State: AOAM530PWdx9OuTJ0J5eGK2+OlGnlg0svL7yoD1nQGu8O2qFHIe0C9io
        R0QkIEf4Ol2xqkzjOrJ157Y=
X-Google-Smtp-Source: ABdhPJxu9kgCzN/zuKlGx91Fwicy9ODewadOy+PMwic0MqilbIPDkmQnpYpDCbE6VQOL4i3fOEx0ZA==
X-Received: by 2002:a05:6830:25d4:: with SMTP id d20mr2703363otu.83.1623334752325;
        Thu, 10 Jun 2021 07:19:12 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u11sm530480oot.41.2021.06.10.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:19:11 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:19:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60c21f5eb4c62_b25b1208ae@natae.notmuch>
In-Reply-To: <bddfe587-704c-a7b2-1182-246226aa09ba@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <bddfe587-704c-a7b2-1182-246226aa09ba@gmail.com>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 09/06/2021 20:28, Felipe Contreras wrote:
> > Virtually everyone is using it, and it's one of the first things we
> > teach newcomers in order to resolve conflicts efficiently.
> 
> Given there are millions of users I'm not sure how you established that 
> virtually everyone is using it.

Because it's the stablished consensus that resolving conflicts with
merge.conflictstyle=merge is suboptimal.

Even if it's not the majority using it (say 49%), the majority would
benefit from using it.

> I think that while this change would be useful to some users (though
> not many if virtually everyone already has it set) it has the
> potential to annoy a lot of users who are happy with the existing
> default.

Every change has the potential to annoy some users.

That's an argument against further development of git, not this
particular patch.

> I do not think that it is a positive change over all.

OK. Others disagree.

> Had the default been diff3 from early on in git's history then I would 
> not advocate changing it to the current default but I think the time has 
> passed when it can be changed without inconveniencing existing users.

git has changed defaults in the past, and it will change defaults in the
future.

There will always be people pushing back against progress, and that is
good. But progress happens regardless.

Cheers.

-- 
Felipe Contreras
