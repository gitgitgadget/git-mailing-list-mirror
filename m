Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17704C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90DA60FDC
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhJYVYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhJYVYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:24:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB7BC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:21:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5so2252350wmb.1
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ONyz8A80Vkj2Jw9sKpY5z8jy0iNzQmzev+uX3V3mIhI=;
        b=p3CuGeGbCqD+A+NrwMWSB5ljyqBtEfIT+U7mIFEoaPmdX4sGqJbT3LBJJ4iRD+Ajih
         eb9e0veVoNzHWCrLMiBcbZTHjhrxqwnpcAKLTRMwQEyaV+JqWjueslNjtz7CbX9cUNjm
         6SYrYU1AJb0WogXD/LbPI8Juhvo8H2NzDOPKT5NEayu9Nxh0bII02aqEjPXblUa8jgp1
         DvMCkvwdS1XNyfxcrZijuC6u6dBCKtTWZ+0ttKvMWu9CFLVxE1kBS7whX5yUHaB8uxd+
         xakhBRc0+Zn7TFx+I2GYJYool5FhtjV1NrvePTZiGzkkdjhXzU+3z1MXkxhU2uXhqsoj
         Ipcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ONyz8A80Vkj2Jw9sKpY5z8jy0iNzQmzev+uX3V3mIhI=;
        b=HNuOieoqErv/dEa9Cvvm5sCDon1fxjoJDRBL7O/wrYQx/HaOJktF8EC9LOx7nZcUXN
         sAXLXhAzumsgunoHHIFx58CFJP0Np3NSs6kiQZcnEnMk7CKI7K7ZUX9GmGB1eouhpnmi
         3ZIftC2lCklwNl1d+i19gCrG6zmge68oQRwLwKegRuoGK7IganQU7t/7OYEZZ988hJP2
         DMH/3ee0sj8ZYSbjVHec+YVD1lx4KoAit4kAeMxaSZLgp/BAsGPMkx5o0Ah2HZCKjLeA
         4Qrt8+ER0a8OtHfTQWGsGw0XJiGG64xB7drp5HcUZ5fAKV5OIYG3XkWRrjUx1QgWlAkc
         bnAA==
X-Gm-Message-State: AOAM532D6CvopAzlgN/RqPgGe8uSElRQLhhVLf60uU6yO6M5UY6rLXVm
        fG9RxWwOLTG6agBNXs9/jUs=
X-Google-Smtp-Source: ABdhPJxMyeSjH9jWHqjmGmZ8oUPQhChA6LFZY4dZeFYcMNndtBY9lzdsns+HSbGds78GdPk8FJFV8Q==
X-Received: by 2002:a05:600c:35cb:: with SMTP id r11mr2491502wmq.76.1635196904986;
        Mon, 25 Oct 2021 14:21:44 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q14sm19653517wmq.4.2021.10.25.14.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:21:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mf7Pc-001fL7-0R;
        Mon, 25 Oct 2021 23:21:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [Summit topic] Let's have chalk talks (part 1/?)
Date:   Mon, 25 Oct 2021 23:20:18 +0200
References: <nycvar.QRO.7.76.6.2110220950020.62@tvgsbejvaqbjf.bet>
 <b485b282-2b26-b9ab-da5d-ea59f5fcf463@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <b485b282-2b26-b9ab-da5d-ea59f5fcf463@iee.email>
Message-ID: <211025.865ytk3imw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Philip Oakley wrote:

> On 22/10/2021 08:51, Johannes Schindelin wrote:
>> Apparently I have to send this in chunks, to fool the Bayes filter of our
>> beloved mailing list into doing The Right Thing.
>>
>> This session was led by Emily Shaffer. Supporting cast: =C3=86var Arnfj=
=C3=B6r=C3=B0
>> Bjarmason, brian m. carlson, CB Bailey, and Junio Hamano.
>>
>> Notes:
>>
>>  1.  What=E2=80=99s a public chalk talk?
>>
>>      1.  At Google, once a week, the team meets up with no particular to=
pic in
>>          mind, or a couple topics, very informal
>>
>>      2.  One person=E2=80=99s turn each week to give an informal talk wi=
th a white
>>          board (not using chalk)
>>
>>      3.  Topic should be technical and of interest to the presenter
> [...]
>
> A 'listener' perspective..
>
> At the summit, the packfile's packing algorithm was mentioned as a
> historic 'chalk talk' that's now in the technical documentation.
>
> In the meantime, while chatting to a colleague about the birthday
> paradox and its relation to Bloom filters, I realised I didn't
> understand what our Bloom filters were trying to do and what they recorde=
d.
>
> I had a look at the code and documentation, but there isn't much there
> about our Bloom filter implementation. A chalk talk could later be used
> in the same manner as the packfile discussion to show what the filters do?
>
> If there is someone who'd like to talk through what the Bloom filters
> are doing in Git then I'd be all ears.

That sounds like a good idea for a topic, not to take away from any of
that discussion, but I believe the bloom filters we have are exclusively
used for path filtering if they exist in the commit-graph.

I.e. for:

    git rev-list -- $path

See c525ce95b46 (commit-graph: check all leading directories in changed
path Bloom filters, 2020-07-01) for one use-case and benchmark numbers.


