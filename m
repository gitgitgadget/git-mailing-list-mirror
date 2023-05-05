Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A10C77B7D
	for <git@archiver.kernel.org>; Fri,  5 May 2023 05:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjEEFz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 01:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjEEFzz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 01:55:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E44273B
        for <git@vger.kernel.org>; Thu,  4 May 2023 22:55:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643995a47f7so1080403b3a.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 22:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683266154; x=1685858154;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYOOebmU05PxCvcNpfTRjVCWtcqkbS23D2XWiSNhWYc=;
        b=aGjYQluCyNq+MQyhY5c/Za+Wnzv8PXft8K6VYKrbnSZVGrSc1L8ovjsJLcdzc5PDUY
         77PhD9xCc7fOzvrRhvlqDFo8acDhiViJv+5bb16Caj0LpGxY4QtfKzMSfa/xOoVKPwaV
         CiN5H30JexajxnOc8qrtY51Wois3Ev7qk0LndeVTEUh4qVL4ltiuj4NNS62NDBioq9xi
         5ylxceR7WB2Ix6viaSRdLy4087BaiGSr8QSPLZZhGz2VXd4E6FIjJ2pFEfKvpGtVMF/p
         S80aCv0BHnPA/grubX6kSgKN/cghWkxGFvVO2fLhxm1Jpazg9iilipmFL1Q9esQAw7AL
         7jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683266154; x=1685858154;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYOOebmU05PxCvcNpfTRjVCWtcqkbS23D2XWiSNhWYc=;
        b=GaQPXvOeNUMuXfFrJdphQ76q4zLkYkZSdqO/wj8UJQi1++/wzwlxH5/RyhrcTzCnbW
         TuGX7swjPSFqDTJpNmtCk7IqZDebaMP86LejRQdtNow74d7CTCH9kTy8wGzVqMhnJwUb
         3WJ8q1JssIRZvZAWm2DuIorcwy5qZEI3QDQOZTopPWj8KK8lMmH3VZbUs/SpQKbHZlSQ
         KCC3sVESDTlOm//gvL6kGXLcY7wOtCaoJ0NTVLPhF+zlWOVizdTlO7tEcnoZGLq2+ZGe
         OBaq77tfTrsVgVBkvay/sUByvzoAR5xrBOhOZgGjPlOO/bc2cg2gS+9J8IzQxa3AnX54
         sqeQ==
X-Gm-Message-State: AC+VfDxI3NGVYYhMj3Fm/Zm6w+slJVK6H8/GivUMI6R/6/yOsswStqU+
        YSb+pJIs0jehJjjdxfb+qBA=
X-Google-Smtp-Source: ACHHUZ6f6uQAWnKWtLp/5UYrbxK0p5wOODZ6kl9lQVOozssxjD+7/f1ydWqap7wou4h+h4FjItYMCw==
X-Received: by 2002:a05:6a00:849:b0:643:980:65b with SMTP id q9-20020a056a00084900b006430980065bmr1022367pfk.2.1683266153761;
        Thu, 04 May 2023 22:55:53 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78156000000b00634a96493f7sm730531pfn.128.2023.05.04.22.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 22:55:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: doc-diff: specify date
References: <20230503232349.59997-1-felipe.contreras@gmail.com>
        <xmqq8re3inn4.fsf@gitster.g>
        <20230505014610.GA2366370@coredump.intra.peff.net>
Date:   Thu, 04 May 2023 22:55:52 -0700
In-Reply-To: <20230505014610.GA2366370@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 4 May 2023 21:46:10 -0400")
Message-ID: <xmqqzg6jgw47.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> >  			GIT_VERSION=omitted \
>> > +			GIT_DATE=1970-01-01 \
>> >  			SOURCE_DATE_EPOCH=0 \
>> >  			DESTDIR="$tmp/installed/$dname+" \
>> >  			install-man &&
>> 
>> I wonder what the existing SOURCE_DATE_EPOCH was trying to do there,
>> though.
>
> It used to be necessary so that we had a reproducible build. Otherwise,
> asciidoc uses the mtime of the file, and diffing two versions would have
> tons of uninteresting date-differences.
>
> After 28fde3a1 I doubt it is necessary, as the header uses $GIT_DATE
> instead (it's possible the mtime may be used elsewhere, but I didn't see
> any spot after grepping a built xml file. And at any rate, if it does
> not produce a visible difference, that is enough for doc-diff).

Thanks for confirming my suspicion.  I guess leaving it there still
would not hurt.  It can be removed whenever somebody motivated
enough comes and shows a well-reasoned patch that explains why it no
longer is necessary ;-)

