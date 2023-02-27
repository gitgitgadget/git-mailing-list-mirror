Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFA6C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjB0TAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 14:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjB0TAi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 14:00:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788ABC179
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:00:36 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i10so7781573plr.9
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wphpshb+F1wTFqV/lMglYs3uLg/v2zejdaJjSgE98fU=;
        b=PIyN4+1NCPplvC8CA9jjviFWacvFk4xAbsrbb+U5ZDpC5B6E2BIhlglD9kmaXZ1nAR
         /mFKD2UdFe1MvhDkkmanTQBTnTEmviyTmUpTsaeMaDk7LxGym+vbZRHA3Z1vA/dWpKG6
         OF28mRWkcx/gBAI0X3fUdLlXZujptDLluVbfqVNGgbbl75gX0nXjOuV2u6IZNtM0pBxG
         uhPDG8qcWB6/niz6/4qDVl3TBIal8WIT3uKOR+le8lHwA9infi2vWjFrVlM9uVIZvH5k
         2s0ojVQArbI106Hy6Nfn40htkx+DZCHsQV/vYeYx7SYK0NEdPkxa043f5SS4OnjUI0cP
         zc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wphpshb+F1wTFqV/lMglYs3uLg/v2zejdaJjSgE98fU=;
        b=23eDmDKYl1sUw82l/4uGA+reaADu9AodM/OAISBXmfis7J++WfY+T0J+L16i0YpXwv
         li+oWKyhGUqesWZjHzjl3IBSaYTibWvzKlXYtIHYkvu02/kHDHcLDEnzFWAdGeMNd1/5
         1dMBnhppR/KSSp3DsC+lRTARgmPkrDEvi0lcdxgEDcEAi5wihK7mrdaqIGi8fZgJakKn
         8GnysscIEZpMAWcEUkiT/SE2qRwmt7G7KcOEMqoK87v/OkjO0h9xl+OXbZk1vSbZSx9k
         M5AHIikCz/MOyCeQxxYPJfrfgieEO1aRnhQlnBglSmFjAOWDUm+VMxSTOoJ5lJeg8XIi
         86PQ==
X-Gm-Message-State: AO0yUKWl+gNV02Wl/dkb6qQcG/oj1gwZ/wROB7qIFfMGqJ854Q3mhYpH
        C9FVje2MfBQhf98JCMuRKPU=
X-Google-Smtp-Source: AK7set+h0CkKolC1KeqGJEiKWAfiZzVXu5YkSRmXrYguy+KFU8EiLexNrS4aVlVotjACoOPi54i8KA==
X-Received: by 2002:a05:6a20:ba28:b0:c3:2bef:bd62 with SMTP id fa40-20020a056a20ba2800b000c32befbd62mr426644pzb.1.1677524435831;
        Mon, 27 Feb 2023 11:00:35 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id f23-20020aa782d7000000b005dea362ed18sm4600759pfn.27.2023.02.27.11.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:00:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2023, #05; Fri, 24)
References: <xmqq1qmeyfps.fsf@gitster.g> <20230226081545.M216523@dcvr>
        <xmqqa60zszq9.fsf@gitster.g>
Date:   Mon, 27 Feb 2023 11:00:35 -0800
In-Reply-To: <xmqqa60zszq9.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        27 Feb 2023 10:57:34 -0800")
Message-ID: <xmqq356rszl8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Wong <e@80x24.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>>> [New Topics]
>>
>> Any feedback for <20230212090426.M558990@dcvr>?
>> ([PATCH v2] fetch: support hideRefs to speed up connectivity checks)
>
> Ah, that one slipped through the cracks, it seems.
>
> Thanks for pinging; queued.

Ah, sorry, you were asking for "feedback".  I think relative to the
original RFC I think what you have is an improvement.  It does make
me wonder if we want to later add 'push' to the family to complete
the client-server for both directions, but that is irrelevant in
evaluating this change.

Thanks.
