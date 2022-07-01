Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BA0C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 09:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiGAJbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiGAJbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 05:31:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839365C9D2
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 02:31:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e28so2393664wra.0
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p2sxMHGI1HvUsfER1Dj+q8rJDXjAKrH46j3ityWD3pk=;
        b=HwzUGUCzCinDrlkmrq7ZTlWY41GCrJFE6G3edKsI8BQ9UYzW9loHN2a123pKt9LeH7
         NGI/Otgn9Kkwb6mtqAB1UJYQqVCiIt8Ta7JHHziYrNbZ/I3jr3ZrqdtkqlaM3bFBv2OK
         9mpIm/4H7Ov80pbF04p/9eyExj87J59au+05NBQHulxzGsI331HVbwzILcWe1pOsr6B5
         NVyzCEiVwV1/JrZlwz+vkmt4+HadU5RZdyVlyPNZGav7DeDYqXzfayi+urXy2dDmd/b7
         VnefLLfyS0taEeb8KmV1RbJcZvWi9pjtTzE23jOZZkcLsHD4m9SCq/CQxXqa0ZdPrc5o
         pe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p2sxMHGI1HvUsfER1Dj+q8rJDXjAKrH46j3ityWD3pk=;
        b=YFNKLqvSIG3dUqQ9ZFbn9rBne9RPzVkwARk9JCTZcT1v9mZ4zu3eiCsSZsncSNVni+
         dfOC+xhPk45JE1fYUxHuE2kgfAza/bnvGKkolIXa11UGZ0Z64ryDE9XTOtJ60x06ojZR
         yGObNwVhKAi3bxxW1RvAiv5pS63IuVPdPWAuFo8UpshM20dbotFYJrqSzBBPXNCBji6w
         5rdf03CAv/fcank6PNvnNkg5DnWa/JhrViRlhcqMj8NJVuHSJkqeQm8pdMzunx0FzXiD
         +yW42O2ILXolYC1kQVC4mvftXaZZ3tzp6Qs5frMoUScQ/UaR8b94MmQVxWLZT4nKxC8W
         JIGw==
X-Gm-Message-State: AJIora8jMTNyWSVerFuptdFy0p4Kj0xPnNVnCERJ3jjN7Y1HkQAGIYvQ
        ffgg2Cd18d3aT5u5Tz/mygy66KutXak=
X-Google-Smtp-Source: AGRyM1sJkcAZ1rynq1slv7+s+LGobs7u0QoztH+C9QfZIV0TujNeKFKckqhMF/LbjSi6001/P5RsdQ==
X-Received: by 2002:adf:e0c9:0:b0:21b:8271:2348 with SMTP id m9-20020adfe0c9000000b0021b82712348mr11793173wri.222.1656667867001;
        Fri, 01 Jul 2022 02:31:07 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id y15-20020a5d4acf000000b0021b9c520953sm21873807wrs.64.2022.07.01.02.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:31:06 -0700 (PDT)
Message-ID: <bee9eb82-6c6a-6467-37d1-d3797c583929@gmail.com>
Date:   Fri, 1 Jul 2022 10:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 7/8] rebase: update refs from 'update-ref' commands
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 28/06/2022 14:25, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The previous change introduced the 'git rebase --update-refs' option
> which added 'update-ref <ref>' commands to the todo list of an
> interactive rebase.
> 
> Teach Git to record the HEAD position when reaching these 'update-ref'
> commands. The ref/OID pair is stored in the
> $GIT_DIR/rebase-merge/update-refs file. A previous change parsed this
> file to avoid having other processes updating the refs in that file
> while the rebase is in progress.
> 
> Not only do we update the file when the sequencer reaches these
> 'update-ref' commands, we then update the refs themselves at the end of
> the rebase sequence. If the rebase is aborted before this final step,
> then the refs are not updated.

This looks good, I've left a few comments but it seems basically sound 
to me.

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   sequencer.c                   | 114 +++++++++++++++++++++++++++++++++-
>   t/t3404-rebase-interactive.sh |  23 +++++++
>   2 files changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 915d87a0336..4fd1c0b5bce 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -36,6 +36,7 @@
>   #include "rebase-interactive.h"
>   #include "reset.h"
>   #include "branch.h"
> +#include "log-tree.h"
>   
>   #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>   
> @@ -148,6 +149,14 @@ static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
>    */
>   static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>   
> +/*
> + * The update-refs file stores a list of refs that will be updated at the end
> + * of the rebase sequence. The 'update-ref <ref>' commands in the todo file
> + * update the OIDs for the refs in this file, but the refs are not updated
> + * until the end of the rebase sequence.
> + */
> +static GIT_PATH_FUNC(rebase_path_update_refs, "rebase-merge/update-refs")
> +
>   /*
>    * The following files are written by git-rebase just after parsing the
>    * command-line.
> @@ -4058,11 +4067,110 @@ leave_merge:
>   	return ret;
>   }
>   
> -static int do_update_ref(struct repository *r, const char *ref_name)
> +static int write_update_refs_state(struct string_list *refs_to_oids)
> +{
> +	int result = 0;
> +	FILE *fp = NULL;
> +	struct string_list_item *item;
> +	char *path = xstrdup(rebase_path_update_refs());

This is leaked

> +	if (safe_create_leading_directories(path)) {
> +		result = error(_("unable to create leading directories of %s"),
> +			       path);
> +		goto cleanup;
> +	}
> +
> +	fp = fopen(path, "w");
> +	if (!fp) {
> +		result = error_errno(_("could not open '%s' for writing"), path);
> +		goto cleanup;
> +	}

Can we use fopen_or_warn() here? It ignores ENOENT and ENOTDIR but I 
don't think that should matter here.

> +
> +	for_each_string_list_item(item, refs_to_oids)
> +		fprintf(fp, "%s\n%s\n", item->string, oid_to_hex(item->util));
> +
> +cleanup:
> +	if (fp)
> +		fclose(fp);
> +	return result;
> +}

> +compare_two_refs () {
> +	git rev-parse $1 >expect &&
> +	git rev-parse $2 >actual &&
> +	test_cmp expect actual
> +}

This is just test_cmp_rev

> +test_expect_success '--update-refs updates refs correctly' '
> +	git checkout -B update-refs no-conflict-branch &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~3 &&
> +	git branch -f third HEAD~1 &&
> +	test_commit extra2 fileX &&
> +	git commit --amend --fixup=L &&
> +
> +	git rebase -i --autosquash --update-refs primary &&
> +
> +	compare_two_refs HEAD~3 refs/heads/first &&
> +	compare_two_refs HEAD~3 refs/heads/second &&
> +	compare_two_refs HEAD~1 refs/heads/third &&
> +	compare_two_refs HEAD refs/heads/no-conflict-branch
> +'

Do we need a new test for this or can we just check the refs at the end 
of one of the tests added in the last patch?

>   # This must be the last test in this file
>   test_expect_success '$EDITOR and friends are unchanged' '
>   	test_editor_unchanged

I forgot to say on the last patch but you could maybe add a 
test_editor_unchanged at the end of t2407 now that there are tests which 
call test_set_editor

Thanks for working on this, it will be a really useful addition to rebase.

Phillip

