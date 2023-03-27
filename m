Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8135AC6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 21:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC0VLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 17:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0VLR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 17:11:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0804119
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 14:11:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so10379033pjt.5
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679951476;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PioJNCs1+aJEp3/KngptCcsO9KjHDsk/2eQLSJQCDaQ=;
        b=HsXERkmc7PpbFyEJ4bIbp3nh46lgwA2zty+Pr0PbMY213iL6oElMIiwWUDdB99d2UG
         7P+78q0zP0aLKiEv3w/8c8acmcvM7q+ORLyt9qFQIq2iuEGMKi0SAV4PIWkkN37FeC5Y
         XtKf03H7qbfT0qqIh0GUIGYTtV2sOUYwR+GqT2MVdG1mCtQXquHUIW67XC9dDp/dybDe
         /cN+kyBVYejfAl6ynch+iMrdByY4Rn2QnAfnF9M9fS9+kxx09w23KzMUVPkvTb2gZWok
         hU7SEnCDA9pAg73PyOL82jxrxCYZlU0eqzsOwpBz0JnINbwL1+UddKWVzkiowZoyFfny
         CfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679951476;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PioJNCs1+aJEp3/KngptCcsO9KjHDsk/2eQLSJQCDaQ=;
        b=Kcl6Tu0RdpCeO2xQEfWkLGi7XSCfsXlo0X8zILUETtDFtcb7I7dlC8/dLIGS0IMjkh
         EpXy1EGK/3Zn5W/LvnbydIdr8wo2iQCGNidgvBQY5Jl2j2QigjwxzDtNhQvpJ4YgWBJY
         j08G/Yjm+wjb8m+/OY/+h4m2XllzULWZjOI6J9au/2DayaFsGf2EJajjsdMoON6LdkMI
         fkFgrnxZtggVwlpDayA7q0zrhZWjqIJWlYhabQlObS2tCUluNSASi4tWCYuFen1ZEkQG
         viMCGN4fZrKHS6vy9LkAAoutCq27DS9GFEafgDFLtnBLKbOdqB+qouubWupYpbQEJUbW
         tg5w==
X-Gm-Message-State: AAQBX9ef9nNi49KvZDTB/jdS5MoKWm3PCm6JQbkGNk24XmFoGXL3vtsi
        Vp+dPabdTph8/UoTR3MvtxM=
X-Google-Smtp-Source: AKy350Z6tUMyJ+giTqp0YoY35SgKXmLZZIGNxmJlr3yQtRP1reZ8K/Ux3XSVaNultxagfWtHt876tQ==
X-Received: by 2002:a17:902:e543:b0:1a1:e112:461c with SMTP id n3-20020a170902e54300b001a1e112461cmr19646479plf.30.1679951476072;
        Mon, 27 Mar 2023 14:11:16 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001a0757b1539sm19691733plt.36.2023.03.27.14.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:11:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mario Grgic <mario_grgic@hotmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
        <MW4PR20MB551779102E85B305E9F675E990859@MW4PR20MB5517.namprd20.prod.outlook.com>
        <xmqqcz4ucg1w.fsf@gitster.g>
        <MW4PR20MB5517E2591A77978709695AC3908B9@MW4PR20MB5517.namprd20.prod.outlook.com>
Date:   Mon, 27 Mar 2023 14:11:15 -0700
In-Reply-To: <MW4PR20MB5517E2591A77978709695AC3908B9@MW4PR20MB5517.namprd20.prod.outlook.com>
        (Mario Grgic's message of "Mon, 27 Mar 2023 13:22:29 -0400")
Message-ID: <xmqqtty5nbm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mario Grgic <mario_grgic@hotmail.com> writes:

[administrivia: do not top post]

>> Mario Grgic <mario_grgic@hotmail.com> writes:
>>  ...
>>> +	NO_REGEX = YesPlease
>>> 	PTHREAD_LIBS =
>>> endif
>> 
>> It will unfortunately break multibyte support on macOS by reverting
>> what 1819ad32 (grep: fix multibyte regex handling under macOS,
>> 2022-08-26) did.

> In my case, I compiled git with pcre2 support, using third party
> PCRE2 library: https://github.com/PCRE2Project/pcre2 and PCRE and
> multibyte support in git works with it just fine.

Sorry, you misunderstood.  1819ad32 is about enabling multi-byte
support for normal regexp types, and does not have anything to do
with pcre.  By setting NO_REGEX, the build will not link with
Apple's regex library but the one from compat/ and that version is
what is used for -G and -E (not -P).  -G/-E patterns with multi-byte
would not work with compat/ stuff, but they should work when linked
with Apple's regex library.

