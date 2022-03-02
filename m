Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27D7C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 14:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiCBOdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiCBOde (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 09:33:34 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB4C2498
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 06:32:50 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id w7so1602623qvr.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 06:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HSl/4PV6/2LNGMyW01Jh/JppKCo/M4kUTX10TLsXY1c=;
        b=PnD+58LF1smFKvFa/yuS32pv0+IFl5Q6IVY9fuy58uGhlEBkuGm7KRPxwsxiQH0dPE
         a4mESLGpjGQ/UssfV3ypo+lhyO/W/k/ZCDqMZHnFG948tT/WNyk70cllsnJl9HTDL7ao
         +/QZtFejCz/IaQ8udr7U9ofvAQ6aSupjwabsCUXoOpmaTEAO+GzU4n533BvxILY03RA7
         s5ao5L/20nvPxiHHFVbKteCf5Gr6bGxIGLUcgwybTsWJEESITGPUMtiU4xQcUE27ZtKy
         DH9AVP881N3UryU2d5t21sLnVRq0EJpGaCtQWLq32aov6Q1bR1W2oi/rkicyu9YiKRTs
         Yp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HSl/4PV6/2LNGMyW01Jh/JppKCo/M4kUTX10TLsXY1c=;
        b=L3UJjXHu8yf3XGpKP+aQQrykpa54T7FvI51/R72CwA/4quxOD1enKpp44WQ7C/SM0d
         STg8UmIf4UzaqMsuQ7cRXSsPYn+0eG3B1MmUzjXk1qozl/GKD+2/tLixiTaBWgYTe8Gq
         vy011h6f5us9S52V2G40MyeBfTy1N1+u04iCjVkxj950E4kOOlI4NDt9hvrgkEewn/Cg
         dWD1V734rQq8rQeUddhamzwsYA5boAVb/TNy50v+jw0pGMZyvujDk3yWQJZu2jAncQGs
         ufD8GYfHCrrTi/31KBDTqZoAWDjbGaSv6/c9GUHSqnBVYr6iCVg1HT/jVlmTHoUO9jJz
         LcvA==
X-Gm-Message-State: AOAM532boHc4Gz6QOXFIt00gCO1A5xjn2+BPretkfuZM59Xg1SXGzwVi
        zEMZa8cDvC4Fb1SIZ9J9ieHd
X-Google-Smtp-Source: ABdhPJy7sCjaxDuWebtlzxPCL/AOmlNZaSUvTWvaqsnA7Dk42msCU5Q3JDE/y5t3rD2kiXXJtg3Pfw==
X-Received: by 2002:ad4:4561:0:b0:432:3a44:144f with SMTP id o1-20020ad44561000000b004323a44144fmr20691920qvu.101.1646231569963;
        Wed, 02 Mar 2022 06:32:49 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm8022513qka.80.2022.03.02.06.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 06:32:49 -0800 (PST)
Message-ID: <06ef2e2c-7048-1101-870a-4774a2dcd988@github.com>
Date:   Wed, 2 Mar 2022 09:32:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 5:20 PM, Taylor Blau wrote:
> When renaming a remote, Git needs to rename all remote tracking
> references to the remote's new name (e.g., renaming
> "refs/remotes/old/foo" to "refs/remotes/new/foo" when renaming a remote
> from "old" to "new").
> 
> This can be somewhat slow when there are many references to rename,
> since each rename is done in a separate call to rename_ref() as opposed
> to grouping all renames together into the same transaction. It would be
> nice to execute all renames as a single transaction, but there is a
> snag: the reference transaction backend doesn't support renames during a
> transaction (only individually, via rename_ref()).
> 
> The reasons there are described in more detail in [1], but the main
> problem is that in order to preserve the existing reflog, it must be
> moved while holding both locks (i.e., on "oldname" and "newname"), and
> the ref transaction code doesn't support inserting arbitrary actions
> into the middle of a transaction like that.
> 
> As an aside, adding support for this to the ref transaction code is
> less straightforward than inserting both a ref_update() and ref_delete()
> call into the same transaction. rename_ref()'s special handling to
> detect D/F conflicts would need to be rewritten for the transaction code
> if we wanted to proactively catch D/F conflicts when renaming a
> reference during a transaction. The reftable backend could support this
> much more readily because of its lack of D/F conflicts.
> 
> Instead of a more complex modification to the ref transaction code,
> display a progress meter when running verbosely in order to convince the
> user that Git is doing work while renaming a remote.

Thanks for this patch. It improves the user experience through
useful feedback.

> @@ -682,7 +686,8 @@ static int mv(int argc, const char **argv)
>  		old_remote_context = STRBUF_INIT;
>  	struct string_list remote_branches = STRING_LIST_INIT_DUP;
>  	struct rename_info rename;
> -	int i, refspec_updated = 0;
> +	int i, j = 0, refspec_updated = 0;

My only complaint is that 'j' is not informative enough here.

'j' as a loop iterator is good, but we aren't looping "on" j,
but instead tracking a progress_count across multiple loops.

Thanks,
-Stolee
