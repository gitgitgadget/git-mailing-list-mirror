Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DCBC433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 15:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiFHPlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbiFHPlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 11:41:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040FF4C434
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 08:41:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 129so19255783pgc.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCDhHunyKMebGCjse5X+sioYXo8GLXaB5Th+JirPEds=;
        b=W9nHrM4aUqGbLkrOkh3t8ZqmN4/blfBnmTo9DhwNEqGddfHwjMo2rw6G7ZaGfuqMG6
         vF7mg2Oc7DQiDesOTWVUyZh3lkp5DgmUrc0kp1Hs7U+1/yzozkMq78vdyzze3V6NwB3j
         Hcgyk/gyT5eGgqQXudcBkfbXrPgtPeyN9ghrBl9VizEzl2zLecAcZuIY5eAGEaUTqmc9
         e7IlCc71xQGgd3g/5NzH0gpWZMT09cY8/hYp/Yjw+N8KWFQnUJWKAu6wKLzTqith3eXe
         e8tmwUsBhBd8JZOOP6yztCVEGs7Y0hf5vXz5TObSHPCatw88+yXwCNo0Bwa3/6bGk+/P
         5aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCDhHunyKMebGCjse5X+sioYXo8GLXaB5Th+JirPEds=;
        b=2xmOL/e0hkNzM0Y34qJatOkUrzZ5Bv8pyZsxf74cfMX4XeQK2x1XWNNm/WJlyzG8gT
         kU1H6N3Be+8YT4kW5FRisgkjuJZn9YbhYxb0N4ZZOgnheU05Cl1vRIv9P80ip/Z/8C42
         oIAXk4oD0i1h0QIG7bJK7IgWiGADJu7OEhLtVALwvxgmWPnTc7RzZAHE7k/DuXXHPzJ/
         whPkfhOg67UgVRHB7wDdX3ZIX27BFBFHCvXrMghYQsl7Mnsp6ybSE+5+CNBxDQBLG/zE
         wLbHz1Vq1s02NQcSEZ8YTw9agtxUvB4rfdjWX8qvFvpvVyZluo4a7dex6lVhomN5mMvi
         TwZg==
X-Gm-Message-State: AOAM532aEGwyrIVgBYmkokc14cnhH8Q1+9PM2pYBkOUKlU37RExDDjFm
        b0RaDGSAzH8mBCSafjhDDgI=
X-Google-Smtp-Source: ABdhPJy4AVRvE9X6+QJ0ol/XZX6m02O36SR3rE0UqS2pMZljoZ4pdGn9vIHDg+B6Ao01+3kQ9DytlA==
X-Received: by 2002:a62:1dc7:0:b0:51b:a56e:35c3 with SMTP id d190-20020a621dc7000000b0051ba56e35c3mr40525673pfd.45.1654702861310;
        Wed, 08 Jun 2022 08:41:01 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2d90:e070:30c2:fb1b:2653:5119])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902e14a00b00166d8100b7bsm11126573pla.176.2022.06.08.08.40.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 08:41:00 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/3] bitmap-format.txt: fix some formatting issues
Date:   Wed,  8 Jun 2022 21:10:50 +0530
Message-Id: <20220608154050.10278-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Yp+6WU+k2OwHDB1b@nand.local>
References: <Yp+6WU+k2OwHDB1b@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> Hmm. When I render the HTML for this page and view it in my browser, the
> removed blank lines makes the contents of the section "2-byte flags
> (network byte order)" run together, and I think it hurts readability
> IMHO.

Honestly I agree with you. I also felt the same but then I thought it
is still better than the currently broken page.

> Is there a way to keep those line breaks without significantly
> reformatting the source of this file?

I have a limited knowledge on asciidoc. I removed those blank lines
only because it generates weird html output. I didn't find any other
way to fix that (with minimum source code changes).

> This isn't new from your patch, but I wonder if now is a good
> opportunity to make some light use of the formatting options that
> ASCIIDoc gives us to make the page read a little bit more easily when
> rendered as HTML.

Yeah, quite sensible. I will surely look for better way.

> I don't want to compromise too much on the readability of the .txt file,
> though, so if there isn't a good way to strike this balance, then I
> trust you and think we should leave it as you have modified things here.

This is one of the main reason why I removed those blank lines and other
stuff. It is the minimum change to fix the html doc. But I will look more
into it.

Thanks :)
