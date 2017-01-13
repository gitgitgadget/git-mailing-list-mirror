Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D025C1FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 02:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750906AbdAMCsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 21:48:53 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53254 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbdAMCsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 21:48:53 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 529051FEB3;
        Fri, 13 Jan 2017 02:48:42 +0000 (UTC)
Date:   Fri, 13 Jan 2017 02:48:42 +0000
From:   Eric Wong <e@80x24.org>
To:     Pat Pannuto <pat.pannuto@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
Message-ID: <20170113024842.GA20572@starla>
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
 <20170112055140.29877-3-pat.pannuto@gmail.com>
 <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
 <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
 <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
 <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pat Pannuto <pat.pannuto@gmail.com> wrote:
> You may still want the 1/2 patch in this series, just to make things
> internally consistent with "-w" vs "use warnings;" inside git's perl
> scripts.

No, that is a step back.  "-w" affects the entire process, so it
spots more potential problems.  The "warnings" pragma is scoped
to the enclosing block, so it won't span across files.

Existing instances of "use warnings" should remain, but I would
rather support adding "-w" to scripts which do not have it (and
fixing newly-found warnings along the way).

Thanks.
