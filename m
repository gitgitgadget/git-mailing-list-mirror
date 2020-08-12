Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3476CC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3B6206B2
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNNyGx56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLN7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgHLN7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 09:59:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E55C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:59:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so2151166wrh.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3hmE1Ei8WLCbGsKJwHJBjSKgZEUo51vGl5zYeaJABis=;
        b=uNNyGx56xp6VsQu6W97SmtdWau5/5atFVqk2BGaXPLPLVYRxqUGyeaxDBUDUAovnPQ
         DMAGnUrt8omTIamKIU+G1qbL8jKCWjOiK5vJq2Aqh0T4FsdJBQuTZPx7Cy9v3JmG02Yk
         B17dM7t8X64s5JREPUD5GOJBAkM3rIqRKhncL+eXyhOm9Rqk0GmmwfXgnhUVbjEd+0PR
         GQdsdkY9wZkksQ42AnNajuWBLHeTG8tu0aP7O+i2CN9Y6kN9f/GoAT1OG0AMjeE860QE
         hpB15Kzs0vmGVh8IaW8UD122R49pBE+k8RM9qEqyLbwEnv2KWVgHhCsatC+6aohDRrvP
         7bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3hmE1Ei8WLCbGsKJwHJBjSKgZEUo51vGl5zYeaJABis=;
        b=T3WGNyRIwlsCVRs2kPbHwVY4KJ602E1HNPDARo9G9MAfQnR1SczjvWswD5hIJxg2+v
         pZ/HGFPmZmcyICIkyB3O2WniIGTKjW2SyRbQq/GY+LRqaRCgHLlD47cg3WmPYLMP86Vn
         YfcjSttys+lkmxci3iYBoMWtBv0o0meIKznv3aIfZ78ln7TZVESrwvoddzwxexY7ALzr
         PvHF8SDjfXPRZU+1+4x0jXJcNMPGbp5z65rdgs+tzjGYQTIk+tQcOecE4wwX7BctJ2QJ
         TJD7vqDPMD5Z2xqFBvnR13bu70DMakjCbrRDKvDgcnEVOSdKgLMgjc6XZSZS1p49jvrL
         7cCw==
X-Gm-Message-State: AOAM532mlq/L6+fLbPQmyRHRQxHgG7ODP5wmwGlqakM11UtnPtVh49lw
        StLu4IZWTvKsbi25alXTeNg=
X-Google-Smtp-Source: ABdhPJyZMp0P5SfrfZ4FxQCzNlUWU5+D0qpBMGKeEOrF0KrZQLd/oRH1+fuz89c3RJeztjbYBasOZA==
X-Received: by 2002:adf:f8c7:: with SMTP id f7mr36476465wrq.117.1597240758995;
        Wed, 12 Aug 2020 06:59:18 -0700 (PDT)
Received: from [192.168.1.240] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id g14sm3770200wmk.37.2020.08.12.06.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:59:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-apply.txt: correct description of --cached
To:     Junio C Hamano <gitster@pobox.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <C4RO9JSUGPKG.2UQX61X628B6P@ziyou.local>
 <20200810110338.52203-1-ray@ameretat.dev>
 <xmqqeeoecw4e.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fae30d82-788a-7c0b-d47d-6d9ac75d3e1b@gmail.com>
Date:   Wed, 12 Aug 2020 14:59:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqeeoecw4e.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2020 17:18, Junio C Hamano wrote:
> "Raymond E. Pasco" <ray@ameretat.dev> writes:
> 
>> The blurb for "--cached" says it implies "--index", but in reality
>> "--cached" and "--index" are distinct modes with different behavior.
>>
>> Remove the sentence "This implies `--index`." to make the description
>> accurate.
>>
>> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
>> ---
>>   Documentation/git-apply.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
>> index b9aa39000f..373a9354b5 100644
>> --- a/Documentation/git-apply.txt
>> +++ b/Documentation/git-apply.txt
>> @@ -72,7 +72,7 @@ OPTIONS
>>   --cached::
>>   	Apply a patch without touching the working tree. Instead take the
>>   	cached data, apply the patch, and store the result in the index
>> -	without using the working tree. This implies `--index`.
>> +	without using the working tree.
> 
> The updated text is not wrong per-se, but I have a feeling that this
> is barking up a wrong tree.  The implication is probably referring
> to the fact that "--index" does certain verification and "--cached"
> does the same (i.e. the patch must be applicable to what is in the
> index).  We may want to update the description for both options.
> 
> How about simplifying them like this, perhaps?

I think this is clearer, I've got one comment below

>   Documentation/git-apply.txt | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index b9aa39000f..92b5f0ae22 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -58,21 +58,18 @@ OPTIONS
>   --check::
>   	Instead of applying the patch, see if the patch is
>   	applicable to the current working tree and/or the index
> -	file and detects errors.  Turns off "apply".
> +	file and detects errors.  Turns off `--apply`.
>   
>   --index::
> -	When `--check` is in effect, or when applying the patch
> -	(which is the default when none of the options that
> -	disables it is in effect), make sure the patch is
> -	applicable to what the current index file records.  If
> -	the file to be patched in the working tree is not
> -	up to date, it is flagged as an error.  This flag also
> -	causes the index file to be updated.
> +	Apply the patch to both the contents in the index and in the
> +	working tree.  It is an error if the patched file in the
> +	working tree is not up to date.

I wonder if it would be clearer to say "This option requires the index 
entry for the patched file to match the working tree". Saying "if the 
patched file in the working tree is not up to date" does not say up to 
date with what and one could argue that it is the index that is out of 
date rather than the working tree if they don't match.

Best Wishes

Phillip

>   --cached::
> -	Apply a patch without touching the working tree. Instead take the
> -	cached data, apply the patch, and store the result in the index
> -	without using the working tree. This implies `--index`.
> +	Apply the patch only to the contents in the index but not to
> +	the working tree.  It is OK if the contents in the index
> +	and in the working tree are different, as the latter is
> +	never looked at.
>   
>   --intent-to-add::
>   	When applying the patch only to the working tree, mark new
> 
