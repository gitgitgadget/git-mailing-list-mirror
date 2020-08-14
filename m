Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9130C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 02:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E59120855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 02:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv3xdZxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHNC0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHNC0y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 22:26:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D9C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 19:26:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p25so7203834qkp.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 19:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3VpZEGpshxds49T+AZ2B5Nm1pfGJkt4tMdTMSCKbMr4=;
        b=Nv3xdZxs1HekosQhnCadMAAcmeNVaz4FhOnVbu4vv7L98lD4cKWIMFNrHXKw/Clng7
         FyNb69WIozdk0u1UHh+nIV/rsJvnysZ7r0zwADypq65Wn8Ru84ZorVc51fLhHGX/vp+d
         3bKh4CYV5MEddHqC7kg+VAyr7ut6p0p+fItwSDKBHgx+KGc8SgvBP95oxdrZjWTOJQVC
         yN9TdMKm9RkGnLqTi5CLU/uwX+QMcdoL1ANq32GcmBtUgLqUeqRrTaAsbwUCjpXICa6d
         yC/qScSDHrDtjxfwr3gpyR3beMd7DlA30j/jyshY1UdCo6mdjxgM7JR3WUjKnc1wc1FN
         pD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3VpZEGpshxds49T+AZ2B5Nm1pfGJkt4tMdTMSCKbMr4=;
        b=jA6Bt3/wj4jYMlafBHpsd3sYGz0mI+JGo+nMX7HWR66zLn8loelvfx3TITjhVaw6U7
         bOV6dCIZUX05uIi31IO8bBoCz/Q6yFFjws6MdGEPgk/KL1DQSuYzXoqr4l5iHTGABcrm
         +94S7yKwo03QkMxI+QzvMWD64t61bBcZEbJD/eISnHluW/L9wTTLT6DdcQDCoPeg3dHx
         S6UsbnOzG2eI3d0yzIvl3FyaKCK1ARRlqoH0/YAGXCfg+WKKDzORYBUr4sYoJSX9+cJd
         +2BtIGO/P7Xyr1tSoZdyv18BGsWtYY5T9/QT6lmC1WYuSss3Xk2pAVaZlOOc8JTo/wDT
         MguA==
X-Gm-Message-State: AOAM532KkyF+s08hGVXxqSH4aqrkrbI515npLyvm0Ub0L4fn8pQcTIal
        r3cXt3YbqHAkVdTmpfIi59A=
X-Google-Smtp-Source: ABdhPJyiw9i+xetxZgFzXxMkg6FaSQz9cquBaabx3t4m1opNIKGuw5qXrKA8qtV937rwZcQnWp1/vQ==
X-Received: by 2002:a37:9382:: with SMTP id v124mr161882qkd.391.1597372013604;
        Thu, 13 Aug 2020 19:26:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id d8sm8747362qtr.12.2020.08.13.19.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 19:26:53 -0700 (PDT)
