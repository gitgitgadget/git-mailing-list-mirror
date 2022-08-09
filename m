Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F633C00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 02:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiHICbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 22:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHICbe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 22:31:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976518E32
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 19:31:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so4552107plb.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 19:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qfjHmLWc3xPLkAOGDF3b5wbR+ZoA/rUH/5ty2ucWVH8=;
        b=TomDzbqVEIykXOFu7vL+dx4JdYfu58okiB1c8u+mLSHta331NiUU6Mwve4QIImnXjo
         n1/epvWWeXHdsmxcGwDtwrT/9IagS7jF84UinpV8nAEkCFisxYmy0XIIpbThG9UxJSQa
         NO+Q4JYfTdYP80i0dTd4av0jGe20+6QVCgCmvoeNRXCurl/1UaYfz+1KDdHUg78HvDS7
         jLUt1jVda6RtseBdpTqB6l376YmMNRYrR0mN06F2G4xPTFSJqpagoo5NTmAc3aTqvefN
         Mw9/oXSfTJsvxgakXvI8eGgDjfu5aa35kM4eyqksCRzKFX5S/47NQDXoWa1iezzepWM2
         WO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qfjHmLWc3xPLkAOGDF3b5wbR+ZoA/rUH/5ty2ucWVH8=;
        b=ogTjrdPSIP/82bG2yT0AznVgV/YFD7Q71HAtfNmz8/gmlchW/E5tc8OvCZcTocp4ga
         hw34MXSg0jG/K3DStpiApnmkdgKS3l3awYyms01d4M+ejaOtXv4LhdLEds/DXAFt6dc3
         rJuShBLsbMeuwupbU2Q0r94F4IWrgUnV6iJDjLk8A6jS9pyJ/nO4kLHGzR/UclTRSUsF
         guxpgB54QKPClZnZzfZLl1USAep4AKHq6p3CZ1tP85xQ+qaZ7CWLzMlb8Z0j4gUOBb2B
         2ywGq2a+wLCxMrfJOTqxcZF/pWBV5+jyDDA9ZL40MYHpN1f0sR8BVp1fPVoWBUH9rh9b
         mXtw==
X-Gm-Message-State: ACgBeo0yaJfWHgIRTkxz8fQXP/o6BRGUYd4q6ttemgQy1a/b7I/UOY+J
        1X1Zv6zDWfyH6h9yo8DXXLE=
X-Google-Smtp-Source: AA6agR5cL5ZYxB1eK89udDviHQDM61h1MGZOj3SCDdcx09T5IQss308GzafSPleNG8lN4l1yTLPFVw==
X-Received: by 2002:a17:903:2301:b0:16e:f916:22b4 with SMTP id d1-20020a170903230100b0016ef91622b4mr21042629plh.52.1660012293178;
        Mon, 08 Aug 2022 19:31:33 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902904600b0016bea74d11esm9386128plz.267.2022.08.08.19.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 19:31:32 -0700 (PDT)
Message-ID: <542b40f5-0c7f-5f3d-eb81-6b8e1ab8924d@gmail.com>
Date:   Tue, 9 Aug 2022 10:31:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/9] mv: check if <destination> is a SKIP_WORKTREE_DIR
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-5-shaoxuan.yuan02@gmail.com>
 <698b86d0-c906-9a9a-839e-71806ae41f2c@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <698b86d0-c906-9a9a-839e-71806ae41f2c@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/9/2022 7:41 AM, Victoria Dye wrote:
...truncated...
> It took me some time to understand what all of these (nested) conditions are
> doing; one suggestion I have (feel free to ignore it, since it's really just
> a matter of stylistic preference) is reduce some duplicate code/simplify the
> change a bit by moving the sparse directory check into the main "if-else"
> block:
Yes, I acknowledge this part is cluttered slightly ;)
> ------------->8------------->8------------->8------------->8------------->8-------------
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 4729bb1a1a..1c1b9559f6 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -203,10 +203,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>   	if (dest_path[0][0] == '\0')
>   		/* special case: "." was normalized to "" */
>   		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
> -	else if (!lstat(dest_path[0], &st) &&
> -			S_ISDIR(st.st_mode)) {
> -		dest_path[0] = add_slash(dest_path[0]);
> -		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
> +	else if ((!lstat(dest_path[0], &st) && S_ISDIR(st.st_mode)) ||
> +		 (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
> +		  empty_dir_has_sparse_contents(dst_w_slash))) {
> +		/* directory dest_path[0] exists on-disk or in the index */
> +		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
>   	} else {
>   		if (argc != 1)
>   			die(_("destination '%s' is not a directory"), dest_path[0]);
>
> -------------8<-------------8<-------------8<-------------8<-------------8<-------------
>
> It doesn't make for the prettiest condition (so your current approach might
> be better in terms of readability) but, to me, it creates a clearer
> distinction between the "if" and "else if" blocks (which handle the case
> where 'dest_path[0]' is a directory), and the "else" block (which handles
> the case where 'dest_path[0]' is a file).

I also find this way clearer! Thanks for the suggestion!

