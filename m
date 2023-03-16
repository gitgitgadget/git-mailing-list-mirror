Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9DEC6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 23:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCPXV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 19:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCPXV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 19:21:26 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7216125E31
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 16:21:20 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5447d217bc6so62024027b3.7
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 16:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679008879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXPt/IkzQfkK+NigyyJTEHgPPVeTw/yKMGCMRbw9yt8=;
        b=aqTN6PpHyo+whZZkEmvPL2dUd/MqWNstzNeObILjN9oFjA383f8SOpkFH3XuavoARh
         lgiy0TtJGX0cPVtwanJY9MUORuMqDE88HZAEh9kyaU8RTfH6em41nvgLxD9YAon/KXfj
         M/D5+WkMTKiu1WmgU6OzrZustP0W47WqLp1zO/1mSPFusfl4jVlszCvmPuUhQzXDe+qu
         fX+cqeMLTV8aDK1AehpUYLw/ZkX5k/7JLvehTntobwxnwqpugw0YW3zMSC253e+2v1RD
         yhSSML9ic2TB4gkU4+yaaQbnwEMIWInBN+0u6ECiXgpiS2DGX4idK7QcZBS3v8fApBWE
         BoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679008879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXPt/IkzQfkK+NigyyJTEHgPPVeTw/yKMGCMRbw9yt8=;
        b=CDiY1CpCDbZonMd1BjV4TZVOwGYxoRIe8KKU4RngBUeJEoCFzXWAei/3yDyt2KbCHZ
         3qazRLUxkAAjOiKWdLCFwdCl0IqLNtPSZJ9kwNVCqGgbZBDfedEoUwTvUHcnWRaGjVd/
         zQw11+/s82BokhKTrtKT1zAc7V92nsBUEmnoY5Qdo3su232wW6HpEEsVN+uoCRMpwR9N
         4ZzVjYM/uUMAGUsYTPmRugtISLKPuQ0odVrCg3Hbh5l+lM+OaXnVeFyS47FtxtjHpUpY
         1hBr4R4eBYmUreFmzNXjWhefL5keZWAGsg3kFgg93SPIkY/MnVjonGrxBmCd/WWUpTqJ
         ym4Q==
X-Gm-Message-State: AO0yUKXThEeeps3orCV1EvKYGLh5e9RskIaDLyQ1RkQEIB1t8V4m7UOl
        oBKIpTzIhUT+VmK6wLLSgQWsxwep80h62zByk2ERRm1HBI4=
X-Google-Smtp-Source: AK7set/HvnVyIGZegp0fzGtfcN+Agkh1QSDJATvGTZHBfvS65DWDnLp6BFrcEykbS/HlERyTgDOElzeqXxFioxqnsB8=
X-Received: by 2002:a81:ac1f:0:b0:541:9895:4ce9 with SMTP id
 k31-20020a81ac1f000000b0054198954ce9mr3274220ywh.9.1679008879661; Thu, 16 Mar
 2023 16:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230228145934.4182166-1-felipe.contreras@gmail.com>
 <xmqq4jr4nu3u.fsf@gitster.g> <CAMP44s23cvp-YWDN7vzsKQCcWoc43PgURq+J6pwtx0rxOpZLBg@mail.gmail.com>
 <9e317aa7-0037-7076-e159-3a70c581ebc1@online.no> <xmqq5yb0i9nz.fsf@gitster.g>
In-Reply-To: <xmqq5yb0i9nz.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 16 Mar 2023 17:21:08 -0600
Message-ID: <CAMP44s3eVcfaeQC-BB+F4FE1e7m=fFj6F3pSP-qrb9uPX9zT1A@mail.gmail.com>
Subject: Re: [PATCH try2] completion: prompt: use generic colors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joakim Petersen <joak-pet@online.no>, git@vger.kernel.org,
        Justin Donnelly <justinrdonnelly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2023 at 5:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Joakim Petersen <joak-pet@online.no> writes:
>
> > I've played around a bit with this patch, and it seems to work as
> > advertised.
>
> As the change itself is so trivial and likely to exhibit problem
> immediatly if it were not right (e.g. for some version of the shell
> but not for others), let's queue it.

For the record, it's not even the shell, it's the readline library,
and those markers are present since the initial import in 2011:

https://git.savannah.gnu.org/cgit/readline.git/tree/readline.h?id=3D06cd36c=
dc90634c88636a6d09230c573078ead0e#n282

#define RL_PROMPT_START_IGNORE '\001'
#define RL_PROMPT_END_IGNORE '\002'

--=20
Felipe Contreras
