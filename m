Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970472018D
	for <e@80x24.org>; Mon,  8 May 2017 14:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754864AbdEHOyM (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 10:54:12 -0400
Received: from smtp106.iad3a.emailsrvr.com ([173.203.187.106]:46300 "EHLO
        smtp106.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754152AbdEHOyL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 May 2017 10:54:11 -0400
Received: from smtp38.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp38.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 9BAE25B75;
        Mon,  8 May 2017 10:54:10 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp38.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5048D5B48;
        Mon,  8 May 2017 10:54:10 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 08 May 2017 10:54:10 -0400
Subject: Enabling the diff "indent" heuristic by default
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlgq77pse.fsf@gitster.mtv.corp.google.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
Date:   Mon, 8 May 2017 10:54:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgq77pse.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-08 03:48 AM, Junio C Hamano wrote:
>
> * mb/diff-default-to-indent-heuristics (2017-05-02) 4 commits
>   (merged to 'next' on 2017-05-08 at 158f401a92)

I think there's a general open question about this, which is whether or 
not we should just drop the diff.indentHeuristic configuration setting 
altogether.

Peff made the point [0] that if we keep the setting then t4061 should be 
rewritten.

My instinct is to keep the setting, at least until the changed default 
has a bit of time to settle in.  So I'll re-send the topic with the 
renovated t4061.

The topic would of course change more drastically if we decide to drop 
the setting right away.

>  + add--interactive: drop diff.indentHeuristic handling
>  + diff: enable indent heuristic by default
>  + diff: have the diff-* builtins configure diff before initializing revisions
>  + diff: make the indent heuristic part of diff's basic configuration
>
>  Make the "indent" heuristics the default in "diff" and diff.indentHeuristics

s/heuristics/heuristic/  (both places)

>  configuration variable an escape hatch for those who do no want it.

s/do no/do not/

>  Will cook in 'next'.

Both Peff [1] and Ævar [2] mentioned situations where enabling the 
heuristic has a small impact on them.  If/when this graduates, it's 
perhaps worth adding a backward-compatibility note that the default 
patch IDs are changing.  Maybe something like:

The diff "indent" heuristic is now enabled by default.  This changes the 
patch IDs calculated by git-patch-id and used by git-cherry, which could 
affect patch-based workflows that rely on previously-computed patch IDs. 
  The heuristic can be disabled by setting diff.indentHeuristic to false.

[0] 
https://public-inbox.org/git/20170501222051.svylxazjwnot3wwg@sigill.intra.peff.net/

[1] 
https://public-inbox.org/git/20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net/

[2] 
https://public-inbox.org/git/CACBZZX5f81HKCjRjTDyXzNMVuef9Z_ECS+0SVk2xpbwXudgxCw@mail.gmail.com/

		M.