Subject: Re: [PATCH 1/2] docs: document SHA-256 pack and indices
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <20200813224901.2652387-2-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ffb5868b-a1af-6f77-9900-aac530201cdc@gmail.com>
Date:   Thu, 13 Aug 2020 22:26:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200813224901.2652387-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2020 6:49 PM, brian m. carlson wrote:
> Now that we have SHA-256 support for packs and indices, let's document
> that in SHA-256 repositories, we use SHA-256 instead of SHA-1 for object
> names and checksums.  Instead of duplicating this information throughout
> the document, let's just document that in SHA-1 repositories, we use
> SHA-1 for these purposes, and in SHA-256 repositories, we use SHA-256.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/technical/pack-format.txt | 36 ++++++++++++++-----------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
> index d3a142c652..f4c8d94f73 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -1,6 +1,12 @@
>  Git pack format
>  ===============
>  
> +== Checksums and object IDs
> +
> +In a repository using the traditional SHA-1, pack checksums, index checksums,
> +and object IDs (object names) mentioned below are all computed using SHA-1.
> +Similarly, in SHA-256 repositories, these values are computed using SHA-256.
> +
>  == pack-*.pack files have the following format:
>  
>     - A header appears at the beginning and consists of the following:
> @@ -26,7 +32,7 @@ Git pack format
>  
>       (deltified representation)
>       n-byte type and length (3-bit type, (n-1)*7+4-bit length)
> -     20-byte base object name if OBJ_REF_DELTA or a negative relative
> +     base object name if OBJ_REF_DELTA or a negative relative
>  	 offset from the delta object's position in the pack if this
>  	 is an OBJ_OFS_DELTA object
>       compressed delta data
> @@ -34,7 +40,7 @@ Git pack format
>       Observation: length of each object is encoded in a variable
>       length format and is not constrained to 32-bit or anything.
>  
> -  - The trailer records 20-byte SHA-1 checksum of all of the above.
> +  - The trailer records a pack checksum of all of the above.
>  
>  === Object types
>  
> @@ -58,8 +64,8 @@ ofs-delta and ref-delta, which is only valid in a pack file.
>  
>  Both ofs-delta and ref-delta store the "delta" to be applied to
>  another object (called 'base object') to reconstruct the object. The
> -difference between them is, ref-delta directly encodes 20-byte base
> -object name. If the base object is in the same pack, ofs-delta encodes
> +difference between them is, ref-delta directly encodes base object
> +name. If the base object is in the same pack, ofs-delta encodes
>  the offset of the base object in the pack instead.
>  
>  The base object could also be deltified if it's in the same pack.
> @@ -143,14 +149,14 @@ This is the instruction reserved for future expansion.
>      object is stored in the packfile as the offset from the
>      beginning.
>  
> -    20-byte object name.
> +    one object name of the appropriate size.
>  
>    - The file is concluded with a trailer:
>  
> -    A copy of the 20-byte SHA-1 checksum at the end of
> -    corresponding packfile.
> +    A copy of the pack checksum at the end of the corresponding
> +    packfile.
>  
> -    20-byte SHA-1-checksum of all of the above.
> +    Index checksum of all of the above.
>  
>  Pack Idx file:
>  
> @@ -198,7 +204,7 @@ Pack file entry: <+
>          If it is not DELTA, then deflated bytes (the size above
>  		is the size before compression).
>  	If it is REF_DELTA, then
> -	  20-byte base object name SHA-1 (the size above is the
> +	  base object name (the size above is the
>  		size of the delta data that follows).
>            delta data, deflated.
>  	If it is OFS_DELTA, then
> @@ -227,9 +233,9 @@ Pack file entry: <+
>  
>    - A 256-entry fan-out table just like v1.
>  
> -  - A table of sorted 20-byte SHA-1 object names.  These are
> -    packed together without offset values to reduce the cache
> -    footprint of the binary search for a specific object name.
> +  - A table of sorted object names.  These are packed together
> +    without offset values to reduce the cache footprint of the
> +    binary search for a specific object name.
>  
>    - A table of 4-byte CRC32 values of the packed object data.
>      This is new in v2 so compressed data can be copied directly
> @@ -248,10 +254,10 @@ Pack file entry: <+
>  
>    - The same trailer as a v1 pack file:
>  
> -    A copy of the 20-byte SHA-1 checksum at the end of
> +    A copy of the pack checksum at the end of
>      corresponding packfile.
>  
> -    20-byte SHA-1-checksum of all of the above.
> +    Index checksum of all of the above.
>  
>  == multi-pack-index (MIDX) files have the following format:
>  
> @@ -329,4 +335,4 @@ CHUNK DATA:
>  
>  TRAILER:
>  
> -	20-byte SHA1-checksum of the above contents.
> +	Index checksum of the above contents.

I immediately got concerned and looked at the existing MIDX
format to see how we deal with hash length and the contents
missing in this diff are suitably vague about the hash-length:

  "The OIDs for all objects in the MIDX are stored..."

These changes are good.

Thanks,
-Stolee
