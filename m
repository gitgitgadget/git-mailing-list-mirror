Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3468EC678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 23:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCBXr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 18:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCBXr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 18:47:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD2A5590
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 15:47:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so607718pjg.4
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 15:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9rW3rFSJU9QlTvvghjufi8a5H1R/bIIV5jN6w6t3ko=;
        b=M6jd7BDtwLY8v/PUQQQ8nVBO8kKvOu7DWEGPduACLC0sqWxjRU2rAaZ+BzugO80AuR
         4SYl88wD9wWUVB1TMmoWUsAHO7VX58dVZ02zMlHGdecFMUEh3Cp1mjK6Spx10jerBysk
         hQCO94Pm0E/pWRZLjF6xZWlX4i5XevfkZxi9vvT0LoFJnc9fl7KOnawcWm3l89+Y3VX8
         OfmL1oLcmoG/HEGsIrSY4/36YYLk9F68wp/lXWGhd+Kbyb7edAABGrxiWhiLL0MaujIi
         DuhmMb9cfbty9zoCW9DD+82ey7T3Mu1pE6WBM7yGX20ZxMJQf/d9OLLtPltERVpp/qh/
         kwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9rW3rFSJU9QlTvvghjufi8a5H1R/bIIV5jN6w6t3ko=;
        b=k49capQ2eJhK+KPyUp2YherrCDbZ7LEXjkDZQZXsF8AifQLFQtTqFLFW/aHin5gtWM
         YwKEYXOZLL915vVJTyWw/YZgOk56AIEh6OchEG3kmt1sElraa48MK+ifcjlc49v8oSqP
         dyzfILhSiXPq4yq7p19gfQWhXYHc8k3QJwgfm8pAmjUhCDhg7fK6LozbnlQuAi12LXiD
         DP3FKmwsh6049ELc5K7yqTl4Sv8sbhK0bVhnCjm5oOxP2O+3CZVdRXUao0mHFPyeHtxR
         x4tZSUaAzb0L6KzWEn6rtag6yPqrmCOy0P+KjsdF8jGKsnrtC1ueHajMLBeST1ku5ZIk
         pD9A==
X-Gm-Message-State: AO0yUKW8ZIzZfSGxQbbia1xtSnIxzU1x9QRUY60A8UMpKsanW3Ww4uDn
        njEVhQrOrnzfow7J4Bpc1Dce+QGcz6E=
X-Google-Smtp-Source: AK7set+H/WFkkdjMsDrOC0k3kx4M5GjM/YZ0MMYXZf4muB1StSymkSfK1ms5Oz11rHOpI9rNg4uW7g==
X-Received: by 2002:a17:903:190:b0:19d:2542:96a4 with SMTP id z16-20020a170903019000b0019d254296a4mr96239plg.4.1677800874813;
        Thu, 02 Mar 2023 15:47:54 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id kf5-20020a17090305c500b0019b06263bdasm222017plb.69.2023.03.02.15.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:47:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Dinesh Dharmawardena <dinesh_dh@outlook.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Let us not call it git blame
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
        <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
        <ZAEgRDelTlNZRJ5J@tapette.crustytoothpaste.net>
Date:   Thu, 02 Mar 2023 15:47:53 -0800
In-Reply-To: <ZAEgRDelTlNZRJ5J@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 2 Mar 2023 22:16:36 +0000")
Message-ID: <xmqqfsamiul2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-03-02 at 22:00:59, Dinesh Dharmawardena wrote:
>> 
>> I am writing to you to request that the term blame in git blame
>> be replaced with something that does not sound so blameful. I’m
>> an SRE and we actively try promote a blameless culture as such
>> industry tooling should also follow suit imo. Progressively
>> phasing this term out with a better alias would be great.

I actually do not think "git blame" is incompatible with blameless
culture at all, unless you blindly say "this word is bad, that word
is not" without thinking.  Blameless culture is about not blaming
the _person_ who made an earlier mistake, but "git blame" is not
about finding a person who contributed the badness to the codebase.

It is all about which _commit_ contributed badness to the current
codebase (i.e. "these commits are to be blamed for the current
breakage that made us lose $XM") and it is up to the users how to
interpret the story behind these found commits.  It often would not
be the "fault" of the author alone, and striving for blameless
culture is to find out what led to the mistakes in these commits.

> I believe there's already an alias for it, git annotate, if you'd
> prefer to use that.  The name "blame" came in with CVS, with the
> synonym "annotate", so it's well understood, but you can use
> whichever alias you prefer.
>
> I do think there may some differences in the defaults between git
> annotate and git blame, but if someone wanted to send in a patch for an
> option to make annotate produce identical output to blame, then I think
> it could be a full replacement.

At that point we can retire "git blame" and make it a built-in alias
to "git annotate --behave-like-git-blame".  Then we will come full
circle ;-)

Thanks.
