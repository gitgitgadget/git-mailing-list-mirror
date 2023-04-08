Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C04C76196
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 00:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDHAHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 20:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHAHu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 20:07:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFDF113F5
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 17:07:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a2104d8b00so253165ad.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 17:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680912468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bsSSJCRaUEHm1VWBWCZk1HZ86MuAR3ciMZfVBUm1168=;
        b=acb/eyEiMfa8FOtSj7Kav/xBBFiX46j8LKq5h6qm3A4smV4EzE3x4rBRfSmX2ldJcc
         oxWqWjLguICOdQQI5rbrVNEnBrbKVYjR5nRPGo9F8aahG/Rt+6NfJ1vV30jfGlZwbFnL
         DTcuk+UKOBj6mFNTTx1toFFJBpEk3eYo1+yAC5nabDZ0zp0L8BT6JT+R/PMYCOtzUpDK
         kFbvJ+2MOS/48y/+UNYVZXndjBpZJV67rtvj2127wl2Evc5dpkowsU/GCAWPvYq0YFey
         BCTUnlZlIArqxTqId+pq93P80k2qYWCa+XKc3RYOijgrODSff29OHRdmCHFj2ilrxsm4
         mUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680912468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsSSJCRaUEHm1VWBWCZk1HZ86MuAR3ciMZfVBUm1168=;
        b=5Dm5FaSKZ+xLYqUsNr2dHclTMAf8wTOyXWLDkDpRPzfDLaMczd+3gatM1xBfc+Q1Iu
         G0SN8d2Q4xBSBJWC4NzAvI9EoI7fKm8Cb98bAtb8m4fOBMMDDbEOkFCPibhXLEMtjnLt
         BeoZ3AEvbmy/6CJwUeoiov6jolZhBFU5EnE7hYXpGM7VlDG/6HR0R1Gq9wPcNziV8XJ7
         CyT++lkVlO1B18S9fGkvWKhBqFsFDSfLUtngBnETzNz5TGd2TnFZCk3T0Lk++2qo6PiR
         yUWl9VGoRIHTv6da9rMrJig9ucJueU+LvKP4oGX46Cd8iXoUX9im58jolncvjyyOoxRj
         oXEw==
X-Gm-Message-State: AAQBX9ctf5XWwx1CPeFh2IdZU6oELp2x+JnaZZWkf5rPpfaPHaUCf5Ux
        9q4P1OBAPjgk04CVnHEK7vKeJ4XFS9HCnzM1gfZ2hAUo
X-Google-Smtp-Source: AKy350ZLAFMz69IBi4RxszlxkJbmoUfIDN8b4VOzYea3/HPQLuG7a3JROtPbVBR1238eXj6/5KknGw==
X-Received: by 2002:a17:902:ba8f:b0:1a1:c941:2f77 with SMTP id k15-20020a170902ba8f00b001a1c9412f77mr112068pls.4.1680912468285;
        Fri, 07 Apr 2023 17:07:48 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:3cbf:c928:3960:94f5])
        by smtp.gmail.com with ESMTPSA id 3-20020a630a03000000b00476d1385265sm3134691pgk.25.2023.04.07.17.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 17:07:47 -0700 (PDT)
Date:   Fri, 7 Apr 2023 17:07:43 -0700
From:   Emily Shaffer <nasamuffin@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage: clarify --recurse-submodules as a boolean
Message-ID: <ZDCwT3mhaGHyydng@google.com>
References: <ZDCWrl4GhgYKYFYG@google.com>
 <xmqqcz4fi7bd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcz4fi7bd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2023 at 04:47:02PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <nasamuffin@google.com> writes:
> 
> > `git switch` `git checkout`, `git reset`, and `git read-tree` allow a user to choose to
> > recurse into submodules. All three of these commands' short usage seems
> > to indicate that `--recurse-submodules` should take an argument. In
> > practice, ...
> 
> Did you add 'git switch' at the last minute in so much of a hurry
> that you forgot to put a comma after it, or rewrap the paragraph?
> ;-)

It was 'git checkout', if you must know ;) and in such a hurry that I
also neglected to s/three/four/g. Will fix it with the reroll.

> 
> I do agree with you that "git checkout -h" and "git reset -h" that
> list
> 
> 	--recurse-submodules[=<checkout>]
> 	--recurse-submodules[=<reset>]
> 
> are being unnecessarily confusing by not saying anything about what
> these placeholders are to be filled with.  
> 
> This however is a breaking change.  Even though there is no hint
> that <checkout> and <reset> placeholders above take either Boolean
> true or false in the documentation, they may have picked up a habit
> to use the undocumented form from some random website.

Ah, yeah, I see what you mean, from my locally-built version:

  g checkout --recurse-submodules=false master
  error: option `recurse-submodules' takes no value

> I am not
> sure it is safe to change the behaviour right under them, like this
> patch does, and I wonder if we should do this in two steps, with its
> first step doing:
> 
>  * "--[no-]recurse-submodules" from the command line gets no
>    warning, as that is the way we recommend users to use the
>    feature.
> 
>  * "--recurse-submodules=$true" and "--recurse-submodules=$false"
>    (for various ways to spell true and false) get warning that tells
>    the users that versions of Git in a year or more in the future
>    will stop supporting the Boolean argument form of the option and
>    instructs them to use "--[no-]recurse-submodules" instead.
> 
> We may have to also mention in the documentation that historically
> the code accepted a Boolean value as an optional argument for the
> option by mistake, but we are deprecating that form.
> 
> And after the second step, the code will end up looking like what
> this patch shows.

I'd be happy to do so with a reroll, probably on Monday. It's true that
while these are user-facing commands which we don't guarantee backwards
compatibility for, there's not a reason to subject users to that kind of
pain unnecessarily.

Thanks for the quick response.

 - Emily
