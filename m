Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82AF41F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeDQR1T (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:27:19 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:38857 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeDQR1S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:27:18 -0400
Received: by mail-pl0-f46.google.com with SMTP id c7-v6so12369662plr.5
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X8YIHq/SsSnDUibmxNMd3UEG+8x0vx5AudhCCLBIc3o=;
        b=Yah9OnwXFCfWFhqSUhJQSqn/9L+aZMh04ChlPqzYW7OocjUvnlVW4owEEVaqPTYPz3
         okiyv0qbmepFBvlOO5kMKhFtZeXsowWmw0tUXF84IfNWlO9rxdVq4fbYTbndWOS1jXmj
         fdyXjJrb0z2i2NZuCM9H8LQLNELqW1c2WOQA6JB3YMhYpaNBj+RDjOZPEqb9L3KTj/yl
         heGT04qE49uCEX70GnJ6b9ZSRD0/msTdfwvz71J6nhh5z2pUtVSSehEOUpHubnDclSlx
         WxXPJkgRx5R/sFR9HPgL2RnK7ta1z6Eb2Y4lJDTfnhIkGunVS2Y8dwOLzCHUQWOgVcMq
         M37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X8YIHq/SsSnDUibmxNMd3UEG+8x0vx5AudhCCLBIc3o=;
        b=NX7z+VSSonw3xTUI5IVeuVIkjnK4X8qkafmR9auUYki7Hkj4cpBMkhQDEOfS1nxb82
         wkurzZ+sLstXfmhKGmB0X9JogsGS680qKPeKoKbDReCHc7OUYexn1Gk6bq6Am0Gju9TL
         3hzjvTbiL33EOj64orfll8ke+mlsDIn2X3mIfkr6ycs+UztRiPoeLBOV79j+6t7brC2Z
         daMfY/39Pbdq8nyuUQ93eCPNIH0ouKoWWKQCzZ6yGcQpkJ5JhvmCcwcVLMxz8lW2hgD7
         j9d8WcMpKmJ3K6X5EkfQacFFIaedYpCwGtHZKBkrGQIr9DQD8esXTZxUYA9Ly6v/uOqJ
         cfiw==
X-Gm-Message-State: ALQs6tCR8xA+m0Nld33kG9pxKBd6bHdnMObdP07/yTq/O11fSJKAXeKv
        Ciq5w3Qb2YwYh/P95LC5uqQmmhVG
X-Google-Smtp-Source: AIpwx4/VondpbVEEb/Kz7ioLO9uMTwpsbnjwyDFRNknw138qKUBooiZ5wN3DTfJ73IEdCzCXs/X2Eg==
X-Received: by 2002:a17:902:680e:: with SMTP id h14-v6mr2697561plk.90.1523986037912;
        Tue, 17 Apr 2018 10:27:17 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id a6sm25563998pfi.12.2018.04.17.10.27.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Apr 2018 10:27:17 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Optimizing writes to unchanged files during merges?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CA+P7+xoVcPV_mFS3WpUvCUR7N4SzJ5WBZqpGT3VVWdkPjh6Qww@mail.gmail.com>
Date:   Tue, 17 Apr 2018 19:27:08 +0200
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, mgorny@gentoo.org,
        Peter Backes <rtc@helen.plasma.xg8.de>,
        winserver.support@winserver.com, Theodore Ts'o <tytso@mit.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C42212C2-6777-41B8-A571-1457ACD405A3@gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com> <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com> <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com> <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com> <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com> <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com> <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com> <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com> <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com> <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com> <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com> <CA+P7+xrmAHjaF=wze1iu0=cZBY3WcHXqpuDep3Nrev+zmt_Gog@mail.gmail.com> <CA+P7+xoVcPV_mFS3WpUvCUR7N4SzJ5WBZqpGT3VVWdkPjh6Qww@mail.gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Apr 2018, at 19:45, Jacob Keller <jacob.keller@gmail.com> wrote:
>=20
> On Mon, Apr 16, 2018 at 10:43 AM, Jacob Keller =
<jacob.keller@gmail.com> wrote:
>> On Mon, Apr 16, 2018 at 9:07 AM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>> What if Git kept a LRU list that contains file path, content hash, =
and
>>> mtime of any file that is removed or modified during a checkout. If =
a
>>> file is checked out later with the exact same path and content hash,
>>> then Git could set the mtime to the previous value. This way the
>>> compiler would not think that the content has been changed since the
>>> last rebuild.
>>=20
>> That would only work until they actuall *did* a build on the second
>> branch, and upon changing back, how would this detect that it needs =
to
>> update mtime again? I don't think this solution really works.
>> Ultimately, the problem is that the build tool relies on the mtime to
>> determine what to rebuild. I think this would cause worse problems
>> because we *wouldn't* rebuild in the case. How is git supposed to =
know
>> that we rebuilt when switching branches or not?
>>=20
>> Thanks,
>> Jake
>=20
> I think a better solution for your problem would be to extend the
> build system you're using to avoid rebuilding when the contents
> haven't changed since last build (possibly by using hashes?). At the
> very least, I would not want this to be default, as it could possibly
> result in *no* build when there should be one, which is far more
> confusing to debug.

I am 100% with you that this is a build system issue. But changing
the build system for many teams in a large organization is really
hard. That's why I wondered if Git could help with a shortcut.
Looks like there is no shortcut (see my other reply in this thread).

Thanks
Lars=
