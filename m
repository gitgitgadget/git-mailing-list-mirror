Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA904C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 21:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCWVgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCWVgL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 17:36:11 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A45B89
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:36:11 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 1E0722038E
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:36:10 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfSbR-ggE-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 22:36:09 +0100
Date:   Thu, 23 Mar 2023 22:36:09 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH 7/8] sequencer: pass `onto` to complete_action() as
 object-id
Message-ID: <ZBzGSbm7GZVK17ja@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-8-oswald.buddenhagen@gmx.de>
 <a3833d93-5db0-454e-526e-04681e5e5276@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a3833d93-5db0-454e-526e-04681e5e5276@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 07:34:57PM +0000, Phillip Wood wrote:
>On 23/03/2023 16:22, Oswald Buddenhagen wrote:
>> ... instead of as a commit, which makes the purpose clearer and will
>> simplify things later.
>
>given that we want onto to be a commit I'm not sure how this makes 
>anything clearer.
>
it makes it clearer that we need only the oid, not any other part of the 
commit object. and pulling ahead the "extraction" reduces the visual 
noise further down.

>> As a side effect, this change revealed that skip_unnecessary_picks() was
>> butchering the commit object due to missing const-correctness. Slightly
>> adjust its API to rectify this.
>
>I don't think this is correct. If you look at the original code it makes 
>a copy of the oid and uses the copy when calling skip_unnecessary_picks()
>
oops, you're quite right. (facepalm)
imo the change still makes sense, though, as it replaces the relatively 
expensive deep copies with simple pointer updates. so just fix the 
commit message?

