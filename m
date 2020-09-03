Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D190BC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 03:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA83A20716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 03:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRCBZo0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgICDuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgICDuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 23:50:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979BDC061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 20:50:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n3so3078949pjq.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=30U900nKSE9HF5ZokO6rioq5Qz1mWd75bISBIBUS2lY=;
        b=mRCBZo0ZH8dc3q5aJ2fGpFnfQK9s8oQxGmdCQO2e2AzBqrcby9/u1qcMKrr7+AhFq+
         e51feY55Efvg83F5LJQtJgABX1pEutT6SOI97CrBWgasJrunYUdKoZysOT1Vdh65eer4
         nEvTFGH8ygKxMWtPh7qerC9UtDWiJh5xrm2Gpc/aUp3NiONI014ibixsMznEsLQXjqFC
         9tZHZQ232L4hx6uYuhhGLs7Aulpo5ITbQ99dLeFC0NWPvf2QNFYDUGkBOhySgNEImMDL
         34LnR4BKrgCvl3ZeZmmK1NnHfHcCeNisVKg1GSwwbeG6gOJQp8iuNtI327PKIlwHIwsZ
         f2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=30U900nKSE9HF5ZokO6rioq5Qz1mWd75bISBIBUS2lY=;
        b=cUp3RX00hQsxYge2QIRjRt3S66DgrZkKQOOdqSIxf1dL6AFnSS6Z+33ZDvF068fUaL
         Hy/hLOu1pqW5cgjAGDczjOsrpFS0RDi0LU+hpP2XzwUugHWKR/D5N6wCjwaTAdp9/W3/
         FkCSGL+zEtP/Ym8I9+gamMEW96tjqKy8ryhfQp55RPQ6FegLYOC7IroyJobiRtNlYoxV
         EZONkk04c2qoN32sQ2p6vMBw5DNxUtA4fZCWGZnRc1ipSPx9dnhhsrq1e53/M5LzDae+
         E976PKA4pNZAJ2Y2ZfXtHrPDj4IBAvbMnFb2nqhspwyWiwzvHDEYzC8zc+w075Xvv8sV
         OZrg==
X-Gm-Message-State: AOAM533l8fA9H9KlAJHU/5xoIopGldN0yCwWUfF0J36HD+y47ltL77Q7
        VYMiik5AWM/aSqtxt+D//tU=
X-Google-Smtp-Source: ABdhPJyNsLAk0HcDVeD3dk66EYeKZ06h7b27EIvOHi15bvOJjtKxPs7vYuQ+5ImFxVLHcKf4EDQM/A==
X-Received: by 2002:a17:90b:108e:: with SMTP id gj14mr1170628pjb.225.1599105011137;
        Wed, 02 Sep 2020 20:50:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x188sm1076766pfb.37.2020.09.02.20.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 20:50:10 -0700 (PDT)
Date:   Wed, 2 Sep 2020 20:50:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] xrealloc: do not reuse pointer freed by zero-length
 realloc()
Message-ID: <20200903035008.GF4035286@google.com>
References: <20200901111800.GA3115584@coredump.intra.peff.net>
 <c81b7225-a663-1598-62b3-bd80457d5648@gmail.com>
 <20200901135105.GA3284077@coredump.intra.peff.net>
 <xmqq3641ebep.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3641ebep.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:

>> If we do handle it up-front, then I think we'd actually want:
>>
>>   if (!size) {
>>           free(ptr);
>>           return xmalloc(0);
>>   }
>>
>> (i.e., to never return NULL for consistency with xmalloc() and
>> xcalloc()).
>
> Makes sense.  I suspect that this is optimizing for a wrong case,
> but in practice that should not matter.  Not having to worry about
> a request to resize to 0-byte in the remainder of the function is
> actually a plus for readability, I would say.

I agree with both points: if we were repeatedly shrinking and growing
a buffer and cared about its performance, then we'd want the first
version, and since we aren't, we should prefer this version that is
more readable.

Thanks,
Jonathan
