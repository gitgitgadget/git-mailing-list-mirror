Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C963C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3B2610CC
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhETQBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhETQBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 12:01:24 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB835C06175F
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:00:02 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g7-20020a9d12870000b0290328b1342b73so7457659otg.9
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MbWuBygr6INCAiQRXLdJns/bJDVCeOdqIPOM8zT/A9k=;
        b=It3sG2QvI5krjVaMt3uyqZMypjtVn5iLoOS/WlNnGFU7aeVknuCwwexdGhGu7FQhJT
         dMPxpNHYr3tN0aQoztxTeDH1RxMsfyG32t7JX0uOfRCuE0vNzrvIG4yodrRWKrGoB/On
         6no+QlW0XIh+M5TzXxhFU89cch/sjJ5RB4JPm+o4HV8FZx+9ncRcQ8jKz3EEmDr2InEq
         hFgpNaer7f+KN9y+G0e9BvHiDeNEpXcomBPYSAMSSK0wCCzv7BstTEtXdAzyWSxQTIP3
         a7cuBiz3grOLm1G/DkemzuRlTIrNCd4bfQdrp19g61+tJJnQw0LhtFsQvxAFGe9iyi/M
         UW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MbWuBygr6INCAiQRXLdJns/bJDVCeOdqIPOM8zT/A9k=;
        b=p6RiGEnliUbHZZq+M+esD/LQKFD10zshgTQVlW51s6eMe4SlMYA4M0GutD0uVxhjI9
         gGHy6Wa0LUNS19x801ptgMHgnnvj1YRTegI5RwBYFu7iwVn+GVF2Fy5hF9QDhrJ0uajQ
         fjhavnIFFc2UG/Y7jorYtMF05rq0i9Ten5rXpq9EUUgurmw5l2B6vUpOde3GtYExrK8W
         PjEVA6enKc4RQog1sJMd/Sjx5xJQgGJlHcFZHpr0NO+r+a0xGPzTlkm+mm6pTSFWxcG8
         zAM9EDOIM1b2UIcaZw5GMOFmUJ+UssOBF/AfIphsJ/nl22nmhUGoQsgepQnx3PzAfbIk
         t2rw==
X-Gm-Message-State: AOAM532CWXg+TVT91ygffoPDls4s2BGtPwzIqTeclOzhGGynxYwDxDTf
        EhOfV1eggEu+AeLLMNouBysTmkCUFquLzA==
X-Google-Smtp-Source: ABdhPJwGPYZIslpZnyqN6cLR8WEMUCMNjlw6+W9SM5MX52To2fxaoenQiQSarCjMZ1IdlNJ42wsfIA==
X-Received: by 2002:a9d:71c8:: with SMTP id z8mr4268533otj.304.1621526402091;
        Thu, 20 May 2021 09:00:02 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id b6sm621010oic.12.2021.05.20.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 09:00:00 -0700 (PDT)
Date:   Thu, 20 May 2021 10:59:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
Message-ID: <60a6877fa8389_2747c20842@natae.notmuch>
In-Reply-To: <b58cbdcc-abd3-ec82-7d8d-771f47c484ff@gmail.com>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <60a66b11d6ffd_2448320885@natae.notmuch>
 <b58cbdcc-abd3-ec82-7d8d-771f47c484ff@gmail.com>
Subject: Re: [PATCH v4] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 20/05/2021 14:58, Felipe Contreras wrote:
> > Phillip Wood wrote:
> >> On 20/05/2021 05:07, Felipe Contreras wrote:
> >>> We already colorize tools traditionally not colorized by default, like
> >>> diff and grep. Let's do the same for man.
> >>
> >> I think there is a distinction between 'diff' and 'grep' where we are
> >> generating the content and help where we are running man
> > 
> > It makes a difference for git developers, not for the user.
> > 
> > The user doesn't care how the output of `git grep` was generated, all
> > she sees is that it's different from `grep`. It's in fact more
> > surprising than a difference in `git help` because it's even the same
> > comand.
> > 
> > Maybe if the command was `git man` they would be equally surprising, but
> > it's not, in fact, `git help` can be used to 1) output directly to the
> > terminal 2) view in a browser, 3) view in info program, 4) view man page
> > in woman, 5) view the man page in koqueror 6) view the man page in man.
> > 
> > Only in one case among many would the user expect to see man, therefore
> > a colorized `git grep` is more surprising.
> 
> I'm not sure I follow that argument

Do this:

  git config --global help.format html
  git help git

Do you see a man page on less?
 
> >>> If the user has already set the LESS variable in his/her environment,
> >>> that is respected, and nothing changes.
> >>
> >> However if they have specified the colors they would like by using the
> >> LESS_TERMCAP_xx environment variables that the previous versions of this
> >> patch used their choice is overridden by this new patch.
> > 
> > That is true. We could add a check for that:
> > 
> >    if (getenv("LESS_TERMCAP_md"))
> >            return;
> > 
> > However, it may not be necessary since many of the tips online set these
> > variables inside a function.
> 
> The only person who has tested this patch has reported a problem with 
> it, it seems unlikely that no other users will have similar issues.

The check above will fix your problem, will it not?

-- 
Felipe Contreras
