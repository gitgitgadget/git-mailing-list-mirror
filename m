Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09940C433E0
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 05:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABF9206F4
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 05:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpx2JK/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGKFsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jul 2020 01:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGKFsR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jul 2020 01:48:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375AC08C5DD
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 22:48:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id b25so6224336qto.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQyQS6R+U5LwAQ2fp9JYJUMtL/UHxETmO2kCVk/rnfA=;
        b=Zpx2JK/g85MI4/tXrj3/rR7e+O9Ojz+J6Ngp6hd5uB7ZCWcP+qkjTB5cQp5hzlZLsd
         I1PYBhgjG1iB17NL+kpbynv7eXEtEpjko47+vOg8XIMxehYWfH3QphLwyR1HhaFjxWU0
         pXjU5mDGhpyUNJy4djxo6bNzxhSOqUdcvlL6p5NGGyj5Zc5hB4lKUkOV0XAZdAAWAIvd
         avdgFSRwxL4c5Ba3OTX5rdljvyKllqqnSy/SAh/lxshhOXQEEo2FgS4ogKZbiOhkJ9sr
         dM8U0ud7eZ7V9ozDkJW4Mudq24x3WQfvcZFj9hWiemk6GQVcoblrPVyft3HlHbvt1F4t
         Cvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQyQS6R+U5LwAQ2fp9JYJUMtL/UHxETmO2kCVk/rnfA=;
        b=qIUkgZqS5tH6/JH9sCALCrlUAV9ImaoyV8LQLMExvF5uOTBiVP230T0NtwkbpnFbtb
         +TXRp/18fmhmVUopVQfXcXOBQ91Q4cmv/bE7ayxqEEFVuMrSf7o+L7Ys5YVb2Es5iYpB
         PBWHwhJrbooOCicxBgUEr/PAGCpcpvrXmbizvk1rE80I4mDlNco7ESODRjxFDGvI0kFh
         XniUcd46qXIKljBoELwJn4U3/ToWY7rmQXLTDo4+kZbFbN1Wqsc6H0GvZrnhs2qW+oMM
         TVgCB6FYZTTzKqbBQxYQCgHIWASKHBbZ5x9ezLVfWDUquB5eyP27Aii/S3fpIEsgyp/b
         91lA==
X-Gm-Message-State: AOAM532+toZW8lt7rXaDGLbuZ/KsoH0G452Q8vOubQInx20QXE9ksrjy
        A+0wAc4fz64VGSYSvcYY/S6EaQ+RNkibrJPEOqo=
X-Google-Smtp-Source: ABdhPJzyW1erbRdJvT3b0ySMHEfpMNqSYpaIpUpg1mNS/tqAmnVhaly7/2JBjaY/o2NwC6PVkrE5uIXmQGEZc9x6bgw=
X-Received: by 2002:ac8:87d:: with SMTP id x58mr15725224qth.28.1594446495900;
 Fri, 10 Jul 2020 22:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
In-Reply-To: <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Sat, 11 Jul 2020 13:48:04 +0800
Message-ID: <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for taking the time to respond to me.

When I run the said shell command, this error reported:
# git log -P --all-match --grep '12' --grep '\b(?!t123\b)\w+'
fatal: unrecognized argument: -P

The version of git which I am currently using is 2.7.4.

One more question, could you please explain '\b(?!t123\b)\w+' in
more detail for me?
Or suggest some related documents for me to go through?

Thank you for your help.
Best regards.

On Fri, Jul 10, 2020 at 4:14 PM Carlo Arenas <carenas@gmail.com> wrote:
>
> it is easier to write specific "not match" using PCRE syntax, but
> there are several other options to choose from combining as many
> expressions as needed from the `git log` man page:
>
>   git log -P --all-match --grep '12' --grep '\b(?!t123\b)\w+'
>
> Carlo
