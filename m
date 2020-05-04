Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09F6C4724C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 08:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49C720735
	for <git@archiver.kernel.org>; Mon,  4 May 2020 08:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXFhdfOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgEDISI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 04:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727100AbgEDISI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 04:18:08 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8EDC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 01:18:08 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id s10so10400200iln.11
        for <git@vger.kernel.org>; Mon, 04 May 2020 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhbZateelEFC8kI+wyuWDbRSB1TE747izyZb940nELU=;
        b=oXFhdfOhby3pqv5tlkT2GlA1W5ks2JLxHJCckFITCUn4dggFH8KOLT0sFQlG/iNGpW
         2WTB/OGy7m6be04YNeQ8vKSUZ0V7zzyy4ptQd0h8HJZvK2XBmSAl2+tIyNBbrK1ZCxdV
         qIYFHpxYYmk01fR4f1gi/R3h/ghgEZnD2JLXAdJie3Ux84mz0hgMzmJFO3CABnCQx/hw
         euRxyJPyX+GjzVAvc5gdl63re3NuOXEEtQmYxqUfNeZAUSg5BRmJKdKOLXEEv5nO13sI
         CQhRXPgFQakh/oh0LpyGDeiHdIs60inyxRt4j/m2EPI9hH8AwvbkKYAR0Ut34IdJfDId
         tEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhbZateelEFC8kI+wyuWDbRSB1TE747izyZb940nELU=;
        b=jx6rQB5xTigYNal53eNHvYpDVxc03jV4fc4ebUfQNw6ht/E8z8fQJbSRGUQ6p9B3W9
         Sk6PhWN+0uO7+ULTpUVh7RVovS6YMAPqMPlWjMSgINNsU03SHIKT8zP9Fx2fa3wSWJ0z
         siNNAcr4uH0NZk1XR8fuiAEjwkLz3MRNGi/u7M5QiiVASOH0u2RHB+q7NhFWFOh0AA1R
         tHAA0jXM40jPbbm2Dr5lliEMlqQwuD20Hm3j5yKG0fVVYwVcloej4HrN1obEBl9Vlk2H
         Z5w9rfKwYD55wX4zCO2JwaU/0SGxgV4ijSoMrhi3D4Mgg3QHjgJ5ktgeBCvjRsig3rZ0
         FcyQ==
X-Gm-Message-State: AGi0PubsQkonsa3zgDED4Wn0TSH0m4s4cmRWf8cxn561kBLLIgaUiNAP
        VgiLH66Ie9k4hEdYH3fBUrxq4laWtLG+sI/IBA==
X-Google-Smtp-Source: APiQypJEVzH4KVeHDt4Z8YGhQcY0X/zjVq2y9jpGDR514VzCbj1qT5VNPaiIccRZ5BxAE+5WMgMAfBKiUZcHOxhNJAs=
X-Received: by 2002:a92:6b04:: with SMTP id g4mr15927976ilc.82.1588580287778;
 Mon, 04 May 2020 01:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
 <20200504055530.GA13290@konoha>
In-Reply-To: <20200504055530.GA13290@konoha>
From:   =?UTF-8?B?RXdhIMWabGl3acWEc2th?= <kreska07@gmail.com>
Date:   Mon, 4 May 2020 10:17:57 +0200
Message-ID: <CAEoQP9g2UKQDi0i8Fi4HRp1d_U=qq4gfoK_vGwRYuPN+mU+GxQ@mail.gmail.com>
Subject: Re: file is showing as modified even that it was never commited
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

thanks for your response.
I consider what you propose rather a workaround, while it is really
important for me to get to know what happened here.
Could you help me investigate this?

I though that I might add those files accidentally before. That's why
I checked it, I described it in the original email.
Did I check in a wrong way?
