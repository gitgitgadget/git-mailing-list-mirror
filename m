Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE92C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 17:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCFRKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjCFRJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 12:09:45 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C506425B
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 09:08:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v11so11140568plz.8
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 09:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678122525;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CODHKx0mhXr+B+bCV2EogyvbJOlEleXT6SI2H68VdY=;
        b=p2kw6u40qgGoAsb9cnVyhlhx5jvcI1o8vIbN36ZdeHEpObrofa82UbmLM3+9NO86FP
         a+Pux/1+oAfp9LUJ6lBBRhxPOBCc0frV83EBRSw0pQ+tF6vuDTEAjRG5RPNdIWN4Xqxp
         +sGtYgw1QXGfndk/6Yv/EuY26bx/diCZ3AaV7GxiU6fiVKZniyd+ZepKuakJQjPhT11M
         8HOcTJSSl6B6y5MB31C52FZlQIkVmYmILfYJwtLcEigPWn61Bd2TLcM+FgZu36K+exPz
         87tQOxWIu0UA5p7jN4oqgxA3pBCKwDzB9w6yEsdJXL5JMKsQCSTbs5YQ+YtrH5x4nYi0
         4g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678122525;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4CODHKx0mhXr+B+bCV2EogyvbJOlEleXT6SI2H68VdY=;
        b=2wmq7gL6083+PLH/QAmgQIL9qN6YQzrfDRJBkJ2Z2QIhtuuFH4VcOYjJI/N8djzddK
         jgDQ3Rqkh7rbaRg4Ds4CLyu8NQNV/KDb0/K3N1K6oRM6yB7Gp3y6xgxXQBbYi2/BYC6a
         bGgPFKo1LxwacnqSC3oxAuJe6Sma+P1Ha+4avfKRgEUGKZ9kJwFJqwP+d2StLcKOJ2pK
         ztWJqx33A0GQEo3mS/eEau6edyR9HjXD8pM0p8/yLlq8+6uzk1jFngR3busrAhgqPI0c
         9CR7YpiKRzDZ2g0WGgNXKsj0Hp/UOcSr+JbskeQpUWVa5SVRI6gE6FuSbgDQHNtcWADg
         ywgA==
X-Gm-Message-State: AO0yUKX9AiGlYF34t9wO3dC4kIhtcX/a0nVF2yI98wkmUtd7x+19gZ8m
        OHjT0jgZee7Apd6Ptzm2RtI=
X-Google-Smtp-Source: AK7set/R8ANv2++v1S/zz0wFWbSppFTPPhdfaqFCFcklutWZEiocoVIbuxcAwZwwscwx/Th8Mcof+w==
X-Received: by 2002:a17:902:db05:b0:19c:da7f:a238 with SMTP id m5-20020a170902db0500b0019cda7fa238mr15322378plx.31.1678122525090;
        Mon, 06 Mar 2023 09:08:45 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b0019c2b1c4ad4sm7012754plv.6.2023.03.06.09.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:08:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     John Keeping <john@keeping.me.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: output header for empty commits
References: <20230303160301.3659328-1-john@keeping.me.uk>
        <xmqqwn3xg3m0.fsf@gitster.g> <ZAMhOehmuIov/KM8@keeping.me.uk>
Date:   Mon, 06 Mar 2023 09:08:44 -0800
In-Reply-To: <ZAMhOehmuIov/KM8@keeping.me.uk> (John Keeping's message of "Sat,
        4 Mar 2023 10:45:20 +0000")
Message-ID: <xmqqlek9byeb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

> On Fri, Mar 03, 2023 at 09:13:27AM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > When formatting an empty commit, it is surprising that a totally empty
>> > file is generated.  Set the flag to always print the header, matching
>> > the behaviour of git-log.
>> 
>> Don't these empty files help send-email as safety against sending
>> them out?  Unless existing tools depend on the current behaviour in
>> such a way, I think this is quite a sensible change.
>
> Yes, send-email fails trying to send an empty file, but to me this feels
> more like an accident than an intentional safeguard.  If there were
> something intentional I'd expect format-patch to fail with --allow-empty
> as an option to bypass that safety check.
>
> Since there are checks in place to avoid unintentionally creating empty
> commits,...

Speaking as the original implementer of format-patch, the original
intention was to forbid such a message to be sent out.  But it was
designed back in the days when an empty commit were not used as "a
marker in the history" as widely as these days.  IOW, the original
intention does not matter all that much when we have to determine if
the code with the proposed change would negatively affect _today's_
users.  What the users would see is that they have been protected
from sending out such a message by mistake (an empty commit may not
be something you created but you pulled from your colleages), but
with this change the protection is no longer there.

Another worry is if the receiving end is prepared to see such a
"patch".

Overall, if we were designing format-patch/send-email/am today with
today's use cases in mind without any existing users of these three
commands, I think these three would be designed to pass an empty
commit through the chain unconditionally.  But we do not live in
such a world, so perhaps some sort of opting in may be appropriate.

Thanks.
