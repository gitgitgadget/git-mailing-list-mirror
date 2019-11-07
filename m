Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405DE1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 04:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfKGEGK (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 23:06:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33203 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKGEGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 23:06:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id h27so1014127pgn.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 20:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9kbENoZUSxH4c9iLGOpS4LxCPXLqnwLM1GRMP2M5awg=;
        b=D/91t044rMLU/nFOGXAJkz/UOH0GtAak6J85qSoaRY+5+j7s0Ox2ctfv6NHCCX5D/Z
         3kS/0BjmBL4fkcyqLz1GSvWaMfFOVYtlXg54bzGcnuiNJPIi25bftogbx9ebHLrL61SS
         BFt69kwC+wteCozJPGZaw4Uh2exVws9db7A1XWMQeL+VVHHxfavQ7l0SdsYeK3FDzzWk
         z/chSmTxzvZTB4mD7qMr2mO1p49xDwSDL5g9UoAMa6YgM6VnY+frZCZ63K3qbgZzAFfz
         s34slcUY/ooyqplsjN5GBXNjVf/BYXidtetJU2e9/DOleJ5CJEH89bfTJ8aQNZf7nT2v
         BoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kbENoZUSxH4c9iLGOpS4LxCPXLqnwLM1GRMP2M5awg=;
        b=LZaop3SuHkPDB/pL2XigQqv8XaYkJRtm7+VzgAArD1hW959jzNN4eVHSwzHONfMo5P
         h0tIJhnXva36BJgtQBbEprhgewxUeFx13j0abGUC2MPQWoSqrF9dkfAuk1+/bK46DFHV
         uipMDAetreNSynGrpWf3tx+DWyTO5LUTDUOmjwLoFFBNf0oa9iGNuE2Ks2yBdOWgUNiE
         X60sl2RBmLzqZh5UQz9hzrqzo4upxijL9t4OVJeiCeYFYiOXGz/HFx7AzGxJrxYBxqqh
         m+TxJNlvc5ELmpT3DdmnhUiIF+KWesfamyGeuv0NZqY8OZ2B796WxNFtEe4vtdMD1lpG
         Uu/A==
X-Gm-Message-State: APjAAAXjl5LEKIKrh2VIy8qadgG+bgTeIQu0PWi1G7g1lVK21fB6RlfY
        D8uKa61KcYD5BJbiEgJHzF0Z7Ug3FZ8=
X-Google-Smtp-Source: APXvYqwboym+7HKNfky0agpnM1AsrRMrQeBFH+NFI2hMGPc6Y0iKXhAYECykoSmDqFqLG4v+RWeTAA==
X-Received: by 2002:a63:5960:: with SMTP id j32mr1838423pgm.281.1573099568782;
        Wed, 06 Nov 2019 20:06:08 -0800 (PST)
Received: from localhost ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id f59sm5393272pje.0.2019.11.06.20.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 20:06:07 -0800 (PST)
Date:   Thu, 7 Nov 2019 11:06:05 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 31/32] commit-graph.c: fix code that could convert the
 result of an integer multiplication to a larger type
Message-ID: <20191107040605.GA8096@danh.dev>
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
 <20191104095923.116086-2-gitter.spiros@gmail.com>
 <xmqq7e4dwxob.fsf@gitster-ct.c.googlers.com>
 <20191107022347.GE6351@danh.dev>
 <xmqqtv7gs6g3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtv7gs6g3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-07 12:37:00 +0900, Junio C Hamano wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
> 
> > On 2019-11-06 11:23:00 +0900, Junio C Hamano wrote:
> >> > @@ -1454,7 +1454,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
> >> >  			    num_chunks);
> >> >  		ctx->progress = start_delayed_progress(
> >> >  			progress_title.buf,
> >> > -			num_chunks * ctx->commits.nr);
> >> > +			(uint64_t)num_chunks * ctx->commits.nr);
> >> 
> >> Hmph, do we need this?  I understand that the second parameter to
> >> the callee is u64, so the caller needs to come up with u64 without
> >> overflow, but doesn't that automatically get promoted?
> >
> > Neither num_chunks nor ctx->commits.nr is promoted because both of
> > them are int. The result of `num_chunks * ctx->commits.nr' will be int
> > and will be promoted to u64 to pass to caller.
> 
> Ah, yes.  Thanks.
> 
> The commit title is about "integer multiplication", but can the same
> issue arise with addition and subtraction as well, by the way?

Yes, the same issue will arise with all binary (and ternary) arithmetic operators
(+, -, *, /, %, ^, &, |, <<, >> and ?:).

IIRC, gcc doesn't have any warning for this kind of issue.

Microsoft Visual Studio (2017+) has C26451 for this.
https://docs.microsoft.com/en-us/visualstudio/code-quality/c26451?view=vs-2017
If our friends at Microsoft could help, we can check the remaining one
in our codebase.

-- 
Danh
