Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE7CC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B59261178
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGLWBs convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Jul 2021 18:01:48 -0400
Received: from elephants.elehost.com ([216.66.27.132]:62084 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhGLWBr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 18:01:47 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 16CLwnDG030686
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Jul 2021 17:58:49 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com> <patch-6.6-365c5cf50b6-20210710T084445Z-avarab@gmail.com> <YOyiTTbFJmWjwXlq@coredump.intra.peff.net> <012b01d7775c$2ddcca60$89965f20$@nexbridge.com> <YOy33I+T0LsLHYoS@coredump.intra.peff.net>
In-Reply-To: <YOy33I+T0LsLHYoS@coredump.intra.peff.net>
Subject: RE: [PATCH 6/6] git-compat-util.h: add __attribute__((printf)) to git_*printf*
Date:   Mon, 12 Jul 2021 17:58:42 -0400
Message-ID: <013301d77769$17fd59f0$47f80dd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD2KZhWDkCBEIj5BP0IEtwnRXwPuwGTu8jDAueUXBYBlG9OPQLJvDYDrLuy+EA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 12, 2021 5:45 PM, Jeff King wrote:
>On Mon, Jul 12, 2021 at 04:26:16PM -0400, Randall S. Becker wrote:
>> >> In practice this is redundant to the compiler's default printf
>> >> format checking, since we mostly (entirely?)  develop and test on
>> >> platforms where SNPRINTF_RETURNS_BOGUS is not set. I'm doing this
>> >> mainly for consistency with other code, now we don't need to think
>> >> about why this particular case is different.
>> >>
>> >> See c4582f93a26 (Add compat/snprintf.c for systems that return
>> >> bogus,
>> >> 2008-03-05) for the commit that added these functions.
>> >
>> >I'm slightly lukewarm on general on adding this to a compat function.
>> >Those are meant to be a lowest-common-denominator fallback, and we
>> >usually avoid fancy features or our usual styles there in favor of simplicity.
>> >
>> >I guess this probably isn't _hurting_ anything, but it makes me
>> >wonder how many systems have a broken snprintf _and_ support the attribute.
>>
>> NonStop does not support __attribute__ on any compiler I know of. This
>> appears to be a gcc extension, so compat.c would create a gcc
>> dependency, which is also not on the platform. snprintf is in place.
>
>We already turn __attribute__ into a noop on unsupported platforms early in git-compat-util.h (around line 443). So this would be OK,
>since the snprintf macro hackery is later in the file (around line 786).

Works for me, in that case.

