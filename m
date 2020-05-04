Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DB9C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8BC2068E
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPqiqJ+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEDXdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEDXc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:32:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71EBC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:32:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so183087pjw.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J4sJWi5ANimeid59+dKh9Nf3iO6iuqFmoOhaBOS7VMI=;
        b=cPqiqJ+BIDZNlSooBflaX9sGkao52VwH6aLrQVFjQehkOX7gDfhFrBwXzB/OT74OjA
         httOmn8ZfSZ3YppsYTaChyItqa58E4+tR6MQgNNl1akUdCwNASFX+n36AoDRyVeFk9Wd
         nub61O8Y5n+YZLjaQJLCf83adE1TIVwR4On+cZ+TgHKga7oaeTvTBfHA6YF/LkPmxCK+
         ySwP/p1ui4QKK9azv0di4XLcYOHP1WmAVkqhFxDuGsV5A4C3KHdC17ASzGVIPlhk75V4
         gVN0rVTp4fEskDPsh9gAhdQtqO1jGEJ936SSHe4NInmy7kOhAFjVMKWFP14zTVqxYYYF
         E7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J4sJWi5ANimeid59+dKh9Nf3iO6iuqFmoOhaBOS7VMI=;
        b=oaYaxHjQfgFiOuqWiV/vab8VW6UvDQLRtrei1UtateaXfJTH8SEeZvG49Q3sojCGxF
         wbcMEaZJ7H2zcIp0mma9xrn2S6ltm/Lb2WwlGsHT1lhrTMV0GKPBm7gD8A/vO2CoRbij
         1iO5bq/yc8zSgMSOoSndlQrd5QqdHaxLGLrNI55HlmPgOasDHPi7uRhcTsYbCfqBG3QJ
         lU2GwB2gNZpy+1zq/1K3rr9PhVZhK1IkKn+7KDnfPWOEj+wh18GIVVDe5TxaduAp/cSu
         /1UfRsxgRtL881Vnb7oup0QE9CL0+L5pnw2Z1cKtanCBlmXKJ3lWntu/sV1O17o6dAjQ
         zQeQ==
X-Gm-Message-State: AGi0PuZ8JHArjmMjoOqdOVdWTk0Chj2v6O0Esa6uPPNauFQEdMFzWUXN
        pl/GKOIG4WxPd6kwK1u/9g8=
X-Google-Smtp-Source: APiQypLlEGH0D9qsLczejEZn9ZLXA5nfnAUJdhmKUwZ/tUglmFEEf9CYCgvnb0zNkSPzmBxYTZt44w==
X-Received: by 2002:a17:902:347:: with SMTP id 65mr386514pld.21.1588635178302;
        Mon, 04 May 2020 16:32:58 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id f30sm112780pje.29.2020.05.04.16.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:32:57 -0700 (PDT)
Date:   Tue, 5 May 2020 06:32:55 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, clime <clime7@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: drop arithmetic expansion advice to
 use "$x"
Message-ID: <20200504233255.GC29599@danh.dev>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091157.GA170902@coredump.intra.peff.net>
 <20200503114351.GA28680@danh.dev>
 <20200504151351.GC11373@coredump.intra.peff.net>
 <xmqqh7wviud9.fsf@gitster.c.googlers.com>
 <20200504160709.GB12842@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504160709.GB12842@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-04 12:07:09-0400, Jeff King <peff@peff.net> wrote:
> On Mon, May 04, 2020 at 08:37:38AM -0700, Junio C Hamano wrote:
> 
> Subject: CodingGuidelines: drop arithmetic expansion advice to use "$x"
> 
> The advice to use "$x" rather than "x" in arithmetric expansion was
> working around a dash bug fixed in 0.5.4. Even Debian oldstable has
> 0.5.7 these days. And in the meantime, we've added almost two dozen
> instances of the "x" form which you can find with:
> 
>   git grep '$(([a-z]'
> 
> and nobody seems to have complained. Let's declare this workaround
> obsolete and simplify our style guide.
> 
> Helped-by: Danh Doan <congdanhqx@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>

I see this patch hasn't been merged to pu yet.

Please have my name as (if it's not too much trouble for you):

	Đoàn Trần Công Danh <congdanhqx@gmail.com>

(I'm going to change my name in email setting)

-- 
Danh
