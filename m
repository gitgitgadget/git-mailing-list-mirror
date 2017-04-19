Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90AC1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 16:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965558AbdDSQMM (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 12:12:12 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38426 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965411AbdDSQMH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 12:12:07 -0400
Received: by mail-it0-f50.google.com with SMTP id e132so18579578ite.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XFrd4CYZzkgvgfvHCplwIyeEhtL34Ody/W6JBm/prMc=;
        b=v/vr/Nei54iK7z2LhD4U792gtDvqueioA2AC+Bi45QTIIfg8VJM9MC1TknausAcTMU
         IAjY4gjmET64tT2LOlu4MitmHbUf3ipk3KaDSrFbcfPrU9hUxBsvHpgIyT0D/kcIu2Ve
         PfD/ysSCPLZhJSfajAmFdDVAOIYHxR1eoEZAnWSP718kxbrYwNe1aLMkBJO0ltFMkdNz
         GNw0Yw/Qg+GJM28vL+jLCB2w338JyD0SQU/rzX38+UvkVzv9XEaSpJDUs8aBY75uj4cc
         38D/xMZYcS9hgtrKP7sAYHRWet1frm3rNk4vTJqhDyMmF+LQMf4a00FLMmndZ55hqfqP
         uglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XFrd4CYZzkgvgfvHCplwIyeEhtL34Ody/W6JBm/prMc=;
        b=ueaMONEn29a4KTh5ciqOSa5ZnoHZGrZhTu4kvT2u+h1899NdnO9Dj5HZNawhWh/yYs
         G6RsSgO4W8BA8dhDnd7nsrOvqMLfJxz1VaJJOxysgfYp3z6tcUedSt+i06lNsdbc2FfY
         yfadoh9G5k7U3lho6zyRaF3bf+pERKQq/A7h2IVAaOA0dU9c4iik/9lOagGomkTOiunx
         aBkAF/v3KYdebkRah3p5gafg2ol5RL7MTrvbAT8y69l/cDz35cK1mz5n80cCIM5AT2wQ
         F5I3drDqL/fT8nOrO/1RJ1VSWrfoxoXc/TJt5soE/48BCTNfBRpzbfe54fnTmm6epQXH
         0u1w==
X-Gm-Message-State: AN3rC/7m+18n+/rLinZkWZn7ejK4cp6Kc387qNvYmZH6Jcsqy4GWTEVR
        ef3yarxkQxS8e7ZV
X-Received: by 10.98.158.205 with SMTP id f74mr3817431pfk.119.1492618240498;
        Wed, 19 Apr 2017 09:10:40 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c085:9655:b875:4bbf])
        by smtp.gmail.com with ESMTPSA id h7sm5470056pfc.99.2017.04.19.09.10.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 09:10:39 -0700 (PDT)
Date:   Wed, 19 Apr 2017 09:10:38 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 11/11] run-command: block signals between fork and
 execve
Message-ID: <20170419161038.GB132229@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-12-bmwill@google.com>
 <4c2f91fd-c9bd-cfe0-4e2d-3f1669410579@kdbg.org>
 <20170419074830.GA25646@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419074830.GA25646@starla>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19, Eric Wong wrote:
> Johannes Sixt <j6t@kdbg.org> wrote:
> > Am 19.04.2017 um 01:18 schrieb Brandon Williams:
> > >@@ -400,6 +404,53 @@ static char **prep_childenv(const char *const *deltaenv)
> > > }
> > > #endif
> > >
> > 
> > Does this #endif in this hunk context belong to an #ifndef
> > GIT_WINDOWS_NATIVE? If so, I wonder why these new functions are outside
> > these brackets? An oversight?
> 
> Seems like an oversight, sorry about that.
> All the new atfork stuff I added should be protected by
> #ifndef GIT_WINDOWS_NATIVE.
> 
> Brandon / Johannes: can you fixup on your end?

Correct, this is an oversight I should have caught :)
No worries though, I'll fix it up in a reroll (since I'm going to be
need to send out another version to fix up another patch in the series
for Windows)

> 
> I wonder if some of this OS-specific code would be more
> easily maintained if split out further to OS-specific files,
> even at the risk of some code duplication.
> 
> And/or perhaps label all #else and #endif statements with
> comments, and limit the scope of each ifdef block to be
> per-function for with tiny attention spans like me :x

Yeah I'm not sure I know the best way to prevent this from happening,
thankfully we have windows folk who keep us honest :D

> 
> > >+struct atfork_state {
> > >+#ifndef NO_PTHREADS
> > >+	int cs;
> > >+#endif
> > >+	sigset_t old;
> > >+};
> > ...
> > 
> > -- Hannes
> > 

-- 
Brandon Williams
