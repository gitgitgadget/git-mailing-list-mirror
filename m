Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB29C77B7F
	for <git@archiver.kernel.org>; Fri, 19 May 2023 04:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjESEIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 00:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESEIh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 00:08:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E3A10CF
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:08:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba81cb5775bso392984276.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684469315; x=1687061315;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=vgzBOJ1iB0Xx5o3tQVEiAjqVFfncQ3FMPpb+3RS8CvE=;
        b=oTi3h5xT5OM5sy6gSQBxIcyOSOc287T2tRybh+dmPfD3YN/eIkL2CSCkpoa4ConFB+
         GchV9egm/HbyUBXVGWYBp6oYjlYuTZZkvBxUUX3wU6Jux/4FoPz7a+mgzAGBSuain8ri
         XHEKrI0hTjX5Ey+ZuItzDm8Oc+rD8n+es+qpmNbGjUpKyHjQVrDGHfTX4owtkyVDmoMd
         Tc/VaiJ1ERM8I0hRcQMh/53eAYS8p7K//cAdmjE+bO4X9T2BFoMdLaMCCYWCIdGEPi/5
         d+LaLCijemBM/4ilDlPm8SrBNi52LGf0eu1dHpyVycx+KBIIw89IjInZes6O5EuiG2gj
         EBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469315; x=1687061315;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgzBOJ1iB0Xx5o3tQVEiAjqVFfncQ3FMPpb+3RS8CvE=;
        b=jVjUwpVxxy3T+I3KGEQL1e1Jng0c17nXKdWyqJAYQK+RZQjcEcZjH+yGM/WAixindI
         dPmak7QE5knCIYVu0FPtdlnh1LXr2MtI6THtZ/cvkvZT/l0c6AV8NLyPjwGhrAAwyURe
         Q9mzizDuNyKwRifWejBEIE+xJ65/K20lh5lZmWLEcwx8GUlk8LbfKJPMem2lgd2yGVC9
         f9HZb719y0+sbkHLZLQA3fATJKLlfdSiiTWE+9yiWE9IccFUo+z6o/2RQTvKRop8jcYH
         wgraskFIaNAQqMiOJpdfzaUBJ/udpg9e7RpfIV9IpX8E/Kk2dDHasj2VAjBJKb46QhD8
         eWhg==
X-Gm-Message-State: AC+VfDyb20+nqoKiCBl3ZCdaqZC8/15jpt0FYhT/Bj9atcGRYnDuUxZN
        XrXIx/f39VFm+A3IpUtoOq4=
X-Google-Smtp-Source: ACHHUZ6Tr/wW4GmgnoXFOfmP0nnNAlJYnS7ft/V+my4cXmEOs3TvtXJ/jITyJ2zL7yA9MJL81aSg2Q==
X-Received: by 2002:a25:d382:0:b0:ba7:8562:33b6 with SMTP id e124-20020a25d382000000b00ba7856233b6mr1230762ybf.1.1684469314934;
        Thu, 18 May 2023 21:08:34 -0700 (PDT)
Received: from epic96565.epic.com ([2620:72:0:6480::10f])
        by smtp.gmail.com with ESMTPSA id h14-20020a816c0e000000b0055a7ff0a5cdsm899505ywc.27.2023.05.18.21.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:08:34 -0700 (PDT)
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
 <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
 <de57b8aa563f20b45e18dbe45abaa14a2971da13.1684152793.git.gitgitgadget@gmail.com>
 <xmqqfs7x8iu4.fsf@gitster.g>
User-agent: mu4e 1.11.1; emacs 29.0.91
From:   Sean Allred <allred.sean@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Subject: Re: [PATCH v3 6/6] ls-remote doc: document the output format
Date:   Thu, 18 May 2023 23:04:07 -0500
In-reply-to: <xmqqfs7x8iu4.fsf@gitster.g>
Message-ID: <m0y1llt133.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:
>> +OUTPUT
>> +------
>> +
>> +The output is in the format:
>> +
>> +------------
>> +<oid> TAB <ref> LF
>> +------------
>> +
>> +When `<ref>` is a tag, it may be followed by `^{}` to show its peeled
>> +representation.
>
> While I can guess what the above wants to say, the above does not
> quite "click" for me for some reason.  Here is my attempt.
>
>     When showing an annotated tag, unless `--refs` is given, two
>     such lines are shown, one with the refname for the tag itself as
>     <ref>, and another with <ref> followed by `^{}`.  The `<oid>` on
>     the latter line shows the name of the object the tag points at.

This is clear to me, too (even reading it late at night -- kudos), so
I've adopted your suggestion verbatim with a few minor formatting nits.
Thanks!

> The verb `peel` is used in the explanation for the `--refs` option,
> but there is no formal definition of what it means in the glossary.
>
> We may want to do something about it, but we probably would want to
> leave it outside the scope of this series.

I'll add a tracking task for myself to potentially address this in the
coming week or two, but I'll be happily surprised if someone else beats
me to it :-) I agree it's out of scope for this series.

--
Sean Allred
