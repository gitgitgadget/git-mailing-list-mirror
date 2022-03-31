Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3A5C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 02:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352509AbiCaCV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 22:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiCaCV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 22:21:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05FB66211
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 19:20:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x34so26524821ede.8
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 19:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0rfNWXLDsg0T8k6eEzuA7msX7BDa+yr7GzYO+7Y+lGM=;
        b=bbbBL6Dh9fyhAgFHTM3IM1eensDjLr/7l2i3rFWQOaLXexcfK5WfAj0XYTOHcu/723
         KsVd8P4o5vSKBDWmHfE35XNSK/H4VqIGxZSRFxa1J249bDymV3LxbMYpRqVmNpYLdb5m
         GUR1LU0f7xoUusgapk6tyCXMEyiNxA0PGLsFtEidiHLFIvj5e7/+9uIZ6oWq5fIEqK7q
         7NHPH7x7YrOFCk/7lO/ro00D6tzgyUisbpdstCO5IQo66jOFXrP20w8FvIOi0y9jaalp
         /3txGQ5+aE0FT50bVgJT/r0ZBBM5IZGnzJ69N/VjpovLnhIAGRYGu8j2NOfDXO0gcV5a
         DtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0rfNWXLDsg0T8k6eEzuA7msX7BDa+yr7GzYO+7Y+lGM=;
        b=ngykZCnnxezjzvikyOLss0jQiTMCXRhKJV8Tgt5q04dfclZDH1WWcLq7hL3Y6rOytA
         shKqvsYGBeqKOM7/aonSWWFuJrUNF38a3Puz8h599T6fBzRjn2TfBAD1m7dAXIkC3pbY
         trTm9ZyUS1ZkCj0UiJpiY7vxc+bPW7dTzc8ULx7NDep4g46vMHD9P+5rvKGMFtIH6ai2
         2NhwsFTJIFNHveIaUyAmXI1WFjJVZgeiu+lngk7ZvKTU79IQsk3nTzxEKnkHjX18e22n
         zKgPElS53lcV1LKaWZnVt5qq/3K32BASMF1znXQaQSZF/07Khlwgi/HYsSyTvi7VvJRo
         9GHg==
X-Gm-Message-State: AOAM532BCbn7WlC5HriFN1AiXbbf3u63S8M3tD6vqGf4wOybIc6274vx
        qkFYSrGF62taDhtNPS5JCulFLKphdF9wjA==
X-Google-Smtp-Source: ABdhPJxdlXzjBvZb2xeCvwPpO5h6cxfxTXyjOaVWmbVDe6mNNmeDBWrLXLe8aANDV6s824+iYkqRaQ==
X-Received: by 2002:aa7:d98f:0:b0:419:1200:91e0 with SMTP id u15-20020aa7d98f000000b00419120091e0mr14564179eds.145.1648693210457;
        Wed, 30 Mar 2022 19:20:10 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o17-20020a056402439100b0041938757232sm10754077edc.17.2022.03.30.19.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:20:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZkPx-0008ut-As;
        Thu, 31 Mar 2022 04:20:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/4] Importing and exporting stashes to refs
Date:   Thu, 31 Mar 2022 04:18:44 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-1-sandals@crustytoothpaste.net>
 <xmqqo81m51ux.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo81m51ux.fsf@gitster.g>
Message-ID: <220331.86h77esw12.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> brian m. carlson (4):
>>   object-name: make get_oid quietly return an error
>>   builtin/stash: factor out revision parsing into a function
>>   builtin/stash: provide a way to export stashes to a ref
>>   builtin/stash: provide a way to import stashes from a ref
>>
>>  Documentation/git-stash.txt |  29 +++-
>>  builtin/stash.c             | 324 ++++++++++++++++++++++++++++++++++--
>>  cache.h                     |   1 +
>>  object-name.c               |   6 +-
>>  t/t3903-stash.sh            |  52 ++++++
>>  5 files changed, 397 insertions(+), 15 deletions(-)
>
> Merged to 'seen', t3903 seems to have a handful of breakages.
> e.g. https://github.com/git/git/runs/5763421702?check_suite_focus=true

One is a segfault because of a missing STRBUF_INIT:
	
	diff --git a/builtin/stash.c b/builtin/stash.c
	index 7cab57bbe4b..92a1682941c 100644
	--- a/builtin/stash.c
	+++ b/builtin/stash.c
	@@ -1931,7 +1931,7 @@ static int do_export_stash(const char *ref, size_t argc, const char **argv)
	 	struct object_id *items = NULL;
	 	int nitems = 0, nalloc = 0;
	 	int res = 0;
	-	struct strbuf revision;
	+	struct strbuf revision = STRBUF_INIT;
	 	const char *author, *committer;
	 
	 	/*
	
