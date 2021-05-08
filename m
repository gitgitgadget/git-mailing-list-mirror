Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B99C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 05:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6EA61456
	for <git@archiver.kernel.org>; Sat,  8 May 2021 05:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhEHFWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 01:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhEHFW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 01:22:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EACC061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 22:21:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s20so6278251plr.13
        for <git@vger.kernel.org>; Fri, 07 May 2021 22:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PuBHUKIk9XqJsMPg+ViKUeQP1tUWlG+bz6PVuLtubgQ=;
        b=Fo6cwKk6didR0wQGgWTTh1AYUEAZF3/AjJtmKZktdJ0HHl5nMAs9mrREmXUxGv3Da5
         MYx0/Fv639SWKmBH3matqlj+i9VPhFmVxAV/vXLn45kyBkvlZa01AjVK6Fc/TSfauoOf
         U+CL/v+UCDEtDC5UAxj64EQWbjerZnJ44sTVTq/xVBj7a3FuXkfXkNv6LQvp0iEwXyH/
         OBwSpHrsvpnoYqTSKV5E5nRP29HZ2utVb6tQRBc9lpA4PMVD93LKdTjAGBA13zYd9pnN
         swtbuQ2HxcaDrcP71zxmvclrDiUF3wcBZk+N2P/rzQK80MWtA8X59bMt7oJUbSravoQM
         +GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PuBHUKIk9XqJsMPg+ViKUeQP1tUWlG+bz6PVuLtubgQ=;
        b=reg89UFg4k3sLSeNjpLNebymOonHcdGPQJ5vVVTsuJ168RxPc/TByXury7nmu1mspD
         y0nDRXzGs5MzLNImNNFNA5VnZlzUbQE5EXjdFRvqWzNTutVbMh3z6kC8Zglri66jt1uU
         9teykIrWAM6Amg9HvqZrC8x6k86z3gkVurYPyX7gfcISN9r2uZ4WA5wUoMLwYXzJN3LU
         C8kUNgTsUi5WEoH+9YDGVZJTaemFOB+/8+TBGqYSu40XRIVd8clR7dENJsxZyuXGpNtl
         pdx39HxyeQkT+ELq+ow0MdXw301c6onLGsPMIiivvO3vkGtaxHJPA/T5eqtzgVemo/FH
         fmYg==
X-Gm-Message-State: AOAM530vym3TBHwrOrF3SYBjBuwYdq2PuPqRcriQDfFDMQD5CZno1oi/
        2FjxfwWu3ybQI7enrv4goan9CLQJ+8GxOA==
X-Google-Smtp-Source: ABdhPJwnlpmtPAQf0dV03pWrM9wU/CLfxSir1AMgh3PSJsIDvNCUIrGw4U71KEcRBAN2eVtMJySGXg==
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr26611240pjt.98.1620451287305;
        Fri, 07 May 2021 22:21:27 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id j29sm5842543pgl.30.2021.05.07.22.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 22:21:26 -0700 (PDT)
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
To:     Will Chandler <wfc@wfchandler.org>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, ps@pks.im
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
 <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
 <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
 <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
 <YJYTQYk5q8g6HaIm@mini.wfchandler.org> <YJYa+7yUyt2YD16r@mini.wfchandler.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <1bb65e54-a18d-852d-bb01-130cc57cce1b@gmail.com>
Date:   Sat, 8 May 2021 12:21:23 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJYa+7yUyt2YD16r@mini.wfchandler.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/05/21 12.00, Will Chandler wrote:
> Subject: [PATCH v2] refs: cleanup directories when deleting packed ref
> 
> When deleting a packed ref via 'update-ref -d', a lockfile is made in
> the directory that would contain the loose copy of that ref, creating
> any directories in the ref's path that do not exist. When the
> transaction completes, the lockfile is deleted, but any empty parent
> directories made when creating the lockfile are left in place.  These
> empty directories are not removed by 'pack-refs' or other housekeeping
> tasks and will accumulate over time.
> 
> When deleting a loose ref, we remove all empty parent directories at the
> end of the transaction.
> 
> This commit applies the parent directory cleanup logic used when
> deleting loose refs to packed refs as well.
> 
> Signed-off-by: Will Chandler <wfc@wfchandler.org>
> ---
>   refs/files-backend.c  | 12 ++++++------
>   t/t1400-update-ref.sh |  9 +++++++++
>   2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 119972ee16..49e6ee069a 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -45,10 +45,10 @@
>   #define REF_UPDATE_VIA_HEAD (1 << 8)
>   
>   /*
> - * Used as a flag in ref_update::flags when the loose reference has
> - * been deleted.
> + * Used as a flag in ref_update::flags when a reference has been
> + * deleted and the ref's parent directories may need cleanup.
>    */
> -#define REF_DELETED_LOOSE (1 << 9)
> +#define REF_DELETED_RMDIR (1 << 9)
>   
>   struct ref_lock {
>   	char *ref_name;
> @@ -2852,6 +2852,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
>   
>   		if (update->flags & REF_DELETING &&
>   		    !(update->flags & REF_LOG_ONLY)) {
> +			update->flags |= REF_DELETED_RMDIR;
>   			if (!(update->type & REF_ISPACKED) ||
>   			    update->type & REF_ISSYMREF) {
>   				/* It is a loose reference. */
> @@ -2861,7 +2862,6 @@ static int files_transaction_finish(struct ref_store *ref_store,
>   					ret = TRANSACTION_GENERIC_ERROR;
>   					goto cleanup;
>   				}
> -				update->flags |= REF_DELETED_LOOSE;
>   			}
>   		}
>   	}
> @@ -2874,9 +2874,9 @@ static int files_transaction_finish(struct ref_store *ref_store,
>   	for (i = 0; i < transaction->nr; i++) {
>   		struct ref_update *update = transaction->updates[i];
>   
> -		if (update->flags & REF_DELETED_LOOSE) {
> +		if (update->flags & REF_DELETED_RMDIR) {
>   			/*
> -			 * The loose reference was deleted. Delete any
> +			 * The reference was deleted. Delete any
>   			 * empty parent directories. (Note that this
>   			 * can only work because we have already
>   			 * removed the lockfile.)
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index e31f65f381..4506cd435b 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1598,4 +1598,13 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
>   	test_must_fail git show-ref --verify refs/heads/restart
>   '
>   
> +test_expect_success 'directory not created deleting packed ref' '
> +	git branch d1/d2/r1 HEAD &&
> +	git pack-refs --all &&
> +	test_path_is_missing .git/refs/heads/d1/d2 &&
> +	git update-ref -d refs/heads/d1/d2/r1 &&
> +	test_path_is_missing .git/refs/heads/d1/d2 &&
> +	test_path_is_missing .git/refs/heads/d1
> +'
> +
>   test_done
>

I ask to you: why did you send v2 patch as reply to v1?

Supposed that I interested to apply only this v2, instead of v1.
With this situation, I downloaded mbox for v1, which contains v2
patch as reply to v1. And git-am would instead apply v1 instead.

So why not send this v2 as separate message-id?

-- 
An old man doll... just what I always wanted! - Clara
