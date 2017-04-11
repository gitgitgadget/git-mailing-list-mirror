Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F2D20970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbdDKRk4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:40:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49088 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752183AbdDKRky (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:40:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B487520970;
        Tue, 11 Apr 2017 17:40:48 +0000 (UTC)
Date:   Tue, 11 Apr 2017 17:40:48 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] run-command: add note about forking and threading
Message-ID: <20170411174048.GA18679@dcvr>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170410234919.34586-6-bmwill@google.com>
 <20170411002606.GJ8741@aiede.mtv.corp.google.com>
 <20170411005348.GA30913@starla>
 <20170411173445.GF36152@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411173445.GF36152@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> wrote:
> On 04/11, Eric Wong wrote:
> > On the other hand, I believe we should make run-command
> > vfork-compatible (and Brandon's series is a big (but incomplete)
> > step in the (IMHO) right direction); as anything which is
> > vfork-safe would also be safe in the presence of threads+(plain) fork.
> > With vfork; the two processes share heap until execve.
> 
> I haven't looked to much into vfork, one of the benefits of vfork is
> that it is slightly more preferment than vanilla fork correct?  What are
> some of the other benefits of using vfork over fork?

Yes, mainly performance and perhaps portability...  Last I
checked (over a decade ago); uCLinux without MMU could not
fork processes; only vfork.
