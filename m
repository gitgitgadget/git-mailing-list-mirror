Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1674FC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 10:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbhLBKat (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 05:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbhLBKao (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 05:30:44 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08ECC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 02:27:21 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 2019859791D46; Thu,  2 Dec 2021 11:27:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 07F7C6198C50E;
        Thu,  2 Dec 2021 11:27:20 +0100 (CET)
Date:   Thu, 2 Dec 2021 11:27:19 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: RFE: Split diff.noprefix for git-diff and git-format-patch (was:
 http-backend: give a hint that web browser access is not supported)
In-Reply-To: <xmqqee6vwj67.fsf@gitster.g>
Message-ID: <s6r03p31-o7o7-2142-9oo7-qno483r213s5@vanv.qr>
References: <20211202003900.26124-1-jengelh@inai.de> <xmqqee6vwj67.fsf@gitster.g>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thursday 2021-12-02 08:38, Junio C Hamano wrote:
>
>>  http-backend.c          | 36 +++++++++++++++++++++++++++-----
>>  t/t5561-http-backend.sh | 46 ++++++++++++++++++++---------------------
>>  2 files changed, 54 insertions(+), 28 deletions(-)
>>
>> diff --git http-backend.c http-backend.c
>> index 3d6e2ff17f..f7858e9c49 100644
>> --- http-backend.c
>> +++ http-backend.c
>
>Please fix your format-patch settings.  The comparisons should be
>between a/http-backend.c and b/http-backend.c and not between the
>same path at the top-level.

You are right. But..

In interactive git-diff invocations, prefixless is the arguably desired mode,
so as to facilitate xterm copy-and-paste of the pathname (since a/ does not
exist, you would want to have it in the copypaste operation anywhere).

I can see why git-format-patch would make use of the "diff.noprefix"
config directive, but equally, it's a bug that diff.noprefix has such
broad implications and that there is no way to distinguish between
diff and format-patch.
