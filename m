Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393CBC433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 16:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiC2QDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiC2QDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:03:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3B151590
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:01:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95BB419436F;
        Tue, 29 Mar 2022 12:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=srU9VSh3ho7q
        7W6/V58Sbgey3yQ+I00DjcMD5TaEtXo=; b=CGonESyW4VkxZ7J+ybkGa+I9OD3V
        eWzP/RlwZlmVNqHLsm3+WgBNjScjyZcTLJd7S3En6V0pztHA2Rp9QbYb/eauS96V
        Z1IHK2C+1qoWC/wXCALiElG3EofOY7FLiPt7/n/zd7a4cdcdJX5vCWFVMoRcjHP0
        9dPKvKuVkS0wbnA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E89B19436E;
        Tue, 29 Mar 2022 12:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E981419436D;
        Tue, 29 Mar 2022 12:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Desmond Preston <despreston@gmail.com>
Cc:     Des Preston via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] worktree: accept multiple paths
References: <xmqq35j1zi7j.fsf@gitster.g>
        <48242777-6442-4A4D-BE76-1B9EF2F7175B@gmail.com>
Date:   Tue, 29 Mar 2022 09:01:55 -0700
In-Reply-To: <48242777-6442-4A4D-BE76-1B9EF2F7175B@gmail.com> (Desmond
        Preston's message of "Mon, 28 Mar 2022 23:00:54 -0400")
Message-ID: <xmqq1qykycgc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E95B2A8-AF79-11EC-9029-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Desmond Preston <despreston@gmail.com> writes:

>> On Mar 28, 2022, at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>> =EF=BB=BF"Des Preston via GitGitGadget" <gitgitgadget@gmail.com> write=
s:
>>=20
>>> From: Des Preston <despreston@gmail.com>
>>>=20
>>> Update the worktree usage to show that the repair command can take
>>> multiple paths.
>>>=20
>>> Signed-off-by: Des Preston <despreston@gmail.com>
>>> ---
>>> builtin/worktree.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>>> index 8682ff4c417..498975c1fd9 100644
>>> --- a/builtin/worktree.c
>>> +++ b/builtin/worktree.c
>>> @@ -22,7 +22,7 @@ static const char * const worktree_usage[] =3D {
>>>    N_("git worktree move <worktree> <new-path>"),
>>>    N_("git worktree prune [<options>]"),
>>>    N_("git worktree remove [<options>] <worktree>"),
>>> -    N_("git worktree repair [<path>]"),
>>> +    N_("git worktree repair [<path>...]"),
>>=20
>> The fact that this line was introduced in [PATCH 1/2] and then
>> needed to immediately be corrected with this patch means the
>> previous patch was suboptimal and this patch is "oops, the last one
>> was bad and here is a band-aid fix-up".
>>=20
>> Let's not do so.  Instead, you are encouraged to pretend to be a
>> more perfect developer who does not make unnecessary mistake ;-)
>>=20
> k.=20

FYI, I've queued [1/2] with the fix-up in [2/2] squashed in.

Thanks.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: Des Preston <despreston@gmail.com>
Date: Mon, 28 Mar 2022 20:47:05 +0000
Subject: [PATCH] worktree: include repair cmd in usage

The worktree repair command was not added to the usage menu for the
worktree command. This commit adds the usage of 'worktree repair'
according to the existing docs.

Signed-off-by: Des Preston <despreston@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/worktree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2838254f7f..498975c1fd 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -22,6 +22,7 @@ static const char * const worktree_usage[] =3D {
 	N_("git worktree move <worktree> <new-path>"),
 	N_("git worktree prune [<options>]"),
 	N_("git worktree remove [<options>] <worktree>"),
+	N_("git worktree repair [<path>...]"),
 	N_("git worktree unlock <path>"),
 	NULL
 };
--=20
2.35.1-850-g6c97ec7725


