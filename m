Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6A2C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 16:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiEBQfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 12:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbiEBQfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 12:35:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F796DF16
        for <git@vger.kernel.org>; Mon,  2 May 2022 09:32:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF73F135C8A;
        Mon,  2 May 2022 12:32:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1kXMyesMqeIAUZdznOyalUDUbX8n4ZTJT7BZ+K
        XXahA=; b=WfLek9EHaFze1/8IZXKmUy1lz6AV+clOgJCbybuMNeIpjytCs68XoR
        sC6wCe3fVk1Sh+1qGNRLyRHa4IdyImU+xp+qX1FutHHubgrEtyzOKpfMwzv7jwe0
        IQWadJrAPASO9C4BIWkabTCO2sg/wFFPBWO5ii7OWn8PpDR8gTaks=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D05AF135C89;
        Mon,  2 May 2022 12:32:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F9BB135C87;
        Mon,  2 May 2022 12:32:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
        <20220430041406.164719-2-gitter.spiros@gmail.com>
        <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email>
        <xmqqpmky70jb.fsf@gitster.g>
        <a3e06290-052e-af36-4170-301e567d561d@iee.email>
        <xmqqr15e5fm3.fsf@gitster.g> <xmqqmtg25cjw.fsf@gitster.g>
        <CA+EOSBnx3-G02=zXGUrRuKPTDPBSYoBY=rERCORe8NtywEOiGg@mail.gmail.com>
        <xmqqbkwg4zi7.fsf@gitster.g> <xmqqmtg01mir.fsf@gitster.g>
        <13dc6ee6-f4ee-c246-b610-ec3d0a72a4ed@iee.email>
Date:   Mon, 02 May 2022 09:32:01 -0700
In-Reply-To: <13dc6ee6-f4ee-c246-b610-ec3d0a72a4ed@iee.email> (Philip Oakley's
        message of "Mon, 2 May 2022 11:00:48 +0100")
Message-ID: <xmqqee1b28vy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65D42B3E-CA35-11EC-8890-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>>> As I assumed that applying the patches in this series would create
>>> the branch B, and then I saw that the tip of 'seen' after merging
>>> this topic still needed to have a lot more fixes according to "make
>>> coccicheck", I got a (false) impression that there are too many new
>>> violations from topics in flight, which was the primary source of my
>>> negative reaction against potential code churn.  If we try the above
>>> exercise, perhaps there may not be too many topics that need fix-up
>>> beyond what we fix in the branch B, and if that is the case, I would
>>> not be so negative.
>> So I tried that myself, and the topic branch B was fairly
>> straightforward to create.
>>
>> We have ~60 topics in flight (not counting this one), and it turns
>> out that there is no topic that introduces new code that fails the
>> equals-null.cocci rule.  IOW, the follow-up fixup per topic turns
>> out to be an empty set.
>>
>> So, I'd probably use the [01/23] and then a single ~5k lines patch
>> that was generated with equals-null.cocci rule as the branch B
>> above, let it percolate down from 'seen' to 'next' to eventually
>> 'master'.
>>
>> Thanks.
> That sounds like a good result.
>
> It may also be worth Elia cross checking against a previous release
> (v2.35.0?) for relatively recent introductions, to cover the potential
> revert scenario, just in case..

Sounds sensible.  We do have some changes between 2.35 and 2.36 and
the fork-points of many topics predate 2.36 (and may even 2.35).

Here is an experiment I just did:

 * Applied the patch to add equals-null.cocci to maint-2.35.

 * Ran "coccicheck", applied the resulting equals-null fix and
   committed the result.

 * Merged the "branch B" from last night to it.

The resulting tree exactly matched "branch B" (i.e. 2.36.0 fixed
with equals-null.cocci check).

If I instead merge vanilla 2.36 with the result of fixing
maint-2.35, that differs at two places from "branch B" (i.e. we
added two new violations to 2.36 relative to 2.35).

Doing the same between maint-2.35 and maint-2.34 seems to indicate
that we didn't add any new violations during that period.

So in short, 2.35 may probably be a good place to start, but basing
on 2.36 seems to be good enough.

Thanks.

 branch.c                             | 2 +-
 compat/fsmonitor/fsm-listen-darwin.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git c/branch.c w/branch.c
index bde705b092..d0ca2b76d2 100644
--- c/branch.c
+++ w/branch.c
@@ -653,7 +653,7 @@ void create_branches_recursively(struct repository *r, const char *name,
 	 * be created in every submodule.
 	 */
 	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
-		if (!submodule_entry_list.entries[i].repo) {
+		if (submodule_entry_list.entries[i].repo == NULL) {
 			int code = die_message(
 				_("submodule '%s': unable to find submodule"),
 				submodule_entry_list.entries[i].submodule->name);
diff --git c/compat/fsmonitor/fsm-listen-darwin.c w/compat/fsmonitor/fsm-listen-darwin.c
index dc8a33130a..0741fe834c 100644
--- c/compat/fsmonitor/fsm-listen-darwin.c
+++ w/compat/fsmonitor/fsm-listen-darwin.c
@@ -342,7 +342,7 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 					   data->cfar_paths_to_watch,
 					   kFSEventStreamEventIdSinceNow,
 					   0.001, flags);
-	if (!data->stream)
+	if (data->stream == NULL)
 		goto failed;
 
 	/*
