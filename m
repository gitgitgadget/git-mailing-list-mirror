Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_HEX
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1233620281
	for <e@80x24.org>; Tue, 26 Sep 2017 19:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031985AbdIZTqk (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 15:46:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:65422 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966436AbdIZTqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 15:46:39 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP; 26 Sep 2017 12:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,441,1500966000"; 
   d="scan'208";a="1018726672"
Received: from mherber2-mobl.jf.intel.com (HELO mherber2-mobl.ger.corp.intel.com) ([10.7.199.152])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2017 12:46:13 -0700
Subject: Re: BUG in git diff-index
To:     Junio C Hamano <gitster@pobox.com>,
        Andy Lowry <andy.work@nglowry.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Kujau <lists@nerdbynature.de>, josh@joshtriplett.org,
        michael.w.mason@intel.com, linux-kernel@vger.kernel.org
References: <loom.20160331T143733-916@post.gmane.org>
 <20160331140515.GA31116@sigill.intra.peff.net>
 <CAJxkE8SVF_ikHqDCh6eHExq=seitHPVpxW2GmPo40jtqWvz1JQ@mail.gmail.com>
 <20160331142704.GC31116@sigill.intra.peff.net> <56FD7AE8.4090905@nglowry.com>
 <xmqqwpoil6vt.fsf@gitster.mtv.corp.google.com>
From:   Marc Herbert <Marc.Herbert@intel.com>
Message-ID: <d9b4725b-3204-03af-1bc2-6469bb815c63@intel.com>
Date:   Tue, 26 Sep 2017 12:46:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqwpoil6vt.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/03/16 13:39, Junio C Hamano wrote:
> Andy Lowry <andy.work@nglowry.com> writes:
> 
>> So I think now that the script should do "update-index --refresh"
>> followed by "diff-index --quiet HEAD". Sound correct?
> 
> Yes.  That has always been one of the kosher ways for any script to
> make sure that the files in the working tree that are tracked have
> not been modified relative to HEAD (assuming that the index matches
> HEAD).  

Too bad kernel/scripts/setlocalversion didn't get the memo:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cdf2bc632ebc9ef51
> scripts/setlocalversion on write-protected source tree (2013)
> I don't see how removing "git update-index" could do any harm.

This causes a spurious "-dirty" suffix when building from a directory copy
(as Mike learned the hard way)

  ----

PS: I used NNTP and http://dir.gmane.org/gmane.comp.version-control.git
to quickly find this old thread (what could we do without NNTP?). Then
I googled for a web archive of this thread and Google could only find
this one: http://git.661346.n2.nabble.com/BUG-in-git-diff-index-tt7652105.html#none
Is there a robots.txt to block indexing on
https://public-inbox.org/git/1459432667.2124.2.camel@dwim.me ?
