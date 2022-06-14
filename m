Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098AFC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 00:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiFNAaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiFNAaT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 20:30:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9252314E
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:30:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g7so9414570eda.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EPtTbFGfOkOD1ulV7gOBY1QfLFRDTO+d4x6FnLo38/Y=;
        b=qkIoY+8dCRsteJhA9secpiTjYqrJRsOOqVIx4w3Ob9QbPqT5HuLqRjg/DAZhDVYQmk
         OPxle1ug38NaFjELhCHhKNFHKVkwAMXuyLXw/8C8/gHY22TBsZlMT8LiZ7Wvd1Dj9y0Y
         RoWgn0OLEPOxVF3UIAAbVGSPoELe5oWAkzRq31Pi4ZvIdxo5l//RB4aZWRKuQJsZB5vz
         jMDPr8f6KQ9MfeIIKEVbut9OEopH7zm5+Ppm9NOUJiRrwDpb+MZZB0WLPgqLsbzsyvTs
         LxPaTWfAfsk61KsC4cBV/GC4jtgowDqtdrZ4SjTNLwMN/gBpA7x9bXrXSkTXkMb05MCK
         MAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EPtTbFGfOkOD1ulV7gOBY1QfLFRDTO+d4x6FnLo38/Y=;
        b=nT3rM2VvcCs471Ss1D0rl/6yUCAeVAY0lsT7n4jR9bntv1tbF4aUFeDscdn9WorF5i
         gAESnnHU2UCv0Q0pleDD8NsEP1AoRYf5EID7XtA3oLdscUFo7UWAoDZUnLvU6jDCTLYV
         K7wg3c6b37HYVZa73jxIzGt0ZXkc+qMEGBy8MUMqfKZ9cxAuM4vEUsp0Mh0vkbTQJ0kC
         dKLtEr1USEvDDPOvT2op91M6Ewjgow88m2QT5nupaT18GUGV1ZXHiZUr3hN62hPJ2vhT
         8szZZFWcHbWDmSTmtHpX25NJIrDRHKVNMTBFCjI5GhnE3eaAFcuec1FTfQEo2YhGT+oS
         ySSA==
X-Gm-Message-State: AOAM532bOsfylfSzhsYK4JAh06xg4V+jk79lbb3N4D7mcQeaO7zIpVwF
        aSbc9xX01eiOYpAUve+5aP4=
X-Google-Smtp-Source: ABdhPJzNA2E9pffSo2Jz1JwpyC5jtn5BD2N8AnZxO5r8oeqhDtTXw9OlQcJWdjDlg5tJHabkM3xa7A==
X-Received: by 2002:aa7:c14b:0:b0:42d:d763:104 with SMTP id r11-20020aa7c14b000000b0042dd7630104mr2744482edp.104.1655166617205;
        Mon, 13 Jun 2022 17:30:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gx7-20020a170906f1c700b006fe8ec44461sm4393874ejb.101.2022.06.13.17.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 17:30:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o0uRk-000Ixs-7Q;
        Tue, 14 Jun 2022 02:30:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
Date:   Tue, 14 Jun 2022 02:24:12 +0200
References: <xmqqfskdieqz.fsf@gitster.g>
 <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
Message-ID: <220614.86czfcytlz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 13 2022, Derrick Stolee wrote:

> On 6/9/2022 7:44 PM, Junio C Hamano wrote:
>
>> +	struct string_list *resolve_undo = istate->resolve_undo;
>> +
>> +	if (!resolve_undo)
>> +		return 0;
>> +
>> +	for_each_string_list_item(item, resolve_undo) {
>
> I see this is necessary since for_each_string_list_item() does
> not handle NULL lists. After attempting to allow it to handle
> NULL lists, I see that the compiler complains about the cases
> where it would _never_ be NULL, so that change appears to be
> impossible.
>  
> The patch looks good. I liked the comments for the three phases
> of the test.

I think it's probably good to keep for_each_string_list_item()
implemented the way it is, given that all existing callers of it feed
non-NULL lists to it.

But why is it impossible to make it handle NULL lists? This works for
me, and passes the tests:
	
	diff --git a/builtin/fsck.c b/builtin/fsck.c
	index 4b17ccc3f44..4160bb50ad0 100644
	--- a/builtin/fsck.c
	+++ b/builtin/fsck.c
	@@ -763,9 +763,6 @@ static int fsck_resolve_undo(struct index_state *istate)
	 	struct string_list_item *item;
	 	struct string_list *resolve_undo = istate->resolve_undo;
	 
	-	if (!resolve_undo)
	-		return 0;
	-
	 	for_each_string_list_item(item, resolve_undo) {
	 		const char *path = item->string;
	 		struct resolve_undo_info *ru = item->util;
	diff --git a/string-list.h b/string-list.h
	index d5a744e1438..aa15aea8c2b 100644
	--- a/string-list.h
	+++ b/string-list.h
	@@ -143,7 +143,7 @@ int for_each_string_list(struct string_list *list,
	 
	 /** Iterate over each item, as a macro. */
	 #define for_each_string_list_item(item,list)            \
	-	for (item = (list)->items;                      \
	+	for (item = (((list) && (list)->items) ? ((list)->items) : NULL); \
	 	     item && item < (list)->items + (list)->nr; \
	 	     ++item)
	 

Perhaps you tried to convert it to a do/while macro with an "if", which
won't work as we need the "for" to be used for the subsequent {} (or a
single statement)..

But under the hood this is all just syntax sugar for "goto", so if we
can avoid dereferencing "list" we're good to go...
