Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0CD200B9
	for <e@80x24.org>; Thu,  3 May 2018 02:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeECCdH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 2 May 2018 22:33:07 -0400
Received: from mail.pdinc.us ([67.90.184.27]:38084 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751929AbeECCdE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 22:33:04 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id w432X2d4011735
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 May 2018 22:33:02 -0400
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>
References: <B8114616E07247C7A78F1DFF91E16A63@ad.pdinc.us> <xmqqh8npv8hy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8npv8hy.fsf@gitster-ct.c.googlers.com>
Subject: RE: Blame / annotate with mixed mac line endings?
Date:   Wed, 2 May 2018 22:32:05 -0400
Organization: PD Inc
Message-ID: <8957C3B9BEF94443ABE0A67340786A86@ad.pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdPifSTLq9tVsOWjQLOq610kZRZ8kQAB56zw
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano
> Sent: Wednesday, May 2, 2018 21:22
> Subject: Re: Blame / annotate with mixed mac line endings?
> 
> "Jason Pyeron" <jpyeron@pdinc.us> writes:
> 
> > Any way to hit git with a stick to treat lone CR as a line 
> break for blame/annotate?

> I highly suspect that you would get more help from those whose love
> is Git if your inquiry were about a way to ask Git politely to do
> what you want to achieve, rather than hitting it with a stick ;-)

No offense meant.

> Perhaps define a textconv filter to fix the incorrect line endings?

Worked perfectly! I Read:

https://github.com/git/git/blob/master/t/t8006-blame-textconv.sh

Added to .git/config:

[diff "test"]
        textconv = /usr/local/bin/helper.sh

Added to .gitattributes:
*.cfm diff=test

$ cat /usr/local/bin/helper.sh
cat "$1" | mac2unix

The important issue was to not use mac2unix directly, because it modifies the file itself.

Read: https://git.wiki.kernel.org/index.php/Textconv but it did not help so much.

Thanks,

Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

