Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF37201A7
	for <e@80x24.org>; Fri, 12 May 2017 19:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758951AbdELTGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 15:06:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33622 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758792AbdELTGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 15:06:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so8665371pgc.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VEqrk3CtXR6KhI9akxVBndmKkCl3Pp/y8G/BO93NAVk=;
        b=t6ReYfCtkwATm3HJfPjA2CF7Lf/GsDeQkRQfx6+JhrKErdH4czmodSWAQx7R1jEXPN
         5V0iZlL0Jd8JZY9cThzaP3BTaMOGqJuNCtimknLGAq19beKqadsKgjs+f6uR4oKGdLUS
         Jnkaaf60aQ8SLVpf/W0PmzN4EEofa63/xjRQspVefd0yz0+DDomSddBQ79div0+D0Whn
         iW/36WGioj0rJ3X+M/lbI2Cb3LPfxC33S0+h1vFTM6JaYRqArgEwoKXeI9YLoyFQWUJo
         ExxibHOl9klPrLbF5tAwEwY/XckjUOrWR7y5bITvLBXi8JiIywKndT43XnDSs66uxZpu
         +IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VEqrk3CtXR6KhI9akxVBndmKkCl3Pp/y8G/BO93NAVk=;
        b=IvuJLV1CkcYnuBodixjIIrVGF1SEC9jWMYFP3s8fLKbRS3k1smYvlQ3tY35NIT13y4
         WlvFpD+6VUpC6NrWQULPMKOAL0D9VWMzTgB7Akpc2UyDJ3tRgdUC1mxspI45vERQfDr7
         peTlqxrOIj9SRrJfauCuiOkWkRF5JfsjJIMK6V3OmA43TpE6c2aqnnnyKQvReHNxqQEi
         C98kDjiRxA8z+5F7xf4lcRt1/Ti5QxyfFaOG8O0t2mjMOIiEbhp6Ui9qgvVq12IDGiVS
         ISNa77hQMVldRbGW3qAJevMT8BvPZQy2yFQfZw46jd7pFRFWaeyi7P05dVxIHSzG9s/3
         h03A==
X-Gm-Message-State: AODbwcAGpKECpKhE1hBhaAwEIuZ4LGzwo+wnV0MXI8kU/9YrC3DUWkoq
        tZIqFujeHdyVlQ==
X-Received: by 10.98.34.203 with SMTP id p72mr6251963pfj.118.1494615980715;
        Fri, 12 May 2017 12:06:20 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:fcb1:2bc1:55ad:11f1])
        by smtp.gmail.com with ESMTPSA id t5sm6946257pgo.48.2017.05.12.12.06.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 12:06:19 -0700 (PDT)
Date:   Fri, 12 May 2017 12:06:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170512190617.GC27400@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511223054.25239-1-jonathantanmy@google.com>
 <20170511224639.GC21723@aiede.svl.corp.google.com>
 <xmqq37ca7gw0.fsf@gitster.mtv.corp.google.com>
 <20170512075931.umunxd72nj53snds@sigill.intra.peff.net>
 <CAGf8dgJxz+jA=pA5TRR6vmK=zP=CUenpsBDy2VEtjYB5CO9yuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGf8dgJxz+jA=pA5TRR6vmK=zP=CUenpsBDy2VEtjYB5CO9yuQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> To make the interface less muddy, would you agree with this (untested):
>
> @@ -648,7 +669,9 @@ static void filter_refs(struct fetch_pack_args *args,
>   continue;
> 
>   if ((allow_unadvertised_object_request &
> -    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
> +     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
> +      (check_tip_oids_initialized(&tip_oids, unmatched, newlist) &&
> oidset_contains(&tip_oids,
> +     &ref->old_oid))) {
>   ref->match_status = REF_MATCHED;
>   *newtail = copy_ref(ref);
>   newtail = &(*newtail)->next;
>
> (making the function-to-abstract be merely an initialization one,
> instead of one that does 2 things). That decreases the scope of the
> function that Jonathan Nieder and Peff wanted, but it might be a
> warranted reduction in scope.

Yeah, that sounds nicer than anything I suggested.

nit that check_ would be clearer as ensure_

Thanks,
Jonathan
