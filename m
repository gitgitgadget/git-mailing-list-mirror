Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F256EC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6ECB6023E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhHSSVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhHSSVw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:21:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2690EC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:21:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i28so14889184lfl.2
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=acesquality.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6j5w7u/4cm9hnRGkEIYM35Wp5UxiUwBEhki805Ajeg=;
        b=XJTihlzkRslNoWW8uyCgVBs3V/1sO6md/XTeec19XEkkUH10V7CRveoWB2Yuskka78
         sj6Ws1eGWeiDZSQofe/CKOr68lA7IE+bQdcMdhvAz0jBATnScYUs0kASZA25DpqfMvCf
         jUMOjUqZvXkBUDzSAI0LBg43mc9v4n5cSrAQZj/ejxEc65/5g1E1dTrgsducNwDGVfyu
         belDKXD+6Z5ud7DhT4Lwt6oqtj0MYHXesIsY0E0WLoUuHcJdC0kIKgtbuRr7Sa1fktWl
         aonC17Q1YOzUB4z8x/AIg/i27xGtJmT70Y7rgmUBzSe2sjQwdtTwz7kkBCYW44XEUUMH
         40yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6j5w7u/4cm9hnRGkEIYM35Wp5UxiUwBEhki805Ajeg=;
        b=Eigf9StGkEevTPUTC0tKF1wTx3JhEjY4Sw/8/cuEA93TH1JlzfaPs4ELKpr0/MMBbI
         DBeHFMH+/+zOKmlLspxOohe63rw1G16UFdCM3H7Ny4p3FsU6aZcYx9tRPo9zjDOYUQdz
         6yHsuNC/pYVri8oSbSRY3CJETdZWsbn2YEtZQHPbIpUtvII2PcEXkSLNwijFhKY5HMbX
         8OOq73nw5Ae6/GzZ00hy2l9Ak4KxJNbS0fIOhKeERduUIX+EQY12CTIFFl5wc5C5nuvq
         h/kphzSgPrBjhLsqUJ7cyqtsNDuHSwoJ2qHslc/DmukrK4HkNNgOTtFGrGy5ZeRdDeqA
         n3Hw==
X-Gm-Message-State: AOAM531iUMQmv9uHvF3Vo1rnwjXFjqCkgQTSbZTAXb/LHxjr/ytkmGBP
        AIvtqOdmmM9FbXJ7RC0TJ9biwnRgqtJ/t6sKxAj7kw==
X-Google-Smtp-Source: ABdhPJyl+/8zh8RMyMXHxkdVf7FbPozEfSV6DF1N08YR/4218GDgLPceLg6hs2/ShYIpYYk1NIG0zBHMiFIaWntpoEw=
X-Received: by 2002:a05:6512:234e:: with SMTP id p14mr11079865lfu.298.1629397274536;
 Thu, 19 Aug 2021 11:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com>
 <010f01d79525$f10a1f60$d31e5e20$@nexbridge.com>
In-Reply-To: <010f01d79525$f10a1f60$d31e5e20$@nexbridge.com>
From:   Jonathon Anderson <janderson@acesquality.com>
Date:   Thu, 19 Aug 2021 13:21:03 -0500
Message-ID: <CAG83euo2B4QFU_S6Yqd3UACWq63p=L+T30CwzT52D8H=S5pRVg@mail.gmail.com>
Subject: Re: Git Modifying DLL
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had not. I tested that and it worked. I assumed that git would
automatically treat dll files as binary. Thanks for the help!

On Thu, Aug 19, 2021 at 1:13 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> On August 19, 2021 1:59 PM, Jonathon Anderson wrote:
> >
> >I'm having an issue with git modifying a DLL file and corrupting it.
> >When I download the original working file, it has a hash starting with 8FE400... I then commit the DLL and push it to our repo. When I
> >download the file from the repo, the DLL can't be loaded, and it has a hash starting with E004FB...
> >
> >Opening the DLL in a hex editor and using the compare feature, there's a single change to the file. In the original, the byte code starting
> >at 0x0074 is 2E 0D 0D 0A 24.
> >In the git file, the byte code starting at 0x0074 is 2E 0D 0A 24
> >
> >A single carriage return character (0x0D) has been removed, and the file size has changed from 260,608 bytes to 260,607 bytes.
> >
> >I ruled out the possibility that the repo server was doing anything to the file because I deleted the file in my local repository then ran "git
> >reset --hard HEAD" to restore the file, and the hash had once again changed to E004FB...
> >
> >OS: Windows 10.0.19043 pro
> >git: 2.32.0.windows.1
> >
> >I have no settings configured for git behavior handling line endings.
> >
> >The original DLL can be found here:
> >https://www.powershellgallery.com/packages/PSWindowsUpdate/2.1.1.2
> >
> >Navigate to "Manual Download", download the nuget package and unzip it. The file is PSWindowsUpdate.dll
>
> Have you set up an entry for *.dll as binary in your .gitattributes file?
>
> -Randall
>
