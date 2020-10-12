Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA10C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 15:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C90208B6
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 15:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5lt796f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbgJLPZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 11:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbgJLPZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 11:25:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57278C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 08:25:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y14so14578190pgf.12
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ph9osJw0o2ul8c9RtD9NNWZyf03TYLh5jRl/DqBIRoo=;
        b=o5lt796fm1I3RlMczyXvNMkeHpCScyn5bQpGGLLTawL5BkLzc7Z6zf8UiTrZPet9mF
         oOi/ec4PI36/Rj3h0wmQYh/BLKxM4KQR010A2qJgAAhXMfYWWIYvWTxaQb/RD9Lrd9DS
         Bb0V+w/Kr8VFp50J4pV/v6+Kf45AGY5aE0j20Ml+2MlMiYv/VInP1fsvdkV7zQhh6dd0
         DaT2Z2r/42T4kQIqwniT/rN7oqrSG/E9VAOw7HtzGjMj0cAv29EBYV6ZxqPqi2l9Qtxk
         6AHji3IQU9ZgSaxauH/H9h85YTFRCaO78bbezw//nJTV2/oQl3r5Okw5j2VYVzKtdQCx
         hQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ph9osJw0o2ul8c9RtD9NNWZyf03TYLh5jRl/DqBIRoo=;
        b=qf0vWRtnpNjLjdxCy/J2XHXw4+1wshd7bFag/ZFV3eHdIkwgOTRYyscOgh54Voy6OS
         rznn6qB6pTa/CPOHbFSBCY1jRIewE1t+H4GodiLnRt4Z6A7bKb9j6ZzYfF1iogRTfx+Q
         yqTPGZ7T8aUjmJqOdh+DZzfOHvDHy4OM/Hih156mytvm/L3QtahHCOQWewaQmsaAcpte
         oy+0jWie34A4m20+xVKnym6ynJr6maejyP9A4iwJUtkrt7vNYOtWkR8YjB8K3rZLvZJQ
         R+97TcmlOeHE5j/cwbOJn4TnNrpViS2k9AoXKwO33F59dw7ydfcHZRDyBPqTCpi1bBTW
         u5XQ==
X-Gm-Message-State: AOAM532qaWCyJPFOoNcP0nGRV4Ooushn203xgPAmemde7dTTl9ieo3k2
        ot4pGMmlUev2XlHDb523drU=
X-Google-Smtp-Source: ABdhPJzQwpa8h+b4JX3BzFL6WprC7B4Toz2jVcheb0xtC8JKo+4dr0HNl0sxRZdN1JMpDGjVvfOKaA==
X-Received: by 2002:a17:90a:c28f:: with SMTP id f15mr20150109pjt.143.1602516307859;
        Mon, 12 Oct 2020 08:25:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id g1sm20452891pfm.124.2020.10.12.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:25:07 -0700 (PDT)
Date:   Mon, 12 Oct 2020 08:25:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
Message-ID: <20201012152505.GB3740546@google.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
 <20201002041214.GE3252492@google.com>
 <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Patrick Steinhardt from libgit2)
Hi,

Han-Wen Nienhuys wrote[1]:
> On Fri, Oct 2, 2020 at 6:12 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Han-Wen Nienhuys wrote:

>>> +     reftable_free(a);
>>> +}
>>
>> Are there other callers that need custom free?
>
> The libgit2 folks requested the ability to set memory allocation
> routines, hence reftable_free().

Thanks.  Patrick or Han-Wen, can you say a little more about this use
case?  That would help with making sure we are making an API that
meets its needs.

For example, is a custom allocator something that would be set
globally or something attached to a handle?  If the former, would code
that uses xmalloc and free and gets #define-d away when used in
libgit2 work?  If the latter, what does the handle look like?

Thanks,
Jonathan

[1] context: https://lore.kernel.org/git/pull.847.git.git.1600283416.gitgitgadget@gmail.com/T/#r2337ddc80848c80f6c9699d904ab64d4297d2c54
