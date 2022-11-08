Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F9BC43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiKHVfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKHVfq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:35:46 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17602264A2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:35:45 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e19so8155746ili.4
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdwE7lqIi3kn6+O/BeQ6ImmXGDAM8QR1JRzbexfj7P4=;
        b=zwl2eEcmvNvwwiEyXRhuzRLvtyvACu1CHtdOobWJ6WYlwnwL9JwK/gwa9J334mUh6U
         m3nCOnA0C9gOi/0aJDn68M2BNVxThYP7m5f35m4aU948yeGz7Dw0dZRisa/aDK/SHIyO
         MgGb+rdRCsSLS/OT4XhMp4yq0+YPsqYJgf6WEGfLWMzMnLF8y6hlXVDKGj5Sl8VcxASo
         vRr8O4aRIQEZ4ldDDg0aHRmzEgYdgaTlx2oFVnq6JoJ0GSq07qw76pP0y1vFSYe6KTH3
         a6G+LLZcJtCXzKU+A47DLlnqbmEh4K+z2DYM6FlisAtxTW6PU6OsO8+0pMI5oVLxzydm
         37Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdwE7lqIi3kn6+O/BeQ6ImmXGDAM8QR1JRzbexfj7P4=;
        b=rT7L8mrNO5oAx+vh5bOsJBzg4JV2wshDK8bLGSNz12pFnVt/p0GRYbGAz8Jih2REqw
         Ka8QkeP2r0LkUNoBinGVx6yHsqq5MVWEkIv1n4cIAYaIKLv0qEt4Xtd8ZBcEA1K/UV6a
         dGUu6ymtpoD//DNWEkfvwfaeQPD9et0CzTTh7ZEp7p9SgH/YhnTmNmst41J51c0K6XXm
         fP34OggW2iPoVmjbSwGYYGCON1XtX1dyc8YYOTd0+FAAXy/si4WK0iiBtCemzuserSuq
         p27MwF5vkI0jG19mN8YBXvBGXqoUHAVY/+KDS4bez9w1hC6X/cKi59vF7uk/eGzPicDn
         iOlg==
X-Gm-Message-State: ACrzQf1tXBqIGmnf/tcWOeidG47omNcZnVQEN13StMh8bFQCZ3hyWMYN
        w3N0L+jHERS0CCzj/z8sqDBNxg==
X-Google-Smtp-Source: AMsMyM4aL5Pc0h+6WSjgcryGN/0Zd/yMF+NkAzKzcLkaIsGRSfA24rAUl9qSD0hJ79ejbUNWeTEtHQ==
X-Received: by 2002:a92:cb03:0:b0:300:c605:5270 with SMTP id s3-20020a92cb03000000b00300c6055270mr1015930ilo.199.1667943344476;
        Tue, 08 Nov 2022 13:35:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v14-20020a056e020f8e00b002fa9a1fc421sm4197720ilo.45.2022.11.08.13.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:35:44 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:35:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     srz_zumix via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, srz_zumix <zumix.cpp@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] fsmonitor--daemon: on macOS support symlink
Message-ID: <Y2rLr5zJTnqownCT@nand.local>
References: <pull.1406.git.1667885119570.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1406.git.1667885119570.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 05:25:19AM +0000, srz_zumix via GitGitGadget wrote:
> From: srz_zumix <zumix.cpp@gmail.com>
>
> Resolves a problem where symbolic links were not showing up in diff when
> created or modified.

Looks reasonable to me. Adding Jeff Hostetler (cc'd) as a possible
reviewer.

Thanks,
Taylor
