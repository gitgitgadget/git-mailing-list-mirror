Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB3220248
	for <e@80x24.org>; Thu, 14 Mar 2019 05:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCNFic (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 01:38:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35362 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfCNFic (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 01:38:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id t18so4411895wrx.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3nfYuS4axRsZ+toz+RcqWTlynvkNI+aEMvxCrCiWgSA=;
        b=u0Dea9DBGmGesgl+MWa3cCF+GgdKZ9kWa1sZdXJec08cKGJaU3IXaThril2CuOqQVU
         07RKIGlEF5w6vqsc5OplIfnWoL9ZRMSTMTADMH5tTsfDDr0W5fry5CaSj2HI93el0OFK
         dRzT/8xdzT1qjgU2TMap1WirKvSAZLSVkNYbMdxRX/W/vmmmLCfosj40hWXdVifBAvZB
         B8J4mJzNhJLOEg/Z9sv8XF2muSkIH2x2ECYG9jPwnDpCtTiHqlsJx63aSw/612gk9GVA
         gbwg3/woyKJr4CtZ0PglYewaIbAPUZcTCl269apVfKW01SmvI2uGpcRHFKCasZ8wVkm6
         esfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3nfYuS4axRsZ+toz+RcqWTlynvkNI+aEMvxCrCiWgSA=;
        b=uAO7Q4R86NZCr1ZmSSruATFbUKtsVUcbm21LHpUdIPNNtDHo6v7G+rz8GlDwkh4TQ5
         aS5KC1pTOTYA/H1EIm7dN97Kqw1UDvEtD0cjooxkTursVvNYSL6HPyiRAefXAZDN9mDq
         /0QIrsgbvIGXeJosuckZRqSLJKEbCnjjx4jUddjcHMBB8SrGeo3gAtKt3V96W12s4/Kt
         aFXeZiHAjAHcRNHljbfQmRkvg1wg7w0XiTlh4EN+510UTiLNMdg+FrIcYNhn8zp2zveL
         RNP5px5ZiCRjdvFfYMl86Q+DIYokabzlSja/BLoU+zhxarcrvbvdVH4OpJ4X9DitF4LK
         IgCA==
X-Gm-Message-State: APjAAAW73f6zqX+i5vuL64XoNgEDtTj/lQxfqcn5GfqtPdCEB77s0Jyb
        33Qi/eFkFNYMbCj0ixcOJu0=
X-Google-Smtp-Source: APXvYqxErSnJMiPSvab8clFbLL1RGd7UpvHVUt8hn/bjtZWW7fkBsif+yuZz9AIGYwxCXbpI1WqPKg==
X-Received: by 2002:adf:d081:: with SMTP id y1mr8583426wrh.283.1552541910584;
        Wed, 13 Mar 2019 22:38:30 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id p6sm40423622wre.63.2019.03.13.22.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 22:38:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] packfile: use extra variable to clarify code in use_pack()
References: <a026ce9f-b825-7fc2-2ad5-c0b00bc508b4@ramsayjones.plus.com>
        <20190314001940.GD31968@sigill.intra.peff.net>
Date:   Thu, 14 Mar 2019 14:38:25 +0900
In-Reply-To: <20190314001940.GD31968@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Mar 2019 20:19:40 -0400")
Message-ID: <xmqqa7hy9fse.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it does apply, though the reasoning in the commit message of
> "this is OK because 'left' is large enough" becomes a lot more
> hand-wavy. The patch is not making anything _worse_, certainly, but the
> fact of the matter is that "left" still might not be big enough, if it
> is not a size_t.

True; it does not make much sense without the actual size_t
conversion, I would think.
