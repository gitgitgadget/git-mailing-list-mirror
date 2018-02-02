Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0722E1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 23:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeBBXac (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 18:30:32 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51282 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeBBXab (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 18:30:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id r71so15802441wmd.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 15:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ey/6VzSaE6fE+FC4dVH0MeEULxKOo/ELm7hA3HpXmh4=;
        b=VFurms/IDl9FRXdiom6NdBz5gi4JDK2asVX+U5zavE+6MsJhWoDRWurV2MFuAwlSjC
         LV8IKQlLqXQjCiq+hF7C1b2tNQsefJ2YiX+9tQI1lXCMBB2fcPNKluNEJnrY1px+fT6O
         7AxrOrT6iqPVyn0Kft/byj4yZM9BvilzmFW1kTcDudU6pZmRF7jyNaxRSQMFlvhChGZX
         J4CD3J7aVU07hTbc5rbJczsseOES2gMtUqFYGlnq/S2rk71kR2mXduAX+qwpXK5ROEUb
         z7D8rr/iioWWX5/8PBLk5kzsKboG2kBsWO5zoiiRUebJkrHsKDRoRoqKjACEAh+BcQbJ
         6N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ey/6VzSaE6fE+FC4dVH0MeEULxKOo/ELm7hA3HpXmh4=;
        b=PtbaBBoe/ioW77zgK0VHQC9fZKVnSt2hFU+jPUD2x3ubLe0RxkAbJyqCXQ7t+2ZY3W
         J5FI2i0kUNmhIqr9GZzy3rP+g6OKn345Bl8DvDRryrHGoSWcXnnb7fAgnBHYkoRnx7pB
         xZ0B/GCc1aEp8zRKiHjquL758l+C6HD7Fs1QmPBoL86npIDL3jB3DXGBo1kcBrZ48Amq
         QAroIuSm9GJ3SABpHvSFaW07BvWZ8oPeaak7yChyFsMp5ubRJkuRLcbm2t4ja7wcSDL3
         aE5/VgjbZ3+F49TBs3JNzRB4xS4yNjKHzvgMVoyirmCyTR/WQ7NPzFtZ6hUjoUqrC7m4
         ocGw==
X-Gm-Message-State: AKwxytcw40/y9foGmXoTH+s4Q+Rkh2HF4U23siH/665avCcSx5qu+va7
        F6ocUF6t1tuPr9vTI5axqHo=
X-Google-Smtp-Source: AH8x224ad15rMBhIPXPBfOlv2FSj8NVPDoMqhkQSAwIzussiA272KBO6QqJ1l6mUZFeWUiaeVnghUA==
X-Received: by 10.28.194.2 with SMTP id s2mr29542856wmf.55.1517614229808;
        Fri, 02 Feb 2018 15:30:29 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u98sm8321084wrc.69.2018.02.02.15.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 15:30:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 0/2] Refactor hash search with fanout table
References: <cover.1517609773.git.jonathantanmy@google.com>
Date:   Fri, 02 Feb 2018 15:30:28 -0800
In-Reply-To: <cover.1517609773.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 2 Feb 2018 14:36:29 -0800")
Message-ID: <xmqqtvuzas17.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> After reviewing Derrick's Serialized Git Commit Graph patches [1], I
> noticed that "[PATCH v2 11/14] commit: integrate commit graph with
> commit parsing" contains (in bsearch_graph) a repeat of some packfile
> functionality. Here is a pack that refactors that functionality out.

Yay.  I had exactly the same reaction to that part of the series.

Thansk.

