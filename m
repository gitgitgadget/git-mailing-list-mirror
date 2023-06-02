Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3134C7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 19:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjFBTGw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Jun 2023 15:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjFBTGt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 15:06:49 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86D1B1
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 12:06:47 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6262d8688baso23512316d6.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 12:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685732807; x=1688324807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55j9w+nWFp8RcY2lBvOxRycotUXOfiBe1SzAdN8PCeA=;
        b=kQwfyHpfwWI4QeClWG7Q8AZiRNXX4US8X5qk9CWlMzj5bzUjlpeU2fG/3QbrkmMiMx
         IiKikPiX3nhp42ly6AE272Kjm5V4+XAu+yySPnNTZ12mymBfsujHciBu855HufUMvu47
         BcqmNmg8HiVvFStZrYlPUJFdG+DvvwfAIniTofU30RNjB8PPcYkBbcJIgKESvBlEO5OD
         IDKeKJ4ZQFGdi2tJa7k6MhHrzvtd1U1ka+2j1OtslnPMJ4DjaRXckSCqaRdmq0VzAWlg
         f7/MM/7HleIUtarmEKm+aWefmxznFIehAtgTYsUArl6X6CYnVUG7lwRvwdzbiagBYrnD
         ZIgA==
X-Gm-Message-State: AC+VfDwYSGBdFtoSzPNv8ZYWrFXf/HlCsBAxNpkwqSjW375rbEwRvE9F
        gYEa3IxYti1RACJKPAkBWgZanJ4EGiGuGmaFcqw=
X-Google-Smtp-Source: ACHHUZ5tI1nawvfqfJL0nFSufoRz0r+k3MRi2USiQqcNCm62Yx3+WFZiIcQCt3uLsdNeDUbWgbK74E+iJL8AyzZxmzY=
X-Received: by 2002:a05:6214:2526:b0:621:6bcb:e49 with SMTP id
 gg6-20020a056214252600b006216bcb0e49mr16611113qvb.0.1685732807044; Fri, 02
 Jun 2023 12:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230602184557.1445044-1-asedeno@google.com>
In-Reply-To: <20230602184557.1445044-1-asedeno@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Jun 2023 15:06:36 -0400
Message-ID: <CAPig+cS0sGYiCa9Og-f-UL=pZo9OAz587UsdX69BCf7hraHWFA@mail.gmail.com>
Subject: Re: [PATCH] statinfo.h: move DTYPE defines from dir.h
To:     =?UTF-8?Q?Aleajndro_R_Sede=C3=B1o?= <asedeno@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2023 at 3:03 PM Aleajndro R Sedeño <asedeno@google.com> wrote:
> These definitions are used in cache.h, which can't include dir.h
> without causing name-info.cc to have two definitions of
> `struct dir_entry`.

What is `name-info.cc`?

> Both dir.h and cache.h include statinfo.h, and this seems a reasonable
> place for these definitions.
>
> This change fixes a broken build issue on old SunOS.
>
> Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
> Signed-off-by: Alejandro R Sedeño <asedeno@google.com>
