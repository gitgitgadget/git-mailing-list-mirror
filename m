Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F82FC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEA6611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhGLU3S convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Jul 2021 16:29:18 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19196 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhGLU3S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:29:18 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 16CKQMqP026371
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Jul 2021 16:26:23 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com> <patch-6.6-365c5cf50b6-20210710T084445Z-avarab@gmail.com> <YOyiTTbFJmWjwXlq@coredump.intra.peff.net>
In-Reply-To: <YOyiTTbFJmWjwXlq@coredump.intra.peff.net>
Subject: RE: [PATCH 6/6] git-compat-util.h: add __attribute__((printf)) to git_*printf*
Date:   Mon, 12 Jul 2021 16:26:16 -0400
Message-ID: <012b01d7775c$2ddcca60$89965f20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD2KZhWDkCBEIj5BP0IEtwnRXwPuwGTu8jDAueUXBas3ooFwA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 12, 2021 4:13 PM, Jeff King wrote:
>On Sat, Jul 10, 2021 at 10:47:32AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> Add __attribute__((printf)) to the compatibility functions we use
>> under SNPRINTF_RETURNS_BOGUS=Y.
>>
>> In practice this is redundant to the compiler's default printf format
>> checking, since we mostly (entirely?)  develop and test on platforms
>> where SNPRINTF_RETURNS_BOGUS is not set. I'm doing this mainly for
>> consistency with other code, now we don't need to think about why this
>> particular case is different.
>>
>> See c4582f93a26 (Add compat/snprintf.c for systems that return bogus,
>> 2008-03-05) for the commit that added these functions.
>
>I'm slightly lukewarm on general on adding this to a compat function.
>Those are meant to be a lowest-common-denominator fallback, and we usually avoid fancy features or our usual styles there in favor of
>simplicity.
>
>I guess this probably isn't _hurting_ anything, but it makes me wonder how many systems have a broken snprintf _and_ support the
>attribute.

NonStop does not support __attribute__ on any compiler I know of. This appears to be a gcc extension, so compat.c would create a gcc dependency, which is also not on the platform. snprintf is in place.

-Randall

