Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912A2C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 21:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbjHKVL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbjHKVL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 17:11:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47832AC
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:11:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586a5ac5c29so28022737b3.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691788285; x=1692393085;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAYJdiOFAs5nPhtLCGSZ1F0oiQ0z2P99WZIU8k8MOIs=;
        b=mgsp1nga29z6S8zSage4rO5H6HxliVwzt0GJWcL0yChVytvspot9SBSigopuB8Yvl7
         c3las/Nt+Fq1pQPIAz6QbIV/pH8yhd7Zn6zKRvcaRbmfpoNWFVtiG1+i1/0cgCEOlCeY
         +nwHIxHgqsfOcMREwwVJi1xJ0f/wV1z7UjqkoCf+V95xA3qfk6XOZQG3A1+zp9lhiEkm
         XnDWdVTVI0Za1Q/kRxLiqdnRJ2fSEhD2bA54iNDQliI9wR4Y7R8q9oSoSGDxU33tME6s
         CBeOtitks7ZJ/PJ+inFmLIvKTvrkI0CL8Fcd5FEBE6PUCoEupT8FNwQUyFGJscFm2AwC
         XrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691788285; x=1692393085;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAYJdiOFAs5nPhtLCGSZ1F0oiQ0z2P99WZIU8k8MOIs=;
        b=UdME+sUAKnduy0pkN3igoB8XEVv6Suxrb6kpvKpo8jM6wh+FEWoeXJPVBqi0zJZ72z
         75hTMgssI/iP6CoVXuNBOnBQFGYDkBLl3/TZOXo08h7AYcOPilJc9NU6DyQs3a0jFCK1
         osckqb395GoMy74hRdpyGlGomHOdsT4IDOsrabh/jkotN6ABS3wHxnsn8xiYFGeAAPTS
         M6RI2cff8KxpwqbqBHCuMN5oWYymlgNd9Ibgt+UmwNqUqIq9XCVeGloEYIMt3v+h381B
         Ys3j2c8uzuviTpayaJ55hvV0mvLUquPykhBglvSCuzZ6z37xcuKM/lqlGpj74iS93SxB
         M3Ag==
X-Gm-Message-State: AOJu0YwEo23jQwT/DyYOeoFgYqn6Ni8bE7MrmPc/N6m1E4TrGa95WRkh
        J9OT0aiVdfL4KMrn5hM57CycKL0GEosSOw==
X-Google-Smtp-Source: AGHT+IFHkWIVZuVeBgqEJx9pYO9uxWTI49Mne9UHW7vpypq9rWtWesV91B9AXAQ2jfcMBbhpTQ+h88o4hMMSdw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:ac45:0:b0:57a:e0b:f63 with SMTP id
 z5-20020a81ac45000000b0057a0e0b0f63mr53088ywj.7.1691788285531; Fri, 11 Aug
 2023 14:11:25 -0700 (PDT)
Date:   Fri, 11 Aug 2023 14:11:23 -0700
In-Reply-To: <owlypm3ufl7j.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <c8bb013662187e9239d4a2499a63ed76daa78d14.1691211879.git.gitgitgadget@gmail.com>
 <kl6l1qgea2k0.fsf@chooglen-macbookpro.roam.corp.google.com> <owlypm3ufl7j.fsf@fine.c.googlers.com>
Message-ID: <kl6l5y5l8etg.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 3/5] trailer: split process_command_line_args into
 separate functions
From:   Glen Choo <chooglen@google.com>
To:     Linus Arver <linusa@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>> I find this equally readable as the preimage, which IMO is adequately
>> scoped and commented.
>
> Aside: is "preimage" the status quo before applying the patch?

Yup.
