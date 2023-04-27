Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA95C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbjD0S32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 14:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbjD0S3W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 14:29:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA133C29
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:29:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-95f4c5cb755so431967566b.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682620160; x=1685212160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yA3wHcokz4O2nVodjusBh1tbzvPC3xH8nMW6p4mn0eY=;
        b=MsVOpVhOKGgUkFUEcorxX/iFT5pRIvimeJaPbI87yW/cSArmAdbswz8KDPq1laYurm
         y7KWKutZTZobizlj2bFE0YbelIwTzngYm9vTJVUCWvWvDms1jA5ZdRmL6vdIqso+xYwN
         J0ucf636Rera87jVjy7DyQfiPPCTk5SPweHHraZTbrQql0e/64dLoTZDFOYp83LE8yci
         2ZV4lNhnLDLnAmJEGlNqBrhOfQL/mbisGBdPKBy/8GYbrWnVEs1FJn9gTt63squ3xBx4
         gGkzF6niqfCwUaP4+0Y8xgDmJhunFhiwvUh7HgLaCMh1KV69UidLZKbYXUiFnaZa84yg
         nW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682620160; x=1685212160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA3wHcokz4O2nVodjusBh1tbzvPC3xH8nMW6p4mn0eY=;
        b=UgIDaZNXywCGOEg7BgKRNo+MrY9IIwREDLGA3Gb99ldlJWjXl7MXiMpu+EraCSbEE2
         +DSC+B+k1HST40Tldudz/5Ib9/Tw7wPkcQfObAK1TWtYC1LgktKpd3fsvNn9eqo78Zdj
         yoRSEdHD8FacrRotAcUPRE/UTEVmfI7FFGP9x9yps0M5VzMNuGgV6vzPk5z3YUUNaKq5
         etCibmkhESGuC5EAHLrROFWqHD0jkAuhsREEfzjNgO4Lv/zmwOjcEJn7WZzrUt8xKCvd
         wb5h+L398Qn7k28yXxmJRTmhHn/3BUxE/j1iG1+hiIbZcUIxSOUDa/6oebSYN6x+Z941
         SoRg==
X-Gm-Message-State: AC+VfDzXfOesaEo0qSDo1sHzvreFKZn2sMjcgGNGesCbzY5q1FoMPDdb
        XjU6fK+vRmzTlnMpFbroirpXINv4y5s=
X-Google-Smtp-Source: ACHHUZ4FG1c4bRhT2/BDE47bR1pnVDFMmWdc7ma04qhAfsjxB3dLW0wXXzVuK2OZOwVH7TttWpEYJw==
X-Received: by 2002:a05:6402:14d2:b0:508:4232:e56f with SMTP id f18-20020a05640214d200b005084232e56fmr2156611edx.39.1682620160073;
        Thu, 27 Apr 2023 11:29:20 -0700 (PDT)
Received: from localhost (62-165-236-48.pool.digikabel.hu. [62.165.236.48])
        by smtp.gmail.com with ESMTPSA id f20-20020a056402069400b00504ecfea8b2sm8239625edy.85.2023.04.27.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:29:19 -0700 (PDT)
Date:   Thu, 27 Apr 2023 20:29:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Message-ID: <20230427182918.GC3271@szeder.dev>
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427175007.902278-2-calvinwan@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 05:50:06PM +0000, Calvin Wan wrote:
> Introduces the C TAP harness from https://github.com/rra/c-tap-harness/
> 
> There is also more complete documentation at
> https://www.eyrie.org/~eagle/software/c-tap-harness/
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>

Why?

Please remember that the justification of a change belongs to the
commit message and that the contents of the cover letter will not be
included in the history.

