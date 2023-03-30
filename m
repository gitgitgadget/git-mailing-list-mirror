Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC45C6FD18
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 00:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjC3ATS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 20:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjC3ATR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 20:19:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7E11B
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 17:19:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y2so11423212pfw.9
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 17:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680135556;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJb3lfaNhdsg08B5aSe9zvDwcObRrSmwgfBqWCwC6Z4=;
        b=Xpp+kVJySDY9DmLeLddaczeTEGYmCEyMioex5OfLIR32/bEA7QpKXBUTFTs8jvKcA/
         tXZsKrmfjMAagLV6xytC4NTImvluU4vFDgLDXsjhXuRwT72PNt31FmnrFkR3auyDziFI
         HwWRXSBR8VrJo0iiNPXKH0IOIacOzeJCYRM7SOXXrNmQUtCyusiJiDFdDIyNjbRZR0zP
         hLmmt02Odpalp4exYhL2dNprNAsQ4XB+dXvDucmwrpWFcS/50c+MXxFi/WbgYhh2iCXD
         aVHdoyXGmuhPZyXdur+9Z/wnRd0oJ6HRw7GaDMri8rOKBNgEyPxkh9+SLR/TGzO95qfL
         Iw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680135556;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EJb3lfaNhdsg08B5aSe9zvDwcObRrSmwgfBqWCwC6Z4=;
        b=D9TtoT424ED1IebYvJRxNoT0PSb5cqF0WBJ8X5LX48d4sTzCspywpyRwE9zwtM7Amf
         aNpKWgHy1fwuzN2jIl9n7V3LkqmzV4kWVJ57vJGw17kM2YOWT1qw5vm2dp2Tu9Heyy6q
         eFKlfEvw2tYHSFM2gUG4sHU/3afoFDvMGd5arZvlQFxqv9NSzxJiqaM2ZAJEvzeG9YUk
         1v/ceS5gY1mCQRPSq6Ep5mgh7Y8O3LxqjGbrx0GGol3LODpxhaejTzWarhdmbkB637IL
         1FI5E4pzFNw4UNWFre+ktmA/U6IViWUSWjHjn75+Q8A75kLdxgU6AezouA3DklVY/Iz4
         mXhA==
X-Gm-Message-State: AAQBX9eONeDRMrmO4gSGRVEB6zX7nD1szCGlfKv0bCY4Wh0u90MJ4MaF
        +LwGIoEQ63cLQk7JeDDtxL8=
X-Google-Smtp-Source: AKy350aRIpkPIcDlKC6PybPDGGncho1Z9IdZt8G0+cx4QR1W4nlkgpjvQ8HjJGKLUvBmBXdI7pcrIg==
X-Received: by 2002:a05:6a00:1345:b0:62d:c459:bc52 with SMTP id k5-20020a056a00134500b0062dc459bc52mr853925pfu.11.1680135555860;
        Wed, 29 Mar 2023 17:19:15 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id a3-20020aa780c3000000b00628e9871c24sm14965683pfn.183.2023.03.29.17.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 17:19:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2023, #06; Wed, 29)
References: <xmqqv8ij5g83.fsf@gitster.g>
        <20230329231826.GA2314218@coredump.intra.peff.net>
Date:   Wed, 29 Mar 2023 17:19:15 -0700
In-Reply-To: <20230329231826.GA2314218@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Mar 2023 19:18:26 -0400")
Message-ID: <xmqqr0t75bwc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> * jk/document-pack-redundant-deprecation (2023-03-28) 1 commit
>>   (merged to 'next' on 2023-03-29 at cb64256b97)
>>  + pack-redundant: document deprecation
>> 
>>  Document that we have marked "pack-redundant" as deprecated.
>> 
>>  Will merge to 'master'.
>>  source: <20230328190641.GF18558@coredump.intra.peff.net>
>
> The application of the patch missed out on --scissors, I think.
> (I also expected it on top of jk/really-deprecate-pack-redundant, and
> for them to graduate together, but I don't think that matters much
> either way).

Yuck, that was very sloppy of me.  Thanks for catching.
