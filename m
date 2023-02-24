Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0351C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 03:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBXDBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 22:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXDBT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 22:01:19 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB005943D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 19:01:16 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id fd25so6301558pfb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 19:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnFYQqafhXOh+IYwGz7qcoL2wBkgyntW1r2GWz+obd0=;
        b=XOo/BArSr9hH8GzIc/Zeq9PfxKovZ+/kVXzzH08bn5nHKBsJVFMzyzZrutgi8mdfdP
         Ur0+Uo4F2QExKizONgKFWhuocK2j7ZxYgsYV7pSHNNsTBcMTY9FtypsDwOckaCzW7byB
         ZilsUEZ2it09BTTF5d+YEAkfHVvRTcs+nfPCtDTNzWu2F+EaIkEC0vFNwJa+IATi7pq4
         Zc2wfUof8uBrhhEsdkav0QzZMiClq29UCrD6xMl5XJDL5N+9Rqrh2V7eVGiK41jDYT7f
         EdDvzhjIKzmsu79fMEYM90rAqxj3iSxy0nsGN6TwQItla2dk7TVNG44XyrOBfUA/gSlN
         N+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VnFYQqafhXOh+IYwGz7qcoL2wBkgyntW1r2GWz+obd0=;
        b=V63ZuuGkKZzdO8EWukRcm+TusU9DbVw8h7t399XJW5t3X/e9AjLQcdy35xR3W/gyMl
         Dzpu5beUFP8llj7WP5crilhAZcSglIcgdS7zgbJQgIeIcoahkfmzcrLCK389JQZ6JKPX
         JYHziJaDn7h9dbLUdJlPDWUHoWrA2U8aOmBwNMixuS3kanqei8z7w0MIStcHG7h32mHU
         mrBdZtRBaciGiiU20FLMH1pktqtTxiRxkWnxMd3LDO5pORBZtnoHklRX5ph1/AByhPXI
         z6Yz/5gW6SWz5qpP/GTimV0nkzQaSLOYfMs/2m5ij8g6PZDANKp+EN1NQTp6GapoZQEU
         /jgQ==
X-Gm-Message-State: AO0yUKX/jeQJkaRb9yXsfC7/9jcexqbsyXiPfiPLDn1OiDP2psYC5by7
        JIZBlfVC9xL5GUtUycGEdvc=
X-Google-Smtp-Source: AK7set+5xbq3+eDJmf2qHXV7tksN2xtQecO87kKA/3DIP4zJ9tZyEtM/s4qeZao9twwcbXKyCP8HDA==
X-Received: by 2002:a62:17c6:0:b0:5a8:b6cf:1a74 with SMTP id 189-20020a6217c6000000b005a8b6cf1a74mr12055403pfx.18.1677207675635;
        Thu, 23 Feb 2023 19:01:15 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b005a84de344a6sm5076405pfo.14.2023.02.23.19.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 19:01:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/16] http test bug potpourri
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
        <xmqq8rgo3qe6.fsf@gitster.g>
        <Y/gdVv63YSilKSYz@coredump.intra.peff.net>
Date:   Thu, 23 Feb 2023 19:01:14 -0800
In-Reply-To: <Y/gdVv63YSilKSYz@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 23 Feb 2023 21:13:42 -0500")
Message-ID: <xmqqk0073gxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Feb 23, 2023 at 03:37:05PM -0800, Junio C Hamano wrote:
>
>> > I'm actually not sure if the final patch is a good idea or not, but
>> > certainly all of the fixes leading up to it are worth doing.
>> 
>> Thanks; this must have been a lot of work.  From the "test what the
>> end users use, or at least something close to it" standpoint, 16/16
>> certainly is the right thing to do, I would think.
>
> Yeah. My main concern is that we are now using SSL by default in the
> test suite (or at least trying to; I _think_ we should fail gracefully,
> but since it works on my system, I don't have any data beyond the fact
> that CI seems OK with it). I think it's one of those things where we try
> it and see if anybody screams.

True.  If a platform has TLS/SSL implementation of acceptable
quality and if we fail to build with it, that is something we want
to learn about and help them make it work anyway, I suspect.

Thanks.
