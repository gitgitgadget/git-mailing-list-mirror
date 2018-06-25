Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0A51F597
	for <e@80x24.org>; Mon, 25 Jun 2018 18:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934948AbeFYSGs (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:06:48 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54736 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934943AbeFYSGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:06:47 -0400
Received: by mail-wm0-f44.google.com with SMTP id i139-v6so3322358wmf.4
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X0Fy39ZwYXY9BlTCRUyiFSajMeADgZkyztgyKZlzuBk=;
        b=IYYqU6KB1nLbzlffPi99FQ1iQKg5LFX8GbEKmD4i1E84LVki/OyUVZ2CmkIgqEyZg0
         cWKwGjWYJA5h90mG7ArrTksl2VczufKfe/gAWHpvjDswxN4a53hL/ixv2+aE2Xw/07hg
         OiAO0786/+A2DWA2CLHUuWzLf+leQc2WMsDwraCPEUF/WDrCdCo6np6/pk+R9sq+yVAi
         AoCtNBOmyriw6mGFHn0/DR+TrcSEHZapnn09C2fp9dsq3AhvN8OGzz/KkTWOWC8wVw0S
         GlNOyfBwNgcVIXyAqpMImC+zatTGW2Fix07RV5xoUcPXAmjr6ylktSaQnUMnjFGAu88n
         wNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X0Fy39ZwYXY9BlTCRUyiFSajMeADgZkyztgyKZlzuBk=;
        b=Hf+sDjDwVpyl369v4oXOTiYuqAmPvXGJ3NMH6EJXW8gNg5Titi85d/tyDRj4Wicrer
         ycQSVGmKwwouSCgdikj0T4vjmX3RX6fRZAZVvtTT/BifZrF2Wm6PG1B14qgXMXgoT9h/
         WP//SPNIGkEXtMBUFwReIobMJ4tAuh32qd7gnUOwxjiYfDiXSpXgA82003FIWex4dcPD
         FIXUvd8Vf+lw7ho5aaD0DkD/oujvjAKVr9XBR/TNH9XBxMws+KD/Gqe0awOIbh3RA+zD
         SZtVz3Wcf3scdCA+YaRx/Nor7lVz3Htc5KytpeZSWfFx16RDNgDyatcUReXObaYz8xzV
         Hngg==
X-Gm-Message-State: APt69E3H8GgEaySmhiRlG6DY31oIyNK0MOR85bQrJ4LRKr6fGijRrjD1
        VnkJZaYzDOvn7JTqoVJOgEI=
X-Google-Smtp-Source: AAOMgpfyjLzVJI9KiF711kyABPllifv0PP3Q5wZTD0SQoF9naLp13UT2brJIQMpbb0snqsPwveLgDA==
X-Received: by 2002:a1c:dac2:: with SMTP id r185-v6mr1747637wmg.31.1529950005694;
        Mon, 25 Jun 2018 11:06:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y8-v6sm19278346wrq.35.2018.06.25.11.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 11:06:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 2/8] Add initial odb remote support
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
        <20180513103232.17514-3-chriscool@tuxfamily.org>
        <xmqqh8n9ae17.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD3kMQxiViL4sUPMjmJHxVkobmTdpJ+=G827hVhPwaxarg@mail.gmail.com>
Date:   Mon, 25 Jun 2018 11:06:44 -0700
In-Reply-To: <CAP8UFD3kMQxiViL4sUPMjmJHxVkobmTdpJ+=G827hVhPwaxarg@mail.gmail.com>
        (Christian Couder's message of "Sat, 23 Jun 2018 14:15:09 +0200")
Message-ID: <xmqqzhzioi4r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> For each promisor remote I think it makes no sense to have more than
> one remote odb pointing to it. So I am not sure what to do here.

If it makes no sense, then detecting and erroring out would be a
sensible thing to do, no?
