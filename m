Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C84BC4707F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26ECE613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhE1Bdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 21:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbhE1Bdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 21:33:53 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB9C0613CE
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:32:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j184so2686666qkd.6
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vyAV31cV3PvZDqSDE7+YeZooKZx/xDcN6j/i3DBoY20=;
        b=zTuC0Wf8VY6wPFyxuj98XGMem3VxvHu886aT8G8eQsRZ/BniHzfzjvYfe39Dbv8V1C
         9RDLpso9LSS3AKbqTqSd1+i43UnZTuxk7bYiOVuQCH7bMSADfAJJuibdkGXXxaJPR3Lk
         OudR7J1axe3gZhCaqfazh1Mcifure8N/cmRP2c8DUbjO5N1GBsSWMwiFu4CVkSfP6N2T
         JfFvYd+nIYnl4L5OQLXykUEYeaq9l/RtpIf7seOhi38wwGfENWbLb0cDo7VEwvrcbJPj
         cJ8QuKbJpAVBOj+NEERHGbeVEVj0LAtO3K/9TMPLINcgzNBYzcb6Etg2cJTXBd8SR+EY
         OHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyAV31cV3PvZDqSDE7+YeZooKZx/xDcN6j/i3DBoY20=;
        b=qiTaZTCXccKvIbhCHr0TCqMJgIx0ac6v/ZFYX6KMakpWbfr6wNJF/Vbf9U+49SG3ZV
         RddwMTv9umA8cpbetDNe+wBCqzXQxRTK4VKg2Bni0lD8P3aIjXXRGvgnv8DToMWo0Xmu
         Rro+8pSlsEcFGH0i6pBPz+8sOnEjTdhwPAr7L5S0FsByHwNqqTBn4wnWIbVYiSFrMMJg
         nthRXcRirPxl+OHLT+OWIZ8uTwVPGTMLSdbk/Y0bS4q0Lm/bYcQCmsJRQBVRcXXJ+ACk
         uJkodhGVfChew7DL60eRw5c62C+oteFW2M5LM9nG61fTXLBKQu3y1K2hD/1/ioo3ZMJD
         9T1A==
X-Gm-Message-State: AOAM530Wv7Bwto/oSbu3+2qE5ThkwXdceVyId8H19IQ9F3OjRy+I+1J2
        ukC7Te+uQLUYudeBOYPBDX3vPA==
X-Google-Smtp-Source: ABdhPJx2rg0yzF7y38HCIgYv2gvqPu076UTGVkRMEKvCzaQBqoSRy/R97J1KDYu7vvElULFvQ9Z8jw==
X-Received: by 2002:a05:620a:44c3:: with SMTP id y3mr1502636qkp.393.1622165538504;
        Thu, 27 May 2021 18:32:18 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e878:3e85:58af:261f])
        by smtp.gmail.com with ESMTPSA id b123sm2606661qke.87.2021.05.27.18.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 18:32:18 -0700 (PDT)
Date:   Thu, 27 May 2021 21:32:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/5] merge-ort: replace string_list_df_name_compare with
 faster alternative
Message-ID: <YLBIIL+yShDVlWo5@nand.local>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <5055dfce32815c8c8ec250457df389d4cd02ee12.1622104642.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5055dfce32815c8c8ec250457df389d4cd02ee12.1622104642.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 08:37:17AM +0000, Elijah Newren via GitGitGadget wrote:
> -static int string_list_df_name_compare(const char *one, const char *two)
> +static int sort_dirs_next_to_their_children(const void *a, const void *b)

I looked at the new implementation of this function (and
df_name_compare() to double check it) and am convinced that it's
correctness, with the exception of one question.

Some thoughts I had while trying to make sure this was all OK:

> +	const char *one = ((struct string_list_item *)a)->string;
> +	const char *two = ((struct string_list_item *)b)->string;
> +	unsigned char c1, c2;
> +
> +	while (*one && (*one == *two)) {
> +		one++;
> +		two++;
> +	}

Advancing 'one' and 'two' to point at either the end of 'a' (and the
same position within 'b'), or the first place where the two have
different characters. If 'b' is shorter than 'a', '*one != *two' will
terminate the loop (since '*two' will be NUL, and '*one' will not).

> +	c1 = *one;
> +	if (!c1)
> +		c1 = '/';
> +
> +	c2 = *two;
> +	if (!c2)
> +		c2 = '/';

Store off the last character of each, or '/' if we got to the end. Hmm,
is this right (the guard in 'df_name_compare()' read 'if (!c1 &&
S_ISDIR(mode1))'). Suppose both strings were "foo", then both c1 and c2
would be "/", and I think we would return -1.

That doesn't seem quite right to me. I think it *would* be right if we
checked the mode of each entry before assigning c1 or c2 to '/',
though. (Being generally unfamiliar with this area, I haven't looked to
see whether getting access to the modes of each entry at this point is
easy or not).

> +
> +	if (c1 == c2) {
> +		/* Getting here means one is a leading directory of the other */
> +		return (*one) ? 1 : -1;
> +	}

> +	else

I did find this spacing awkward (would have expected '} else' or even '}
else {'), but it hardly matters.

Thanks,
Taylor
