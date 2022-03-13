Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE7C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 14:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiCMOsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiCMOsM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 10:48:12 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B96E75C21
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 07:47:04 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r2so4345084ilh.0
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 07:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=h5/HVb1IgLvIwUamFj2OtGcVVMBvZGDgNXDHJ1Ytiws=;
        b=l1ECJeo+H30v5wdN4TdxHqCHb8YraahLvOz1bjZS08w77pVI7/ZX58hUOu0VyDonwJ
         TSxGd9/jpyGvA7jq4ZB2MgqYflSEH6Xj4D/HlG4V1+cASlc/1swgv+R260XLVtmrhjXM
         QPK+fOCHDGXEHaj6d8XVmMq1f7EP1DWoGLzhWnLmHM+t0L5LaIEAQvdexmPqgxP5JAc0
         ZW4dhCifaSsmpZTy73JC31NTKT5hxrZmO/36rOC6rHn2Q/dffXxHvNWuEpKImlRIVo4Z
         YA6elnUpX7Wk2QxawjqxmQCL/pyrZ0cFDrIf2b1z8WexoK3oWDvGAPR66GbLOJRbPKz+
         x4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=h5/HVb1IgLvIwUamFj2OtGcVVMBvZGDgNXDHJ1Ytiws=;
        b=cS3wByCMwC2dVi0Q1yQMvTyOh47jNbuyOW8OuZmcPcZGfclZzobjmrYDVbc3AfE//B
         Yu38Y9jyFMr1eITQFli7oN4wXdERTM59bgytXz2lEhe0iFQ6XBYv3h0dwL/MYG0UsB1i
         LY94I0Nz5YTSNttWsg/4IMpDJBMvz6VjfolS7IH5MKNgN0C/nkNej8SG1GzvB1i6qLN0
         d6OLddmSpUxfff+OJFsKRgvWumJpcO55U6hWYdz2TjBEu6YbGKPFQUOLqLu78KbOCc0l
         MuqA4M92TgMNMR0dsx6Q43SpLkx7lb6L3+4esbQlYwrfuNCvtzzEzyVlPxSHCsnQrD9k
         ohig==
X-Gm-Message-State: AOAM532TcYcOcHsQGpRECOdR9pTNMsUVBlCdQWq2cKFS0hsqSvJ3bMqM
        cjSNEtKPkj3N/Vvq1y14N4E=
X-Google-Smtp-Source: ABdhPJyCzpXG+aRVp2K3I+3USQHpgOYgU4P1NWSof8vUCpDADA/X/WtdIrwhtYayqOg2eOZx3xf+2w==
X-Received: by 2002:a92:d0d0:0:b0:2c7:895c:e197 with SMTP id y16-20020a92d0d0000000b002c7895ce197mr6929509ila.11.1647182822290;
        Sun, 13 Mar 2022 07:47:02 -0700 (PDT)
Received: from EPIC51148 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id j28-20020a056e02219c00b002c795a5f312sm1610397ila.83.2022.03.13.07.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 07:47:01 -0700 (PDT)
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
 <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>
 <01f201d836e5$89247c30$9b6d7490$@nexbridge.com>
User-agent: mu4e 1.7.9; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        sallred@epic.com, grmason@epic.com, sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 09:41:18 -0500
In-reply-to: <01f201d836e5$89247c30$9b6d7490$@nexbridge.com>
Message-ID: <87v8whap0b.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


<rsbecker@nexbridge.com> writes:
> (I am a little nervous about this advice, hoping others will chime in and
> correct anything wrong here)
>
> While this will change the commit hashes, AFAIK, the other metadata is
> preserved, including date, author, and committer. Set up the specific
> keys/settings in ssh-agent and the user.signingKey value, then:
>
> git filter-branch --commit-filter 'git commit-tree -S "$@";'
> <FROM-COMMIT>..<TO-COMMIT>
>
> Others might have a better way of doing this or may tell me this will not
> work. Test this before you do it. I have not done this operation before. You
> do need to start from the oldest commit going forward otherwise I think that
> filter-branch will (should!) invalidate child commits. I suspect this is
> going to be a rather lengthy script to build and run.

Given the size of our history (several orders of magnitude larger than
linux.git), using git-filter-branch after the fact is certainly not
ideal.  The replay already takes a week to run (we're IO-bound).  We'd
rather want to extend git-fast-import to allow signing commits instead
-- which comes back to our shared 'nervousness' about this approach in
general: I don't know that Git should endorse this as a standard option.

But yes -- hoping others can chime in with more thoughts :-)

--
Sean Allred
