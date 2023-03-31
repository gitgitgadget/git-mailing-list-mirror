Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4677C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 15:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjCaP5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjCaP5U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 11:57:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C620D9D
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 08:57:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso25900311pjb.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680278233;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6O/kEsxPhKWa9o9CNr2ZwLRQd/PS5jRNId1XF+brl9U=;
        b=Zh1Q+baeruJIJCxHcidNCZH8VWygmmv3m2QCts7TBOtJY+JVKZzOz4qBa9GkJPT2gu
         4lXFeKoQtuQOPomrVDsZLVS+hA5ZfTweIA7m6OpeQECqz7IeRiNnNSyzUneSpRXBbR8M
         J+A9U0vakDaLkPgS1ghGttQ+uvIA8Y3ZJ8Tsci+HE6C1p/e4EPWSG+J/9GQb+nYW06Vz
         R8LGsk5Tz1LOX1Ejq63S4RI7R7QKHmdcxRPFzI3Aut6/PZ9w9X/OWE/PRg9+Ot45gKzQ
         2tcN5hNmw3GYQvJ1USfu5qiEyIpK5EwsYF7gr91XH0uvhTBg2vBUaZmG+u7xjmop1phO
         om2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680278233;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6O/kEsxPhKWa9o9CNr2ZwLRQd/PS5jRNId1XF+brl9U=;
        b=4A+A2lmwfry2IpynjolVd+DUYnOdAy3ZLuRm7qaeEikXUF1SY+FpzYGMooeoMXOS/O
         eR1bSHNkrmsrqCc619tan/9XbRKnQWu2OsewpSlr3hN0X9xVdmPXMFZtnvga8Tju9WFB
         dkPCzEfYC4mWbjVbry8YdAYMtUTBMA41F71Vm/TVr15Xx9aewsDQA1nOTI3hLgkbUpdE
         68g3WrwLrmbZu5bnX4ixutHZcIy3DlhgxTOaebYM0d5fCTDRi6efqOh702RCdrAZOZjX
         V80Q6wdK0EVVLskcHiAROQKxPMnkBH6eQhl7fx2DbczLhzgRqo0PpelAj3RHfJGlnM0r
         lFcA==
X-Gm-Message-State: AAQBX9fk9A/W/5B/akoEMZR52JOiYvfwYxDEJsOIdcJjAYoRGCKhbwLr
        UjDqtaTydObVEjG7VaAQGUdg2k4ZCs4=
X-Google-Smtp-Source: AKy350ZoETjLGJmHGrasX4gi1g4Qdim/wUQr73f4XOW5cV5DjkUu9tbmwUEN7TrhOe+sRwkoYNeRzQ==
X-Received: by 2002:a17:90b:38cd:b0:234:67ef:304b with SMTP id nn13-20020a17090b38cd00b0023467ef304bmr31933579pjb.37.1680278232972;
        Fri, 31 Mar 2023 08:57:12 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902bb8100b0019a7c890c5asm1720026pls.263.2023.03.31.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 08:57:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
References: <xmqqilei1bgk.fsf@gitster.g>
        <20230331083213.12013-1-oystwa@gmail.com>
Date:   Fri, 31 Mar 2023 08:57:12 -0700
In-Reply-To: <20230331083213.12013-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Fri, 31 Mar 2023 10:32:13 +0200")
Message-ID: <xmqq355kj4mf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

>> > +             if (omit_empty_lines && !format.format) {
>> > +                     error("--omit-empty-lines without --format does not make sense");
>> > +                     usage_with_options(builtin_branch_usage, options);
>> > +             }
>>
>> Does it not make sense?  With the default format, it may happen that
>> there will be no empty line so there is nothing to omit, but I do
>> not see a strong reason to forbid the request like this.
>
> ... it's perfectly fine by me to allow --omit-empty when the user has
> not specified their own format. I added this merely as guidance for the
> user. For example, Git will bail out with a similar message if the user
> tries to unshallow a repository that is already complete, which I assume
> is technically not a problem.

It is not just technically a problem but from the end user's point
of view a misguided message.  If the end result is in the shape of
desired state after the command completes, there shouldn't be an
error() to stop the user.  Informational "the history is now fully
complete---by the way, it was already so before I started working"
may be OK.  It probably should be fixed, instead of being modelled
after to spread the mistake to new features, like this patch does.

Thanks.
