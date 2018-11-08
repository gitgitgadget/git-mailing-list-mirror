Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A1F1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 14:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeKIATj (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 19:19:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52529 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeKIATj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 19:19:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so1520684wmb.2
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 06:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=FeOUSfzSh/qYLXznVMPRk1H9ab9r4bZwN8Dclhmrkx0=;
        b=hNQqD5FHgwrnOzKHckdJxYHTJ9pSRID6WjyyTDSAuBP+FzR1BeADEKjFpNBrIZz1mi
         PPZYuTfHdaNnaWxElz2isMPuSJ0TKxODr1H/uHSMrJ8i8SBL03SbaDRUtFlbmFYWjTol
         uQLR5vIhyVWGI7ShBaMGN5gcKAHMPelhweRptKgRnJVTYcT7cT5rmZy3zdVWyOld0cbh
         lXoOSYlu07uJ6vxmCAT0hRLoj0cGPwe9SvlP2Ow5o6XfuagE1Z36IOJ0Aq398K6b9d4f
         WWpnDDUX9OpmQqZ/9wRjqHYnsC7JAToHIzIOS6gWOWOrJVgFtN6RvKSjfQ1f250ozmtF
         1V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=FeOUSfzSh/qYLXznVMPRk1H9ab9r4bZwN8Dclhmrkx0=;
        b=DKuWW/6TZsfYYCeFXrv9Bz75aBvUtVb+dkB3f5s95bSSh2ArONcewOR7l2E3CSMVgU
         CNUjBeH4IDoTtmFA6ooXdDtzgu5dKLfQfiL8CypIqE5Fh31HrB9ZP4PJxMMCdt2nrdOT
         D5/0OUGL8A6t6lIMniVGMrLDkhJvEDW/3W9eM8GoWbuw/9jIoA5kptIXy7ahAtji/RxD
         rjk5DUvmcWIrAatRDGlCdkZ+sol8KFrESqxZBbfoXipVmmq7GKaDkWJm8VivZ3jnEra2
         TNUCHckk2dTgjCiUR201SAGbUjr6+neF6KYRr00Vo0WD9v8b465JtRN00jFZ1AuJbV/F
         nviw==
X-Gm-Message-State: AGRZ1gKbCWRB+EG3FWYxsll+h35vOhtIs5jdLlQ8tJGTGzxh30/Wyf4Q
        Gp7YCosE54RvlL5LixkJVGADvnkTEO4=
X-Google-Smtp-Source: AJdET5dOYkAcYDxiZKDZMZdiEWqbJH/fuIs+Otc+OOFTly7KbihlSF07EcRkSOZpo69QOce4gHjcZA==
X-Received: by 2002:a1c:e355:: with SMTP id a82-v6mr1502341wmh.74.1541688229347;
        Thu, 08 Nov 2018 06:43:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m13-v6sm5139379wrw.14.2018.11.08.06.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:43:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
In-Reply-To: <nycvar.QRO.7.76.6.1811081356350.39@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 8 Nov 2018 14:04:17 +0100 (STD)")
References: <pull.66.git.gitgitgadget@gmail.com>
        <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
        <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com>
        <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811071217280.39@tvgsbejvaqbjf.bet>
        <d7a70226-3441-76c4-df6a-e8fb32249f27@ramsayjones.plus.com>
        <xmqqr2fwa0ew.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811081356350.39@tvgsbejvaqbjf.bet>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 08 Nov 2018 23:43:47 +0900
Message-ID: <xmqqr2fv7hp8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 8 Nov 2018, Junio C Hamano wrote:
>
>> I am tempted to say "//<token>/<the remainder>" might also be such a
>> way, even in the POSIX world, but am not brave enough to do so, as I
>> suspect that may have a fallout in the Windows world X-<.
>
> It does. //server/share is the way we refer to UNC paths (AKA network
> drives).

Shucks.  That would mean the patch that started this thread would
not be a good idea, as an end-user could already be writing
"//server/share/some/path" and the code with the patch would see '/'
that begins it, and start treating it differently than the code
before the patch X-<.

> Granted, this is a highly unlikely scenario, but I would feel a bit more
> comfortable with something like
>
> 	<RUNTIME_PREFIX>/ssl/certs/ca-bundle.crt
>
> Of course, `<RUNTIME_PREFIX>` is *also* a perfectly valid directory name,
> but I would argue that it is even less likely to exist than
> `$RUNTIME_PREFIX` because the user would have to escape *two* characters
> rather than one.

Yes, and it is naturally extensible by allowing <OTHER_THINGS>
inside the special bra-ket pair (just like $OTHER_THINGS can be a
way to extend the system if we used a special variable syntax).

>> Are there security implications if we started allowing references to
>> environment varibables in strings we pass expand_user_path()?
>
> Probably. But then, the runtime prefix is not even available as
> environment variable...

Ah, sorry. I thought it was clear that I would next be suggesting to
add an environmet variable for it, _if_ the approach to allow env
references turns out to be viable.
