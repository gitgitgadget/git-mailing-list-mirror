Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962E11F42D
	for <e@80x24.org>; Fri, 25 May 2018 01:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972072AbeEYBHg (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 21:07:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53936 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972052AbeEYBHf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 21:07:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id a67-v6so9870654wmf.3
        for <git@vger.kernel.org>; Thu, 24 May 2018 18:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/36WhOVrYZdCyS6lJabcc6z0pcNTQELtvGYZVSMk/cI=;
        b=dGA64tC5lacUgvLwrUi3h/OMvNI1mtiBE49DQhlBO41IT4aeajTpv7gP+DY/tIU1Ch
         aEyWmC6nauk4wxP3kkQcTKjK1+3iEYO/x8cVo0hcrY+N3ZW8hMzpaknXTJ/N59Q2Iq1M
         xwchrmAOMv+lPwg4TxhxTbpvga1sPvCxqWCXqKENUZPg2wuBLWBv47pl0Wm7iex0Xq6o
         cR/XMyLVql9wjLRNtTki9HkiJfWuDuJHeN48sW+iVUZ3r/GBhwzqXgP3kGXOjP/M6hVB
         SZt6fSVY6WNQW+yWpekO2wR45yYEWuZmZXp+zE+ecJW5KXiHfVBlu4zLJWY9KeLR3SVK
         fh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/36WhOVrYZdCyS6lJabcc6z0pcNTQELtvGYZVSMk/cI=;
        b=E1pKn5sqNJ1ZC/jv78WlRiB83B5sMbzhiMR9nF6sIomB8IJpVH1PYtpUXeiQz3WGla
         Z6qbtp/d0j3WZbEFimbXGGce1u1vJIkGZ0e+XeBh+jkZ8Oyi0axHymXpgjUPtZiKq6kO
         Mw3d3+0NhP43Y7vKT1NuI6lRPJ961A0ixU2VjtSi2wn57RE5sd7B6mLxWld7V0NZ878f
         X4rEdBPN4yfcHDSrQm91Oucba9Xx1hIjk6su655JmgRZS9zdwK1mdJYNVBQbLqpL0oNO
         X191dEYBLnmX/S3lWTJmz/RYhSvrr01m7398BYupMd5HiAiq9ARNBYXn7BYvOHkMllIu
         PQhQ==
X-Gm-Message-State: ALKqPwdx638QsdZosALRegWOlRGepM0KYduYTCMX+vsC05NwhmS3eRTa
        eUG7jaq3vxOyuk1o7FHZET0=
X-Google-Smtp-Source: ADUXVKIrw2tEKRPcRYnm0C6UER3BWxMm6Ho4yJLGEo2jxKStbvTvGBSqBl8IHGS4e3pYBpoFUeWUBQ==
X-Received: by 2002:a1c:e384:: with SMTP id a126-v6mr173168wmh.93.1527210454229;
        Thu, 24 May 2018 18:07:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 76-v6sm29897862wmj.0.2018.05.24.18.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 18:07:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, B.Steinbrink@gmx.de,
        sbejar@gmail.com
Subject: Re: [PATCH v2] rev-parse: check lookup'ed commit references for NULL
References: <20180523220915.GB32171@sigill.intra.peff.net>
        <20180524062733.5412-1-newren@gmail.com>
Date:   Fri, 25 May 2018 10:07:32 +0900
In-Reply-To: <20180524062733.5412-1-newren@gmail.com> (Elijah Newren's message
        of "Wed, 23 May 2018 23:27:33 -0700")
Message-ID: <xmqq36ygr19n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I would have used a Reported-by tag for Florian and Todd, but looking at
> the bugzilla.redhat.com bug report doesn't show me Florian's email
> address.  I grepped through git logs and found two associated with that
> name, but didn't know if they were still accurate, or were a different
> Florian.  So I just went with the sentence instead.

Or write names after reported-by without any address?  There is no
law that says that a trailer's contents must be proper e-mail
addresses.  People are already known to put garbage on Cc:, for
example.

>  builtin/rev-parse.c          | 8 ++++++--
>  t/t6101-rev-parse-parents.sh | 8 ++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index a1e680b5e9..a0a0ace38d 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -282,6 +282,10 @@ static int try_difference(const char *arg)
>  			struct commit *a, *b;
>  			a = lookup_commit_reference(&start_oid);
>  			b = lookup_commit_reference(&end_oid);
> +			if (!a || !b) {
> +				*dotdot = '.';
> +				return 0;
> +			}

We thought A..B or X...Y were a commit range, but it turns out that
it is not the case, since at least one end is not a committish.  We
simply restore the original and tell "No, this is not a range, try
to parse it as something else" to the caller by returning 0.

Makes sense.

> @@ -328,12 +332,12 @@ static int try_parent_shorthands(const char *arg)
>  		return 0;
>  
>  	*dotdot = 0;
> -	if (get_oid_committish(arg, &oid)) {
> +	if (get_oid_committish(arg, &oid) ||
> +	    !(commit = lookup_commit_reference(&oid))) {
>  		*dotdot = '^';
>  		return 0;
>  	}
>  
> -	commit = lookup_commit_reference(&oid);

OK, the logic flows the same way for things like foo^@ here, which
makes sense.

Looks good.  Thanks.

