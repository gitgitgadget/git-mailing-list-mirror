Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C2AC433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 09:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiDCJfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 05:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiDCJfv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 05:35:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D0627CCC
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 02:33:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m30so10249119wrb.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I1avQivOLr4EeYDnVxInOfHpHEVTOD7vm3otWHlm3Pc=;
        b=H9wFKDFkQVFzTaibHGXevdsqORPw5sqp6jV/teItG2tW6zPxh2+5KW+4rPuOfPAfQs
         GR4pPftu+EGOd70RvDMIiixG91rUW9SKPB8ymoILHZiuwFY3WW/IQndRf+yyVXENio6r
         bmKeF7Dqv5MGwgycfsh218uIabdBtJX9Zn0VkyZDmYNMXfrn9UzK4NL4CI2YwiAa6j/Z
         jLuy0Vg0D8KrC+Q8crc7P/RJ8BNaJ8hVfjhzAjgooOWdb5Jg+3nluTYhguqgdQTsjtdu
         zObgoTfBH5h/qiabXFHfcYCVnjJoyeFdHY35I22cGWeU65oJ+N9TzzcLELJWv8JCmu6D
         Q6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I1avQivOLr4EeYDnVxInOfHpHEVTOD7vm3otWHlm3Pc=;
        b=aqEbdm2kBFe/cJpsYfNt3F+flsrj69Y7sFuzGCMesGT49ap57wOY7edGz6s1l1qanF
         VGBObTWUa/WP1jGUXEx6IumgiuB88eW6kf1CYllYa7z53PL5MTTRL/RRBWKnP9twc7eZ
         fSUBpJ/s9Mf/yJv8qJAbkXqAXKQqgx3pd3LhfsVrCJyS4XowY9K3PGZ2SmP791s8KlRr
         C4dLabtXMFxIPLB3ezrbGzfIJsIo5k9C+x81PktSXI9ExvTV40xERGKQWoFQOX3LI6NV
         rhAN8ffdK650TgzXikfsABTqRKxnTnlvU0o2FJYuqxU4xaYhY4NPG9EGT+CL0xoDer22
         ZdRQ==
X-Gm-Message-State: AOAM530iMWxWP5m6eDbJDnOae4WAaUKRtRczb9ndGx9QRPWsl/2nR0VQ
        SU1E839CpDqRh9Y70/JMqhI=
X-Google-Smtp-Source: ABdhPJz6AdwjdfWP4cKAr6xwZ83/OE+fKCWk2t2kHfFsLNYWs3DY6X6IkqI9jGv5IrvGQH+CF0Mp/g==
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id j73-20020adf914f000000b001edbb92d0ccmr13304452wrj.297.1648978435216;
        Sun, 03 Apr 2022 02:33:55 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d53cc000000b00205a0ee9c74sm6114797wrw.89.2022.04.03.02.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 02:33:54 -0700 (PDT)
Message-ID: <5044b964-0605-356c-3e03-1aad8cbbe619@gmail.com>
Date:   Sun, 3 Apr 2022 10:33:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 17/27] revisions API: have release_revisions() release
 "mailmap"
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-17.27-ca659940ee5-20220402T102002Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v5-17.27-ca659940ee5-20220402T102002Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 02/04/2022 11:49, Ævar Arnfjörð Bjarmason wrote:
> Extend the the release_revisions() function so that it frees the
> "mailmap" in the "struct rev_info".
> 
> The log family of functions now calls the clear_mailmap() function
> added in fa8afd18e5a (revisions API: provide and use a
> release_revisions(), 2021-09-19), allowing us to whitelist some tests
> with "TEST_PASSES_SANITIZE_LEAK=true".
> 
> Unfortunately having a pointer to a mailmap in "struct rev_info"
> instead of an embedded member that we "own" get a bit messy, as can be
> seen in the change to builtin/commit.c.
> 
> When we free() this data we won't be able to tell apart a pointer to a
> "mailmap" on the heap from one on the stack. As seen in
> ea57bc0d41b (log: add --use-mailmap option, 2013-01-05) the "log"
> family allocates it on the heap, but in the find_author_by_nickname()
> code added in ea16794e430 (commit: search author pattern against
> mailmap, 2013-08-23) we allocated it on the stack instead.
> 
> Ideally we'd simply change that member to a "struct string_list
> mailmap" and never free() the "mailmap" itself, but that would be a
> much larger change to the revisions API.

I agree it makes sense to leave that for now

> We have code that needs to hand an existing "mailmap" to a "struct
> rev_info", while we could change all of that, let's not go there
> now.
> 
> The complexity isn't in the ownership of the "mailmap" per-se, but
> that various things assume a "rev_info.mailmap == NULL" means "doesn't
> want mailmap", if we changed that to an init'd "struct string_list
> we'd need to carefully refactor things to change those assumptions.
> 
> Let's instead always free() it, and simply declare that if you add
> such a "mailmap" it must be allocated on the heap. Any modern libc
> will correctly panic if we free() a stack variable, so this should be
> safe going forward.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/commit.c                   | 5 ++---
>   revision.c                         | 9 +++++++++
>   t/t0056-git-C.sh                   | 1 +
>   t/t3302-notes-index-expensive.sh   | 1 +
>   t/t4055-diff-context.sh            | 1 +
>   t/t4066-diff-emit-delay.sh         | 1 +
>   t/t7008-filter-branch-null-sha1.sh | 1 +
>   7 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index c7eda9bbb72..cd6cebcf8c8 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1100,7 +1100,6 @@ static const char *find_author_by_nickname(const char *name)
>   	struct rev_info revs;
>   	struct commit *commit;
>   	struct strbuf buf = STRBUF_INIT;
> -	struct string_list mailmap = STRING_LIST_INIT_NODUP;
>   	const char *av[20];
>   	int ac = 0;
>   
> @@ -1111,7 +1110,8 @@ static const char *find_author_by_nickname(const char *name)
>   	av[++ac] = buf.buf;
>   	av[++ac] = NULL;
>   	setup_revisions(ac, av, &revs, NULL);
> -	revs.mailmap = &mailmap;
> +	revs.mailmap = xmalloc(sizeof(struct string_list));
> +	string_list_init_nodup(revs.mailmap);

This is a common pattern in one of the previous patches, is it worth 
adding helpers to allocate and initialize a struct string_list? Maybe 
string_list_new_nodup() and string_list_new_dup().

>   	read_mailmap(revs.mailmap);
>   
>   	if (prepare_revision_walk(&revs))
> @@ -1122,7 +1122,6 @@ static const char *find_author_by_nickname(const char *name)
>   		ctx.date_mode.type = DATE_NORMAL;
>   		strbuf_release(&buf);
>   		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
> -		clear_mailmap(&mailmap);
>   		release_revisions(&revs);
>   		return strbuf_detach(&buf, NULL);
>   	}
> diff --git a/revision.c b/revision.c
> index 553f7de8250..622f0faecc4 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2926,10 +2926,19 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>   	return left;
>   }
>   
> +static void release_revisions_mailmap(struct string_list *mailmap)
> +{
> +	if (!mailmap)
> +		return;
> +	clear_mailmap(mailmap);
> +	free(mailmap);
> +}

It's not a big issue but if there are no other users of this then it 
could just go inside release_revisions, my impression is that this 
series builds a collection of very small functions whose only caller is 
release_revisions()

Best Wishes

Phillip
