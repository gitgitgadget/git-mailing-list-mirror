Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF481C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 09:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348826AbiFUJ3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349122AbiFUJ3e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 05:29:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5635427175
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 02:29:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ay16so6809482ejb.6
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CisnCxs98QhKWxd3u/HwZN1TqraEm1ndo0KMDLbjDhc=;
        b=q0XowfWDZwuVgY0A2bUR/kWcO6pkrRuAkJJDW5JBKQ+58mX6lExTsh4xgiUcj5FmZa
         h6Tcr1rxYD8hIb/9vfOo7lVYYtsATQEs+8mn+qSk1USkapyfBtOAEHcfhDJ4q4cRAZ99
         rOORa5jm+tF+IyVb6G9YbEotm0sAFyWzJbIMpheY2+glg8auJ0G7YkUtXe+erYpEyI4g
         Bi0Jx0i2c1kdf0ypu1L64df9AUZ8NIqZz8XRgG7xP1rdBzYwww4wp3JaOKKsfmbW7qiY
         Nt+TDY4igv6bKq/Q3vmhS1W09xZ3SSuzpHfxHekfUR7jZWcnZClt+hqpeEegLTW1mugF
         hoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CisnCxs98QhKWxd3u/HwZN1TqraEm1ndo0KMDLbjDhc=;
        b=cgoV9odDjnu7VWMmC6RIHGUrMz7uqIFTeb9CR3ufuslfrLjVigJEwUZIHVmi6W9gis
         n33EIqIW8UvlXixf8rEboU215bi1jp6Vdi64WT8xeHy+1O3xoi0v8cygsaSAOXpUqf3C
         g2A05GFM5uPu60xpkKvVki1o7rWvz8rWLD/n4CjrGfE5OSH/y6jxZMCDMn+DWOMklSuT
         qGVy3nE7KPdGpFp6IOXMfMyl31QmJnXVnbRFR35ZnczYLdjWAS+STI2XPmHZLXuPIzz1
         6RIPQjY9s05sn4/WglEMVwngsecic9+TpRwppfaVJikhqpcx99FNdgvnXStBbC2NgNlo
         ysbA==
X-Gm-Message-State: AJIora8eU0p0ep54bIiMUPFYmTKDUowLfzmYw4y+qNk3n2bdmbSmkuV5
        3Qan9WbrWRa9JpMtJoUBXTo=
X-Google-Smtp-Source: AGRyM1txIzuGo1BK5L6H0EmeoWhTVcc5xAE2SjOhM3kLuKxtGD+qY33NBhXoI/LkdcSo5OOag3vw2Q==
X-Received: by 2002:a17:906:2245:b0:715:7c81:e39d with SMTP id 5-20020a170906224500b007157c81e39dmr24118551ejr.262.1655803769794;
        Tue, 21 Jun 2022 02:29:29 -0700 (PDT)
Received: from localhost (78-131-14-143.pool.digikabel.hu. [78.131.14.143])
        by smtp.gmail.com with ESMTPSA id dt8-20020a170906b78800b0070f6855b90bsm7273546ejb.170.2022.06.21.02.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 02:29:28 -0700 (PDT)
Date:   Tue, 21 Jun 2022 11:29:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>, rsbecker@nexbridge.com,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v2] t5510: replace 'origin' with URL more carefully (was
 Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1)
Message-ID: <20220621092915.GD1689@szeder.dev>
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
 <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
 <YrFwcL2dRS/v7xAw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrFwcL2dRS/v7xAw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 03:17:04AM -0400, Jeff King wrote:
> On Mon, Jun 20, 2022 at 06:20:07PM -0400, Derrick Stolee wrote:
> 
> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > index 4620f0ca7fa..c255a77e18a 100755
> > --- a/t/t5510-fetch.sh
> > +++ b/t/t5510-fetch.sh
> > @@ -853,7 +853,9 @@ test_configured_prune_type () {
> >  		then
> >  			new_cmdline=$cmdline_setup
> >  		else
> > -			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
> > +			new_cmdline=$(printf "%s" "$cmdline" |
> > +					sed -e "s~origin ~'$remote_url' ~g" \
> > +					    -e "s~ origin~ '$remote_url'~g")
> >  		fi
> 
> Doesn't this introduce a new problem if $remote_url contains a tilde?
> Unlikely, but I thought the point of the exercise was defending against
> funny paths.

And it doesn't replace a standalone "origin" word, either, which does
occur a few times in the test script.

> So perhaps something like:
> 
>   perl -e '
>     my ($cmdline, $url) = @ARGV;
>     $cmdline =~ s[origin(?!/)][quotemeta($url)]ge;

I don't like this "(?!/)" magic, because I haven't got the slightest
idea of what it might do by merely looking at it, and these characters
are not exactly easy to search for.

The good old "add a space prefix and suffix" trick can help to easily
match the "origin" word even when it stands alone, but, alas, the
result is still not as simple as I'd like with the \s and the string
concatenation:

  perl -e '
    new_cmdline=$(perl -e '
            my ($cmdline, $url) = @ARGV;
            $cmdline =~ s[\sorigin\s][" " . quotemeta($url) . " "]ge;
            print $cmdline;
    ' -- " $cmdline " "$remote_url")

(The 'sed' variant looks good to me:

  printf " %s " "$cmdline" |sed "s~ origin ~ '$remote_url' ~g"

but then again it just trades one set of troublesome characters for an
other.)

>     print $cmdline;
>   ' -- "$cmdline" "$remote_url"
> 
> I don't mean to golf on this forever, but I wanted to show something
> concrete since you said you don't know perl well. I just think moving to
> sed introduces more opportunities for errors here, not fewer. :)
> 
> -Peff
