Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C244DC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjEAQoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 12:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjEAQoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 12:44:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEBE76
        for <git@vger.kernel.org>; Mon,  1 May 2023 09:44:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24e0241013bso1043687a91.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682959447; x=1685551447;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4zJ6X9rEzQtIn3WYTL0scZsE3ZK9pg7ilUJ+sextwc=;
        b=loMtmweV4fA3u8klyIKr6WCpRx2uW6jP4hDbcppKOy5+tkIuce+kqtK1i60tDJMBtU
         qBzOg1wJd66eKlwGGyo04zZJNEZEC+5bVmbIjrIauBt7VH84M+gXg4sU6LH6zC1hai2A
         KgTOYFM881OdTGKgvhVPKVOVuzcUBqgYmuNTE5vdYfkkMGsx7Zv+qt2LTEad2w+5iTYe
         5h3olZFGF/kAuSYSfnFOJ/xPYdUCh2bFrYdOnEDIov0jo2729xR398O1XpaNEc8VmLcw
         7Rt+PAvgWmASTe7g2bszs0rf99QMX1maIovGUp3vPxsZclyjLqiSZ+jSxiwt3b3D28TU
         ayyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682959447; x=1685551447;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X4zJ6X9rEzQtIn3WYTL0scZsE3ZK9pg7ilUJ+sextwc=;
        b=MEtpsa4fH2P5uqtV62z+2+SBfDE3LZza/iYClXhlViev6bOfsK9CwTWxv5zEmwcLhV
         G9TkyZGcrobiNGKF5OE2mEUHfvJ7Nx+xJ6kRXfSmC4Ze35hsSZngvVG/vjc+KO74T5Fl
         gnxHTohOnmgz8j73Jgl4Sbt2R4y/Bt1kMj/UB0TSWrwT1u1D67Fc9n/M0qa6mM2sGF90
         +XcfLrxtNhNPz7TxGrF9AUiM2sB98fUHB4g1TDhXDxxYmRsZ32lJONxHC1WnOpLsDnTV
         GmFxpyQ0TrsUz2GZCAiTcEImRvI6rUzfxNNZFNMr7xVORzUW4Fk5dHJ2Gy9g/SRa2m1N
         ojgg==
X-Gm-Message-State: AC+VfDxM28I3lSzx9YvmndLVCw2ZXzQDw/OR7uIDsgw9XkePSoa/N0dY
        GJXDbsnHmU2v9woy0BgQmoHgbaVAtbk=
X-Google-Smtp-Source: ACHHUZ5ev7JUNVr/Q3WsXFi+d2z6/y8wtGnjLqXG3mqSXBxX91X4WN/yCjaOlyXGeB9sg3+9JhvhhA==
X-Received: by 2002:a17:90b:380b:b0:23e:f855:79ed with SMTP id mq11-20020a17090b380b00b0023ef85579edmr16345990pjb.28.1682959447307;
        Mon, 01 May 2023 09:44:07 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id nm20-20020a17090b19d400b00249604258b1sm19632801pjb.38.2023.05.01.09.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:44:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <xmqqcz3netxr.fsf@gitster.g> <ZEwafQmat347la3/@ugly>
Date:   Mon, 01 May 2023 09:44:06 -0700
In-Reply-To: <ZEwafQmat347la3/@ugly> (Oswald Buddenhagen's message of "Fri, 28
        Apr 2023 21:11:57 +0200")
Message-ID: <xmqq4jow6lyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> but i don't get the argument anyway. i think the docu is pretty
> pointless except to emphasize that the generated subject is a default
> that should be edited when circumstances recommend it. in fact, i
> wouldn't mind writing just that, with a notice that the default
> attempts to be somewhat natural for repeated reverts.

I think it is very well known that the user gets the default message
to be edited in the editor.  I would understand if the instruction
is "do not edit this line, because ...", but otherwise it is pretty
up to the user to do whatever they like to the log message, no?

