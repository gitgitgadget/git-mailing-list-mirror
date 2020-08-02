Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A85EC433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BED62072A
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHBQdU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 2 Aug 2020 12:33:20 -0400
Received: from elephants.elehost.com ([216.66.27.132]:33003 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHBQdU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 12:33:20 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 072GXHgG045281
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 2 Aug 2020 12:33:18 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [POSSIBLE BUG] t5562.08 hangs consistently in 2.28.0 when run via Jenkins
Date:   Sun, 2 Aug 2020 12:33:10 -0400
Message-ID: <072201d668ea$9f90a0e0$deb1e2a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0718_01D668C1.26B0B4E0";
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIcx+gSN19NCBRcwuRd+T9lUY1EvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been working through figuring out why we are getting a consistent
hang on t5562.08  for 2.28.0 on the NonStop TNS/X platform (x86 big endian).
This did not happen in the -rc series changes and appears transient. My
investigation into this did not turn up anything useful other than the
circumstances.

When run from a shell, the test consistently passes regardless of options
used. Then only time this hangs is when we run through the git test suite
through Jenkins – so there is no valid input tty. Even redirecting stdin to
/dev/null does not cause an issue.

I am suspecting something in the test suite rather than git itself. We have
had similar issues with t5526 in the past – 2.20 timeframe as I recall.
Interrupting git-http-backend unwound the test and allowed us to continue
with the pipeline but I have no evidence of anything wrong there.

This will not stop our release of the NonStop builds of 2.28.0 since the
test passes in isolation. Curiously, this does not have an issue on the
TNS/E platform (itanium big endian) where we have seen more issues
historically.

Kind Regards,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.



