Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69B71F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 02:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJJKJt (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 06:09:49 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51560 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeJJKJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 06:09:48 -0400
Received: by mail-wm1-f43.google.com with SMTP id 143-v6so3735686wmf.1
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 19:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4fUgP8qXjGZScaResoFuM5XWyhMmsWzSyrVhGWVmHbA=;
        b=F1jEsdoEYUhQytjnSZqkBSIq3czL8R5ddsJdGDnahn7HpdOX4ZgSmuq6FW3cWN/o5l
         lxg1P0zBbTYhdbBpFA82Nym+zDLnBYywbMjXdp0AEXICQ5krAdx0dS8SNH2L/DEH7Xut
         NJTNeektx9DRiBF6NKVJRO1ijVMx1q8Mbv1QPQOdsZNFW91OKqsfj+A2qxxtzQMam9Lw
         F9dgA9XhYrsdzxblh1fcmdpCcmDr1/pI6L0b2U8Xs6iRZ4bVJWrxyoncamluW0Ar2IUb
         1LrMceqWvqBSMDHvDna53CzP6IRdsCdKhdxd65xhqiPjJ3Bq7pmRce4BU+4Xak+0ibLO
         vuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4fUgP8qXjGZScaResoFuM5XWyhMmsWzSyrVhGWVmHbA=;
        b=R0LrMAmRWm8BH7dYFcR+6Gv+xvINtQkg4WhnO6+5O4Eop1XiG7jexZypGLXezecCxn
         gvCkQx8kePUfH/UGTwd76CrJJNqLzUVZQo18pTNYE8UfEBI0iGrmMZPfogGIzt1y9o5r
         dweslP0rkcBEHzHp7GhCYn4WQkofTvPCEtTRfH8DCoUOaNrwsOM/S95i5eCvjfrNj0SB
         wdp+EGVHZUO/21nDudO8fsr//mu8+PyaGQYXRUIa/YAzESSAKai0CmV4ONdEfBrJVEXm
         XffI/LoZsyCI6p7FoHH75q086RckMePo4Xz3b1YxgFvzaAzdJRaLa85SkEJub7ulpnci
         7geQ==
X-Gm-Message-State: ABuFfoiKdZAcUcoiCc9D+uIlik+yBBQP8+YeqE2Z3yBWwyu3hWiUsbpu
        D8GmFSuW1jZralttzFTU3XA=
X-Google-Smtp-Source: ACcGV615+0jwQE4g+iafx1yIwGpAeJzBpwhP1PjfVEcHc/N2d4jiTF0w8eHaqNMqrju1QRHnG7yGqA==
X-Received: by 2002:a1c:e5cf:: with SMTP id c198-v6mr3861294wmh.113.1539139788926;
        Tue, 09 Oct 2018 19:49:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c18-v6sm2682482wrr.74.2018.10.09.19.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 19:49:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Eric Wong <e@80x24.org>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        List <git@vger.kernel.org>
Subject: Re: git svn clone/fetch hits issues with gc --auto
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
        <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
        <20181009234502.oxzfwirjcew2sxrm@dcvr>
Date:   Wed, 10 Oct 2018 11:49:47 +0900
In-Reply-To: <20181009234502.oxzfwirjcew2sxrm@dcvr> (Eric Wong's message of
        "Tue, 9 Oct 2018 23:45:02 +0000")
Message-ID: <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forwarding to Jonathan, as I think this is an interesting supporting
vote for the topic that we were stuck on.

Eric Wong <e@80x24.org> writes:

> Martin Langhoff <martin.langhoff@gmail.com> wrote:
>> Hi folks,
>> 
>> Long time no see! Importing a 3GB (~25K revs, tons of files) SVN repo
>> I hit the gc error:
>> 
>> warning: There are too many unreachable loose objects; run 'git prune'
>> to remove them.
>> gc --auto: command returned error: 255
>
> GC can be annoying when that happens... For git-svn, perhaps
> this can be appropriate to at least allow the import to continue:
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 76b2965905..9b0caa3d47 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -999,7 +999,7 @@ sub restore_commit_header_env {
>  }
>  
>  sub gc {
> -	command_noisy('gc', '--auto');
> +	eval { command_noisy('gc', '--auto') };
>  };
>  
>  sub do_git_commit {
>
>
> But yeah, somebody else who works on git regularly could
> probably stop repack from writing thousands of loose
> objects (and instead write a self-contained pack with
> those objects, instead).  I haven't followed git closely
> lately, myself.
