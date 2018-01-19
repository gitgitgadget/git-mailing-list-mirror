Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C3B1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 22:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeASWm3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 19 Jan 2018 17:42:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:41142 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756471AbeASWm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 17:42:28 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0JMgFgK099301
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Jan 2018 17:42:15 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        <git@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] DO NOT APPLY  Bypass GCC attributes on NonStop platform where used.
Date:   Fri, 19 Jan 2018 17:42:09 -0500
Message-ID: <000d01d39176$c0b6cbd0$42246370$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdORdhYkNDtx+IzBStO2r3rSEQxIdA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 19, 2018 3:29 PM, Ramsay Jones wrote:
> On 19/01/18 17:34, randall.s.becker@rogers.com wrote:
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > * remote.c: force ignoring of GCC __attribute construct not supported
> >   by c99 by defining it as an empty CPP macro.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  remote.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/remote.c b/remote.c
> > index 4e93753e1..c18f9de7f 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -11,6 +11,10 @@
> >  #include "mergesort.h"
> >  #include "argv-array.h"
> >
> > +#if defined (__TANDEM)
> > +#define __attribute(a)
> > +#endif
> > +
> 
> Hmm, the only use of __attribute() I can find is in compat/regex/.
> In particular, there is no use of __attribute() in regex.c.
> [__attribute__() is used in regex.c]
> 
> Is this an old patch which is no longer required?
> 
> puzzled.

After investigation, this patch can be dropped. The __attribute__ fix from git-compat-utils.h is actually being picked up correctly now (unlike our 2.8.5 port when it was required). I am suspecting that this was blocked by a configuration setting in config.mak.uname that got fixed when I got my hands on that file for a cleanup. The path through there is via #ifndef __GNUC__.

Cheers,
Randall

