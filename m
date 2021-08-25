Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4FDC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9C861026
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhHYXxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhHYXxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:53:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D428C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:52:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g21so1695823edw.4
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qEvVcNZIaV19PhwTnyefq4qoLmyqZvOfmdmNWI9QhSM=;
        b=KXu05Hhsr2X+1gJWwG7ccGK5rS1ooOK9FFUBjps5yo1aZZrceSMHUhT38u52ivzT1O
         V0+QmlHEbp0mxXEaOn1376qZ/Mp4HKHdbNmLLuLvx40dZS7xKN4cd5mCQehXXhd1tJsa
         HsMweJbbnHB24249HYrvVuelhjkvUuHL7WjVhrL9A3PUbTEfJgP7vcGa99hXfJhIa2GH
         bLdwO13fo8qJINM7cDnv/6vwIdRgu8vMVfiv9gr0DTROGMm1la31U7Zo2cmW9jNam9q/
         f5Sw8yrhxP7M1ANx/ZDf2JjaQG3Ftzb31TdhogR23PFb+tsv66BUuLCh2kCC3+fDCIPu
         jiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qEvVcNZIaV19PhwTnyefq4qoLmyqZvOfmdmNWI9QhSM=;
        b=V3sgbQxle1gLGMj7goZMzH+FXj8VVxKo0duT61xFgNLG+alLGEqxJc0RharNlb/mjH
         vaUkHVEvC9J72Bz6jOuzPK0k8xVzm/4NNOzp9je1W5FxEzdsCfBJVx9PFDIK6x0/rUPw
         oJWuVy0EyW+pPVfgljXDHVMIFLVkWKH4UccYNHBPtr6JXfJA9bOOY/ZLRKmvbBS5e9lc
         hWUU55JvDvBFcfc5O0QWe+H6nh6I89Va9xIIE47fcgI+vBqCDkQjQv2pFH9NGqsCrZ5U
         1+8t3APSruXcsqYcRxSc5Wrtb+zAo3Em2pFI/SXBMm/XzE0Eo4/nRVFaJh8xLrwhwgoG
         IFvw==
X-Gm-Message-State: AOAM531wd7hzJWsyQyPQI2YJbn+WcohgabVRxamzgNO5dMVdMDlJLczw
        gisM2QfRfIoLebhmny3+hGY=
X-Google-Smtp-Source: ABdhPJzIJ67Tm4pjg/VI2DRb7mVVQP80rLC+O1apzk3RwtccK35pj0QAVpjkEoWMtf9+qNlIEtgRfw==
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr1117043edb.286.1629935541897;
        Wed, 25 Aug 2021 16:52:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i11sm692908edu.97.2021.08.25.16.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:52:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v5 05/14] packfile-uri.txt: support for excluding
 commits and trees
Date:   Thu, 26 Aug 2021 01:52:11 +0200
References: <cover.1629805395.git.dyroneteng@gmail.com>
 <8e5bf4010cb0d7e8b4f6c7285fe1f5365af955e8.1629805396.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <8e5bf4010cb0d7e8b4f6c7285fe1f5365af955e8.1629805396.git.dyroneteng@gmail.com>
Message-ID: <8735qxccay.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Teng Long wrote:

>  Client design
>  -------------
> @@ -65,9 +78,6 @@ The protocol design allows some evolution of the server and client without any
>  need for protocol changes, so only a small-scoped design is included here to
>  form the MVP. For example, the following can be done:
>  
> - * On the server, more sophisticated means of excluding objects (e.g. by
> -   specifying a commit to represent that commit and all objects that it
> -   references).
>   * On the client, resumption of clone. If a clone is interrupted, information
>     could be recorded in the repository's config and a "clone-resume" command
>     can resume the clone in progress. (Resumption of subsequent fetches is more
> @@ -78,4 +88,4 @@ There are some possible features that will require a change in protocol:
>  
>   * Additional HTTP headers (e.g. authentication)
>   * Byte range support
> - * Different file formats referenced by URIs (e.g. raw object)
> + * Different file formats referenced by URIs (e.g. raw object)
> \ No newline at end of file

Newline churn?
