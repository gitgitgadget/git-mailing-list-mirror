Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA87C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 22:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D038D61207
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 22:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhKDWio (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 18:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhKDWin (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 18:38:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B50C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 15:36:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k2so7165305pff.11
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 15:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lDTN/Fz2USmU2J5lHRNpFtqCIV/GCt+Gg6dbje5XOPY=;
        b=SRdsSJ6eTUOe4As7jUpUWfDRUp7dY2QUiMvMscrZ1R9PGkqYMgsRFVDhne/LBO9pIO
         0sEdsf5KHX/NcJchMDWrfib/Izn2WevMdjpGqaoUNzxlPqZPz088R8Q3LaptS4rbn01B
         9uEzyqV79Dpg7msNpgDcxIS1dSq9+715IVVUtnSLOcgpyjmo+1Ul0Yzq7f/z+7QUQRVX
         g1QjwN0D7Cu/G2/lN5pv7ns3aEY4Lz5OipknvOl6InOx3SR0va8vdcZ7dJo7OO+xLILY
         s9+Mu2t5TaIwBmiRUNG9bKzOE7qvTqHC56OzGVm/dx0OyXwHOKfNOebf4rYxcplqHj8H
         0GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lDTN/Fz2USmU2J5lHRNpFtqCIV/GCt+Gg6dbje5XOPY=;
        b=Di6Lwh0nRtUCWHECzrXNe2TGtHEh4gA7Icob7cgwaxMfWLoth3wdhX2Anf5zXDYQYM
         HANdxE14199r7bkZwJ1gW6vJf1hCrpWyCSN7IE0pxmQvxUemI0yr7QlS3mSOXba2OXqV
         IBB6bFoj+Y3lixUihnwMrQOlpuFzcKzNvVrsGFqduBWyDGSuVvypPKGzyRLOXET/Yrrw
         Ej7EW+JyfcQ3YyimEA7ZisXxaTaMvMUJlB4pNc5p0QtcPxgaKc7utaHfj1iNk32HdksN
         xmnIdYnHrcd8jC7dbLrqINxTpH2wSwBl0Dl8kTLA4J21qn9O0iM5lqHGOt9wEI6SSYYy
         4ekA==
X-Gm-Message-State: AOAM533W8JolrPncw1/6n2tAgwmc3BHzacl1tLnGuRnRf9IbyssbGSUj
        ZgTGV42zHzLoQipQ3K1CL7Y=
X-Google-Smtp-Source: ABdhPJy+qvbTJ+f4NaZKXBgQrj0mnUkKWLSRQgFGelZAnXq4m7S1WJ5X8iZmIgJ3CF+S3CWy6kUmkw==
X-Received: by 2002:a63:3f0d:: with SMTP id m13mr41232292pga.287.1636065364641;
        Thu, 04 Nov 2021 15:36:04 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id u13sm4605103pga.92.2021.11.04.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 15:36:04 -0700 (PDT)
Date:   Thu, 4 Nov 2021 15:36:00 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <20211104223600.GA4069@neerajsi-x1.localdomain>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com>
 <xmqqk0hn1unp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk0hn1unp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 04, 2021 at 02:24:26PM -0700, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > I think it would probably be best to create a git_fsync_fd() function
> > which is non-fatal and has that config/while loop, and have
> > fsync_or_die() be a "..or die()" wrapper around that, then you could
> > call that git_fsync_fd() here.
> 
> Adding git_fsync_fd() smells like a poor taste, as git_fsync() takes
> an fd already.  How about making the current one into a static helper
> 
> 	-int git_fsync(int fd, enum fsync_action action)
> 	+static int git_fsync_once(int fd, enum fsync_action action)
> 	 ...
> 
> and then hide the looping behavior behind git_fsync() proper?
> 
>         int git_fsync(int fd, enum fsync_action action)
>         {
>                 while (git_fsync_once(fd, action) < 0)
>                         if (errno != EINTR)
>                                 return -1;
>                 return 0;
>         }
> 
> fsync_or_die() can be simplified by getting rid of its loop.
> 
> None of that needs to block Patrick's work, I think.  A version that
> uses raw fsync() and punts on EINTR can graduate first, which makes
> the situation better than the status quo, and all the ongoing work
> that deal with fsync can be extended with an eye to make it also
> usable to replace the fsync() call Patrick's fix adds.

Is there some reason we shouldn't die if writing the ref fails? We are
already accustomed to dying if fsyncing a packfile or the index fails.

I assume the number of refs updated is not that high on any given git
operation, so it's not worth having a batch mode for this eventually.

Thanks,
Neeraj
