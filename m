Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79E8A1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 05:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeDPFFh (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 01:05:37 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:41906 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbeDPFFf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 01:05:35 -0400
Received: by mail-wr0-f182.google.com with SMTP id v24so5065164wra.8
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 22:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NxkmTVA8Tconv9sSsTM6aoYm3L9zq8yeceatOl8wR6k=;
        b=IHiuq0NC0b3AeSzsRVZ+ep8QGWO9FGG2IUHSo8hnLmhilLSE3qwB94xOHnZDZ3bvVk
         IaKYIxs7G987spiGRi/jQM7U4+HMAlvwo7R4I7l0Wgg4fQ4MCHC1M8CAHm0PGIy+qD5G
         tvFzq2C/bEGqeItqtw1f/M8UnPG36Iqm4+Q86NbZOaASbyL3tDe6UXu2feTPKF6TNRZL
         wkrkCXyw4+YNSw0W78fdMerVIzucyLUCxFhV4X9uPB+DXQ7AkPsbQzVe+Hm8Sk85+Lxx
         1aaHxFne/89DFns2VGa3Ro4C91vqWvCwSyb+/f1q93xu9LTpK4xyJHXzu6P+W71aBQEa
         oHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NxkmTVA8Tconv9sSsTM6aoYm3L9zq8yeceatOl8wR6k=;
        b=nU+g+nQKjbNW0CEEpguNlC32uCckjw1uee/k9nszWlxtsKUajVBjq7EcHwvbVJ54lt
         JihM6lsOBntCSvc6ltbrg1kJ25mSz5boxYNv6/vHm/HnDGVNmuzOi10p2c3TMh2ftclB
         4dpsHynPYbCQFaGygle23QU05d+qOgH90z2yPbdFnBPPz0eYp07Qaw4rXtoa7bujENUk
         DCm7sPjzw+z2s3UEiBZKYaNp9frVfw4jZGk2cHXcXHMWjr2UwO5+0wiriVZCeTb6OZq9
         sJe13MCCsWvJXJN21DNtMWBrS1gX91kVoKdx9eVX1/Fdqj8pZ43bl9GztGPy3K6A7Njk
         k+3w==
X-Gm-Message-State: ALQs6tBfw1s3XJBWkctnN9HdztMiUALmgvCy9Hn8iBB9kEkb6+eG79Qf
        yW6LyJYAov9JHpKw9CXsPR4=
X-Google-Smtp-Source: AIpwx4/SyoDTH9LcJkyVfOXTUMq5Mz8PPZWDmDxmUGxzF0H+V1hNeiSR4PZ5+EyMybEnRjRhehYHWw==
X-Received: by 10.28.15.83 with SMTP id 80mr9426559wmp.151.1523855133855;
        Sun, 15 Apr 2018 22:05:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j3sm22494652wmf.23.2018.04.15.22.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 22:05:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
References: <20180409204129.43537-1-mastahyeti@gmail.com>
        <20180409204129.43537-9-mastahyeti@gmail.com>
        <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
        <20180414195954.GB14631@genre.crustytoothpaste.net>
Date:   Mon, 16 Apr 2018 14:05:32 +0900
In-Reply-To: <20180414195954.GB14631@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 14 Apr 2018 19:59:54 +0000")
Message-ID: <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Apr 10, 2018 at 04:24:27AM -0400, Eric Sunshine wrote:
>> How confident are we that _all_ possible signing programs will conform
>> to the "-----BEGIN %s-----" pattern? If we're not confident, then
>> perhaps the user should be providing the full string here, not just
>> the '%s' part?
>
> This is not likely to be true of other signing schemes.  In fact, other
> than OpenPGP, PEM, and CMS (S/MIME), this is probably not true at all.

Hmph.  

That argues more strongly that we would regret unless we make the
end-user configuration to at least the whole string (which later can
be promoted to "a pattern that matches the whole string"), not just
the part after mandatory "-----BEGIN ", methinks.

