Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FDB20357
	for <e@80x24.org>; Mon, 17 Jul 2017 17:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdGQR3D (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 13:29:03 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34778 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdGQR3B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 13:29:01 -0400
Received: by mail-pg0-f48.google.com with SMTP id 123so10221675pgj.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MGXS+SP3VODp7X0IdU9nOEp2mO1/dBE6esC7niP+uVI=;
        b=BavrW7WB5TgPpiRfnjQ3hkSVZ06ZVQ8d+VkSTWCT5Hao4+l81mmPO5K53nnYmxexn6
         HkohTb17bywXMsUH3yX0F3ytzFEAS+2r/ZG/k/mKX8Z2YRMYP08owAQ0B3OLAwOOjO/W
         ObHyf8q92pV44xBjKu6C3STCeyu4G6j9rcOzNleXX2Add4/IKUkHCnVpfIkT2yWF4dlm
         XZJwhrdCIzTV+bT3rwevDQgD3Qm/NfWCnkrF2tsGCuZbXuA54G/FJQ9TfGM9wd0CWm8v
         sSCaMe6K3NUNMkDPtWqvRLf2+MAXfE3voqNUve1eV9E57kU4jigybmZh9gcg0swhlHyp
         HRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MGXS+SP3VODp7X0IdU9nOEp2mO1/dBE6esC7niP+uVI=;
        b=sg8B+U6YP3QxD3R7PM1AJ1wwmDPvWXVfyghW4ZsrRYkfwCg2sQiVGr6S62Kaw/YfgC
         FjBHnUs5enFT4sSl6nk9/b01PwbSmv7/FdXN4/AhEUWr3z/cBinn4DsdbFICgDuFzPRI
         HXnrWqys06qamqQ4fSnfWqRoXFsW4Szo3MYmFhQAh31TE73jlJiRqv+PT4e7I/iSoXG/
         +Dip4tKOggRnASUXar3vIObw6YX52k89yff3QGKxbMFXjIp5kfCx6lPFYqmy5i45vWkp
         /v40msVAEkpqus7pYOyy5VcDgYIOvG5kjaAd7TlAYwkoy5x1nWp4apVXB8IqBZRq7vUx
         T2HQ==
X-Gm-Message-State: AIVw113u/q/wwqZyitf5n2fa7f7vvt5HCR1WX23JfBKy5LRITAPdxWBz
        Sh8FGJeH3UCqnAhZfjk=
X-Received: by 10.84.210.1 with SMTP id z1mr9841641plh.125.1500312541083;
        Mon, 17 Jul 2017 10:29:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id b6sm40831821pgn.67.2017.07.17.10.28.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 10:28:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
References: <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
        <1n8sh3u.1lsabkd1pislrwM%lists@haller-berlin.de>
        <8760f4bmig.fsf@gmail.com>
        <xmqqlgo0cm7f.fsf@gitster.mtv.corp.google.com>
        <87k23a2d28.fsf@gmail.com>
Date:   Mon, 17 Jul 2017 10:28:58 -0700
In-Reply-To: <87k23a2d28.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Sat, 15 Jul 2017 12:45:51 +0200")
Message-ID: <xmqqy3rngeg5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Once Francesco's patch is also applied (or some version thereof) you can
> then set push.AlwaysForceWithElease to make --force mean
> --force-with-lease, which is disabled by default.
>
> I think this is really crappy UX design. Now in some future version of
> Git I need to set a config option *and* type a longer option name to get
> behavior that's an improvement over --force.

After thinking about this a bit longer, I changed my mind.

I do not think a configuration option that turns "push --force" with
anything but "unconditionally force, I mean it" is acceptable;
otherwise use of "--force" as the last resort that always does what
the option means will be broken, and I do not think you can ask
everybody who has scripts to do so to temporarily disable the
configuration in them.

What we could do is to improve the "--force-with-lease" that does
not say what exact object should be there at the remote for the
non-ff push to go through.  In another thread there was a discussion
to improve the logic to ignore remote-tracking branch and instead
use the reflog of the _source_ of the push, and I think that is a
lot saner and safer heuristic than what we currently has.

After that happens, we probably could give it an even shorter
synonym to the option.  But even then, it is unwise to use "--force"
as that shorter synonym.

Thanks.
