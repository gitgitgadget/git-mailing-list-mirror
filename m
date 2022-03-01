Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F121BC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiCASKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbiCASKd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:10:33 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F7E517E2
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:09:52 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso2594729pjj.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=TXE2KGfLj3ocOZ8r8rMT+kXfae7a5D1lgH1ZxUagOBg=;
        b=ogWW76yBr/y6Ih6B4CWEXAafKzVPBvleR7DmBm8DdDW75FmERak2NZjz7TFP6bQk2f
         ntpJoh2TjCbEAzfj7Yz793m8Y5hR6yWJywvGI+rhxIQKYwcx8UPDqP/qCJIYCmRq8TBo
         2LJ9I6u/C2b1uEdMaC1P3Etz6xcXlMtzirxt++OIB9DTOo1eFU+3DIUxtlxejS4dASoB
         85LrtGbV35ShsHVizs3MNcCqb5Ur0DmohRnwUOjQcPIgt3Qrl75SiuYr8eAjre79lFuu
         P99RDpqXIQEik0oWGL+t3ERVsJPvhpdNCFzIIjhIAby6mk4ULMrT7gsiH9/cGr331zgh
         tdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=TXE2KGfLj3ocOZ8r8rMT+kXfae7a5D1lgH1ZxUagOBg=;
        b=g518w8qCr0UQlIO4AJLOncbBCm0NdCrQLOCcZu6xUCUlUb4+Z1ppZ5z1X8GHcbY2ZI
         F2jKvkwR/2V15ALcxxAb1cGniCev/jFDz7DwSbyDCNyhG+sMjp88FFUkO4RYTMtXbFbU
         dK5GgLPFd9ZexRFBEBIf058yU2wPfNWPQ1XIowZqUPjTYBvAu+nYBDJ8KUTN37tOidCW
         wCCrh7fq8jkPXHynG8VQ26XZsXO4jOjbaIa/J4Hl2iOJWgbvR3mcIKee5UBMogLxpTC6
         UBJSWGe9zYKPxDJq2yZ+svQomlJBv25VptNjIR2uE7ALHmztT1bKDYFbT05Xz922re8X
         4tfg==
X-Gm-Message-State: AOAM533z7ENHj3UIzLw5sskZiymtAgWc6JQk1NFgj1PcNUWQL4Jaz2E7
        OZ8gR3h8Pyytr+j6bzl+KagH9C/AxVz8GTNk
X-Google-Smtp-Source: ABdhPJy/fblxzPJQhq/ch7FWrbkhgsTarkNcWMpu8RB5XtPUmNsu2dovU9HKiPxnwHEbKrCM1CZESw==
X-Received: by 2002:a17:90b:4c4c:b0:1be:ebe8:c81b with SMTP id np12-20020a17090b4c4c00b001beebe8c81bmr1847574pjb.88.1646158191546;
        Tue, 01 Mar 2022 10:09:51 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7939b000000b004ce11b956absm16775442pfe.186.2022.03.01.10.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 10:09:51 -0800 (PST)
Message-ID: <c59383e0-d549-d198-f358-18153f18d24b@gmail.com>
Date:   Tue, 1 Mar 2022 23:39:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220301155431.2534136-1-jaydeepjd.8914@gmail.com>
 <xmqq8rttsic1.fsf@gitster.g>
In-Reply-To: <xmqq8rttsic1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review.

I have some criticism regarding `t/t4018-diff-funcname.sh`.

When any test fails, its verbose output is not "verbose" enough.
For example, If due to wrong xfuncname regex or wrong test, all of the
following hunk headers

@@...@@
@@...@@fun right(){
@@...@@fun

produce the same verbose output:

`not ok:....hunk header:[testfilename]`

Initially, I had a difficult time to debug what was going wrong
so as a temporary fix, I made `t/t4018-diff-funcname.sh` to
`cat` out the hunk stored in `actual`.

```
# check each individual file
for i in $(git ls-files)
do
	test_expect_success "hunk header of file: $i" "
		git diff -U1 $i >actual &&
		echo 'hunk:' &&
		cat actual &&
		echo &&
		grep '@@ .* @@.*RIGHT' actual
	"
done
```

Is there another proper way to make the test script produce
the hunk for each test?

Thanks,
Jaydeep.













