Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A502C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 20:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443328AbiEFUo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiEFUox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 16:44:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1E369CD7
        for <git@vger.kernel.org>; Fri,  6 May 2022 13:41:08 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t16so6864809qtr.9
        for <git@vger.kernel.org>; Fri, 06 May 2022 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pS+ACe5FPOnbZKRcEmkmdiTdJNSY3g5BPtzFSlvTaY4=;
        b=MPd2GFcJCApjfAIG7G9accDZ3VJM4r/dOgKA4HMuHi3qFYIK00AAsiqEQ/Wk9ROXG3
         kaoUREGk3TUte6zFMV0HYhEDoBgkUwS/J59NTBpxgDC0/4o3ooPRDLXw99JEepk1aSIf
         QXfQvO5H4TyA7Rb19Ui36+omQwNzBX5dWbxBvbReM9M5Spy/PfSORtJM9fntzDv+3kix
         E7UfAhm8DxMIEHJpluXbsj+kxE7ZF7oAjklKvgFOvq48lSmNVg1PuJG8ivIyGcMyFysq
         U3O57ci//lRNRF15PbejEis2QVJYUPc9z495QPr9eFwKqGozn/Trsxw+bA9Z0uQwZBgK
         84mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pS+ACe5FPOnbZKRcEmkmdiTdJNSY3g5BPtzFSlvTaY4=;
        b=44NShckKIg047FGcQScDPeEpQsboiusq42qx4vDBEaIgK6eZr+p9XqodQYTiwTigA6
         vcbMCaZXWU1lCP6Z3f6xrfYRKl0t+6/yZRGeeaADu/BJedyhlfNHtr5t+R03InOO1K+6
         OAth8cCvtJxlrc+pWXoqc2rR3Dv1kn4o3Osyz9p+L8Lotcc6OlRJsQxZLfLamHCo3TdQ
         eGrfbwZiRByTXRPG53tGkxfYaW4z9pvzYsLBR/LAN1qkLPppoRHFFLJVfDdL/9O0Jfge
         KvlJ1zYJBYMBZFn2gBAyAqZFtUYO6yNZZNskM4NAJVQXeBe1NzCUktpMs6oiEaKAmfP7
         NELQ==
X-Gm-Message-State: AOAM533yN6ih4cOo4gd9C5IBPjLJ3ts08TVAYXLwovN+W9zPJZexfCdV
        MZnv3HIiUeM/yoi1XDAK7Mv8LRcDXq4=
X-Google-Smtp-Source: ABdhPJw+luzwn4k4dOBzpO2PfV+s3u4DVdM39vsd5XhLyYtvrxH3fEm81j4i4QunuHKGNKZvQJZe2w==
X-Received: by 2002:a05:622a:293:b0:2f3:b483:baae with SMTP id z19-20020a05622a029300b002f3b483baaemr4456861qtw.111.1651869667961;
        Fri, 06 May 2022 13:41:07 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r68-20020ae9dd47000000b0069fc13ce201sm2561760qkf.50.2022.05.06.13.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:41:07 -0700 (PDT)
Date:   Fri, 6 May 2022 13:41:02 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http.c: avoid gcc warning
Message-ID: <20220506204102.iyn7mxogtz2t7gh6@carlos-mbp.lan>
References: <cover.1651859773.git.git@grubix.eu>
 <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 08:04:06PM +0200, Michael J Gruber wrote:
> Related to -Wdangling-pointer.
> 
> In fact, this use of the pointer looks scary and has not created
> problems so far only because the pointer in the struct is not used when
> execution is out of the scope of the local function (and the pointer
> invalid).

I think it might had been used by a different thread though and therefore
it should be at least a thread local static to be safe (which should be
possible to do now that we are supporting C99).

If you are going that route, would be important to tell you that I tried
and got in trouble because of Windows and the build environment in use
there, but it didn't seem that difficult to fix, before I got sidetracked.

Carlo
