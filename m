Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E40F1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 16:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfBRQPD convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 18 Feb 2019 11:15:03 -0500
Received: from elephants.elehost.com ([216.66.27.132]:56631 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbfBRQPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 11:15:02 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1IGExS3068717
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 11:14:59 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        "'Joe Ranieri'" <jranieri@grammatech.com>
Cc:     <git@vger.kernel.org>
References: <1ff48830-f3de-11f4-9014-c20eb3890c21@grammatech.com> <20190218151725.GL1622@szeder.dev>
In-Reply-To: <20190218151725.GL1622@szeder.dev>
Subject: RE: [BUG] ls-files showing deleted files (unchecked lstat return value)
Date:   Mon, 18 Feb 2019 11:14:52 -0500
Message-ID: <000c01d4c7a5$17915a00$46b40e00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFJjgaAGbTDkZVlAQbFZ175xUV0NQJ7CZVOpuhVfwA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 18, 2019 10:17, SZEDER Gábor wrote:
> To: Joe Ranieri <jranieri@grammatech.com>
> Cc: git@vger.kernel.org
> Subject: Re: [BUG] ls-files showing deleted files (unchecked lstat return
> value)
> 
> On Sun, Feb 17, 2019 at 08:49:39AM -0500, Joe Ranieri wrote:
> > "git ls-files -m" can show deleted files, despite -d not having been
> > specified.
> 
> To my understanding that's intentional: a deleted file is considered modified,
> because its content clearly doesn't match the tracked content.

That's a good point and why I asked for a specific test condition that illustrated the bug as being unanticipated. I'm not sure what Joe supplied elsewhere in the thread does that.

> > This is due to ls-files.c's show_files function calling lstat but not
> > checking the return value before calling ie_modified with the
> > uninitialized stat structure.


