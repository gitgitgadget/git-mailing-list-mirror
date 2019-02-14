Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981021F453
	for <e@80x24.org>; Thu, 14 Feb 2019 22:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440497AbfBNW0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 17:26:11 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55493 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391491AbfBNWZz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 17:25:55 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1EMPj6i038675
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Feb 2019 17:25:46 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        <szeder.dev@gmail.com>, "'Max Kirillov'" <max@max630.net>
References: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com> <nycvar.QRO.7.76.6.1902142234070.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902142234070.45@tvgsbejvaqbjf.bet>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results)
Date:   Thu, 14 Feb 2019 17:25:38 -0500
Message-ID: <005501d4c4b4$39b68f90$ad23aeb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLvzwUmvPaRP6545mvVYB21mmRPlwI+2omYo5fRgCA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 14, 2019 16:37, Johannes Schindelin wrote:
> On Thu, 14 Feb 2019, Randall S. Becker wrote:
> 
> > t5562 still hangs (blocking) - this breaks our CI pipeline since the
> > test hangs and we have no explanation of whether the hang is in git or
> > the tests.
> 
> I have "good" news: it now also hangs on Ubuntu 16.04 in Azure Pipelines'
> Linux agents.
> 
> There is a silver lining with those good news, though: I found a
workaround,
> and it might work for you, too:
> 
> 	https://github.com/gitgitgadget/git/pull/126
> 
> (I also submitted this to the Git mailing list, as I really wanted to tag
Git for
> Windows' v2.21.0-rc1.windows.1 only with a passing build, and I do not
want
> to keep that patch to the Windows port only.)

Thanks for trying. It was a good try, but did not fix the hang. See my other
response for the stack trace. I tried debugging once it hung, but the code
never exits from the operating system, so I can't get inside. It is hiding
in waitpid on a process that exists otherwise we would get an error (EINTR,
ECHILD, EFAULT are possible returns). One thing to consider is that we do
not have kernel threads, so if that is assumed, that is badness.

Regards,
Randall

