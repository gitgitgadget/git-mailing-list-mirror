Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3442BC433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 15:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04AAF20748
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjZH15Pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHHPsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgHHPsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 11:48:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C95C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 08:48:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z18so4299921wrm.12
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5/TwQD5VAjIEVi7Hv9HIOofi2qGt57xUGTU84GSXIp0=;
        b=BjZH15Pch4/JzmynzAGZ+zxsgkfINbYNzsxZfD2crJi+LUMgKfsUCf8m1HQUm5oYow
         NI6Em3HYSXs2sihsdBd0Mq6GnWgEQWDmjZiYv9KHHGSaFCEVC6avDcleyCkA7ROPVEk2
         dJJ20gEosNVa2GZnM8QLsa6KCvDsIHOQk4199s9AREZfpXlrgm/2tvY1bPn1qMa/qHC0
         WLWfrXUmjkfSV06Mk/A/E0dti5Sgu+XhVgrJUDUX2k8LOz4E6Tbk4S77HMf4YxtBoV0f
         5jMIgta9c4NF+AWFj3/ElYnhvFkMAK8TGbNAEuSL8VAyMIHJAhrtwM+xVxbJmXU9UgIw
         w3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5/TwQD5VAjIEVi7Hv9HIOofi2qGt57xUGTU84GSXIp0=;
        b=tGXXJAmc04GBci0ETw7EUYJl5gn28X+hGZXPN+Ow60fpEmRsAdqzwwBfl+te+VLyov
         M9irmeuCLW4t5haB08wfi0ZQdWIziZL61E+ytPS5iWc21v16k+gSxGZxJsniWIjbkkbU
         iIwCnMsEtRMmC24sXuhb4eo7iw0tbfz7TbF8/h0BZFXSEznfkAAK9IgB+tltET4E7IBe
         hbHxSmRkG1k0yAQ85Ye7RFx225Ud27oJ6GBLwHYzetj1hJaJsPaUrZulfUBXIDGrAeUE
         RdvIXdLpvJDq1DXh34xxvnmI1pKq9LND3VPZRHQYs/rBOQjhFjJIkSqj9+mi5WO+jK6N
         UFRQ==
X-Gm-Message-State: AOAM5300dD40KSCs9KAFYj92TFacVhQELsiZSyHagdEHq21thHdZo5HZ
        0bQFLLULSNBeGfrf4sWqpvJKDabN
X-Google-Smtp-Source: ABdhPJxn17ZPz3roHzdmxWyttkmKFQGzVzhQPd3Wz3mp4YUrXRI4DvbpNd/6ObzoIixc52r0kVGqEQ==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr17834374wru.95.1596901685123;
        Sat, 08 Aug 2020 08:48:05 -0700 (PDT)
Received: from [192.168.1.240] (161.252.189.80.dyn.plus.net. [80.189.252.161])
        by smtp.gmail.com with ESMTPSA id m8sm14671294wro.75.2020.08.08.08.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2020 08:48:04 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 2/3] apply: make i-t-a entries never match worktree
To:     "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <C4RO9JSUGPKG.2UQX61X628B6P@ziyou.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d81e79a9-7d7f-22a0-9d53-06fb92b0af48@gmail.com>
Date:   Sat, 8 Aug 2020 16:48:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <C4RO9JSUGPKG.2UQX61X628B6P@ziyou.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Raymond

On 08/08/2020 15:07, Raymond E. Pasco wrote:
> On Sat Aug 8, 2020 at 9:46 AM EDT, Phillip Wood wrote:
>>> By definition, an intent-to-add index entry can never match the
>>> worktree, because worktrees have no concept of intent-to-add entries.
>>> Therefore, "apply --index" should always fail on intent-to-add paths.
>>
>> I'm not sure I understand the logic for this. If I run 'git add -N
>> <path>' and <path> does not exist in the worktree what's the reason to
>> stop a patch that creates <path> from applying?
> 
> "apply --index" requires the index and worktree to match, and applies
> the same path to both to get the same result in both. I brainstormed the
> logic a few emails upthread, and that's what's consistent with
> everything else.

I had a quick scan of the earlier email and found

 > The index and the filesystem are both able to represent "no file"
 > and "a file exists" states, but the index has an additional
 > state (i-t-a) with no direct representation in the
 > worktree. By (correctly) emitting "new file" patches when
 > comparing a file to an i-t-a index entry, we are setting down the
 > rule that a "new file" patch is not merely the diff between "no
 > file" and "a file exists", but also the diff between i-t-a and "a
 > file exists".
 >
 > Similarly, "deleted file" patches are the diff between "a file
 > exists" and "no file exists", but they are also the diff between
 > i-t-a and "no file exists" - if you add -N a file and then delete
 > it from the worktree, "deleted file" is what git diff (correctly)
 > shows. As a consequence of these rules, "new file" and "deleted
 > file" diffs are now the only diffs that validly apply to an i-t-a
 > entry. So apply needs to handle them (in "--cached" mode,
 > anyway).

If I've understood correctly an i-t-a entry in the index combined with 
nothing in the worktree is a deletion and that is why we don't want 
--index to succeed when applying a creation patch? If so an expanded 
explanation in the commit message to this patch would help rather than 
just saying 'by definition'. I'm still a bit confused as we don't count 
it as a deletion when using --cached or applying to the worktree.

>> I was relieved to see from the next patch that this does not affect
>> --cached even though the documentation says it implies --index. It might
>> be worth mentioning that in the commit message. Also it would be easier
>> to follow if the tests were in the same patch (this is what we usually
>> do).
> 
> --cached doesn't really imply --index - the docs are wrong and should be
> changed. If anything, --index is closer to implying --cached - but
> really, [no flags], --cached, and --index are three different modes with
> different behavior. (Just removing "this implies --index" would be
> sufficient to make the docs correct.)
> 
>> How this does it affect --check? `git add -p` uses --check to verify
>> that hunks that the user has edited still apply. It does not let the
>> user edit the hunk for a newly added file at the moment but that is
>> something I'm thinking of adding.
> 
> --check goes through all the same code, 

The same code as --cached or --index? (I assume it's the former but 
wanted to be sure)

Thanks

Phillip

>it just doesn't actually touch
> anything in the index or worktree. Splittable/editable new file patches
> are a logical related feature, IMO. (This is just to squash an error
> that shouldn't happen.)
> 
