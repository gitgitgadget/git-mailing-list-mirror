Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF2AC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 18:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbjD0SVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 14:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjD0SVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 14:21:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D233630F6
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:21:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115e652eeso6971382b3a.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682619677; x=1685211677;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dN5YtVeGDEc62S2mFYVonQLUSjSBgEool1OCRl5MUe4=;
        b=sT19x5pgrEeO/sOlHxesSf/2sRFVYFqhXSh7PcCxEeOvzPDFBozv0G7jd7nlqtF3sX
         kvXMvO7VtoGLCHruuuet76r1W/RvtLD0MH0BfQt42igSwYaXtreFpTOXa+mxOUHvOlgE
         kOtv31f+Lg20UzT/M30/eUKrni2UC3xmHzz0QrWTK5e8YQ38wah3zqcH/siwmiJN9lQA
         mCcdcyamwJ+KSQ3oCeGbzYBAO4ESQwTySaexPAIIDidFb5rIEz6qFo3Ox45x5Ia5OJTZ
         cIILGQ1+HOz/wsxgvtN9kG6NPoWuWQWm9sIQ7WBWr1f1JIuF5+4GC2/ak5/BnGfIcaTB
         P39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682619677; x=1685211677;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dN5YtVeGDEc62S2mFYVonQLUSjSBgEool1OCRl5MUe4=;
        b=EWvb7He0TZxFWGutCqkMfVISK0izS3BzqGTHySjzjRoF4QgHZukAAIdpj/FVHjtEIM
         YuXxfO8tFqV1Row9PituuNspe32XWo5lh14vWuSHm6tmXiT+6bpxjF4WdnvsnuGIvJvA
         vKoh7KeXDXoyZJFz6YkEV7laXW59tMrV+6z+6PQRsmEhfAN7/dfjg1dnG0SP69BQO6d3
         CSnvlBndyhh7ly9mQZaa5sjcuChnuwDzLFi/EQU2Psjfxc00yZ+1GATork8I45/QAgER
         vb6hEzCWBD/b1zmVRf2joBBNzLEJMrV8sdEa6UOHIO2MvalxIgVx4COnxx8TPoL7PtAW
         ycLw==
X-Gm-Message-State: AC+VfDzPgr3mRfRFoelxfeZEVWKUMKuWG8W0Kg5LSx6wG72xlNou+F5E
        qsnv4zfzeyQnIKNH0bXFRQ6rzfHTkjA=
X-Google-Smtp-Source: ACHHUZ5VJAh3Knhqo/BMgJIdP7J9bjjAcjLbKZT8NUU+pwI0dF5g9lnBojvKjlBq/rDdiWlKxs7tjw==
X-Received: by 2002:a17:902:e551:b0:19c:3d78:6a54 with SMTP id n17-20020a170902e55100b0019c3d786a54mr3557766plf.14.1682619677207;
        Thu, 27 Apr 2023 11:21:17 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b001a1d41d1b8asm1387939plg.194.2023.04.27.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:21:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <xmqqsfcn27e0.fsf@gitster.g>
        <20230427072107.29821-1-tenglong.tl@alibaba-inc.com>
Date:   Thu, 27 Apr 2023 11:21:16 -0700
In-Reply-To: <20230427072107.29821-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Thu, 27 Apr 2023 15:21:07 +0800")
Message-ID: <xmqq8redkwyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +	while (d->msg_nr) {
>>> +		--d->msg_nr;
>>> +		strbuf_release(&d->messages[d->msg_nr]->buf);
>>> +		free(d->messages[d->msg_nr]);
>>> +	}
>>
>>        while (d->msg_nr--) {
>>                strbuf_relesae(...);
>>                free(d->messages[d->msg_nr]);
>>        }
>
> Will fix or optimize.

Not a huge thing and I would be very surprised if you saw a
different machine code output.  The original stood out like a sore
thumb at me, primarily because we rarely if ever do pre-decrement or
pre-increment in the void context in our own code.

>>Interesting.  
>>
>>I would have expected that where we add to d->messages[] array a new
>>note_msg structure and set its .stripspace member, we already knew
>>if the associated strbuf needs to be stripspace'd and instead of
>>maintaining the .stripspace member for each note_msg, we can just
>>have it contain only a string (not even a strbuf).
>
> That's because the "-C" option, it will not do stripspace for the
> whole note, but support to use together with "-m" or "-F"(they will
> do stripspace). So, for the consistent result with backforward
> compatibility, we have to get the information about whether to do
> stripspace when concating each message.

OK.

Thanks.
