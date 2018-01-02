Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714101F428
	for <e@80x24.org>; Tue,  2 Jan 2018 23:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeABXI1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 2 Jan 2018 18:08:27 -0500
Received: from elephants.elehost.com ([216.66.27.132]:57993 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeABXI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 18:08:26 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w02N8KLU097531
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Jan 2018 18:08:21 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.us>
Cc:     "'git mailing list'" <git@vger.kernel.org>
References: <004701d38346$7dd4be00$797e3a00$@nexbridge.com> <CAPig+cQ_H20ON0usig-FWj7YVF_AOR_yvBRhXJeFmRv_w7pZAw@mail.gmail.com>
In-Reply-To: <CAPig+cQ_H20ON0usig-FWj7YVF_AOR_yvBRhXJeFmRv_w7pZAw@mail.gmail.com>
Subject: RE: [Bug] NO_INTPTR_T not being honoured in compat/regex/regcomp.c
Date:   Tue, 2 Jan 2018 18:08:14 -0500
Message-ID: <004c01d3841e$94d9e6b0$be8db410$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE3cxGYCsV/QOaTOLXHLdw3/n0bvAJDGDFipIc7Y0A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 1, 2018 4:51 PM Eric Sunshine wrote:
> On Mon, Jan 1, 2018 at 4:21 PM, Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > * I have defined NO_INTPTR_T = UnfortunatelyYes in config.mak.uname
> > for my platform. The c99 compiler I have does not define it.
> > * The code compiles except for compat/regex/regcomp.c - not sure why
> > this is being used since I have also *not* defined NO_REGEX because
> > regex is sane here.
> 
> Presumably you're compiling for NonStop? config.mak.uname defines
> NO_REGEX for that platform (it also defines NO_INTPTR_T). git-blame points
> at 6c109904bc (Port to HP NonStop, 2012-09-19).

I found one teeny thing. NO_REGEX=NeedsStartEnd is what should be in config.mak.uname to get it right rather than ignoring NO_REGEX completely. I will commit that after my porting adventure. This still requires regcomp.c to be used and misses intptr_t, so still looking for a solution. I'm also currently at commit 7234152 and dealing with a bunch of new dependencies that weren't there at 2.8.5.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



