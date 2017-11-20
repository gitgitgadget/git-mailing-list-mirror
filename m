Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04F0202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbdKTW33 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:29:29 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:39973 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdKTW32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:29:28 -0500
Received: by mail-it0-f66.google.com with SMTP id 72so13622958itl.5
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wRsWsFNMFww2F7jCTDL/MWOCdjkwUhQudheAKfq/8oE=;
        b=RU9TKVS8NTW6JDPC9tHco7wbb/Mi/awMNFQO+wjhonSeB44OqDsIwD8dCiLldwXpXV
         AgIwuW+xkDYHty8NN5t+hhkIlJxR8Yi3oCQmAFWVluim57v0LcECTwEuQ1cx2CNfE2ez
         P49E0FWzdZ3KYIhz0BMGIartS4QkU1xmZu2VeeisngXucTtn+ipwzQxhn5nAdPT63Klu
         +vfJLSSZYsX4foKRSnztSllGYU5sh99YA4/EIRyzqxtgpPdpg7ZxkWMh52A6tSVgOHdR
         azok9YtVrhuiQ9oaZvPak7maOSDTu7mxma9AJOVyzvPveQfDmCexq6K8KDtajl8FPHqL
         KnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wRsWsFNMFww2F7jCTDL/MWOCdjkwUhQudheAKfq/8oE=;
        b=jjgI92ynWQgFr4dWH9FaV906XfyKE24WktryJ+euDiZqa1VusY1Xtzxehb4rncgi3a
         yCAmpjUDXYXzzMdT9e2SDeJBEPppXVjowSdEbW8gkSPNxtOLYL3pFvYi4KXWQlel7XkA
         CGY+HtkiPmVbL8oeR/9xUf2ZB8/vG8oHRFRfd7Qc8PfYbF/zUY0EAohvidem1lDbfy4w
         nNRS0NIVAUH77acX4sZhz/xtfOsQPdHVkL2I5oP26r2TCOWT3GR+bqc8K4emaqH2KrsY
         LLXkyFd+TJvRdEYwjKjqkvZVTjmSdOuAv2BOBmGbpVwIdc4zqAAFF9qWYdAbDMOSQ4dp
         c0HA==
X-Gm-Message-State: AJaThX7RUx4tzSUrwnYhJ0URAQiAQ10cXokg5GtZlRNxKl2kTlnKbGuP
        s37r/fgzMiEp3T+40CMIUVr7gGCszmc=
X-Google-Smtp-Source: AGs4zMYAaC+Nvs42W2QloKdGqJXA/dYjW0OIs2WkIrD+o820vWqEtwGhpOr2whb5w/3Yr+2fNDGFrA==
X-Received: by 10.36.181.82 with SMTP id j18mr21048279iti.18.1511216967282;
        Mon, 20 Nov 2017 14:29:27 -0800 (PST)
Received: from google.com ([2620:0:100e:422:255c:f926:518d:9e83])
        by smtp.gmail.com with ESMTPSA id d186sm5511111itd.38.2017.11.20.14.29.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Nov 2017 14:29:26 -0800 (PST)
Date:   Mon, 20 Nov 2017 14:29:25 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH 3/8] connect: split git:// setup into a separate function
Message-ID: <20171120222925.GF92506@google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212327.ssk6vmw2hd5jwbi5@aiede.mtv.corp.google.com>
 <20171120215218.GB92506@google.com>
 <20171120220458.sxltsyheixgkunyh@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120220458.sxltsyheixgkunyh@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20, Jonathan Nieder wrote:
> Brandon Williams wrote:
> > On 11/20, Jonathan Nieder wrote:
> 
> >> +	/* These underlying connection commands die() if they
> >> +	 * cannot connect.
> >> +	 */
> >
> > I know this is really just code motion but maybe we can fix the style of
> > the comment here?
> 
> How about doing that as a separate commit?

Looks good!

> 
> -- >8 --
> Subject: connect: correct style of C-style comment
> 
> Documentation/CodingGuidelines explains:
> 
>  - Multi-line comments include their delimiters on separate lines from
>    the text.  E.g.
> 
> 	/*
> 	 * A very long
> 	 * multi-line comment.
> 	 */
> 
> Reported-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  connect.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git i/connect.c w/connect.c
> index 20ed1d9574..e544a5e1dd 100644
> --- i/connect.c
> +++ w/connect.c
> @@ -889,7 +889,8 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
>  
>  	transport_check_allowed("git");
>  
> -	/* These underlying connection commands die() if they
> +	/*
> +	 * These underlying connection commands die() if they
>  	 * cannot connect.
>  	 */
>  	if (git_use_proxy(hostandport))

-- 
Brandon Williams
