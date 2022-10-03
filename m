Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8BDC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 16:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJCQg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJCQgY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 12:36:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649B625C52
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 09:36:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso15771085pjf.5
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gd2daFZosSSi7uwPQxchyVWszdTWOnF1ZbKDZ5vkBog=;
        b=pmY3avnC8s3S6EL844fpovOyd2UaWnTdWdXPeZM399kRha87Rirj4W2XScK3fLGLMG
         6sd+8Z8yvFIR6hVKlnijBYldMyiiW8J/WotxHTZOCqxRGa95phdZcgAjA50qgTv5mip6
         FzB24eu+v66mwa+jS/nyJc1VAY3bX0C2Ogi1K77ueHK4OkUmX5XVScDp4HXNFMEBsyOF
         E+611d1Ao2ZybuIxk5yaSl8IFLYlMgky5QRtGqhwYXCuCnraSX0WidUOX6zay+qGywiF
         y8CEKKXWSz6sQE2nEGaUjPYTmYTDPpZptQkz/m258FXzvjdwyIxB3yjiSQgvulH9NP4A
         2niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gd2daFZosSSi7uwPQxchyVWszdTWOnF1ZbKDZ5vkBog=;
        b=MC5rboi8EnosT4i7xH7xWOuMZQPna/Er6rjN81kPY71quQcLGWsA8/y5OvaRjgXbeX
         QPNyBUK+a/WrjeIAqrvWKHipPISPOPwpx4Bt73V9Q4cYV7JtTa/saB23da3JWd7pAmha
         UoUh7bNF+iyeWgGJh1S6/wCXeVxE1wwINICSfcVChy0Nar9xy01jaUvdV2g1fYpaTDZp
         O841ZIzaTlXXe++WtmztL1O9OrqwuLQ/5rhaQ8CKJYMwTrKQfySYDgCoq9p2IkmgC+IF
         n+Up1T4Ed3oCJIE95E6rHp9OvlP4MTSLhD0DHV5sUAuMR8jBIMIHIg6gO6ZASGl3CQ/8
         Ls/A==
X-Gm-Message-State: ACrzQf0+2cy3K5/EjMUMR/JKbciPbkn+1IIkmwhs+DSNBu9kLNrxrlyi
        cALwYbSus6QgQBvMjlSivfM=
X-Google-Smtp-Source: AMsMyM7bFI0jBgIm9Hu3bFVK0sD0xtn6WEzbMH+H+vecDV2YinRfb+qW8Ncxu+eZcjty1TfaiaHC+w==
X-Received: by 2002:a17:90b:3510:b0:202:f18c:fdb6 with SMTP id ls16-20020a17090b351000b00202f18cfdb6mr13022924pjb.122.1664814979474;
        Mon, 03 Oct 2022 09:36:19 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q14-20020a63750e000000b004468cb97c01sm4667884pgc.56.2022.10.03.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:36:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-reflog.txt: add an EXAMPLES section
References: <20221003084654.183966-1-gitter.spiros@gmail.com>
        <da2c8d2f-eefa-1681-b1f2-93c7865c300c@gmail.com>
Date:   Mon, 03 Oct 2022 09:36:18 -0700
In-Reply-To: <da2c8d2f-eefa-1681-b1f2-93c7865c300c@gmail.com> (Bagas Sanjaya's
        message of "Mon, 3 Oct 2022 20:07:33 +0700")
Message-ID: <xmqq4jwkx3st.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 10/3/22 15:46, Elia Pinto wrote:
>> This commit adds an "EXAMPLES" section to the git reflog man page.
>> This new section currently provides examples of using git reflog
>> with branches, for which doubts often exist. In this commit we also
>> add a "SEE ALSO" section which refers to further information
>> on git commands or documentation referenced in the git reflog man page.
>> 
>
> Better say "Add git-reflog usage examples to the man page."

Thanks, indeed.

> Also, shouldn't "SEE ALSO" additions be split from this patch?

I think they are better together.  The overall theme is to help
readers of that one documentation page, and 80% of the effort of
this step is spent on adding an EXAMPLES section, while the rest
goes to SEE ALSO.

Thanks.
