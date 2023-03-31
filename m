Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE825C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 17:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjCaRRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjCaRRF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 13:17:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FD91C1FD
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 10:17:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ja10so21872611plb.5
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680283024;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3HrQPVywMnoTbQx+ODv5tlpPnT5ey+Y3N7udLPuD4k=;
        b=V2J9VJiHcDZ1BoGJDiJyE6CvyRlQSXUHCFOYG8OpAcmZNZ/3K3ygkNT4d9uxaE/kpl
         ABz+4gvmGEcdyY2e9GHZnx/f7Yw2Q9HEC6Vm3CAtJi0mLhNCeFb5CugDrmOpUxWi2bNa
         hiRhcy791VDG8EUGZSTLoMGkl7QNTwwAmpeQdK/sSZLj/Y3CopiStGLUhqTuR1WQeeA/
         eRO/otXMONJ2JZurMBHQH7rOPthSLmx9UgJc6KDfkrzTgGwLuWgtd/PTqdL8BT5D1ohE
         sUdyI9b5Zk6YL+SrVaGJUr3aqcZvf00r83CWuYME/pvh9sYPfBZLo+6K1d43A43UvcSU
         6MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680283024;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c3HrQPVywMnoTbQx+ODv5tlpPnT5ey+Y3N7udLPuD4k=;
        b=29ToKPlqtpQV/n97m2TZa26ryfGTzMjDL41iskIqCdwHAMSMNmOvQ1BY+vgqKpSuwM
         2VXVquBnLJzGpNN8F3/cUhjuGiWXiab5k14Ya269kXlHwlXQ76p6J3XZLcozhka4Q4Gz
         UhHnelMYg/XlFb4f4r6QNeTdx+AIC4CVvOQiGSte4hmpToXCB73Z2tD9qefVdW2YRfDY
         hMSYJRGpF14yZGbVsc4VLE2ASHZYx5I4Z6H0+6YE8gwuE7gEDw6CeaQTWYDKGulXCUVN
         QLqqj7Q3FGwF5rPK4w0xItFUVqdJQUdorRAiM9z2H5wgZm4jCDwtZn7myaFKIXxJlfef
         OZXQ==
X-Gm-Message-State: AO0yUKVmmBKJBP3oePqtbsPHnFBBH+96FnRm3DSCEwpA8uCvrNCaDuxr
        l5aBXh3nL2s+5308Eva58mw=
X-Google-Smtp-Source: AK7set/GXb24Vbg5Cv7L532sDHN4M0qZwv/NY/Ph1g4g5t1Bwb9eFimauqwgc0kaAkuKVyRqIU/+8Q==
X-Received: by 2002:a05:6a20:4924:b0:cc:9643:1f8f with SMTP id ft36-20020a056a20492400b000cc96431f8fmr25600245pzb.13.1680283023850;
        Fri, 31 Mar 2023 10:17:03 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j7-20020aa783c7000000b006251e1fdd1fsm2033023pfn.200.2023.03.31.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:17:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
References: <20230330112133.4437-1-oystwa@gmail.com>
        <20230330112133.4437-3-oystwa@gmail.com>
        <44e7ac0f-2fd9-fd01-89da-a8d036d2e400@dunelm.org.uk>
Date:   Fri, 31 Mar 2023 10:17:03 -0700
In-Reply-To: <44e7ac0f-2fd9-fd01-89da-a8d036d2e400@dunelm.org.uk> (Phillip
        Wood's message of "Fri, 31 Mar 2023 17:33:37 +0100")
Message-ID: <xmqqjzywg7sg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Do the empty lines in the output serve any useful purpose? If not then
> it might be better just to suppress them unconditionally rather than
> adding a new command line option.

It's a nice egg of columbus.

It however theoretically can break an existing use case where the
user correlates the output with a list of refs they externally
prepared (e.g. "for-each-ref --format... a b c" shows "A", "", and
"C", and the user knows "b" produced "").  I do not know how likely
such users complain, though, and if there is nobody who relies on
the current behaviour, surely "unconditionally omit" is a very
tempting approach to take.

Thanks.



