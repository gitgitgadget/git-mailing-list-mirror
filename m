Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B9C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 22:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiGYWfi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 25 Jul 2022 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGYWfg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 18:35:36 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B7B659E
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 15:35:36 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 26PMZYKL013057
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jul 2022 18:35:35 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>,
        "'Derrick Stolee'" <derrickstolee@github.com>
Cc:     "'Abhradeep Chakraborty'" <chakrabortyabhradeep79@gmail.com>,
        "'git'" <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Kaartic Sivaraam'" <kaartic.sivaraam@gmail.com>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>,
        "=?UTF-8?Q?'Jakub_Nar=C4=99bski'?=" <jnareb@gmail.com>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com> <CAPOJW5wVYcmTA6kpf=kGEofziq1RLCg2haCMrye=EXaPLzb7Tw@mail.gmail.com> <9c909270-cbd5-0356-0418-4b2d3e105c93@github.com> <Yt8VzTLmVOKCALxr@nand.local>
In-Reply-To: <Yt8VzTLmVOKCALxr@nand.local>
Subject: RE: Can I use CRoaring library in Git?
Date:   Mon, 25 Jul 2022 18:35:30 -0400
Organization: Nexbridge Inc.
Message-ID: <028201d8a076$dbb5a7d0$9320f770$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLeWSMr9g7ZfERIXUDmy4jngTmBowKnN4VNAlnVpdECP6cbDKtKNVVA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 25, 2022 6:15 PM, Taylor Blau wrote:
>On Mon, Jul 18, 2022 at 08:18:14AM -0400, Derrick Stolee wrote:
>> On 7/18/22 7:48 AM, Abhradeep Chakraborty wrote:
>> > I just got to know that CRoaring doesn't support Big Endian systems
>> > (till now) -
>> >
>> > https://groups.google.com/g/roaring-bitmaps/c/CzLmIRnYlps
>> >
>> > What do you think about this?
>>
>> Git cares enough about compatibility that that might be a deal-breaker
>> for taking the code as-is. If we _did_ take it as-is, then we would
>> need to not make it available on such machines using compiler macros.
>
>I definitely agree here. If I'm understanding CRoaring's implementation correctly, a
>bitmap written on a machine that uses big endian would be unreadable on a little
>endian machine and vice-versa.
>
>That's definitely *not* the case with the existing EWAH bitmaps, which are
>readable on machines using either endianness, since we always write numbers in
>network byte order, independent of machine endinaness.
>
>(I suspect you know all of this already, but just stating here explicitly for the
>benefit of the list).

It is possible to use a Clean/Smudge filter to normalize the format to be independent of the endian-ness of the target platforms?

I have to admit being a fan of that approach.
--Randall

