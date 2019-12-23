Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C56EC2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F95A206B7
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 14:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLWOuq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 23 Dec 2019 09:50:46 -0500
Received: from elephants.elehost.com ([216.66.27.132]:33593 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLWOuq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 09:50:46 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xBNEofGV011297
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 23 Dec 2019 09:50:41 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Hans Jerry Illikainen'" <hji@dyntopia.com>,
        "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20191216153204.8906-1-hji@dyntopia.com> <20191216153204.8906-2-hji@dyntopia.com> <20191220225746.GF8609@szeder.dev> <87y2v54i9v.hji@dyntopia.com>
In-Reply-To: <87y2v54i9v.hji@dyntopia.com>
Subject: RE: [PATCH 1/1] gpg-interface: add minTrustLevel as a configuration option
Date:   Mon, 23 Dec 2019 09:50:34 -0500
Message-ID: <011401d5b9a0$58604df0$0920e9d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH/oBb3ftzF/OFyCWbLkK6Mvt6t6gKRyqzRAmGGTpICW2zph6c5igZw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 21, 2019 1:59 PM, Hans Jerry Illikainen wrote:
> On Fri, Dec 20 2019, SZEDER Gábor wrote:
> > On Mon, Dec 16, 2019 at 03:32:04PM +0000, Hans Jerry Illikainen wrote:
> >> This patch introduces a new configuration option: gpg.minTrustLevel.
> >> It consolidates trust-level verification to gpg-interface.c and adds
> >> a new `trust_level` member to the signature_check structure.
> >
> > This patch causes several test failures:
> >
> >   https://travis-ci.org/git/git/jobs/627909430#L2259
> >
> > I see you've already posted an updated version, so I tried it locally,
> > and the same test scripts fail with the updated version as well.
> 
> Sorry for that!  I'm preparing a v2 (tested with both gpg1 and gpg2).
> 
> > I noticed that only Linux CI jobs failed, while the OSX jobs
> > succeeded.  Our Linux CI jobs (and my box) are based on Ubuntu 16.04,
> > and thus use GnuPG v1.4, while the OSX jobs use v2.something.  Not
> > sure that the version difference is connected to the test failures,
> > but I figured it's worth pointing out.
> 
> Your observation about the different GPG versions was spot on; thanks!
> That explains why all tests pass on my machine as well as on a personal CI
> setup for my git contributions (both using gpg2).
> 
> The issue was that the search for the end of a trust level to parse relied on
> the TRUST_ line being space-separated.  But that is not always the case for
> gpg1 (only the lowest-two trust levels contain a space followed by additional
> information in gpg1).

Side question: are there any tests running with alternate GPG packages? I have a platform where the official GPG itself is not available, so am looking for alternatives for that community.

Cheers,
Randall


