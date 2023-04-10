Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E13EC76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDJXoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDJXoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:44:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698A31700
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:44:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q2so10972770pll.7
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681170241; x=1683762241;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CX4dauBHRblUwSd9JSZtLhW4jGN1rjbvnWBqEwotlaQ=;
        b=hZBwzrLBX4tMfpbLTqAt1CotxhUfUs0PkV+t36cKPOcC8wClo3eY4XMh9pB7gqo/cV
         GWwe7s3a8VqoZXNLxrsek6J1CbjqiYbEI9pn2uMEQaRfMOycdXIMump0d0MMFbkZAyM4
         1vX/XviLR7Xu8XMR6gV54vFJGq+x9ZKkcWk8yPiwZUD6rhk03WJDOfcyumRMWWEct8JI
         qM1+v0XytpH53VnK5m0siup2KITCwJc6Md7bkovgPJEPkFdpgMVRTSb42cDS/ucEeLUl
         Vc4Fn/DI7WNwIdA+sCVs+lY7HNgLaF/cxpeqq1gZAKt22WaiAmjf5KFexUu9ifoGDxCE
         hfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681170241; x=1683762241;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CX4dauBHRblUwSd9JSZtLhW4jGN1rjbvnWBqEwotlaQ=;
        b=6Owu7woiosimFa2xFdAzjmjZ/IdTCVsKP8OdGL5XJuATeGzQqyb5QdGGunK+U2fLpX
         KE2ctFOPCannD+Nd87oL3u+KxCvoYsr0cY1XTUun9eUpWCJNvEe6O7ZyVYfWGBwDNvpy
         TGf0zX0N1GC8uAeGXuDxoWmvhWGrQEQDxW+m9lqcnppPXcwwyVYskPVj4WhTvNObmhb7
         Na8iEQWPwjARNONCtzt8PreIgNdml5x7UF95hVr1uaI7eEL8GdJkwjvXvpWbg+JROP/L
         hAz6xxpxEgfZfEBV+OENzu36dMr5THBUsrLVqjpnsbmePZiey2Hxom4/vEDkn6QcGfHr
         mQxA==
X-Gm-Message-State: AAQBX9f9e4kD85mu0/J8rvaEjQ6mJLTgyCWwlDpjZuz8w0sm/A01Wy7G
        0gbRbyDfEduoCLcEyJun9VI=
X-Google-Smtp-Source: AKy350bQhQacFdpDwvkV2DH8U9D57H1cYH/SGIVzAdyb8S21+MT6jKi/bAxTb5VguUy4tOZeJcQaqQ==
X-Received: by 2002:a17:90b:4d04:b0:233:c301:32b3 with SMTP id mw4-20020a17090b4d0400b00233c30132b3mr1381246pjb.3.1681170240851;
        Mon, 10 Apr 2023 16:44:00 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id ei21-20020a17090ae55500b00233cde36909sm260863pjb.21.2023.04.10.16.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:44:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: simplify man version
References: <20230408001829.11031-1-felipe.contreras@gmail.com>
        <xmqqr0suf0wz.fsf@gitster.g>
        <20230409190805.GA77061@coredump.intra.peff.net>
Date:   Mon, 10 Apr 2023 16:43:59 -0700
Message-ID: <xmqqa5zfcngg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Is this a complete patch, or will this leave us in an incomplete
>> in-between place?
>> 
>> We have some references to manversion in "git grep manversion
>> Documentation/" in asciidoc.conf and asciidoctor-extensions.rb
>> remaining after this ptach is applied, which presumably are no
>> longer used.  I would imagine that these leftover references end up
>> substituting them with something benign, like an empty string, in
>> the output, but it somehow makes me feel dirty [*].
>
> I think we are OK with this patch on its own. Asciidoc seems to be smart
> enough to omit the empty XML element on its own.

OK, that kind of "why is this a safe thing to do" was what I
expected to see explained in the proposed log message.

Will queue.

Thanks, both.
