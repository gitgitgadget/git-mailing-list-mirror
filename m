Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D0B208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 07:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbdHIHTM (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 03:19:12 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:27183 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752008AbdHIHTM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Aug 2017 03:19:12 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dfLGn-0005LZ-Nm
        for git@vger.kernel.org; Wed, 09 Aug 2017 09:19:09 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id uvK61v02f5BuuEg01vK8Tu; Wed, 09 Aug 2017 09:19:08 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 9FA1745D4512; Wed,  9 Aug 2017 09:19:06 +0200 (CEST)
Date:   Wed, 9 Aug 2017 09:19:06 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Convert size datatype to size_t
Message-ID: <20170809071906.GA19310@mail.zuhause>
References: <1502222450-20815-1-git-send-email-martin@mail.zuhause>
 <xmqq8tit8efv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tit8efv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2017 at 11:04:20PM -0700, Junio C Hamano wrote:
> Martin Koegler <martin.koegler@chello.at> writes:
> 
> > From: Martin Koegler <martin.koegler@chello.at>
> >
> > It changes the signature of the core object access function
> > including any other functions to assure a clean compile if
> > sizeof(size_t) != sizeof(unsigned long).
> 
> As https://travis-ci.org/git/git/jobs/262463159 shows, unfortunately
> it turns out that things are not so simple X-<.  On Linux32, size_t
> is uint, which is the same size as ulong, but "%lu" is not appropriate
> for showing a size_t value.
> 
> So you are correct to say in the comment under three-dashes that
> there is much more to change in the codebase.

My patch is based on V2 of my "Fix delta integer overflows" patch [also changing the variable types].

I'll post a new version fixing the *printf issues.

The patch can't be splitted without causing compile errors, if sizeof(size_t) != sizeof(ulong).
Many variables are not changed to keep the patch small.

Regards,
Martin
