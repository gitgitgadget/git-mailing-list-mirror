Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5AE208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 09:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbdHKJMH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 11 Aug 2017 05:12:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:33895 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751521AbdHKJMG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 05:12:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5428CABB8;
        Fri, 11 Aug 2017 09:12:05 +0000 (UTC)
Subject: Re: git-describe --contains
To:     Davide Cavallari <davide.cavallari@gmail.com>, git@vger.kernel.org
References: <CANOKeme4j9fHuQoQY3MQeoNuietjez8m1wPkAO=1eSDtHG3J9w@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Message-ID: <476ddcbb-6d66-bc6b-5fbd-aa43851dec30@suse.de>
Date:   Fri, 11 Aug 2017 11:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <CANOKeme4j9fHuQoQY3MQeoNuietjez8m1wPkAO=1eSDtHG3J9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 11/08/2017 à 08:50, Davide Cavallari a écrit :
> Please help me understand how this command works. There is one case in the
> linux kernel repository that puzzles me. Let's consider patch "drm/i915/
> execlists: Reset RING registers upon resume" [1]. This patch was committed 641
> commits after version 4.8-rc2:
>
> ~$ git describe bafb2f7d4755bf1571bd5e9a03b97f3fc4fe69ae
> v4.8-rc2-641-gbafb2f7d4755
>
> So I would expect to find it in version 4.8-rc3 and later versions.
>
> However, if I search for the tag that follows (and hence contains) that
> commit, I do not find version 4.8-rc3, nor version 4.8, nor version 4.9, but
> 4.10-rc1:
>
> ~$ git describe --contains bafb2f7d4755bf1571bd5e9a03b97f3fc4fe69ae
> v4.10-rc1~154^2~44^2~178
>
> Why? Why not v4.8-rc3? This means that the patch has been included neither in
> v4.8 nor in v4.9, but only in version 4.10-rc1, right? Why so much time was
> needed, considering it was the 621st commit on top ov v4.8-rc2?

Because it was not in v4.8-rc3.
This probably means it was applied on a branch that started from somewhere between 4.8-rc2 and 4.8-rc3 but it was only merge into master after v4.9 was released


>
> BTW, what are the numbers 154^2~44^2~178 that follow the tag name?

This is due to merges. You have basically a roadmap to go up the ancestry graph.
~154 means 154 commit before the tag
^2 means the 2nd parent of this commit.
and so on...

The format is detailed (among other tings) in man gitrevisions

Nicolas

