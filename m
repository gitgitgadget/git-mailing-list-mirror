Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B191F453
	for <e@80x24.org>; Thu, 14 Feb 2019 22:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfBNW7Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 17:59:16 -0500
Received: from elephants.elehost.com ([216.66.27.132]:41163 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfBNW7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 17:59:16 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1EMxBHA040356
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Feb 2019 17:59:12 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>
Cc:     "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>
References: <pull.126.git.gitgitgadget@gmail.com> <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com> <20190214223334.GE3064@jessie.local>
In-Reply-To: <20190214223334.GE3064@jessie.local>
Subject: RE: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
Date:   Thu, 14 Feb 2019 17:59:04 -0500
Message-ID: <005801d4c4b8$e5669980$b033cc80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJRGauSxHI8crErjTmvoq3vRhvADwFUx24oAoEs3RukyI284A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 14, 2019 17:34, Max Kirillov wrote:
> On Thu, Feb 14, 2019 at 05:17:26PM -0500, Randall S. Becker wrote:
> > Unfortunately, subtest 13 still hangs on NonStop, even with this
> > patch, so our Pipeline still hangs. I'm glad it's better on Azure, but
> > I don't think this actually addresses the root cause of the hang. This
> > is now the fourth attempt at fixing this. Is it possible this is not
> > the test that is failing, but actually the git-http-backend? The code
> > is not in a loop, if that helps. It is not consuming any significant
> > cycles. I don't know that part of the code at all, sadly. The code is
> > here:
> >
> > * in the operating system from here up *
> >   cleanup_children + 0x5D0 (UCr)
> 
> ... so does the process which the stack was taken from has any children
> processes still?
> 
> I could imagine if a child somehow manages to end up in uninterruptible
> sleep, then probably it would never complete this way, wouldn't it?

From what I can tell (previously reported), none of the children are dead.
git-http-backend is waiting and the others are in a read state. I can try to
get full stack traces once the current cycle ends.

