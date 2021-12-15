Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55385C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 19:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhLOT7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 14:59:49 -0500
Received: from elephants.elehost.com ([216.66.27.132]:35365 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhLOT7s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 14:59:48 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BFJxZN1029346
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Dec 2021 14:59:36 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jacob Vosmaer'" <jacob@gitlab.com>
Cc:     <git@vger.kernel.org>, <avarab@gmail.com>, <peff@peff.net>
References: <YbizfdGq+RSu9BGe@coredump.intra.peff.net>        <20211214194626.33814-1-jacob@gitlab.com>        <20211214194626.33814-2-jacob@gitlab.com> <xmqqa6h16414.fsf@gitster.g>
In-Reply-To: <xmqqa6h16414.fsf@gitster.g>
Subject: RE: [PATCH v2 1/1] upload-pack.c: increase output buffer size
Date:   Wed, 15 Dec 2021 14:59:29 -0500
Organization: Nexbridge Inc.
Message-ID: <003001d7f1ee$48c88410$da598c30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIouFwJmPFhmz4Fe3UZ8hmRUMo3gwJyt/wXAnwpaG4BGKhHDKtiL0eQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 15, 2021 2:51 PM, Junio C Hamano wrote:
> Jacob Vosmaer <jacob@gitlab.com> writes:
> 
> > When serving a fetch, git upload-pack copies data from a git
> > pack-objects stdout pipe to its stdout. This commit increases the size
> > of the buffer used for that copying from 8192 to 65515, the maximum
> > sideband-64k packet size.
> 
> Thanks.  I agree with others that extra configurability is not needed in
this
> case, and allocating this on the heap (as long as we correctly deallocate
it
> when we are done) is the right thing.

This is likely to break NonStop as our sideband packet size is less than
64K.
-Randall

