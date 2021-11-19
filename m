Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A834EC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 02:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8270B61AFD
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 02:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhKSDBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 22:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKSDBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 22:01:06 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876DAC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 18:58:05 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t4so51606pgn.9
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 18:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IUI6m5sFHmKeCFyMVMygua/fQ9oSt615T/BGoZFyG3A=;
        b=m0YLbTWTgSUPJ554taA5bEDeYM3vijQgp0qsUCrTbqgz5WgfItFrdGITY/960bH8QJ
         UFAOp0TI9eFMNlaag1IB15+LvDcEdvV4ugOrKgj9Z6ipgz1uTGWPd24JXrsOQIpr8SxR
         hUyjeQZvdT1R9Jic25qPiElhyuqs4PtKSt56PPazg5pu6yGsfDDtC7nhd3UqTNi2Z7Yh
         biqzzhuVt21c1jYhbdTMB+A6HN4rT6HKSVfWmr+AMthUosvRE9gk8rK6Xto2WNOObh/s
         RN8YpPukLhd9ITQwoRox2vWaz/06bM/jWTylMV5IxO6RzMluObEMJ7bB/CLzq2cjqES8
         c8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUI6m5sFHmKeCFyMVMygua/fQ9oSt615T/BGoZFyG3A=;
        b=ybU5xdgCVrkDkFQffE+gjpIx7SAtCzuMykEz3+sK0dug0LF7DNLTLl6rxVwrYfRve7
         5xtgu4FRsDBqPWwNi3hJ6h1qw7+8dy4wZruHfKkY1k/46cvJwqvqqsZzuOtOxSiYgqtV
         aVmJDus//x3b/azRN/MP4f1RArrtYCn/0Yf3bjW1nlecivlY5MPGYL683vBj6VHwM2sc
         mHlBC4/ntHZb9ukaHTefEdAwSxdcewcDLAlc1Fy2JZQLGzKAm4WQnOLYsKpTzO4MAlnO
         TYs8ZhU2dKTNoB4EC7dxn13ugitXXzyNOw6GJwcIvhvhC4lF353PssbjqnhV+Iw7ZleP
         kPqQ==
X-Gm-Message-State: AOAM532Y4BWwSicVhW9wmJrPYbFDZ2jen1+rHCfBxQSowYwuia7CtZ3w
        /hoR1IBA3y/6BBche5NYCl4=
X-Google-Smtp-Source: ABdhPJwA/XnsgWPYnZyY8V7vHKsFfrVVV9l3qmH2XokwNCFSXV76edoBifeATHOoVN5SNxHB624YkQ==
X-Received: by 2002:a63:175e:: with SMTP id 30mr14193913pgx.318.1637290685096;
        Thu, 18 Nov 2021 18:58:05 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id f22sm969406pfj.49.2021.11.18.18.58.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 18:58:04 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH 0/3] support `--oid-only` in `ls-tree`
Date:   Fri, 19 Nov 2021 10:57:49 +0800
Message-Id: <20211119025749.91014-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g62ef0b3803.dirty
In-Reply-To: <211115.86o86lqe3c.gmgdl@evledraar.gmail.com>
References: <211115.86o86lqe3c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> A quick patch to do it below, seems to work, passes all tests, but I
> don't know how much I'd trust it. It's also quite an add use of
> strbuf_expa(). We print to stdout directly since
> write_name_quoted_relative() really wants to write to stdout, and not
> give you a buffer. But I guess it makes sense in a way.

Thanks for the patch and the inputs about "strbuf_expa()".

> Then we'd be future-proof with the same interface expanding later, and
> wouldn't need to support options that we're only carrying because we
> didn't implement the more generic format support.

I agree but like Peff said it maybe another bigger task. I think I will
firstly solve the existing problems in next patch.

I will consider about the generic format support but not sure whether
it will continue to iterate in this patchset.

> (Assume my Signed-off-by, if there's any interest...)

Of course I will.

Thank you very much for your advice and guidance again.
