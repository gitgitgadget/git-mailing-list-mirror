Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4E5C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjECRtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 13:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjECRtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:49:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F26A70
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:49:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-642f5394651so2554622b3a.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683136160; x=1685728160;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wO5cvj43SntCbW5FirTHdqARcItnUq46F+Q4sg8qjec=;
        b=hnW6lSpxy54Ty4ACSXky0oN2uSfusQrTtfhqIek2jmwNxQPOmtiN/LdThjHe9DYiO/
         oI6XT7M5L+ibNhle2+GXzhmuNl8J8Q/57zsgjdZp4I5H0/umqCLFtmESulJfkpjCUTto
         bvCl+NeEEEiLYyJ6Pwe5ysc1bfJscNufZw7wP+D/kEG9WzbGOGp2klA8ww+Z1B185R0f
         4W20OeEIZY+5HECM1zwWqBVOa81CuzKxV8Qity2/w3EaadMzhR9HixFIyHa4pSmBNHAU
         4NpjJrTqFc/3j0gSFdVxRJXaBku6j5T7H4qu3waCMNJwcjifoJu/agGmnbGXkNZJiFR8
         DDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683136160; x=1685728160;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wO5cvj43SntCbW5FirTHdqARcItnUq46F+Q4sg8qjec=;
        b=N3woZ3sjsD023pKw1FIbigXvyGDdijdT78/S++Pigja0G0H30HUj0VvelFYraLkF8h
         xuEVh7/sVuLqUqONt1rzsMI6syV0Or+Q7KhVv8YX8hBqLAcivo/WfQB1CUVPcE4rHUu5
         V9zEVb9e/A23xKHlYYEJYqP3Ke7peoXMY+i+r/puj9koHtYJviLHW49ygL6ZVwbW99Ll
         7weK4xUPeVdQRKWsQrlTjLJOpCxX8oxGKWlAyh4MkRh3MLN07FfdcUZbD27MXNgRGvfB
         feJHZgK/Z8zFDIz4OzuvGgUfkSLtxP9HkwRpLdlnnQPaaCAGZDxeh24/apzBOjBBT5my
         8h0w==
X-Gm-Message-State: AC+VfDxS6ZrZ/bsoAHkqdOd0cdH4oNhXqH/rn1ubD2uTmIK5fwxMkj26
        Fq7d1oYS3hsFuA54mCfMkOsmY4qtQXc=
X-Google-Smtp-Source: ACHHUZ7UqA3kvAepBnCjK1ZDhDWamTEuTbVr9ANmOEZp10+Mm6265/FErvHWblVvHxVqcwOOqwbldA==
X-Received: by 2002:a05:6a00:b51:b0:63b:7ae0:fde9 with SMTP id p17-20020a056a000b5100b0063b7ae0fde9mr32249370pfo.20.1683136160069;
        Wed, 03 May 2023 10:49:20 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f195-20020a6238cc000000b0063b8428b0d8sm23825714pfa.152.2023.05.03.10.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:49:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: manpage: remove maximum title length
References: <20230503052926.217219-1-felipe.contreras@gmail.com>
        <xmqq7ctps438.fsf@gitster.g>
Date:   Wed, 03 May 2023 10:49:19 -0700
In-Reply-To: <xmqq7ctps438.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        03 May 2023 10:43:39 -0700")
Message-ID: <xmqqv8h9qp9c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> FWIW, my primary motivation behind suggesting update of the above
> log message was to make sure that we document that we made a
> conscious decision to make it unlimited, instead of choosing another
> arbitrary limit (which we can do when we actually need to).

Elsewhere I think I saw "asciidoctor does not limit" mentioned.  If
that is the case, then it is a very good thing to throw in as a
justification why we chose to make it unlimited instead of raising
the default limit.


