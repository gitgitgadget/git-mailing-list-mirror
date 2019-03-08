Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A9C20248
	for <e@80x24.org>; Fri,  8 Mar 2019 00:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCHAJm (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 19:09:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37482 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCHAJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 19:09:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id w6so19483407wrs.4
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 16:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=heTxN4s3Mqt/heyN409kgPWZb3RkEMcXo9hwL+QRkFs=;
        b=XVElNHUIYiVDL2mlPFx4+2BnOMJy/7sVSWvlNKI8gBJ05ZlQgOVTkZYkIFa+dfWDj9
         ut/e5asmKcZXFo+HuZ9QnkV9KTTARYfRawrELDSu5jpn9LH+jOVmYH/y+/5wa9Wr4Ep6
         1Sg0LHbs0HdyyDQzOPjmZSDRqgWFgurpfq3Ma3C0omXPewp31/AZThRTWup197gg7LE4
         f1N8kDoKbQhV9gMqYRF4gXtAIB1YDgRAv3Qe7e7Y1xzVHoTrC9wGU0D3V1YZZ6D2gofm
         PdPxmMdg5BfcwsmejRM+TR7wBlj+QctDFSrffrfLnOXynp2rgSp/Q79N5COoCbdIigsb
         tx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=heTxN4s3Mqt/heyN409kgPWZb3RkEMcXo9hwL+QRkFs=;
        b=gXF5LxabDhZZDb/nYO/vTHKWchLpcFfgmUffW331QsfA7ZeK5YA2hOaquKwGiLA3kp
         MdeUyaKq6WSglnnYPUFIgNo5TZuTgWLfu/SlycKjMww1wMb/3TXFEsye1AHTeryHCvMp
         +BJaDvh3n5ef3y6TrrwkMJ/sdS1QYvHl70sFohB/7hAw1ej45GocrXI3Bi+R8Yg1CVV2
         qdqeKDYmKcplYRI7cTnVXfkNiba7kpbHN1JmF5gdG4zsyPpojR4A4P5t4BKzYfP8Z9SJ
         ln7hnzJKOK0b1ZBvluT8nxQrkBNMz3fZR0iqvZrwC2CqkV9LNZIIaRHw/Ma90BBmMU1U
         J2Rg==
X-Gm-Message-State: APjAAAW9EvpmiECzr7udcVhbQt4edXazsHP4to4+rqZQ8lc2/rIE2QL+
        A6m4+AJ9lvLLAwiuPw1b9nwKO4hOJotFTw==
X-Google-Smtp-Source: APXvYqydKXY6v2W0yay2FJYT8QKTe/Fz3jve0dQvPkOvkLB1TEWplql6PujgDcJi1hp1xZcCKXVYfw==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr8507938wrw.314.1552003779872;
        Thu, 07 Mar 2019 16:09:39 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id p68sm7189592wme.45.2019.03.07.16.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 16:09:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>, phillip.wood@dunelm.org.uk,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] cherry-pick/revert: add scissors line on merge conflict
References: <cover.1551940635.git.liu.denton@gmail.com>
        <cover.1551951770.git.liu.denton@gmail.com>
        <14672ce10c90c46b15b62c48d2eea6fe8d85ed86.1551951770.git.liu.denton@gmail.com>
        <b568185b-2411-7c43-b1bb-c22594904fa0@gmail.com>
        <20190307175628.GA14130@dev-l>
        <8404ea52-6556-1232-176e-f74f8d9583f8@gmail.com>
Date:   Fri, 08 Mar 2019 09:09:38 +0900
In-Reply-To: <8404ea52-6556-1232-176e-f74f8d9583f8@gmail.com> (Phillip Wood's
        message of "Thu, 7 Mar 2019 18:36:39 +0000")
Message-ID: <xmqqo96mkz0d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> What are you basing this series on? builtin/rebase--helper.c was removed
>>> last September in 34b47315d9 ("rebase -i: move rebase--helper modes to
>>> rebase--interactive", 2018-09-27)
>> 
>> I was basing this patch on the tip of dl/merge-cleanup-scissors-fix. I
>> can rebase or merge my work to something else but I'll wait for
>> additional directions since I don't know what would be best.
>
> See what Junio says, I think it might be simple enough for him to fix
> that up when he merges it into pu.

Perhaps it is a good time to kick dl/merge-cleanup-scissors-fix out
of the 'next' branch, so that the whole thing can be rebuilt on top
of a more recent base like v2.21.0, without the need for these
"oops, that was wrong, so let's patch it up" fixes.

> I've just realized that if you're cherry-picking a range of commits and
> it stops for a conflict resolution then the new option is not saved.
> You'll need to update populate_opts_cb() and save_opts() in sequencer.c
> to do that.

Yeah, good point.
