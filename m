Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D441C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303C8610F8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346100AbhIGTzY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 7 Sep 2021 15:55:24 -0400
Received: from elephants.elehost.com ([216.66.27.132]:13870 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbhIGTzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:55:23 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 187JsEXw055845
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Sep 2021 15:54:15 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Neeraj Singh'" <nksingh85@gmail.com>,
        "'Neeraj K. Singh via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Neeraj K. Singh'" <neerajsi@microsoft.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
In-Reply-To: <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
Subject: RE: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
Date:   Tue, 7 Sep 2021 15:54:07 -0400
Message-ID: <003701d7a422$21c32740$654975c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEuszLZPnOzWuI9JhEj5nYbH7e2rgGns2uvAVb0vKSs0uaNQA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 7, 2021 3:44 PM, Neeraj Singh wrote:
>On Fri, Aug 27, 2021 at 4:49 PM Neeraj K. Singh via GitGitGadget <gitgitgadget@gmail.com> wrote:
>>
>> Thanks to everyone for review so far! I've responded to the previous
>> feedback and changed the patch series a bit.
>>
>> Changes since v1:
>>
>>  * Switch from futimes(2) to futimens(2), which is in POSIX.1-2008. Contrary
>>    to dscho's suggestion, I'm still implementing the Windows version in the
>>    same patch and I'm not doing autoconf detection since this is a POSIX
>>    function.

While POSIX.1-2008, this function is not available on every single POSIX-compliant platform. Please make sure that the code will not cause a breakage on some platforms - the ones I maintain, in particular. Neither futimes nor futimens is available on either NonStop ia64 or x86. The platform only has utime, so this needs to be wrapped with an option in config.mak.uname.

Thanks,
Randall


