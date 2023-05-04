Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F544C7EE21
	for <git@archiver.kernel.org>; Thu,  4 May 2023 10:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjEDKzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjEDKzb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 06:55:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669E649F7
        for <git@vger.kernel.org>; Thu,  4 May 2023 03:55:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f37a36b713so3365215e9.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683197729; x=1685789729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sf9Un7aMWdHbYq8pfMZoWDCrnX8mJu/H3BI9Pj+gmfo=;
        b=b6B8jV7hrbwBxaJ1KcOzxYbFFNGwPr85cO7Tzs0OObpPmSu+gwFCqnC2LE7ZHJemzk
         mArWsCpgf+NRXtVTlnIAk4Rzq0+UMaWMKrWCA9qLKkea1WX73rqUJS6EuR6X8KpXnvEy
         jV2HnDIpJtkNM6SnGdRZwDA03NujVUZoV+xA9OzpFYgOo8ZIIsYz5e8r91oA/XA1DaGh
         mIL4c3objY4gHiDJXuUFZEjv4i38vl/oPtEFwb6kiBDMz2/ux1KtwZjWxqPK5GwBeybH
         7Jvmfa04BEs4bmJDmdpDgkp7k4tjFMA7TYGT7LBkjftja9n6JChwUdplBG8kyRqBniBB
         Qa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683197729; x=1685789729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sf9Un7aMWdHbYq8pfMZoWDCrnX8mJu/H3BI9Pj+gmfo=;
        b=jZ7LuK5UEdMjUabj7C47KlpswhCEn0fcTJctlouF1wSbyRAmAqF4JlMZuJk9iBJxCD
         4XnohNHwJYu3mlVuh/wk5hZvLcfraMo9s1gLZESWnd+R6vIpvhX1JFGOVTJwWKfnGrOu
         3CxPEPV7Ic6oSrpeJ+hsr+2zMXGDUgOg7mMGAsW8srAnttA/8FjrRna+99kbHqJPKqAs
         EyC+2NEd2lHSKbdYyuzkA8Pyiie8W4/IBbEc1ZW+ey+FRAce+vAn03I4rMMklZmGQwf6
         e1VCck6RaosfOmd9xL+xaQv8Mwy1ILfN6JpZYkB8gXgoefAi0TFG82ufggX118hqQ2AR
         sEbg==
X-Gm-Message-State: AC+VfDxteb9011B9E0DvxcrJH53R7qGc5TYzjHzyp+E03hpk3lbu9/Rf
        UBUx2hQD4AI4r+hcFV13nXg=
X-Google-Smtp-Source: ACHHUZ53JRd9ONqPUguvB7rZwCm18mTb98CzEW/1CNCp22ghXNE47e8zJTKeSgHNBebkKtFD30gDqA==
X-Received: by 2002:a5d:6b4c:0:b0:306:32fa:6750 with SMTP id x12-20020a5d6b4c000000b0030632fa6750mr1997138wrw.33.1683197728704;
        Thu, 04 May 2023 03:55:28 -0700 (PDT)
Received: from penguin.lxd ([46.69.195.17])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d63cb000000b003062cdc6ac5sm11237912wrw.89.2023.05.04.03.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 03:55:28 -0700 (PDT)
From:   M Hickford <mirth.hickford@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2023, #01; Tue, 2)
Date:   Thu,  4 May 2023 11:55:26 +0100
Message-Id: <20230504105526.1287-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <xmqqcz3ixsas.fsf@gitster.g>
References: <xmqqcz3ixsas.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * mh/credential-oauth-refresh-token (2023-04-21) 1 commit
>  - credential: new attribute oauth_refresh_token
> 
>  The credential subsystem learns to help OAuth framework.
> 
>  Needs Review.
>  source: <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>

Hi. Is Jeff's positive review [1] "correctly implements the intent ... sounds reasonable to me" sufficient to advance this patch to or towards 'next'?

[1] https://lore.kernel.org/git/20230425064758.GD4061254@coredump.intra.peff.net/#t
