Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF57C1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 18:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfBSSIT (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 13:08:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50549 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSSIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 13:08:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so3817032wmj.0
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 10:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZP3WjSdh50nQMUVWagPhG48UkkLQ6ls+xKPsbZD0o24=;
        b=aN1vE1UOwrOZEiJpo0CyXxjUhrWk9HT/b6APe8HKKkuPehNHwtgNL+c0W8cuCo0KyZ
         cgwjHtLFgvajkvPtbyS+Z1bvQsXR2iESsFbNk3APDD68Vf1tWGhscCIABFtF1EcBWY4/
         VvbLoYWxeYuoPH4oz41CvXIjZ5NTdSY6ytsr5Ak5ebHEAaiChXCINxjI9fjAhciULwuA
         zbtwmCevj7J6i/D78ClJgZQpqQEm3ACY9YJ6v68TTjeVQHM3CMEPymlDwzrcr314EBbX
         mXOBZTnly24xVTEqy4NDCdJi8r27RB6S2qDWiO9UeyHodznn0pR4PamqeEcbBD3T9yMN
         sgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZP3WjSdh50nQMUVWagPhG48UkkLQ6ls+xKPsbZD0o24=;
        b=f7f24ESuMQ5Yt2Atg5RxmtpWI/QhevjumeVr5rNU29CxjhLlPkSNPSzGnMiKs4DfTB
         srNPsW0unCXDMbf6LzFbUc9n23xBAANMCEQFHooL9T1dybKGcgkDI593g4I4RO7dj9iA
         /g3iukOP0aIzAmGnfK3x1nKli2JjL0cyrG/A4oecN94ah955aGnytfk8W9MqeH2aga/i
         ipFkw0rysvYyKbp4THyqWzd8Tb13NW91CNnI0kV2q1tACEvH/sfuODb3WrVrLkF/e0e0
         ns30PcDdK8AW5ML5mUnQdsRr7bXRgjodt74jEphBOtExANu939Ha9/UIXyFVi7Sp/8Bp
         b6pQ==
X-Gm-Message-State: AHQUAubvu6BmYpjKyT6XFZczLnps2dafeMrOki2TeQX1RI3i/SjEpbgA
        ov1iqim8dwpJr2q+PWPrScY=
X-Google-Smtp-Source: AHgI3Ib4cF2TI8YeSytt6WNxUktiGJD1rySYMowFI/C9GiF0t98rf3J2/o6/Apl2DeOuSDHT/xZf3g==
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr3657112wmc.43.1550599697408;
        Tue, 19 Feb 2019 10:08:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a9sm2550498wmm.10.2019.02.19.10.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 10:08:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
References: <20190216114938.18843-1-pclouds@gmail.com>
        <20190216114938.18843-2-pclouds@gmail.com>
        <87wolzo7a1.fsf@evledraar.gmail.com>
        <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
Date:   Tue, 19 Feb 2019 10:08:16 -0800
In-Reply-To: <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 17 Feb 2019 16:31:56 +0700")
Message-ID: <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Feb 17, 2019 at 2:36 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Sat, Feb 16 2019, Nguyễn Thái Ngọc Duy wrote:
>>
>> [Re-CC some people involved the last time around]
>>
>> > A new attribute "precious" is added to indicate that certain files
>> > have valuable content and should not be easily discarded even if they
>> > are ignored or untracked.
>> >
>> > So far there are one part of Git that are made aware of precious
>> > files: "git clean" will leave precious files alone.
>>
>> Thanks for bringing this up again. There were also some patches recently
>> to save away clobbered files, do you/anyone else have any end goal in
>> mind here that combines this & that, or some other thing I may not have
>> kept up with?
>
> I assume you mean the clobbering untracked files by merge/checkout.
> Those files will be backed up [1] if backup-log is implemented. Even
> files deleted by "git clean" could be saved but that might go a little
> too far.

I agree with Ævar that it is a very good idea to ask what the
endgame should look like.  I would have expected that, with an
introduction of new "ignored but unexpendable" class of file
(i.e. "precious" here), operations such as merge and checkout will
be updated to keep them in situations where we would remove "ignored
and expendable" files (i.e. "ignored").  And it is perfectly OK if
the very first introduction of the "precious" support begins only
with a single operation, such as "clean", as long as the end-goal is
clear.

I personally do not believe in "backup log"; if we can screw up and
can fail to stop an operation that must avoid losing info, then we
can screw up the same way and fail to design and implement "backup"
to save info before an operation loses it.  If we do a good job in
supporting "precious" in various operations, we can rely less on
"backup log" and still be safe ;-)

