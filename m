Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730541F404
	for <e@80x24.org>; Thu,  5 Apr 2018 18:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeDESgr (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 14:36:47 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42481 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeDESgr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 14:36:47 -0400
Received: by mail-vk0-f65.google.com with SMTP id m72so3006901vkh.9
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p4LcegwP85dKm7/wVHXY5J9hpmC6cOFaMNmTcV8GMNk=;
        b=axERcfWDU0VeJJuM5u995HdhzN4c0dS0XztJjA/AuFj9Tocs5z28jSG6fUuvV6XXxZ
         qe1EL7Lu+G4m3XSza8FBvdojMBiHQWpNO+lAv99A4lBXU/8SAdILu8fNR7mcZ3roaeXS
         dwWMRXZUMK/aALfFFgJAbKXdiCDNGec/hhmIH/lslZdiLPnQbviKfHwPNG++KYZgE81e
         C/QVlkz5Ij7rLk6l/oXdQ2p/YM9cCZRDLXXeVkZ0f0Ow7BbcNy62F18kC5J0JandMSp4
         mTiA8yKd4ZrA9SkjGfWKqZXpUCI8ySL5RZdQ3F1gh/GTzdyR0dVNsxjVljd1ZBnlea5+
         vfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p4LcegwP85dKm7/wVHXY5J9hpmC6cOFaMNmTcV8GMNk=;
        b=biZi7j96oeD/sa74egAmpWFpbWE74lJooLsUKzbATNmWryPjijpIDED80xozX760ZS
         HnFcRsxae6oRGCGi2Y6tMggjDHxU4CFGplvyfy4DGrg41KswUIsoJ0I5uQiw4EVdf9I9
         hJ3ec85GEQ9a0c+8X4VeT5va1YN5zqH5/ahiCa8Mzp0OsIBCbflDbap25dp+PEJI1gSv
         9dErgnhWsC6Wh+rhfychtOgLWj+B5RSeghivQNewRFinkQ7K7m2XMBa92TkPYCr47aG+
         Vp7a27RD9M7hL2O5uUJgoGRmB1aK3mLm0wAOYxCbCLVyIbpwOtTsPeQMNkfJS2PEsfzk
         8u2Q==
X-Gm-Message-State: ALQs6tAKnoAK2vaPNAb0As3RgqFxAm44sdUfNS6bHd6NkbJ/ICghhYAZ
        vcFVbxNaS4znUVEa8lBhujpqTpXd9YD0ypydnAE=
X-Google-Smtp-Source: AIpwx497t6wSmlHPTKpmio3mVpXFc2yfiHVhyd7/kC313oaXxzXxs2espl0aU9IgRvSeyeMnuZdkld6tbCfiG+e1w88=
X-Received: by 10.31.150.143 with SMTP id y137mr2955393vkd.118.1522953406068;
 Thu, 05 Apr 2018 11:36:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Thu, 5 Apr 2018 11:36:45 -0700 (PDT)
In-Reply-To: <20180405174925.GA19974@sigill.intra.peff.net>
References: <20180405173446.32372-1-newren@gmail.com> <20180405173446.32372-3-newren@gmail.com>
 <20180405174925.GA19974@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 Apr 2018 11:36:45 -0700
Message-ID: <CABPp-BERWUPCPq-9fVW1LNocqkrfsoF4BPj3gJd9+En43vEkTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] dir.c: fix off-by-one error in match_pathspec_item
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>, sxlijin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 10:49 AM, Jeff King <peff@peff.net> wrote:
>> diff --git a/dir.c b/dir.c
>> index 19212129f0..c915a69385 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -384,7 +384,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
>>       if (flags & DO_MATCH_SUBMODULE) {
>>               /* name is a literal prefix of the pathspec */
>>               if ((namelen < matchlen) &&
>> -                 (match[namelen] == '/') &&
>> +                 (match[namelen-1] == '/') &&
>>                   !ps_strncmp(item, match, name, namelen))
>>                       return MATCHED_RECURSIVELY;
>
> Do we care about matching the name "foo" against the patchspec_item "foo/"?
>
> That matches now, but wouldn't after your patch.

Technically, the tests pass anyway due to the fallback behavior
mentioned in the commit message, but this is a really good point.  It
looks like the call to submodule_path_match() from builtin/grep.c is
going to be passing name without the trailing '/', which is contrary
to how read_directory_recursive() in dir.c builds up paths (namely
with the trailing '/'). If we tried to force consistency (either
always omit the trailing slash or always include it), then we'd
probably want to do so for match_pathspec() calls as well, and there
are lots of those throughout the code and auditing it all looks
painful.

So I should probably make the check handle both cases:

@@ -383,8 +383,9 @@ static int match_pathspec_item(const struct
pathspec_item *item, int prefix,
        /* Perform checks to see if "name" is a super set of the pathspec */
        if (flags & DO_MATCH_LEADING_PATHSPEC) {
                /* name is a literal prefix of the pathspec */
+               int offset = name[namelen-1] == '/' ? 1 : 0;
                if ((namelen < matchlen) &&
-                   (match[namelen] == '/') &&
+                   (match[namelen-offset] == '/') &&
                    !ps_strncmp(item, match, name, namelen))
                        return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
