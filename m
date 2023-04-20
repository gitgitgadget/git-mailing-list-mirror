Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F142DC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 21:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjDTVPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 17:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTVPq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 17:15:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A544AF
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 14:15:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b5465fb99so1395642b3a.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 14:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682025344; x=1684617344;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abPmLX6WkXnXWKFF407mGmiyZF9mBguNaSYKMB/h7AM=;
        b=KJZp7SD7Dro17MDpK8T3ISBcbXuFyBvmOs0IaQfnmIofTYjaVorPwXMLNDNWHFWpJH
         gFP/oxCLko3/ZlyfoaWe2AWpikN2ptvrxenlKJSJpPHlVHLQdqeSZ1rUNXjFxDIMUi3x
         /vstuCU51gN3bBdmVpDURgrCJubn1g/W5JsVKpug2X7EsG4IrPlRlosXrRDBvWBIza6M
         5z/z3VmPDBAFXmDsEgvSmoaSsTL8FFe1mHWAlLH7gMQlouWvvKq2wP1Lyl3+R5iJEyox
         Jz9nrYBLwB4YTJrGP7ppd6WUtL8mrHQa7sg8dirha3yvnOxgh/DvUtA4DKs9klD8cFXP
         F1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682025344; x=1684617344;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abPmLX6WkXnXWKFF407mGmiyZF9mBguNaSYKMB/h7AM=;
        b=FnqCxLMdm8qmcIKh5O34gEog99vkIQGROjAUz6rHIOsXsOv9AlZN1SU3ov8On7JkIV
         Kc18tjcska5O3xTdD3DfmWFSNfqguRowu68gU+aDtcCAvBpfyDBzHFwr98hUjDoELlr3
         Mtt51JWDvE90CS8wjgiWuqmXAtm7z/+mHmCE7iiOrzaG8hi1Y9GRbmv3VyHaO+f2bCW1
         UIIHymZTlapKcTEL8MPvnMdLHmS60aXEfMHSQJaM7SN6WvFkTO+5IHaeuZ/D2knQOj8A
         SQXIKNmUMuzQvMS8cL9afKYb0zBkXvpRdc83nztsdi/6NsYgI7KkyxCChuy2KNNRS8PU
         tCJg==
X-Gm-Message-State: AAQBX9ejBM4z2pHFg9oZLF4kNxgiQjCyg8Fym9ZX6YDWebwL0SNMHP+R
        KNQ1Ny4VeXvxq6URQYss5Vc=
X-Google-Smtp-Source: AKy350YPCK+fILb8Dqv9KGqpsKVjCodrQToMuvrlr/FCxL750kgJ+2PpTQtXW9/q/af7njj/yLJj8Q==
X-Received: by 2002:a05:6a00:10c9:b0:63b:8b47:453c with SMTP id d9-20020a056a0010c900b0063b8b47453cmr3326468pfu.1.1682025344503;
        Thu, 20 Apr 2023 14:15:44 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7918f000000b0063b778f0952sm1662535pfa.70.2023.04.20.14.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 14:15:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] gittutorial: drop early mention of origin
References: <cover.1681579244.git.martin.agren@gmail.com>
        <36a8ede4c83ff6d88c9d49bd64f1546262934c55.1681579244.git.martin.agren@gmail.com>
Date:   Thu, 20 Apr 2023 14:15:43 -0700
In-Reply-To: <36a8ede4c83ff6d88c9d49bd64f1546262934c55.1681579244.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 15 Apr 2023 19:29:10
 +0200")
Message-ID: <xmqqr0sexnk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> We don't have an origin at this point in the tutorial, so "Your branch
> is up to date" won't actually show up in the output of `git status`.

True.  The example is a repository created out of a tarball extract
and not a clone of anything.

Will queue.  Thanks.

> diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
> index 0e0b863105..33dd5a2cba 100644
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -109,7 +109,6 @@ summary of the situation with 'git status':
>  $ git status
>  On branch master
>  Changes to be committed:
> -Your branch is up to date with 'origin/master'.
>    (use "git restore --staged <file>..." to unstage)
>  
>  	modified:   file1
