Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4755820188
	for <e@80x24.org>; Wed, 10 May 2017 17:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbdEJRAu (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 13:00:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33519 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbdEJRAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 13:00:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id s62so176776pgc.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+QYwfDMcIYyD2xR33VmEGzHL9JWId4NqMTERFt+DqY=;
        b=En5LdmtKAFENLomQn6NOoV3LVFA99mAu4bBQh9mM3j8b7wqQs4kFaYZJirRfyan06m
         2xwIg5HPKla4BG/eN+wdrvDFUrq0jDGD4ljs7ip03xUAe97vxGxtbF3aeTZvJAIwzAun
         C0GAWGkearKCOzQ2BSDw8CuH1VBjLjST2PADw+qdQzzmLqCxxgaC24OSnIwnY+DUgZ2s
         EOmqfdVhcs1WVCi4nkiRbKt07PZ/Tmk780a0bU5xSbtedxVw0SPQxRC4VK7EXoI7r7k8
         mG2kjka24f5Wq2amby+yqE85VfzQ1j4gWr3e5AKscJt+yCmQbjtgc1ZSPBaB+svZCVHl
         EwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+QYwfDMcIYyD2xR33VmEGzHL9JWId4NqMTERFt+DqY=;
        b=BhYREBe/BvzZshs9C4J6eQKFI8STTiQ8gdvcDtj/FT30yguB8S74tPQg4RZ8KogwsM
         HSR93rtTdwZyxMWyFblPrc/PW2/1qpHz+IwDKbg0RIm4EwwPB9qFQaX7uw3oNy8QeK/U
         lvM0/rqj0JDSr6HEuCGfdFPcL7hZLJsZJ3GMlr9wNSqusP31pIgW2YRt3e8AadyAWcIL
         25e5GV8o9PgxpBgmNM5CLRxBGKM4sdWUgTMbe05DDmL60P6nB/4y3eLjDne/rJ8H2RXh
         I6zNlDkBrKbU1AC4Bwz+sKPBNBln25kC5ELsiO32lLi0t8dtc39VIkV4n7ZYAjKbKHop
         L/EA==
X-Gm-Message-State: AODbwcAm+74/jB4tn8hFeGPRg0dlqw1xIwOCo//lINlx21LJPLNZeCvK
        rkMCglpRIL0+Pw==
X-Received: by 10.84.178.131 with SMTP id z3mr9513831plb.175.1494435647717;
        Wed, 10 May 2017 10:00:47 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:55dd:a079:3f06:9176])
        by smtp.gmail.com with ESMTPSA id l7sm9217648pgn.10.2017.05.10.10.00.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 10:00:46 -0700 (PDT)
Date:   Wed, 10 May 2017 10:00:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170510170044.GX28740@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
 <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
 <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> Right, makes sense.  I wondered if GitHub should be turning on
> allowTipSHA1InWant, but it really doesn't make sense to. We _do_ hide
> some internal refs[1], and they're things that users wouldn't want to
> fetch. The problem for your case really is just on the client side, and
> this patch fixes it.
[...]
> [1] The reachability checks from upload-pack don't actually do much on
>     GitHub, because you can generally access the objects via the API or
>     the web site anyway. So I'm not really opposed to turning on
>     allowTipSHA1InWant if it would be useful for users, but after
>     Jonathan's patch I don't see how it would be.

Given that, what would make me really happy is if github enables
uploadpack.allowAnySHA1InWant.  That would be useful for me, at least.

Thanks,
Jonathan
