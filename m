Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8964AC433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbiAQSwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:52:25 -0500
Received: from elephants.elehost.com ([216.66.27.132]:36035 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAQSwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:52:24 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20HIqM0A041354
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jan 2022 13:52:22 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqq35lp68rw.fsf@gitster.g>        <026201d80bbc$10a251a0$31e6f4e0$@nexbridge.com> <xmqqy23eurut.fsf@gitster.g>
In-Reply-To: <xmqqy23eurut.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.35.0-rc1
Date:   Mon, 17 Jan 2022 13:52:16 -0500
Organization: Nexbridge Inc.
Message-ID: <027301d80bd3$5c5b6c50$151244f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGnTa7oMwcFXa3F3zH2drJd0IRiNwHnIH4EAhAGWsesqVFqUA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 17, 2022 1:42 PM, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
> 
> > On January 14, 2022 9:19 PM, Junio wrote:
> >> A release candidate Git v2.35.0-rc1 is now available for testing at the
usual
> places.
> >> It is comprised of 467 non-merge commits since v2.34.0, contributed
> >> by 80 people, 32 of which are new faces [*].
> >
> > FYI: rc1 built/test (mostly) passes on both NonStop x86 and ia64
platforms.
> >
> > We seem to have a recurrence of a transient failure in t5562 from a few
> releases ago. Retesting makes the problem disappear.
> >
> > Subtest 8
> > #
> > #		test_env HTTP_CONTENT_ENCODING="gzip" test_http_env upload
> empty_body &&
> > #		! verify_http_result "200 OK"
> > #
> > Subtest 14
> > #
> > #		test_env HTTP_CONTENT_ENCODING="gzip" test_http_env
> receive empty_body &&
> > #		! verify_http_result "200 OK"
> > #
> >
> > Am I mistaken that using the ! verify_http_result construct is not
recommended
> or am I misremembering the discussion?
> >
> > Regards,
> > --Randall
> 
> I do not recall anything about that shell function.
> 
> I found a half-thread with similar-looking report on an obscure system,
since the
> 2.25 era:
> 
>
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2003252000200.46@tvgsbejvaqbjf
.
> bet/
> 
> And then from you that is even older, in the 2.21 era:
> 
> https://lore.kernel.org/git/002201d4c560$5a319c40$0e94d4c0$@nexbridge.co
> m/
> 
> But neither seems to lead to a discussion on the use of verify_http_result
helper.

We transitioned from the platform default ksh to bash for build/test of git
right after that point that cleared the issue. It looks like there could be
a regression in bash introduced on the platform very recently (June 2021)
that may be responsible unless /bin/sh is referenced directly in the
scripts. I will check.
--Randall

