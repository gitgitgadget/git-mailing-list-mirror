Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABDF1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdHPUWw (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:22:52 -0400
Received: from vie01a-dmta-pe01-3.mx.upcmail.net ([62.179.121.156]:14005 "EHLO
        vie01a-dmta-pe01-3.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752313AbdHPUWv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:22:51 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe01.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4q1-0007GQ-Jj
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:22:49 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwNf1v00X5BuuEg01wNgrP; Wed, 16 Aug 2017 22:22:40 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 2DEFA471EB03; Wed, 16 Aug 2017 22:22:39 +0200 (CEST)
Date:   Wed, 16 Aug 2017 22:22:39 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Koegler <martin.koegler@chello.at>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
Message-ID: <20170816202238.GA3008@mail.zuhause>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
 <20170813183026.GC31079@mail.zuhause>
 <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
 <xmqqtw1bw1v6.fsf@gitster.mtv.corp.google.com>
 <xmqqfucuw00a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfucuw00a.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 10:08:05AM -0700, Junio C Hamano wrote:
>    It may help reducing the maintenance if we introduced obj_size_t
>    that is defined to be size_t for now, so that we can later swap
>    it to ofs_t or some larger type when we know we do need to
>    support objects whose size cannot be expressed in size_t, but I
>    do not offhand know what the pros-and-cons with such an approach
>    would look like.

Where should the use of obj_size_t end and the use of size_t start? 

We often determine a object size and then pass it to malloc. 
We would start with a larger datatyp and then truncate for memory allocation, which use size_t.

Regards,
Martin
