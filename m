Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C14C636D3
	for <git@archiver.kernel.org>; Sun, 12 Feb 2023 18:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBLSLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 13:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBLSLH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 13:11:07 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B62CDCE
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 10:11:06 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x15-20020a4ab90f000000b004e64a0a967fso1017604ooo.2
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 10:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=so/IQsVv8B+WZk8nvWbHJi79xMCy4Gy44C2MdtUSyag=;
        b=ch8OH6uAoRFE8B/ch73LWR8LgO3Zt195brktl65IE6c/ssgBL90cvGKtftwWpUIH3L
         xwFYLVrv5SUJTl6XPTPelu8oc7i66KMzBi1By0t/D+t6LRZK9M/malM7MWxDvxgwJ4AN
         7X1GCSmEeN9THfPX95JgwIcNp21PLNt4sFAZE4TitSuZL+JYZmKvPEj9ZEecAy7FNHBY
         ndMVudWtiKOgYO4tTvwSU8Y35/ApLHmXePdrX54qip5q/e1SHvXvcwycf9jfEIAPOADL
         G91h6EIce0I4itUeu/bMqUDA1ZU7JQHCLwUvJV8fPKNTf93yqE55SK82OdBzUEyuwX/K
         n64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=so/IQsVv8B+WZk8nvWbHJi79xMCy4Gy44C2MdtUSyag=;
        b=s3obHfXLs6RXNv7pxAa9hEFc6ynd7e0jAgVjetWgyJJcvINtj2koZvW6opmSrUlXIs
         ihf4pSwm6uKVsweribgLiOwVnRBlViO5aeFswGkdnhv+wb3FCh4SRtEsPv5aJ1TkjDZp
         avYBINSKqODBaPA770sx1mlTn/1Ks/FE7xtFxyhLsSh8I85RaTWkVDU3sFNRKnvnbPkv
         dXWuKcfQMNXzhoDNOywkYdAS7KiuYXJLoQiv34Z17I0uE4b1g73vD20bC4GcZHvtY+Au
         MqIbgfRpYyfC9Ql1xdA+FVA2jG84RrQvySlaHrClGtq5Auzv70deOyN0LEp+pGvzkBze
         LNzg==
X-Gm-Message-State: AO0yUKUPnm0+ftx4rOOHFWitUCm9LCl1iu+sSm23lPK+QV5vaD7iiKjg
        KKt8hm78sBzfSy+MiiELZhvAczouXYc=
X-Google-Smtp-Source: AK7set/I0I2l22k7gNjE+uLMEF6/0oMfuU9EKJwohmVgKFzvZCyl5p56Ka4t1usDYOy0q7yK5DEgVQ==
X-Received: by 2002:a4a:e385:0:b0:519:b605:9d78 with SMTP id l5-20020a4ae385000000b00519b6059d78mr10988188oov.7.1676225465649;
        Sun, 12 Feb 2023 10:11:05 -0800 (PST)
Received: from zosoarch ([2804:14d:728d:8561::1363])
        by smtp.gmail.com with ESMTPSA id v23-20020a4ac917000000b004fca8a11c61sm4094264ooq.3.2023.02.12.10.11.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 10:11:05 -0800 (PST)
Date:   Sun, 12 Feb 2023 15:09:58 -0300
From:   Renato Ramos Ribeiro Araujo <renatorraraujo@gmail.com>
To:     git@vger.kernel.org
Subject: Suggestion and question about hooks
Message-ID: <Y+krdsIPhKIxFRHt@zosoarch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why git does not have a hook 'post-push'?
