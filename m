Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FAFC3524D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A093D20721
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q4aRBFJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgBCIMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:12:05 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43326 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBCIMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 03:12:05 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0138Bjlj093696;
        Mon, 3 Feb 2020 02:11:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580717505;
        bh=Ktd7K7CyX1AxHFWRZvjAgX3+k0pQIIz053kXIkPdcJI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=q4aRBFJp13LYBmATVXJldBPp3JiVwRbAbjWbrwLkaY11/AWj0CDAS/lFbTQXuXdWa
         sIhsem4S/BWutcH1896GNlDaKtDuDllrToCpuvHMxm1VrZdtuZ7PV2WmpdUUk8gR6+
         n3PIrZFJSpQryutrkQur+ejI15MFTM7ERS7pWSCM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0138Bjm0099671
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Feb 2020 02:11:45 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 02:11:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 02:11:45 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0138BiQt082180;
        Mon, 3 Feb 2020 02:11:44 -0600
Date:   Mon, 3 Feb 2020 13:41:43 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
CC:     <git@vger.kernel.org>, <gitster@pobox.com>,
        <johannes.schindelin@gmx.de>, <christian.couder@gmail.com>,
        <peff@peff.net>, <newren@gmail.com>
Subject: Re: sending attachments via git send-email
Message-ID: <20200203081143.zv6f5tb3prp6kd4v@ti.com>
References: <20200203064712.14621-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200203064712.14621-1-shouryashukla.oo@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

My $0.02:

On 03/02/20 12:17PM, Shourya Shukla wrote:
> Hello everyone,
> 
> I was doing some tests on 'git send-email'[1] and noticed a couple of things:
> 
> 	1. We are not able to send attachments via 'git send-email' unlike
> 	   various other mail clients such as GMail, Yahoo, etc. Is there
> 	   any particular reason for this (maybe performance issues or code
> 	   compatibility issues etc.)?

IMO git-send-email shouldn't really be used for sending attachments. 
That is the job of other mail clients that you mention. git-send-email's 
purpose is to make it easier to send commits/patches via mail in plain 
text form. Its purpose is not to be a general mail client.

> 	2. Even so, I tried sending an image to myself and noticed that the
> 	   command basically does not check if we are sending a text file or
> 	   not(though I think it should unless there is any key reason behind it).
> 	   On executing the command(when trying to send an image), it asks for the
> 	   encoding (that was odd as it did not ask for any of emails I have sent
>            using the command). I entered the command:
> 	   'git send-email --to=shouryashukla.oo@gmail.com --subject=test_mail me.JPG'
> 	   which prompts:
> 	   'The following files are 8bit, but do not declare a Content-Transfer-Encoding.'
>     	   'me.JPG'
> 	   'Which 8bit encoding should I declare [UTF-8]?'
> 	   So i enter the encoding as '8BIT', which at the end prompts:
> 	   'No subject line in me.JPG? at /usr/lib/git-core/git-send-email line 687.'
> 	   
> 	   Why is this happening even though I entered the subject in the command itself?

I don't know much about the internals of git-send-email (or the JPEG 
image format), but my guess is git-send-email tries to decode the JPEG 
file as a text file and then fails to detect encoding, and so asks the 
user explicitly what the encoding is. I don't necessarily think that is 
a bad thing. You shouldn't be sending images via git-send-email.

That said, maybe it would be a good idea to check the mime type of the 
file and warn the user.
 
> 	3. I looked up at the script of the command and noticed that there are two files,
> 	   namely: 'git-send-email.perl' and 'git-send-email', both are identical except for
> 	   an extra 'use lib (split(/:/, $ENV{GITPERLLIB} || '/home/<<username>>/share/perl5'));'
> 	   on line 3 of 'git-send-email'(my inference is that we are trying to import the perl
> 	   library by splitting the addresses at '/' or something similar). What is the purpose
> 	   of the latter file?(I am new to Perl, if I am missing out on anything please forgive
> 	   my ignorance).

Running 'git ls-files | grep git-send-email' gives me:

  Documentation/git-send-email.txt
  git-send-email.perl

So it means the file 'git-send-email' is not tracked and is an output 
from the build system. My guess is that the build system inserts this 
line when you run 'make'. Check the file 
'perl/header_templates/fixed_prefix.template.pl'.

-- 
Regards,
Pratyush Yadav
