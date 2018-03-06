Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11ED91FAE2
	for <e@80x24.org>; Tue,  6 Mar 2018 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeCFRtl (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 12:49:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53415 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFRtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 12:49:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id e194so5525165wmd.3
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 09:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MB/W05m5ySJqbNE9PU/n2gxTEA8xYLOrox18t0Ib3tg=;
        b=lz6noH9Zbq8xmMM11Vg56q4SdlbChcuBzztF6n0ui5tiLaA/MXpBMDAIPoZIC71e3S
         FnlJ/fV1UUBodEr0bCv89gLuuE+JBeA7dy0rGEeXeMZqKGW7DjMpK8YstT4FaanZwbk/
         gWe0h02msgIJ8Hbq0SWz+BoWX1V1XKQlJEX0drDJ2FwO++g93YIUj79wmDtMm55YsSWh
         ZAtHz3dFgAyAw6qwQDYI/LhKeH8MD/7n2EpWLN6C+zRmAiaW/Pxwq4J2J1TTAPRG9VYo
         P5dujHLGVaxHhoT49/Iebb+m1FJV5GYKg5Gilzlw632EcLPuiklcQxhuyeFmozqVBmU/
         Vs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MB/W05m5ySJqbNE9PU/n2gxTEA8xYLOrox18t0Ib3tg=;
        b=ArIgN30yxFEgtPrHQo+9niO37xd0N2hirjn1DsbNbUmmT7mkFPx0HH7qM/rOyTXmJP
         6RVsbCsBgVqKiDZgFVKkPxYhKH4uLHQwj0KVPGYU7zOjFzsFyvjjH4XOiTxFnE9knWzE
         wVBgYBZQ8St7dWnQzsEdA3pMr5ysO2kzwNRKU0qZRn+ZDrbDNgE2EX7r8CvgNS1uuHw1
         LSSiO3btHeISwbBgzTpRfJ3eBhGK7EjXRGZT0rNIHZzq+wNyctd1Rp1zUpnAfvGALO0x
         NkApY0dSYjaWaeu13WPvgWdidP9j0wgjRD1/U/raQhc6Ci1FAsIEUjW0ijMkWqkC7tHj
         zOfA==
X-Gm-Message-State: AElRT7E+ls5EfGrseH+LXFoQ6X8JMhjrSEQPH4ae5zygVy6g0vrCX+JN
        rVPMVhhzb/AyM6OqE4gXMjo=
X-Google-Smtp-Source: AG47ELt9II5bV2rrMO0qOq/O+EI+PlZ8Arj/DVDEuBYLDTw7RFU8XzY8PUt5foVee1Kp5fzjWhwUiQ==
X-Received: by 10.28.223.212 with SMTP id w203mr12827001wmg.96.1520358578655;
        Tue, 06 Mar 2018 09:49:38 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s26sm12437304wrb.10.2018.03.06.09.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 09:49:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/5] Avoid expensive 'repack -ad' in gc --auto
References: <20180301092046.2769-1-pclouds@gmail.com>
        <20180306104158.6541-1-pclouds@gmail.com>
Date:   Tue, 06 Mar 2018 09:49:35 -0800
In-Reply-To: <20180306104158.6541-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 6 Mar 2018 17:41:53 +0700")
Message-ID: <xmqqsh9d5c28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> I'm pretty happy with this now. Like v1, this is about not touching
> the giant base pack when doing background gc. This saves about 2/3 of
> memory, which in turn should improve performance if you're under
> memory pressure.

Thanks.  I've quickly scanned them and the overall idea looks quite
sound.  I'll comment on individual changes if needed.

Will queue.

