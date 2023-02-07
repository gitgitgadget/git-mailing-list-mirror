Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AE7C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBGSxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjBGSxe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:53:34 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8849218AA3
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:53:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso19584975pjj.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Onnqz4aO1dfySF32FzxOTV6WLWhaW5/Gt5jsW8HIheE=;
        b=XnQnYripPpEhLCWEMzDnhjZjpg03XD4pBLCY4ogJO1Dl9ofSdn6PfODioVmFAdYF82
         HRwMTSTBDoUI5wc5kJeooeFhwL6VNzqJ55seaQJJWTvs3ROhpRcO40n5Ld0YSG+VfEtW
         e3Z32x/e5EWH4ZvtJEYxhPtM3+tsX/NkoNxfGDKZ3Jh3DzxN2MgWEmlbbOmRn1oVwMQ5
         tLgfjdaGLy5+rQeX1RaVOkIluJuDdelAnI16D5gdt+0XMTG+Ip4g/9EVnUc5j5h30ZCV
         /YpFwCp4+ihMCZyqkwcPU9W5NgZtAHMUDozuCCwFwvvxUC85Z60O6kzou9Mz6VBtqZfV
         /tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Onnqz4aO1dfySF32FzxOTV6WLWhaW5/Gt5jsW8HIheE=;
        b=PzOALX7ULIkXFUiM26m7JIMsumnqY4aiJzopy/pNclw7iB/njng2quXP+kNdNoPSTl
         TicFSJ/lDBAY/1fWnLzvlIMyUadlIcgFHI0VSnmX3MrS+UBBj8ST2xhHKRp7gkAM4ECM
         iizHegK/5CyhEU84qRy8L/2/Qs9ehAZ59XwgoP1rraCiLJwf5DrrUoo6GR5FdMHC/4BO
         d9jtMbpA228JVobT6ld2slf/QhOe+6NzEOJGhii+T0EBrVoLnvzy01ZB1ihpgDIQ+fso
         vY09UsZDs2w7iY0N/s6Kmpw8RmZn/9sdj/oQzDpSO3ICRgVBfdKTca1/x8xjehy3mss7
         gQ+w==
X-Gm-Message-State: AO0yUKVGfMv9ZVZgjzU4a1ryBF0fMesgr3VKMI0rjnPCv8/31JIh2JQR
        vpKr0vMoa3KxWZEd7Fp991c=
X-Google-Smtp-Source: AK7set9MWiv0L/atC+9gKHSwW3M2KZb3s8UV7TTE37Uwk+JdkMtO9UDSw+xhtdvIRkacN+j/u8keAg==
X-Received: by 2002:a17:903:11d0:b0:194:a531:4b39 with SMTP id q16-20020a17090311d000b00194a5314b39mr4551643plh.67.1675795991894;
        Tue, 07 Feb 2023 10:53:11 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id r24-20020a170902be1800b001949ae8c275sm9238620pls.141.2023.02.07.10.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:53:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [GSoC][PATCH] commit: warn the usage of reverse_commit_list()
 helper
References: <20230207150359.177641-1-five231003@gmail.com>
Date:   Tue, 07 Feb 2023 10:53:10 -0800
Message-ID: <xmqqk00tz4rt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> -/* Modify list in-place to reverse it, returning new head; list will be tail */
> +/*
> + * Modify list in-place to reverse it, returning new head; list will be tail.
> + *
> + * NOTE! The reversed list is constructed using the elements of the original
> + * list, hence losing the original list.
> + */

After re-reading the original, I realize that "in-place" is good
enough clue to say that this is destructive.



