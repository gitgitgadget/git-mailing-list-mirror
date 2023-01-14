Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FDAC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 16:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjANQzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjANQzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 11:55:07 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7788A77
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:55:06 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h192so16913545pgc.7
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTHXehlqGnBgShWWlFkH8y7g9c9BOE9fFyIIHjh3EOw=;
        b=GtUFqauE1Ir4edaWpf2VXyoYnNhPComZ24Z2lcBV4OqwAHq0WwNcx8FhdlYGM30ndN
         RazPiPj5CA8QuIMEXfRBY/8S9+RkcUJNb5K2qe9cCJqGLRT5ggL0rHxhTEnk1ftGNPK2
         y/6Q364lSnRdguZzFFsFgLWzBkFzm2JU/LI2D7WK9cy3LswGsyM9lkvsw4sPd8TMYhGm
         x/NzoxsUurI91+zxaa+TKHZjRuMCtMcL8glfahI4LPVNdYLj83s3Jucws9SkE7AAuE7I
         6XtcOA2IORZZECJnhQxYevdsziRR+ahD6N2nkVvwicKCp10w/RTUn+hRX4YPUg63r5tU
         6ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTHXehlqGnBgShWWlFkH8y7g9c9BOE9fFyIIHjh3EOw=;
        b=bVch4ymI7AI76IZ6P9+8rbZe6FRfckYmx9P12AXzyhEL5Ulj/0l7FcmSIgFP8hkL+H
         ihisT5kidjYfLQYc8ijBJ1Et96UJxdO+rXcDUxqmSUaOGqjec6bra+sYQFs1cdGFpovI
         o+5vw/948aUMa5ZS4VniYNsoTTKOpIn/qZGXpGJs5/nOYdczBhIy9RSKQaP96VlREpqY
         5rXWhEsYh7Hk9UrQILKtLf2mDfd170ZK4NMsNSViNIen4RV9/eC7j7Y7WaWCND/Cpzrt
         StcOoE4VMUWUJxoFt8ueRXlyvFsNFXy16epzGWyncG6bjMHWEZ04wqcel0qDHCzGhVZ3
         pP/w==
X-Gm-Message-State: AFqh2kreTdmgyUiCg/YDW6TgCC6JhbfsFHUYWsX9d5dpsI/uwkLq9WrM
        8+2HLtyAOLWAZX0zWAF5ViA=
X-Google-Smtp-Source: AMrXdXsLv2F9vtVMm5jGNxLqEyvUVTmvt2+Ss70Xf1rcC9wp/rlFrEWJrzwZw0MFaWxAaYAYe3ggQA==
X-Received: by 2002:a62:ed08:0:b0:577:272f:fdb with SMTP id u8-20020a62ed08000000b00577272f0fdbmr68543208pfh.29.1673715306255;
        Sat, 14 Jan 2023 08:55:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b193-20020a621bca000000b005810c4286d6sm15513635pfb.0.2023.01.14.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 08:55:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
References: <xmqqv8l9n5fj.fsf@gitster.g>
        <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
Date:   Sat, 14 Jan 2023 08:55:05 -0800
In-Reply-To: <Y8LAim4D3g6qnZdq@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 14 Jan 2023 09:47:38 -0500")
Message-ID: <xmqqilh9kqdy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +# Libraries deprecate symbols while retaining them for a long time to
>> +# keep software working with both older and newer versions of them.
>> +# Getting warnings does help the developers' awareness, but we cannot
>> +# afford to update too aggressively.  E.g. CURLOPT_REDIR_PROTOCOLS_STR
>> +# is only available in 7.85.0 that deprecates CURLOPT_REDIR_PROTOCOLS
>> +# but we cannot rewrite the uses of the latter with the former until
>> +# 7.85.0, which was released in August 2022, becomes ubiquitous.
>> +DEVELOPER_CFLAGS += -Wno-error=deprecated-declarations
>
> That's a pretty broad hammer. And I think it may stomp on the hack to
> rely on deprecated() in the UNUSED macro.

True.

> As Ramsay suggested, we could probably use CURL_DISABLE_DEPRECATION to
> limit this just to the problematic case. An even more focused option is
> to use curl's helper here:

One possible downside of the use of CURL_DISABLE_DEPRECATION is that
we may still want to see deprecation warning to learn about upcoming
change.  We just do not want the -Werror to make us die when it
happens.

But anyway, let's use CURL_DISABLE_DEPRECATION first to see how it
goes.

Thanks.
