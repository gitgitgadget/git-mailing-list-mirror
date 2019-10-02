Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434CA1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 20:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfJBUvm (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 16:51:42 -0400
Received: from smtp92.iad3a.emailsrvr.com ([173.203.187.92]:50055 "EHLO
        smtp92.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727287AbfJBUvm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Oct 2019 16:51:42 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 16:51:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1570048906;
        bh=KMgXJaBGy0o59Nl6S0y1De/87zqbYOc2X8Ry32BX0Vo=;
        h=Subject:To:From:Date:From;
        b=nxzXM70YLVWMoS3ClFuKywuhaqe1taP+RiDCXM4lyDufzqS1KwCptj0WNSj3Wqio/
         ut7LHtmhcQskt8pTesLRLk6V8LAjtKqQhFoR8AM2WiK5CL5yWn3XvakfOSUQqM+HRb
         cJagXfYGvO+yupE/lQjBDr77IDcWhW8vUBsl2xMY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xiplink.com;
        s=20181102-2c3qeqyt; t=1570048906;
        bh=KMgXJaBGy0o59Nl6S0y1De/87zqbYOc2X8Ry32BX0Vo=;
        h=Subject:To:From:Date:From;
        b=SzRG/KF36N7IljLcHlY9l6kORJGR9blH/OBoxgfOaYBh/RlE6MZNjHdRXBtf3WF0k
         P4uxt+ORNwur0bgZtCYE4GDaQYP//K0Vb7FTdpzRO6mU9qRBjYCzZQERY6ZpkIkOOZ
         5nL9jwellmikKWtaZ5YYxqT1bDUKffZAuLmYy9pY=
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp36.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 413ADB60;
        Wed,  2 Oct 2019 16:41:46 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 02 Oct 2019 16:41:46 -0400
Subject: Re: git-gui: disable the "loose objects popup" dialog?
To:     Pratyush Yadav <me@yadavpratyush.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
 <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org>
 <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
 <9d77189d-a357-ab0a-6cb5-e87ecdeffb91@kdbg.org>
 <20191001180005.iemqmlbn7ncv3dav@yadavpratyush.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <d774be5e-e451-5435-f131-19020062fee9@xiplink.com>
Date:   Wed, 2 Oct 2019 16:41:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001180005.iemqmlbn7ncv3dav@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-10-01 2:00 p.m., Pratyush Yadav wrote:
> 
> So here's what I propose: why don't we try to do something similar? What
> about running `git-gc --auto` in the background when the user makes a
> commit (which I assume is the most common operation in git-gui). This
> would be disabled when the user sets gc.auto to 0.
> 
> This way, we keep a similar experience to the command line in case of
> auto-gc, and we get rid of the prompt. People who don't want
> auto-compression can just set gc.auto to 0, which they should do anyway.
> 
> Thoughts?
> 

+1 from me.

		M.

