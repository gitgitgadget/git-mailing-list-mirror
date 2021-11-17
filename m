Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921D6C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724BC6324E
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhKQJZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhKQJZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:25:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A51C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:22:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so8122383edv.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9a3SlUUAsrXLBIWUK9g6KbdC8DOGc65FTDjvtipTd1M=;
        b=n54TKA/1Nj3r36RWE6tZSBijDHuOj8zzhpXmi+Xrl2ifoEFZdKEVhyVCtbowCeBBVT
         mZwvEzhq33MkLI6OR1wl7Xvb0qydBDnQsqHWpoKVYNKv9n+DW6mvdQMIYKNvLoOdcfCR
         s6kiNe6ZZ54kdBA6rud+Id69oD9A0iPI3N1SB76PrIvmcLEgeGEbrJY148S+haJaDJc4
         JAHMrY7E39um5Fk+2zAI9GBUCeL444OV2psCeD+0ahrnF4vDT/nTdHYQBsIAhMukCdhp
         o7XwueszfmitTrpmFH1DiLv4M0HCOU5W4ER3lzHoOs/KWCU/kUqnqfmDGzLF2Gr1n/8B
         8tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9a3SlUUAsrXLBIWUK9g6KbdC8DOGc65FTDjvtipTd1M=;
        b=5OecO+hBLjnSARcYSntXns9UJ9xBtuOyidYiGzHetILsoJ5arYaxMtyXIve0Wit18V
         WjP633ClWi2KTe/wvh4+9tAHtOse311/NmZR+lbVRpdNG0TREd31wthP82/G8wnkZclP
         dGMo5U8JjTByCi+CPUWTEHISrznzqXsG6wl0susjV0Md6a0l18JUe6U3y7YPBT3OB9YT
         ZkFPamkIFtEVyH+wsRuCMY4IaR4aniufdHh8gHS5oyftYNexTHTi0jL2m3Rg3CYrhFtS
         aKeA8Ep4OcWXDpY1Y255zJxsv18A3vWmDzxFivxl3KW0aaIeyWU36QfDyogD2jpAKX88
         9OcA==
X-Gm-Message-State: AOAM533Y/4szyW3aRYzzG4yjvl0E0vE0aaOW1qAOjNct0hGMPvRDNC3g
        mpwHdABNpfkE0B60NIN8b34=
X-Google-Smtp-Source: ABdhPJzpczICmIMze0oZ2oKFtFdCZwFZN00WsVHYTn/+ebtwbRIMzcln0Tc+TerzDlvUZEJ5XjtBTA==
X-Received: by 2002:a05:6402:604:: with SMTP id n4mr19898204edv.226.1637140935241;
        Wed, 17 Nov 2021 01:22:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qz24sm2465355ejc.29.2021.11.17.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:22:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnH8w-0004cX-88;
        Wed, 17 Nov 2021 10:22:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 05/23] Makefile: remove "mv $@ $@+" dance redundant
 to .DELETE_ON_ERROR
Date:   Wed, 17 Nov 2021 10:20:10 +0100
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-05.23-e38c90ad0b6-20211116T114334Z-avarab@gmail.com>
 <20211117020158.4p3iwlrdf2v4nc55@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211117020158.4p3iwlrdf2v4nc55@glandium.org>
Message-ID: <211117.865ysr87cp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Mike Hommey wrote:

> On Tue, Nov 16, 2021 at 01:00:05PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Since 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
>> 2021-06-29) we don't need to guard the clobbering of $@ with this sort
>> of "mv $@+ $@" pattern in these cases where we're merely generating a
>> file that'll be used as a dependency for other files, as in this case
>> for GIT-PERL-HEADER.
>
> .DELETE_ON_ERROR is, as far as I know, a GNUism. Does building git require
> the use of GNU make?

Yes, we've had a hard dependency on GNU make for forever, and already
use .DELETE_ON_ERROR, this is just moving it around.
