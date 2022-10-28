Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD9DC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 14:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJ1O7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ1O7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 10:59:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AFD203547
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 07:59:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v27so8297696eda.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7X44uacuhVpIDHXUY/t9QJ3+uRkqDTp/Chh/N+5A6nc=;
        b=UsW54uuEJ3klTa0do7sJM1tOwgagXc15U/U4T2MCDzfceqiQkyw6DtNKJRrXL7fLOq
         OJF7lyIcCHZdMVfcQB4ntHCHaHwB45xjxzdBgLnvsWe8WRjaunz34ZY1mep38NGUMik0
         nYUjhbeXYhwLSoJII28loW+9Wrcw/zK13kt5LqgwmmoyG3INbjvbVLf1RsZsu0OHFZ/D
         0HpuCJLnwTUkLTPcFIr82BqAU+JOww37MZRKMryNS1L/t86mCSUd/SpKQfdzMTHHDUeD
         dYfK/KLlJfmJdVowjDcjevfTVs2uj1tXm//6N3Os35YO9tU2NGCqtJy2Jl3rrrwMO3js
         mw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X44uacuhVpIDHXUY/t9QJ3+uRkqDTp/Chh/N+5A6nc=;
        b=TxaRcZIBxTUBOaN2+Y6HbYy8hmoARNt1EY1mrm+jp/1e1f9tIbTrRuAWtPW2/94QFA
         Oc5FtCxnitSPlgJgmIxRNZl0tCSoihz9qfFbxuT4N++NVLvICIga8f019nq95v0tOYXq
         bWp00ke4ZbajYGR50gjkKGhUJvG2ODfj+UvByOSHRPyVfutcXkoYGzp5oc0gJXb0dQQU
         FKp/0qcHEuJVDy+PKyuPGoN1SQOylmNLnsBkTpgPzcEBLmBn8rf3FzVBMRNE8pUu97Ey
         E3j02cQYIyFt8vcLsrCIiXD5f08zyI3gTaDEAy4/kPhAPB2C1oUPLE133vhPUcC4mppw
         sfPA==
X-Gm-Message-State: ACrzQf1R/CSug9PqLgPHQTU6oiEf3Te4PDoYgp0FV6zMjgOUyOFkRyFv
        yCe4PFQWXNZllVIqDiuzmaNXWP3rtjk=
X-Google-Smtp-Source: AMsMyM58bp8zPmo0CWtz+rsIqJxfETY3oipP00NeQjvDVfJSrBkvp5u0mv3hg0aAsDwqjqhBI5tzhQ==
X-Received: by 2002:a05:6402:517c:b0:461:e7e7:c0b9 with SMTP id d28-20020a056402517c00b00461e7e7c0b9mr21955295ede.73.1666969141785;
        Fri, 28 Oct 2022 07:59:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090603c700b007ad86f86b4fsm2372710eja.69.2022.10.28.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:59:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooQp2-009ugk-0b;
        Fri, 28 Oct 2022 16:59:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] connected: allow supplying different view of
 reachable objects
Date:   Fri, 28 Oct 2022 16:54:56 +0200
References: <cover.1666967670.git.ps@pks.im>
 <a32e3d6146dd41af36f525a744d6cc099b42d6fb.1666967670.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <a32e3d6146dd41af36f525a744d6cc099b42d6fb.1666967670.git.ps@pks.im>
Message-ID: <221028.86bkpw805n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 28 2022, Patrick Steinhardt wrote:

> @@ -125,6 +125,13 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  
>  	rev_list_in = xfdopen(rev_list.in, "w");
>  
> +	if (opt->reachable_oids_fn) {
> +		const struct object_id *reachable_oid;
> +		while ((reachable_oid = opt->reachable_oids_fn(opt->reachable_oids_data)) != NULL)
> +			if (fprintf(rev_list_in, "^%s\n", oid_to_hex(reachable_oid)) < 0)
> +				break;

Just a style nit, we tend to avoid != NULL, != 0 etc. comparisons. I see
connected.c has some of that already, but for new code let's just check
truthiness.

Also for such a small scope a shorter variable name helps us stay at the
usual column limits:

	if (opt->reachable_oids_fn) {
		const struct object_id *oid;
		while ((oid = opt->reachable_oids_fn(opt->reachable_oids_data)))
			if (fprintf(rev_list_in, "^%s\n", oid_to_hex(oid)) < 0)
				break;

The fprintf() return value checking seemed a bit odd, not because we
shouldn't do it, but because we usually don't bother. For other
reviewers: We have that form already in connected.c, so at least locally
we're not being diligently careful, only to have it undone by adjacent
code...

Looks good!
