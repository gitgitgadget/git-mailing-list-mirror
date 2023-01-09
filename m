Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9EAC61DB3
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 15:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjAIPJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjAIPJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 10:09:37 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17470C7A
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 07:09:35 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c7so7969152qtw.8
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 07:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gp8gsH6jhcfXu380sOUTHbA64697ljnORhrhGAJ9+Zw=;
        b=GUbyOz5qVAvJ60kFub+TJRnnzdweorksizyi8qorWHK/w0fhGfA/BoeJ7Gfg+2R+HX
         I48VKK9xCj3DGpgSru4YzYu+oH9Kd5/aAy0t3jKM2RyAV15oew6079wQcvMDZR0GOY2d
         IXSHHvZudxnUo2ti51gqtdJv7TsfiLLnGTQLRWDK+r3sMFvO2/KxsPQJQUdVzNITYy+X
         TaEuq0GBKkYYmS1k+OQXU5pDsc8iy9XW2FY95TXsN1MteRy7JjcRsmZl7KpAa7e8GvXK
         m7L1GARviBHFkogNSvg+6fwhqfRsfKmT2qljWhj2n6vovcpQInSqihF0bCrox+XkwLVz
         c0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp8gsH6jhcfXu380sOUTHbA64697ljnORhrhGAJ9+Zw=;
        b=avSJW4KDpbFA8TiNqbiNOIXOSZZHTX7iXKDLZwX21zOBcKzwBuoofJG4Au5OPzAEXS
         nllFqCmTbVD7xlEwOOahF+Cyso+jGgfbMJPR7MOx7pqjrrcA+zOqXmr+BBh6PwWRyWgJ
         +rYi0QbxP4lj+rtOdgPYlwSRrX7aHEZfgNxeZRVH7W/rU5TOyHX0RZKENTRixjrnPqr0
         1QAVNleS9oUIaa2aUOm9HtXkLsC4YdhOwn1lbDwu9AXP9lNJIvj5O+2YV7gzUEqOPOA5
         UMgHOWYkWxlSb8YjHir33paA5eFXlD8FX6tUAAcPN7sP70GX0lfz8X2+ixIaRCV5zkEu
         VdPw==
X-Gm-Message-State: AFqh2krSHT3q3RsNNUKzY+0asogSySRATrus+2b3WZxmXntpwfNzFwCV
        KR2ayImHvCmxo6x0anx1qXPa
X-Google-Smtp-Source: AMrXdXu3pUclGbVfZXDCewIV6ZnNMaT3oOcdLKJhoWEM2Izh77gfyBdSDNnXDltUhrvsgMTL+EasMw==
X-Received: by 2002:ac8:4793:0:b0:3a8:1c63:7603 with SMTP id k19-20020ac84793000000b003a81c637603mr95241683qtq.57.1673276974848;
        Mon, 09 Jan 2023 07:09:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9803:bdc5:6740:d9fa? ([2600:1700:e72:80a0:9803:bdc5:6740:d9fa])
        by smtp.gmail.com with ESMTPSA id bp43-20020a05622a1bab00b003a68f5d98c1sm4631869qtb.93.2023.01.09.07.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 07:09:34 -0800 (PST)
Message-ID: <f1028cba-5fc6-3584-3f21-545550012e9d@github.com>
Date:   Mon, 9 Jan 2023 10:09:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/5] cleaning up read_object() family of functions
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2023 8:48 AM, Jeff King wrote:
> I often get confused about the difference between:
> 
>   - read_object()
>   - read_object_file();
>   - read_object_file_extended();
>   - repo_read_object_file();
> 
> Since Jonathan's recent cleanups from 9e59b38c88 (object-file: emit
> corruption errors when detected, 2022-12-14), these are mostly thin
> wrappers around each other and around oid_object_info_extended().
> 
> This series shuffles things around a little more so that we are down to
> just read_object_file() and repo_read_object_file(). And the
> relationship there is pretty easy (and long-term we'd eventually merge
> them once everyone has a repository object).

I read the patches carefully and the translations look correct and
definitely help with this confusing mess of method names.

> It is a net reduction in lines, even though some of the callers end up a
> little longer (because they have to stuff pointers into an object_info
> struct). If that's too distasteful, the middle ground is to have a
> helper like:
> 
>   void *foo(struct repository *r, const struct object_id *oid,
>             enum object_type *type, unsigned long *size,
> 	    unsigned flags)
>   {
> 	struct object_info oi = OBJECT_INFO_INIT;
> 	void *content;
> 
> 	oi.typep = type;
> 	oi.sizep = size;
> 	oi.contentp = ret;
> 
> 	if (oid_object_info_extended(r, oid, &oi, flags) < 0)
> 		return NULL;
> 	return content;
>   }
> 
> which is basically the same as read_object(), but makes it clear that
> you can pass OBJECT_INFO flags. The trouble is that I could not come up
> with a name for it that was not confusing. ;) So just having most places
> call oid_object_info_extended() directly seemed better. It would be nice
> if that function had a shorter name, too, but I left that for another
> day.

I did think that requiring callers to create their own object_info
structs (which takes at least four lines) would be too much, but
the number of new callers is so low that I think this is a fine place
to stop.

Thanks,
-Stolee
