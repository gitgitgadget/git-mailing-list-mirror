Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12A75201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756965AbdELW2o (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:28:44 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33846 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756193AbdELW2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:28:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id u187so9067204pgb.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yGF3tJGp2F5U4gvBk1UXpPeJlDFCMIqg3MRWcmOc9ek=;
        b=cxJAyiUv6qhaoOdtKmfXGDfOvFsTl0Uk4mEhHSCG0hBvTH3fl5JePPniXz8FcNpSSp
         DaPT0+Ir/rPXQJXZmjn+yJSZCviq8vBgw5pE3A/AhwxXLJqbZAmuPv09xcg5Ey8DRhFK
         FRucJxIODz6MCyWBQUX7C+bPDoxC2Y6qgOGgwl7DoH//M6SBSKYCon+4CO5qm/RQb3GE
         /9oBwQUp/ydoKktQ2aYwJu3B4F6lJKnx3ePLvR/l7RFOhP3Zr7PlUE8EqJ53+v2Q0LOl
         MbxAckpYhLw46Z4egjPqans08kQtPDVF6oerM/X0D9jWXU6d1VoDWAmgU0VB4p+PA/Jg
         JSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yGF3tJGp2F5U4gvBk1UXpPeJlDFCMIqg3MRWcmOc9ek=;
        b=OpfZMjHzt77EvXTQADXruSdB5DmAzaP0TkuSZxo0KrOwhuAYovUn79sqpi1mFWjSbv
         oHA9HeocxKJExJ0Y0JVhgxHXLPq2f9pUAnwSLdVo7o9cT1naGBxzbMQXFZh21Nj45LRP
         xsSzxIgOV6vQ6iNfVzgwwymriIc22G3JhpIEaMxm70RIHfYSY9LKQiJ9VtMCWQ0haEwP
         leuT1vHJb+zA9bwI2cBFNvvxgMacjSCMxbfoUZevNmV7kar+XmRTSc+KR/6KzmRIv4kD
         rrZhajVNTE0OJM4dxf7eH8tJiCRoPS7N88HPsEnSkrlFhMYYujDxXGLqpXfCeihdtpqm
         pN7A==
X-Gm-Message-State: AODbwcCwFhJvJvPp8zK/VdUobqWkZ5+bmZd5Q7D4bQ/fHPnh7OtJt6dz
        CM2q4uJrT0Ej8g==
X-Received: by 10.84.238.200 with SMTP id l8mr8554224pln.85.1494628122580;
        Fri, 12 May 2017 15:28:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:fcb1:2bc1:55ad:11f1])
        by smtp.gmail.com with ESMTPSA id m89sm6745520pfg.22.2017.05.12.15.28.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 15:28:41 -0700 (PDT)
Date:   Fri, 12 May 2017 15:28:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v6] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170512222839.GD27400@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170512204648.10611-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170512204648.10611-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c          | 35 +++++++++++++++++++++++++++++++++--
>  t/t5500-fetch-pack.sh | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your patience.
