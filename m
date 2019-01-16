Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8F01F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 04:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfAPEMY (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 23:12:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51235 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfAPEMY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 23:12:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so520414wmj.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 20:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ilS9gdHiIV7/I1rce2LmKjhtzOAvmw2Ao5aspg2+V9s=;
        b=O+5Yszq9oWS6DDtDUeG/3SIhfYMu/9MFyHisfgrVC/rQFJi559ulRiMunvJqLz4AJf
         3a10zR2OIxtJa6M5lNJ/jwZ+Gs+fHsEs/F+lYp2IJWD0hpGOb7X/wKTz7HV1sg3Q8fTZ
         228371vHWy8lRlzgZ1yYgD3zo/aPkPk5CIKuAUWa/D36dgBH/bnCJ01X3KnFcWN/HkuA
         uy0FAUsQSWfW3/L9sHh7PkWWpc9BaPzdLrGhxtKc5mMjY7j1UxSw8agGRNhvbl3iDXwh
         JVIt3j2IorH+pCNms4xUa5tG1oiQkUqBHg7BgnaHnXhaZRgadl2aj0RpQuTNiWVRryaY
         e1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ilS9gdHiIV7/I1rce2LmKjhtzOAvmw2Ao5aspg2+V9s=;
        b=iWGjhDKQPeX1uYgPsU3P02aagvlnP1WYVpdUXRVKfAjXUwJIO/nianC+Zx4aNPg7JZ
         ujVtEDK7eRaFeFZKkfdy0lbxQNK/mj2HavXkLWx1sMVDiCW9veB708zdu/INhujD3nKZ
         HXGPlGQO+y2NeVeUDwoSpMwwHIVXm0O9JEAk54MY4Yfycn9AWNGPnQDQISz0ICDBgwgs
         vV+cZrKFPmT8ZzAQJmZ8MiiRO9qxIelTtLVdkfOzURAsjuCSOyaURVv5KbMFfBkFJA3w
         yRcRV02y6uoKbQkohE7b//7ClyGK8ek04AbEvhGWEaU9pzb18fsh6gaEtQZtJkVVGbDn
         0gtA==
X-Gm-Message-State: AJcUukeIPjy/c0wLrK7XF5pcmDSKb83vBM1zpAlzevav6QOV933UQqGK
        sOvhnrHok0Dnv0XhFMwSBb0=
X-Google-Smtp-Source: ALg8bN6sSq0LCVAvNNvzYSWxRNZwKXMX5g1XWOT+cbyz+JF8yhofSkAyJ1/XGZSSn7BMdPNUmM3sMA==
X-Received: by 2002:a1c:2d08:: with SMTP id t8mr3505001wmt.5.1547611941641;
        Tue, 15 Jan 2019 20:12:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j8sm85938613wmd.0.2019.01.15.20.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 20:12:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Sideband the whole fetch v2 response
References: <xmqqr2ddpl8q.fsf@gitster-ct.c.googlers.com>
        <20190116003828.64889-1-jonathantanmy@google.com>
Date:   Tue, 15 Jan 2019 20:12:20 -0800
In-Reply-To: <20190116003828.64889-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 15 Jan 2019 16:38:28 -0800")
Message-ID: <xmqqy37lnsuz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> We could make the caller of demultiplex_sideband() store the outbuf, but
> at this point, it might be better to refactor packet_reader into its own
> file and have it depend on both pkt-line.h and sideband.h.

I do not know or too deeply care about the pkt-line / sideband
distinction, as they are logically one thing.  With a packet-reader
abstraction in place, doesn't this "here is the remainder of the
packet from the  previous round" belong to each reader instance?
