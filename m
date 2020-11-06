Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A945DC55178
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5019F2072E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLoAgN2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgKFTxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFTxV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 14:53:21 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26A7C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 11:53:21 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so1620435wmg.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 11:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lEf7VThOwbTkAAAS3NNZG0HdhT4ZsOJRDzSO/Rg9lIo=;
        b=mLoAgN2MZeXzV7RGejyKwHH7hZPRtZj81qZVQKJNTgBx0hVTNUyQboBRM8XHAtcJkX
         gfeHcJWoqWqkiW/lbB21imce4gCZydP3jawyKo9wLTSi03P5qTxZIkOwGUZcvzY4of1T
         jvwa+iJlB1NfRnmxTJG2H3MDrZQ+uayDHVruOL7ZWOnBR/NB5zljSbd8y/Y11gOWZkYk
         GOyRKBkDtcPoY7Sm8iJh4OwyzwFIDnoSCbJDaI3/eXRIBHGicYactm6btxSb3xjI22cy
         RbbrxNE6w2JuGQgustoRi5kQ9yZvNL1VZvHguXNvRG8L6jw8SKddCzTMfauvsq8RLpVo
         C94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lEf7VThOwbTkAAAS3NNZG0HdhT4ZsOJRDzSO/Rg9lIo=;
        b=nRAVUENorot8FS2YAjg/DZzbbxvd432Sj6Vq4Id/t0SB/3rjUWf07uWyEbwGZ7Wbji
         ba0E9tUnsaT/BPFeofI1yKUrUPAbMiHag0EkQFWCDxlJiqwusPeWJHsuP1KmBKhuZiY1
         /z3GDmJ/DSwtNtxPkiD5aPoEhn4Ka+qXhMFaPVe47ld4n3L4uLBkh5b17pln4YK2Nk4L
         iKd86yqoqNVa5N0HHSIdUuCMLQ+VKLLQkF8gYS/vynxTwDR0C6+0E8UCFx8jcEOeHTsO
         ePgQwzL4Pco8DBS8NttOvHFjYwnEsNzLbDLdwiSHUgA+W/z07jgpNeGKd7SyV3X5Pdni
         HCwA==
X-Gm-Message-State: AOAM531QkQN6HPhSaoMTJRaWzlyD4GUY/OeFthXYh6venILahZmMuCua
        lal5aUtvCLeVr6FMHd3weGylV/sZTdY=
X-Google-Smtp-Source: ABdhPJwkwHiop9GlxuE828WCTnEQa53ICf3I2oQ0npmsEi0giEyrVfHlcI6UA5vPFq1MKf86zM9+jQ==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr1159093wmo.97.1604692400445;
        Fri, 06 Nov 2020 11:53:20 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-325-232.w86-199.abo.wanadoo.fr. [86.199.212.232])
        by smtp.gmail.com with ESMTPSA id w1sm3537867wro.44.2020.11.06.11.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 11:53:20 -0800 (PST)
Subject: Re: [PATCH v3 05/11] merge-resolve: rewrite in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201005122646.27994-6-alban.gruin@gmail.com>
 <xmqqr1pyashe.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <f321f01d-8071-9be3-7214-f8506081f17c@gmail.com>
Date:   Fri, 6 Nov 2020 20:53:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1pyashe.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 16/10/2020 à 21:19, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> +#include "cache.h"
>> +#include "builtin.h"
>> +#include "merge-strategies.h"
>> +
>> +static const char builtin_merge_resolve_usage[] =
>> +	"git merge-resolve <bases>... -- <head> <remote>";
>> +
>> +int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
>> +{
>> +	int i, is_baseless = 1, sep_seen = 0;
>> +	const char *head = NULL;
>> +	struct commit_list *bases = NULL, *remote = NULL;
>> +	struct commit_list **next_base = &bases;
>> +
>> +	if (argc < 5)
>> +		usage(builtin_merge_resolve_usage);
>> +
>> +	setup_work_tree();
>> +	if (repo_read_index(the_repository) < 0)
>> +		die("invalid index");
>> +
>> +	/* The first parameters up to -- are merge bases; the rest are
>> +	 * heads. */
> 
> Style (I won't repeat).
> 
>> +	for (i = 1; i < argc; i++) {
>> +		if (strcmp(argv[i], "--") == 0)
> 
> 	if (!strcmp(...))
> 
> is more typical than comparing with "== 0".
> 
>> +			sep_seen = 1;
>> +		else if (strcmp(argv[i], "-h") == 0)
>> +			usage(builtin_merge_resolve_usage);
>> +		else if (sep_seen && !head)
>> +			head = argv[i];
>> +		else if (remote) {
>> +			/* Give up if we are given two or more remotes.
>> +			 * Not handling octopus. */
>> +			return 2;
>> +		} else {
>> +			struct object_id oid;
>> +
>> +			get_oid(argv[i], &oid);
>> +			is_baseless &= sep_seen;
>> +
>> +			if (!oideq(&oid, the_hash_algo->empty_tree)) {
> 
> What is this business about an empty tree about?
> 

I don’t remember my intent here -- perhaps I wanted to avoid merges on
empty trees…  I’ll remove that from here and merge-octopus.c.

>> +				struct commit *commit;
>> +				commit = lookup_commit_or_die(&oid, argv[i]);
>> +
>> +				if (sep_seen)
>> +					commit_list_append(commit, &remote);
>> +				else
>> +					next_base = commit_list_append(commit, next_base);
>> +			}
>> +		}
>> +	}
>> +
>> +	/* Give up if this is a baseless merge. */
>> +	if (is_baseless)
>> +		return 2;
> 
> This is quite convoluted.  
> 
> The original is much more straight-forward.  We just said "grab
> everything before we see '--' and call them bases; immediately after
> '--' is HEAD and everything else is remote.  Now do we have any
> base?  Otherwise we cannot handle it".
> 
> I cannot see an equivalence to it in the rewritten result, with the
> bit operation with is_baseless and sep_seen.  Wouldn't it be the
> matter of checking if next_base is NULL, or is there something more
> subtle that deserves in-code comment going on?
> 

After re-reading this many, many weeks later, I can confirm that this is
convoluted, and that there is a much better way to perform some checks…
 for instance, checking if `bases' is NULL instead of having
`is_baseless', or checking after the loop if `remotes->next' is not NULL
to verify if there is multiple remotes.

> Thanks.
> 

Alban

