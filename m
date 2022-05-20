Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F251C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 17:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352309AbiETRnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbiETRnW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 13:43:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C032C129EE2
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:43:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j4so7266947edq.6
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TdRvTFfJAEXPJW5tN+T5rO20rH4Xjv2yZMe519ftEPs=;
        b=KAiM7Mrmd5ZQOrFgrmPuH9VsJJh02DMukSx2oWMUHNaUPVEDSug+5RGkOZ4hA4oWIT
         31lGb6mHVRiWEBtw3cXEmSprrFoAlgzUEWMhfPTK8tLf8yAeBmUWvpyxZCj7WJTV9/if
         pvlEmcjVqyQLVxF3sdyWqO8hzLjlWOBTwk/9qwRLM224qovZUnN8/T3JL0e/xDAHWS1c
         qzDnnZ2UEL3aySozayLLzn1ZlxKt0UOkHTSwU6a+3jVHJMMqt/22r4XPJes/Ah1Xhyv+
         6y+IRLuibGegnDHfejmO+tUkovX789dGKjTzsvYQrKCwR+pjRXSC6qcZo/9g//g3mQQn
         149w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TdRvTFfJAEXPJW5tN+T5rO20rH4Xjv2yZMe519ftEPs=;
        b=sdgTujlmuHVY8/5d9jyQ1LxubehpigiLJhBYnphn8S5VckqNb+Oc/FilQ5l9a1tRM+
         Jxy4HAp8pkbXw+Faq12JgJ/edhK78DFBCc85GrEhmvZsMF+YL0UdCaFYBG1y1lle+a33
         GiXkmZOWd0f51+mYhjfvPtGr9IYWsc0sqxWABUhxIC+5oycK9nDGvVBdFZPd5XIvEWZJ
         xbz4MNBojEuAI13V8nR70b7IKRLeRkWsnj/vGuuWK+fMUTl7pfsSXUdFeYWr6RcjUqIL
         rv5gnUXsSIpAF7DjVNXrcJSHwNptYwWZw0qbtK96Cjh8xHkywBmveNu140fvpGq5xNxH
         lTvg==
X-Gm-Message-State: AOAM531602jT8uCIA/uGnYWzhuYuAU8t45Yj32hnusMtTHvsNVSI/ajJ
        i2mz86rZds7anJkeXD8DRM8=
X-Google-Smtp-Source: ABdhPJyTNTbDikQP23a4rO9XzzRowxGKXsC8dPwmtj5qDr24TWywvCUbIkYoKH+cg0Nt+4AmOGG3/Q==
X-Received: by 2002:a05:6402:520c:b0:428:25e3:a1e4 with SMTP id s12-20020a056402520c00b0042825e3a1e4mr12268326edd.198.1653068599268;
        Fri, 20 May 2022 10:43:19 -0700 (PDT)
Received: from localhost ([2a02:2149:8a5a:2200:6b01:100f:2ae1:a37])
        by smtp.gmail.com with ESMTPSA id ig25-20020a1709072e1900b006f3ef214e7bsm3291600ejc.225.2022.05.20.10.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:43:18 -0700 (PDT)
Date:   Fri, 20 May 2022 20:43:10 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/15][GSoC] iterate dirs before or after their
 contents
Message-ID: <20220520174310.2worceevbqkqn6oo@compass>
References: <20220509175159.2948802-1-kioplato@gmail.com>
 <xmqqilqd8i33.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqilqd8i33.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/10 09:31AM, Junio C Hamano wrote:
> Plato Kiorpelidis <kioplato@gmail.com> writes:
> 
> > This is the second version of a patch series which implements pre-order and
> > post-order iteration over directories. In this version I use the new iteration
> > scheme to convert entry.c remove_subtree() function from using opendir/readdir/
> > closedir API to dir-iterator API.
> 
> This cover letter seems to be written specifically for those who
> have read v1.  It is not very advisable way to write your cover
> letter, unless you are aiming to shrink your reviewer base in each
> iteration.
> 
> Do not assume that everybody who didn't give reviews to the previous
> round is not interested in the topic.
> 
> Instead, at least repeat the justification and the motivation enough
> in each iteration to make it easier for those who were not involved
> in earlier rounds to join the discussion.
> 
> "implements pre-order and post-order" is "what" and not "why".  Even
> in this version, "convert remove_subtree()" is only a "what" and not
> "why".  The reviewers need to learn why helping these patches is a
> worthwhile thing to do before they decide to devote their time, so
> helping them would in return help your cause.
> 
> You highlighted the difference since the previous round very well
> (omitted here).  It would be very appreciated by those who were in
> the first round.  Keep up the good work ;-)
> 
> > I also didn't CC Michael and Matheus in this version, since they weren't
> > interested in v1 where I did CC them.
> 
> This is OK as long as the message goes to the list, but again, "no
> responses" should not be taken as more than "no information".
> Seeing no review comments from somebody on CC: is not a vote of "no"
> by the recipient (nor it is not a vote of "yes").
> 
> Thanks for working on the topic.

That's great advice, thank you. Indeed, I did assume the above. I'll
follow this up with a patch on how to write better cover letters in
the related section and file of Documentation/. I've seen these patch
series[1] and I've read through them in detail. I'll figure out how
to incorporate such information in them.

[1]: https://lore.kernel.org/git/pull.1226.v3.git.1652399017.gitgitgadget@gmail.com/

Thanks,
Plato
