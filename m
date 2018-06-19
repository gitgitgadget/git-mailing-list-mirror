Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C201F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966700AbeFSQ7U (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:59:20 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36817 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966768AbeFSQ7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:59:19 -0400
Received: by mail-wr0-f178.google.com with SMTP id f16-v6so399978wrm.3
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HW/D/+KCso7Fcz0BdzJoA+e/dx010rCIPRPwVX8/2gc=;
        b=Ri5BkuvzFSeBiU2F/1kU/bNqNxUbmweSPtF2AC1aU6DOCxBxbOid2J5nohB4qxFvVN
         5vmiv29YAcaj1zdg/VZPP5qzXI0Y6AUekhHiNW5hjC2c/99asqxY9gpM9fe2NPKKFlh1
         3kPXjb1cBCgPxIEDu/IphVxTcrxzuShxwOhjTF0HffFfhKkkUiorJw0+/jP+89y1we9m
         bm5VqwvzaNJP/yIU13haBeqBQjT7Dw42aSP6JGT6PI37dJl2sGUkR/+TdxC5NDXU9h+f
         4dpIq4BVDbrEEDoXR678gyOdc4n7qVDvRdG9tUPpiiCkkeiq59HFAWk5XlvO0lMCSQPv
         pjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HW/D/+KCso7Fcz0BdzJoA+e/dx010rCIPRPwVX8/2gc=;
        b=s0n9HcgxKUOW/OsDVcm90j3mzaGCqFHoI8x2Lbm45XU5o8kZxkkv1x1iD3Sbly7Kgl
         A6jiWDqpuwsNdYAa3WG+Kpxq6kQYcnvRtnrAtGp2RL/8nyt2aCQaILYiCe8hh30rDwHG
         jFOVo+hRh7cfsoZ4Pg03mpX7l04nCxlvN+iH3hXcMUXAWT2VsP8rUI4t55dUtbNWEPiG
         b9eA08zziYRnFXC24lVvRx0/5TateS6yETrPaHmui4hODGFP+v6850cSHBpUsVCRYi60
         4oAlMsGLczd650tUF4UKfuBVgAMjVmAJRvv+Y+CEE5mMwn4DWDkJJpR15yUol4+Benjg
         jG4g==
X-Gm-Message-State: APt69E3Uv8ttnb94mE/xVGR6oJD+x07ncACCqYoKiOwsTzV+qCHdL8mm
        tPE3lQ2/v9pWZTwKJbQNLBQ=
X-Google-Smtp-Source: ADUXVKJt/RAaYHtuMxd92QGE0Z0QrOAAlGY4nslZWLvXl2soYYKenOu2NRN3CqeFh8kOQtk1oAsB3A==
X-Received: by 2002:adf:94e3:: with SMTP id 90-v6mr14380896wrr.110.1529427557775;
        Tue, 19 Jun 2018 09:59:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b190-v6sm790752wma.24.2018.06.19.09.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:59:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>
Subject: Re: [PATCH v3] sequencer: do not squash 'reword' commits when we hit conflicts
References: <nycvar.QRO.7.76.6.1806182326420.77@tvgsbejvaqbjf.bet>
        <20180619124651.17425-1-phillip.wood@talktalk.net>
        <CABPp-BHFuqh1KVPod+chZD=AKGVBd_apOt6F9oTaZ0ZA66G03Q@mail.gmail.com>
Date:   Tue, 19 Jun 2018 09:59:15 -0700
In-Reply-To: <CABPp-BHFuqh1KVPod+chZD=AKGVBd_apOt6F9oTaZ0ZA66G03Q@mail.gmail.com>
        (Elijah Newren's message of "Tue, 19 Jun 2018 07:29:12 -0700")
Message-ID: <xmqqsh5ivhjw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> [As an aside, I know there are multiple other outstanding emails for
> me to respond to, unrelated to this patch.  I'll try to get some time
> in the next day or two to respond.  Just responding to this one since
> Junio mentioned picking it up for 2.18.]

Thanks for a reminder.

I thought I said that I'll backburner/ignore the topic and expect
something that can be picked up to be there when I come back after I
cut 2.18 final, but I ended up coming back to read the topic anyway
it seems ;-)

