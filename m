Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C547720958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934930AbdCWWg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:36:26 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34842 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933401AbdCWWgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:36:25 -0400
Received: by mail-io0-f195.google.com with SMTP id f103so1086045ioi.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9YYeYNyw3v4iEqF86vyRkMT3AIF6hC7cTi7ELZMmWNc=;
        b=nLCeruVw2zsgOf7FVmElMiZqPWd0h1JUelNimCq+sgGl93fJWDL7w9j7Ool8eyE4hW
         phTF0DnKiEJOjFTMk2Qd5mD6gPYctFyk3eCzRaX191gJvO+DT6u2EMH+Y0yUA8inWLWT
         bTn5Rwka+sBQCudvTALhh1Hc7DfT64tFNOSvyzaKDyiqEYGr+2U7tb0QgSAP3eYu2K7j
         N6/vaFOqVDU7/Hg5dOvzUp50lfgb/3CeM48vjz+uzybRqbRNDLh46PRQvex4keFDVU1R
         BxVi9xWO0I8krA4wjam1YP/wn9b0MowE2A49i26W6EYoZpAUulEMu2CSgk0ksxOqT2po
         JfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9YYeYNyw3v4iEqF86vyRkMT3AIF6hC7cTi7ELZMmWNc=;
        b=ieT/uDtcZJiaKxXfTSNBJ7nHQ1ocgEs9piSo0gwG6zuY8GQKtIlBuVywt7JTo4udBc
         PhYIc8oBfNphWGqfrLXigQPtJEObeCQCt1f0ZP/Gwe5zgStUDRGE9lQE0oWQxIrph2jG
         2pCI33s7rqPdZdrIjS4VFQ84P3Bqh8dzJ039IaaZB/a+fBdXDFTJnQGUFA40mAHuMtXj
         R8J4cPGs9F7P26ZXpV4WD+FeeClpi27Ob2hPe2DrisW9Jz6C4n1Vn0Q75V/xhnyuNON/
         28fgDqzChR9XZJRzAjTGYxKv22+iTrc6tU8DCIPPepSy85gfw//Klhi1cDmT13fpEAKT
         ay7w==
X-Gm-Message-State: AFeK/H0cJjPMY/ApE4Nioo0mY9ThY06lArkfZKGp8xRL8OQLyE0BWgMdU2NjyLQYgVgQJg==
X-Received: by 10.107.39.70 with SMTP id n67mr5218356ion.114.1490308584038;
        Thu, 23 Mar 2017 15:36:24 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c40:39b9:f9ab:ec6f])
        by smtp.gmail.com with ESMTPSA id l198sm32586ita.10.2017.03.23.15.36.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:36:23 -0700 (PDT)
Date:   Thu, 23 Mar 2017 15:36:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/7] submodule.c: use argv_array in is_submodule_modified
Message-ID: <20170323223621.GC20794@aiede.mtv.corp.google.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com>
 <20170323223338.32274-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323223338.32274-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> struct argv_array is easier to use and maintain

Yes!

[...]
>  submodule.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

I also like the diffstat. :)

[...]
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1043,12 +1043,6 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  {
>  	ssize_t len;
>  	struct child_process cp = CHILD_PROCESS_INIT;
> -	const char *argv[] = {
> -		"status",
> -		"--porcelain",
> -		NULL,
> -		NULL,
> -	};

and the avoidance of this kind of fixed-size magic.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thank you.
