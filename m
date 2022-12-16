Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE842C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 22:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLPWzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPWzH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 17:55:07 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A530B56D7B
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 14:55:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gt4so3872544pjb.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WLFzLUNJkVFJnkct7w7dhkKFHRkqPCsYEckoYN8P/c=;
        b=aXobd65x+t+8Ttl7qtFWSioVFW6NuHJG9YOrxYkpG6/v5mvy42bKdddzeuWh7uvv6P
         FMzts24I4AnNqqQZeJyS7wa8MeXCV6eqmwCZpQWwlxD22kK6Ci3PjOZFbD42NQGzVfsX
         c4+OpjDLrnuT6XgmyAW1K8TgbkbSCU4Js7Io+y5j1M8jvSX9v1RMkiqGJHhjbSbqVlWu
         LgCKhackKNOSF2lyFP6Xsx9r3jGnuYpOtSXfGpTFjqwxXjXRWdMlO6AnuYDUGDwD7jsN
         tcEN/XOLKDrfKtjguzl9gFEYTqgRFtM12WJSQe43qak6HP8zaxwMDPLBcgbTe9jkFzRG
         UEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1WLFzLUNJkVFJnkct7w7dhkKFHRkqPCsYEckoYN8P/c=;
        b=snrP5z2ztouuQJJRS0XjTwclCkQRZZ4QnWnZ5TXRjYtXpHcWX1Qnfha56V6t+Z9Rkr
         r+5XOn8WGCvaNR6FtxayWU7BMQflTg6VHrwOnQeGnRtiM2o6AOBdKQb/siJwOZKJn0gu
         ZBHX+1li0haSEkLyO0qqHW1pgtFGyMhLBwkAV7UKhpFsrRYDHwRZQsYn4Y+J0/4/OfCl
         WVxBHt9YpjUF0JEqFCo3CjBqB4zM5y1pOQhk+o65jiU4SkifbgCwA9Tbe9svA2y35kop
         xtWeBl1UGrdeeuppwCBU/aaLeYPESxT+7KoIBih+mVem3p5HCpQUajA2upHmv63bTmtZ
         xTtA==
X-Gm-Message-State: AFqh2kqKwbEBID7b0YZysrt3ac8TIuXUnW9G168Zf9WqYwoQN0bLEZK0
        KI4LfCk6FwGN/GTMVbWWiMPw42+ZWtJ/SA==
X-Google-Smtp-Source: AMrXdXsHanzUgyCf8XfG8PGkGClDlaI1BpcKPBQfR03XP7o9yfcVM8m+NSgs+Y6asUUBulqtB/7EDA==
X-Received: by 2002:a17:90b:19ce:b0:219:6a87:bd09 with SMTP id nm14-20020a17090b19ce00b002196a87bd09mr113347pjb.18.1671231305147;
        Fri, 16 Dec 2022 14:55:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090b010d00b001fd6066284dsm1851026pjz.6.2022.12.16.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 14:55:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/bundle-uri-4* (was Re: What's cooking in git.git (Dec 2022,
 #05; Wed, 14))
References: <xmqqiliewbje.fsf@gitster.g>
        <4b4d5c18-dee3-76c6-8c72-db8ac05a046e@github.com>
Date:   Sat, 17 Dec 2022 07:55:04 +0900
In-Reply-To: <4b4d5c18-dee3-76c6-8c72-db8ac05a046e@github.com> (Derrick
        Stolee's message of "Fri, 16 Dec 2022 10:33:15 -0500")
Message-ID: <xmqqy1r7klh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 12/14/2022 4:59 AM, Junio C Hamano wrote:
>
>> * ds/bundle-uri-4-fixup (2022-12-13) 3 commits
>>  ...
>>  Will merge to 'next'?
>>  source: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
>
>> * ds/bundle-uri-4 (2022-12-06) 11 commits
>>  ...
>>  Will merge back to 'next'?
>>  source: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
>
> Please do merge these to 'next'.

Heh, these question marks were meant to invite "wow, now we have
both of these outside 'next', we can fold the 'oops that was wrong'
fix-up patches and redo the base series; thanks for the opportunity
to clean up the history" ;-).

> Things have been stable since ds/bundle-uri-4-fixup was submitted
> and I'm currently polishing part 5 on top of that branch.

OK.

Thanks.
