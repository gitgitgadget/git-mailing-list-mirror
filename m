Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9002820248
	for <e@80x24.org>; Tue,  9 Apr 2019 08:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDIIVN (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 04:21:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33451 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIIVN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 04:21:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so19673676wrp.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=g4dG38XqRrZH91mGxdV/xXvlOeopcq4eb5uxe7pslYI=;
        b=qT5OX9yMsv5ZAJXehJjqztqtFGyD5lOA/+k/7duZupRMl+8yP/ZVKohQV44337imUx
         yy/PVrVEAk+m8IKLTICigC7GrR5vTm73lzC4UMUnkQy6w1zuatka7DUMTfiFhmcn9V8c
         P7tVWSy80NKc/NR5UHzEGSbRMLzKP0eVjR1WpyDfUkI11xJV/bfVg9SasHmXTpCblFcg
         UHC5XKg6Ex0RV9nivsdSs4eFRGdapYNLMYcuOn318WrJOMDhIkNOmAMdixHnk3S24rYN
         HyEULdghru/XrVNd26EhbShO11oocoCcvvLnuvC93XmCMxv4zZnZOEw6WXB2HF2LsOM2
         R+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=g4dG38XqRrZH91mGxdV/xXvlOeopcq4eb5uxe7pslYI=;
        b=gGlUI8OgbP2Orh+fTHiqmjfLw6MTnvvyl0TPgZFg8xvgLAaIlJZvAyCTfPz8eHj6TF
         6FDYWoSJZG6XJBPXHe4f6bG3QBVVBs/MdzdNSr5Zp9J5AOcu99Esz5hGQPFrxotJMU1T
         QeidwoHU5DTGlPFK071r6ObTbr0KHJNc8jESeWwzYdj0mNfpW1d21OVrhVPhwgxGWnh6
         1FAugr6jcpxBALopbc/xSXLue9RIvjjJxdTM6KTjW90oCLaJvGE8U2HclDogUmy4wDCb
         U+V6vgzgOdYBnQ/OsMyN6sYAtF98ekQpVlh/OufEs1qP1faCWaz/CEDtDMn+dD3hOgj/
         O7vQ==
X-Gm-Message-State: APjAAAWx+z49y6z2wYdmSoEeRoYtq+jz8g/F9sv5AtEpIo9l433zyma+
        2zr0oEqS23h2eyxRuFyPD0w=
X-Google-Smtp-Source: APXvYqxpPkH+DJ87Wb/B63g1hHcTHbPm594CW816/Oi2It7xC5cpiYVTp8DBEE7XS4SLibAOvx8dww==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr16335941wrx.93.1554798071032;
        Tue, 09 Apr 2019 01:21:11 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a23sm10681607wmm.46.2019.04.09.01.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 01:21:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] sha1-file: test the error behavior of alt_odb_usable()
References: <20181204132716.19208-2-avarab@gmail.com>
        <20190328200456.29240-1-avarab@gmail.com>
        <20190329134603.GB21802@sigill.intra.peff.net>
        <87pnq9aipl.fsf@evledraar.gmail.com>
        <874l78a3rz.fsf@evledraar.gmail.com>
Date:   Tue, 09 Apr 2019 17:21:10 +0900
In-Reply-To: <874l78a3rz.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 08 Apr 2019 17:57:20 +0200")
Message-ID: <xmqqimvn7fnt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Yup. Just wanted to get the patch to test what we do *currently* out,
>> might loop back to finishing up the rest of this.
>
> Junio: *ping* about picking up this trivial test coverage improvement

I was waiting for you to make up your mind about your earlier "might
loop back to finishing up".  For a topic like this, for which the
ball has been in your court for a long time, just resending would be
easier to handle than pinging, as I do not remember much about the
original attempt anyway ;-)



