Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D76208D0
	for <e@80x24.org>; Mon, 21 Aug 2017 18:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbdHUSRL (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 14:17:11 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35054 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbdHUSRK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 14:17:10 -0400
Received: by mail-yw0-f169.google.com with SMTP id s187so10560406ywf.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vtudn45p5y5QpCfn0iVeoj5nTqpr494T5JGsCYeTMn0=;
        b=Mwf3gp13Ib5FTLblfVwPwMOua7IpDfCoIOaZ3N2meg9Rxik3XPP7IL5vrYsyp0DbUi
         8eVFjR8nIT/opHvgYQwgKHxbVE+B8Q0iNAFSIaYDdtyWz0TJHyuXkwOOcrBUsLvnnRyR
         gt1x7jNuvazKDFg3DJ7Rd+nyD8xKr0EV0YX2/Cwf9MjUeGrUGkBalYSADrt550+w9eic
         FE2FdoI3OqnT7DT9Gdx2WkmKnd2F1sMN05jCfdNIAP0g2aJBld1ybwH8hj+GPy8xeCmd
         P1EtGlclFgxyUiOKOc4C5jw1Y/hymvZvcuN1I19hCG5NkUgpV+NGNK111ZWD3PK/mv9b
         L/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vtudn45p5y5QpCfn0iVeoj5nTqpr494T5JGsCYeTMn0=;
        b=H+Rjgv3pNeNBgB1OhcpWSXktuJDwCltzXed+EORKyS+BTfyyMSbkyjqbPUIbtVveUk
         MAcyecBe/v635IVvG8y9i4rAlxDl2ME6aeJ1L/mV/fLgIhWI6BFbrV08MDtReTIINvWM
         9Gp2UqrhX6dWoJc0XkSFIVXdYA2X7qdbnoXE2f5DxbfjTaV35b/PC92n0aBB1rdOWqj/
         2nKuz2Det1/syuRlpxhCsIl1l/ctqaHwy0CnnsqM+4Fn0QPYuRlufVGPUi6Ah03utzEJ
         pz50U+iU679sdcnC4dyc4LRqTbYuRCPUHuYCHmb1lTR0Jx0I9PuMgVSsKs0KqY5hv0d9
         cWjA==
X-Gm-Message-State: AHYfb5imMAxcUFv/HiwVlDPyd0kC4IBVWeSyyC5qvbin8d4wB8R2dSg4
        3andQnA1KbGVM3KNfHHjcymRZEStS6f3PkLblg==
X-Received: by 10.13.206.132 with SMTP id q126mr14933415ywd.337.1503339429594;
 Mon, 21 Aug 2017 11:17:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 21 Aug 2017 11:17:09 -0700 (PDT)
In-Reply-To: <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de> <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
 <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de> <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Aug 2017 11:17:09 -0700
Message-ID: <CAGZ79kZm31jYZs5BXh8pwV2sLnhsy0AcQzoBWv1UZKtDFfYhkw@mail.gmail.com>
Subject: Re: [PATCH 4/4] archive: queue directories for all types of pathspecs
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 19, 2017 at 9:53 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 19.08.2017 um 07:33 schrieb Ren=C3=A9 Scharfe:
>> When read_tree_recursive() encounters a directory excluded by a pathspec
>> then it enters it anyway because it might contain included entries.  It
>> calls the callback function before it is able to decide if the directory
>> is actually needed.
>>
>> For that reason git archive adds directories to a queue and writes
>> entries for them only when it encounters the first child item -- but
>> only if pathspecs with wildcards are used.  Do the same for literal
>> pathspecs as well, as the reasoning above applies to them, too.  This
>> prevents git archive from writing entries for excluded directories.
>
> This breaks the test "archive empty subtree with no pathspec" in t5004 by
> omitting the empty directory from the archive.  Sorry for missing that!
>
> This is kind of a bonus patch, so please discard it for now; the first
> three are OK IMHO.

I thought so up to reading this patch. I found the naming and
content of should_queue_directories not obvious at first read.
This patch confused me even more for that name to be chosen.
I have no alternative to propose, though.

Thanks,
Stefan
