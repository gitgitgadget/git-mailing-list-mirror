Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82000C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 15:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiGUP3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGUP3a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 11:29:30 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58667A51E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:29:29 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 26LFTPbu036823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Jul 2022 11:29:26 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqilnr1hff.fsf@gitster.g> <xmqq35eumrp8.fsf@gitster.g>
In-Reply-To: <xmqq35eumrp8.fsf@gitster.g>
Subject: RE: On-branch topic description support?
Date:   Thu, 21 Jul 2022 11:29:20 -0400
Organization: Nexbridge Inc.
Message-ID: <010101d89d16$a97184a0$fc548de0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEkKUYbAx2+J5zTwv5GK2so27+hNQITrdhNruE82GA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 21, 2022 11:06 AM, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>>  * "git merge" would learn an option to recognize that the branch
>>    being merged has such an empty commit at the tip, and instead
>>    merge the parent of the tip of the branch into the integration
>>    branch, while using the log message of the discarded tip commit
>>    in the log message of the merge itself.
>
>An issue that needs to be worked out at the Porcelain level is that this
layout will
>make "git branch --[no-]merged master", which is an effective way to list
what's in
>and what's left out of the 'master'
>integration branch, more or less useless.  A topic branch with the cover
letter
>commit at the tip may want to be merged to 'next' and then after cooking
for a
>while merged down to 'master', and each time it gets merged, the merge has
to
>leave the cover letter commit alone.  In spirit, such a merge commit merges
the
>topic "fully", but at the topological level, the topic is not (and will
never be)
>merged fully, and "git branch --merged next" will not show.
>
>I guess once the topic hits the oldest integration track that it meant to
go, we
>could "pop" the cover letter commit out of the topic, and at that point it
would
>appear to have been merged to 'master' as well as to 'next'.  But it would
be nice if
>we did not have to discard the cover letter commit only to please "git
branch".
>IOW, it would be helpful to teach "git branch --[no-]merged" to compute the
>"right thing" in such a layout.

I might be missing something here, but could not a description follow
similar semantics to how git describe works on tags? Anchor the description
on the commit where the branch was spawned, then determine the appropriate
description based on things like --first-parent. Again, I'm probably in the
weeds.
--Randall

