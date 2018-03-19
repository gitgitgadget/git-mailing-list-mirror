Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD771F404
	for <e@80x24.org>; Mon, 19 Mar 2018 16:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965271AbeCSQn0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 12:43:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34706 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964803AbeCSQnX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 12:43:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id a20so13518295wmd.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fcQUWbvwCAPmDcdGDGMrmEek2C4vi+VCPNBSxPhh8zY=;
        b=IWthnXt9zagGGtIX6tAQEOYvR7QDEVvtRtto7T2+Xgtk+OgJhBbhTgHHxsO7CxOTQH
         58X69U1aVcoq/rcrCSUfKYJabj7c6AlyB/eEEJugjEYFLd2xrEnDouMZ7TeqTW/w37o1
         nNpZY/PrfbN/WP78aN+CXEl/8dtoc7F13lG9WXt8i4LQu2C9Dg1vgRzo+XCL5jIcty21
         b57ypL6xjJLxahygTvwszZaPHosGNpXchf+ExP3e+koGO7uPqJJ/YtYMM4rS0XJcIN6K
         uEr+L/KxxDEbp+pgTlMgiqu5JWjfDxHo/CKydJVbDW1xFkW2MXZbYx/6E7eSIZ8Bw6fQ
         c6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fcQUWbvwCAPmDcdGDGMrmEek2C4vi+VCPNBSxPhh8zY=;
        b=U3yqCJhdKQqWIdS+laNnlY1xhhIX9mSxMjK0t9BuqpucmtBnaIqG/jPdvg1tMfclcp
         P2MhkD2CsNSEClW0SBc+AuT2R5eVXdVhQBsBcO7a7NJhSNwEbmJtUlK7gx0F8/HrY8KO
         tC69/DAdN4VZideT4zK9bsdcWX8YWQNCPXpSWUofSXPLs9U2+989nZ2Aq+M1a9sMIPJg
         YrvE1c6KjKyv/K+Vj31H7edAFYAoc7ApKZrYq2vmXQOLpxVmi7TSe6xw8SM69JXdMcYT
         48gQZNcuC+VvAkgWdd3SYz0OC63VIRH56tnegDXbBgsDwkFR/0SaNg1qg8itAd2CiLqw
         6B+A==
X-Gm-Message-State: AElRT7H6I4JEbJxHCMtp7pjSQuSAKhOACKul/Jxc79FoDlbvyB1E2Snr
        HRMuqhhMmyYMX0JVGeFXRT8=
X-Google-Smtp-Source: AG47ELvBoHYAYJazFuZQjfOlOMQpSeyW3kM5pwL+XVRDEptHv9dxfwi6OihDljO+3nr5KErUvC2Cpw==
X-Received: by 10.28.47.3 with SMTP id v3mr9746113wmv.96.1521477801717;
        Mon, 19 Mar 2018 09:43:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w29sm446665wra.84.2018.03.19.09.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 09:43:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
References: <20180317141033.21545-1-pclouds@gmail.com>
        <20180318142526.9378-1-pclouds@gmail.com>
        <20180318142526.9378-10-pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 09:43:20 -0700
In-Reply-To: <20180318142526.9378-10-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 18 Mar 2018 15:25:24 +0100")
Message-ID: <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +static inline void oe_set_size(struct object_entry *e,
> +			       unsigned long size)
> +{
> +	e->size_ = size;
> +	e->size_valid = e->size_ == size;

A quite similar comment as my earlier one applies here.  I wonder if
this is easier to read?
	
	e->size_valid = fits_in_32bits(size);
	if (e->size_valid)
		e->size_ = size;

Stepping back a bit in a different tangent, 

 - fits_in_32bits() is a good public name if the helper is about
   seeing if the given quantity fits in 32bit uint,

 - but that carves it in stone that our e->size_ *will* be 32bit
   forever, which is not good.

So, it may be a good idea to call it size_cacheable_in_oe(size) or
something to ask "I have this 'size'; is it small enough to fit in
the field in the oe, i.e. allow us to cache it, as opposed to having
to go back to the object every time?"  Of course, this would declare
that the helper can only be used for that particular field, but that
is sort of the point of such a change, to allow us to later define
the e->size_ field to different sizes without affecting other stuff.

> +	if (!e->size_valid) {
> +		unsigned long real_size;
> +
> +		if (sha1_object_info(e->idx.oid.hash, &real_size) < 0 ||
> +		    size != real_size)
> +			die("BUG: 'size' is supposed to be the object size!");
> +	}

If an object that is smaller than 4GB is fed to this function with
an incorrect size, we happily record it in e->size_ and declare it
is valid.  Wouldn't that be equally grave error as we are catching
in this block?

> +}
> +
>  #endif
