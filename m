Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C834CC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiD0SJN convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Apr 2022 14:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiD0SJM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:09:12 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD7338B3
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:06:00 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23RI5w2C048980
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Apr 2022 14:05:59 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>
Cc:     <phillip.wood@dunelm.org.uk>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        <philipoakley@iee.email>, <me@ttaylorr.com>, <guy.j@maurel.de>,
        <szeder.dev@gmail.com>, <johannes.Schindelin@gmx.de>,
        <derrickstolee@github.com>
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com> <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com> <xmqqczh2o5xg.fsf@gitster.g> <ed2cdc8f-1908-a095-ddf1-660ef8b5a90b@gmail.com> <00ab01d85a5f$2831e0a0$7895a1e0$@nexbridge.com> <CAPUEspjgMw2CwFCj4i+iH8phX_8mSRT0wPYhNrEA0E6avNTaTQ@mail.gmail.com>
In-Reply-To: <CAPUEspjgMw2CwFCj4i+iH8phX_8mSRT0wPYhNrEA0E6avNTaTQ@mail.gmail.com>
Subject: RE: [PATCH] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Wed, 27 Apr 2022 14:05:55 -0400
Organization: Nexbridge Inc.
Message-ID: <00b501d85a61$74130240$5c3906c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKW87AjxA2cdMBJpUJ6sUXK7KFdYwFanWTqAZPhW0MBIEH92gDqbA5BAl+YXloCXLrkzwIGwk9Qqyj5DCA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 27, 2022 1:54 PM, Carlo Arenas wrote:
>To: rsbecker@nexbridge.com
>Cc: phillip.wood@dunelm.org.uk; Junio C Hamano <gitster@pobox.com>;
>git@vger.kernel.org; philipoakley@iee.email; me@ttaylorr.com;
>guy.j@maurel.de; szeder.dev@gmail.com; johannes.Schindelin@gmx.de;
>derrickstolee@github.com
>Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if running
>privileged
>
>On Wed, Apr 27, 2022 at 10:49 AM <rsbecker@nexbridge.com> wrote:
>>
>> I can confirm this on multiple 32-bit platforms. With
>strtol("123456789012345678", &endptr, 10) returns 2147483647 and *endptr == '\0'
>just beyond the last 8.
>
>can you also confirm that you have strtoul and works the same, before I break
>NON-STOP in my next reroll?

Results on NonStop: strtol("123456789012345678", &endptr, 10) returns 4294967295 and *endptr == '\0' just beyond the last 8.

