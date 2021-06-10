Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E7C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B8D60FF0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFJNfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFJNfq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:35:46 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277AC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:33:35 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h9so2127605oih.4
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=rKlERWmGWR2CVhRsyK6YmkjA62YthqlaCXWPCxuucXc=;
        b=Bnnfhe/W8smzky+eMnwcW5/JAgjpXjsJFCjRveDcxjLWL3vQAc8j9E7xskUPPDFqmo
         Ig1F/TPRFBwMrkw45xXXCWK/7O351e4y0Vp5x9AAxoCmgLHoH6FIfgaOEhUXKjOno5Wq
         hvNIT1gTmiJMXztywDTonEi+JmoCsCXwNf8/I0BnVSjNmAMNMELO0zFFluxUTIApOFvy
         4POhMNn7jA1P4Kwgy/BdoadctWwe26rvgAmvXk1g47eOwE3nGSvDXgzdsXlrJEZzphoC
         9laZ7u3OYKZaXKhP753NkfCZbE5+zTC+B0EyUP86zL9JgeyO7VEZipiEM+iKw0uQDi87
         8gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=rKlERWmGWR2CVhRsyK6YmkjA62YthqlaCXWPCxuucXc=;
        b=d3r2VqU6bquXhHy6uoQ4dV6Xr7zBlH8TdqIZK5FTmfVxqpwvpZgDzcPMrvQ1uq+qdb
         /d3cGc/GqQ2oN1wBvBuhNo76KbeBRZBMp+sK23DnZIvpO+SqaqSzplnB7RVADAIKKDO2
         dmnvciHg42wJ9qrSyw0JizTBzD5LN5xb/b0IVS7B/LxH6Mkj0SeoOvq26CmLVchx+p8K
         1v/+lwOg+LRqqxmeW8oHDf2Hsd/1tu7H2ZNsqZlvAsau4nJeU3TFtNH3G8gSq/1iubUa
         69it9KIT1MyO3XI6ecvqI1f2Hm3o/9BdlJdVa7rGAfER53l+ct+x+PdFdXwQKREyQ1xv
         zT3g==
X-Gm-Message-State: AOAM53275WXtD2Gt8W7pT8smZ+tN9RzJcqHmLlk+Cmslpu1eYk/8HKdQ
        9niriAP7Sb32PlP/jkSJLAc=
X-Google-Smtp-Source: ABdhPJxUcmWo4gCUE+rw0ACrnO610/Wj/C5eIIi1725KbTWAm4HN804/hVi9HBvTMT9kylExwq63Iw==
X-Received: by 2002:aca:e009:: with SMTP id x9mr1889363oig.154.1623332014381;
        Thu, 10 Jun 2021 06:33:34 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z6sm561597oiz.39.2021.06.10.06.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:33:34 -0700 (PDT)
Date:   Thu, 10 Jun 2021 08:33:32 -0500
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
Message-ID: <60c214ace1191_b25b12086e@natae.notmuch>
In-Reply-To: <3168eb15-25a6-a3eb-a498-8effa0c79855@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-6-felipe.contreras@gmail.com>
 <3168eb15-25a6-a3eb-a498-8effa0c79855@gmail.com>
Subject: Re: [PATCH 5/7] xdiff: rename XDL_MERGE_STYLE_DIFF3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 09/06/2021 20:28, Felipe Contreras wrote:
> 
> The subject would make more sense as 'xdiff: rename XDL_MERGE_DIFF3 to 
> XDL_MERGE_STYLE_DIFF3' rather than using the new name of the constant alone.

That is 55 characters, more than the recommended commit title length.

> > If we don't specify we are talking about a style, XDL_MERGE_MINIMAL
> > could be confused with a valid value instead of XDL_MERGE_DIFF3, which
> > it isn't.
> 
> I don't object to the rename but what is the source of the confusion 
> with XDL_MERGE_MINIMAL?

XDL_MERGE_MINIMAL and other XDL_MERGE_FOO constants go into xmparam_t.level,
XDL_MERGE_DIFF3 does not.

As stated in the commit message, the name XDL_MERGE_DIFF3 doesn't
distinguish it as a style.

Chers.

-- 
Felipe Contreras
