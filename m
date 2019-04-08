Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A09220248
	for <e@80x24.org>; Mon,  8 Apr 2019 05:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfDHF1J (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 01:27:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41010 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfDHF1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 01:27:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so14666446wrq.8
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 22:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0QC84r8vU2qSTcwUg9geqi4PbX/gqsMTHGqJ+2mccg0=;
        b=IoKkNCqQcPvu9NoANTkenyGeDfZTXYltdiKwbUtgN+hBRkxC+eXzBR7K1oU88p36ea
         xXWE2/gGIPti0jRSxHubam8K2KhoTqlWi3HP7i0Dtfu+GEkQHfl/P6xTWsYw3ZQttdG5
         aPru8a/jPrtVN5Au5Bc/jeB5k7OEUlgDJToaZiwhMcYuh/z9YS4lK5yGuyy5YJUK4uww
         IFJ1IfpSypmtGYw2ivXY4MDbx89BQR2RvQgp+oHO1Kg885ZYhSust4S93ywkJAFeGB4l
         rpNHkcQnxfsxf0KewPTeb+FqiqyksdzgVQbrK0VpQ/+5gpyP9sIi2Bdd9NX8aZY3d8hZ
         rWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0QC84r8vU2qSTcwUg9geqi4PbX/gqsMTHGqJ+2mccg0=;
        b=Iw4ccb9gz0Zp/I2BlzM0E80DTR60AAPPfeugfm7qYevLTCqPOMpjMpsmoPmIXgi7fl
         el4sRZkKfTOSHRVTAi+v/6T2SW2qwyCcoX9Y5W6MCVNdykr19y/OhW/SefILrCa3TRhx
         XXI73+kHrrzhXxAbN+T9KFzTOa9yLeYNrLw8c6D7/0LlRrYcT9En7rltZLydWWBQpuWr
         loS7XPsxY58IZ4nVE/b5dSKhKD7b5JZrcf5jl9a3Zw07wPVtkO0ncaYv4kV2Dql8v3ub
         wCi7s5BsEPnpvN9D8KCu3YaS+9JjFxiJWa7kzaZm7CcegAXvYP3xb5lWIU5UFPrSUvFx
         oGqg==
X-Gm-Message-State: APjAAAW14JyGkZQ98IYv9T0/kU8f/nv4thy6WYORxpIj4klNjIZkIlC9
        C8HBed+K6mgUJmDfK/FS4HU=
X-Google-Smtp-Source: APXvYqxwDDxmMokgLK3jY4fN3UdvGolffsWCw+U7gJps5EQPNcXLXF66u04hYQKMC4/MsbXZEE2kJw==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr17735157wrv.281.1554701227366;
        Sun, 07 Apr 2019 22:27:07 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j3sm69077563wre.51.2019.04.07.22.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 22:27:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
References: <cover.1554435033.git.me@ttaylorr.com>
        <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
        <20190405105033.GT32732@szeder.dev>
        <20190405182412.GC2284@sigill.intra.peff.net>
        <20190405184229.GB8796@szeder.dev>
        <20190405185241.GG2284@sigill.intra.peff.net>
Date:   Mon, 08 Apr 2019 14:27:06 +0900
In-Reply-To: <20190405185241.GG2284@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 5 Apr 2019 14:52:42 -0400")
Message-ID: <xmqqsgut9idx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think it is, but I could be wrong. POSIX does say that "\n"
> matches a newline in the pattern space, but nothing about it on the RHS
> of a substitution. I have a vague feeling of running into problems in
> the past, but I could just be misremembering.

Yes, it was quite bad on minority platforms like AIX when I had to
touch it the last time.
