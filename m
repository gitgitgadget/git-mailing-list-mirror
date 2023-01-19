Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E09EC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 22:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjASWK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 17:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjASWKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:10:10 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3429DCA0
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:47:54 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id j9so2730975qtv.4
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85mo/Z5ATFE+38TOaeSA4og5uf9v+slLASOH5XfDPj4=;
        b=QCqYe4rsu8Wb11OHWnuyWOAw3+d8m+JU5kNuSzWlhqnZUSExzSbxNxFup70GUTVWcv
         WmfrSOw2+QdlhWAZ30b6oiapCeZp60xGqXwRcwXU0RSNCukUKrl66GDz2+zLJKLb4x57
         +aOskxpdjhy96ed2rbMVGwymCl4EdOV8XS4RS5KgVq0uBQRNlmj7ZJrSUWY/dZ6IH5QV
         VY9CkSUT4N4Fn4AqM0led+htFz1tuo8wGAJR+MxMq/c6O7i5rfv3Fh4aWv+DzwAPA7yd
         mZNMuze4xuEUlFoIWEWCNOvdskfdErgqxxFb8ZUUZSrHOthyoKDOH7rlxwhwe+3OiC3y
         g8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85mo/Z5ATFE+38TOaeSA4og5uf9v+slLASOH5XfDPj4=;
        b=NiaPmK2u7hlKe5hEAT5riQO4UAWL/xWrm2wVVM+xFGs/VYH0yiOc/Qt6eribY1/4Xc
         2rys7PCNKs7ikXOR1Ijv8/if0fzc5orfq8dUDkjxBoBH67yFOfzDqSpnv0aPX7tbAAtQ
         DdBrc9x8kzNTelizeuuHWRNL45cAnyzFhZITjap6o3ZRB4aoniYe62yyZ71wUGBmLZTo
         bxUuHHDEYTaZtixOLLLu062J2ZEBOAuDj00GCDxgeDJmP2Yr0LerSUil+FxP2NKxkBll
         kzj5tzPMl0tb4AQ11JGXRYxUaP0lIsbMEx1PdmKChj03EDfOEPNE2bjdLLlphleKLn7b
         ry/w==
X-Gm-Message-State: AFqh2kqLRX3vbX/0y0wwpNFqsQsnG4Xk4RnJQ+IFzOz63s8Kl+G2CS2E
        TqaifHSwpwa7tHHPKThVoqa/0YUYIViwv1M=
X-Google-Smtp-Source: AMrXdXsCrTWsZziX/8VcKamsqVymuCQGv+V6gcj7Ryd/ujuAqJCUNiDznDZGOPYkUDNlUKyv48yRcA==
X-Received: by 2002:a05:622a:4897:b0:3a5:3cb5:2485 with SMTP id fc23-20020a05622a489700b003a53cb52485mr20454953qtb.0.1674164874546;
        Thu, 19 Jan 2023 13:47:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:686c:2f5e:d9b:ebfe? ([2600:1700:e72:80a0:686c:2f5e:d9b:ebfe])
        by smtp.gmail.com with ESMTPSA id bi27-20020a05620a319b00b00706a1551428sm5434549qkb.6.2023.01.19.13.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 13:47:54 -0800 (PST)
Message-ID: <f480813c-7583-179f-0149-d970d3f2519f@github.com>
Date:   Thu, 19 Jan 2023 16:47:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] rebase: mark --update-refs as requiring the merge backend
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2023 12:36 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> --update-refs is built in terms of the sequencer, which requires the
> merge backend.  It was already marked as incompatible with the apply
> backend in the git-rebase manual, but the code didn't check for this
> incompatibility and warn the user.  Check and warn now.

Thank you for submitting this version.

> @@ -1514,6 +1514,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> +	if (options.update_refs)
> +		imply_merge(&options, "--update-refs");
> +

This solution is very elegant. The only downside is the lack of warning
if --update-refs was implied by rebase.updateRefs=true, but I'm happy to
delay implementing that warning in favor of your complete solution here.

Thinking ahead to that option, are there other options that are implied
by config that are required in imply_merge()? Is --autosquash in that
camp? If so, then maybe it would make sense to expand imply_merge() to
include a boolean config key and supply that warning within its
implementation. (This consideration should not block this patch, as it
is complete as-is.)

> While at it, fix a typo in t3422...and fix some misleading wording (all
> useful options other than --whitespace=fix have long since been
> implemented in the merge backend).

>  #
> -# Rebase has lots of useful options like --whitepsace=fix, which are
> -# actually all built in terms of flags to git-am.  Since neither
> -# --merge nor --interactive (nor any options that imply those two) use
> -# git-am, using them together will result in flags like --whitespace=fix
> -# being ignored.  Make sure rebase warns the user and aborts instead.
> +# Rebase has a useful option, --whitespace=fix, which is actually
> +# built in terms of flags to git-am.  Since neither --merge nor
> +# --interactive (nor any options that imply those two) use git-am,
> +# using them together will result in --whitespace=fix being ignored.
> +# Make sure rebase warns the user and aborts instead.
>  #

Thanks for the update here. The -C option is also used in this test,
so --whitespace=fix isn't the only option, right? At least, -C doesn't
make sense to port over to the merge backend, so maybe that's what
you mean by --whitespace=fix being the last one?

The user could also explicitly request the apply backend with --apply,
but this test script doesn't check it, strangely. That seems like an
oversight, but not a drawback to your patch.

>  test_rebase_am_only () {
> @@ -60,6 +60,11 @@ test_rebase_am_only () {
>  		test_must_fail git rebase $opt --exec 'true' A
>  	"
>  
> +	test_expect_success "$opt incompatible with --update-refs" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --update-refs A
> +	"
> +

Thanks for adding this test. I would delay the rebase.updateRefs
version until there is extra behavior to check, such as the
warning message.

Thanks,
-Stolee
