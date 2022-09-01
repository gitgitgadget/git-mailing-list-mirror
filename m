Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8306DECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 01:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiIABNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 21:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIABNp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 21:13:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E612A5FA
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 18:13:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso958796pjd.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=doSbtUzEz8pSkkktdMkJQvnXHcGYmy8lz2299FypXsU=;
        b=nGBn6XiBdRLKJJIYixvJ7uMLBGTVxlsxbXaNgtC+NRr73o42Tlwgbrsk88i5TJQ0xv
         beM5SRlIeYsoGzN5H8OLpRQEbviNFp+Dhhli7QMEJ8pUUQANd1E2LdeMaim97h9L2W2l
         L8ZIBKDhWg/rYhgJFOUPG196BqyeOLVv8f2rqLexcXUXYXZOqpgEzqhdWvOw8NHXz7+3
         HEAIxw3jYDFydqw6MxNSi+wvDlsxUW+NpeIiY20RijErZJDk1rcnQ12RyBj8mcQQ2gCV
         umFQPl/76jagsVACTTuioxzd77WV5KbHyBsKmcTZmFv+IgwPIRJ/FbPRnUSCxbsumSTl
         fA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=doSbtUzEz8pSkkktdMkJQvnXHcGYmy8lz2299FypXsU=;
        b=wlyXeiSeNJoQOhz1lk1Hjy5gB7N3GVPlnf7HmI7tS0D57f4rVzAWoX1Y+wc3Wfpsif
         vfqVc6qB2W7wYw2Yx2qui2DatucvMM1ll/qhBEVysbYjxY5z4MdmcDXCI+KdiETaUpdg
         1kL4b8ZtJPjnqXtLru2sgArBTgD+qprebNo4nJXMqatNFavS+t6LdRtlGGRMme/Ttusb
         atMn6ju6xIIZzwOcw9JWOFDfbMrBOyZTP/m/m4ktRJ/OpxH85pXZpkaf0t2ycP2AfTMB
         KL0fZne3Dd4vUsGMSJIi6YCYkTChyAaH8X4IFY5uBfzTuGQZsonbOyKBsaCrl2D3Wd1s
         qtXQ==
X-Gm-Message-State: ACgBeo2m0C0n0RpcqjGhhGz7ndd2GE6wj0PM7pm/5tDGH84Ciah9UvDD
        VKYzoL+AEc5GW5zGTkq1RdY=
X-Google-Smtp-Source: AA6agR4053rms78EQU9e/bcNJcXQD3oQi3KiMBjLF+VQ0/gsPiUA7YuYoDnVDu50vwMQ6s2k/KiRyQ==
X-Received: by 2002:a17:902:f70a:b0:173:36e4:eddf with SMTP id h10-20020a170902f70a00b0017336e4eddfmr27977030plo.9.1661994823733;
        Wed, 31 Aug 2022 18:13:43 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e5c300b0016edd557412sm1828213plf.201.2022.08.31.18.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 18:13:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Output fixes for --remerge-diff
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 18:13:43 -0700
In-Reply-To: <pull.1342.git.1661926908.gitgitgadget@gmail.com> (Elijah Newren
        via GitGitGadget's message of "Wed, 31 Aug 2022 06:21:45 +0000")
Message-ID: <xmqqv8q7dhh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Philippe Blain found and reported a couple issues with the output of
> --remerge-diff[1]. After digging in, I think one of them actually counts as
> two separate issues, so here's a series with three patches to fix these
> issues. Each includes testcases to keep us from regressing.

Including this to 'seen' seems to break the leaks-check CI job X-<.

https://github.com/git/git/runs/8124648321?check_suite_focus=true

