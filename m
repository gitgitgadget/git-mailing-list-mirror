Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3380FC433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 01:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22C422B4B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 01:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbhAYBGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 20:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbhAYBFr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 20:05:47 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6B8C061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 17:04:59 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l27so636572qki.9
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 17:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wiR40pi1nEhGNDCWfH4/lilBAZpKJHn53VzZLDBbcxY=;
        b=DTlm0oDzc7xDo/rVc1CjPMY5ou7aobtZAFHwhkmMIM+i6mNIuGXpcJYWa70T3SUznM
         m9+Xh7Bsld9xv6qhJxygYycxTiSo6ouW0BHFRj+KJWKPP0C3w9w9GQtua4NrvwpQtx8N
         xEvamg7aWHA+0W3KlAkeyDrpPbpi+NJO0PaWwMyS40yuPJA1cglPvMS71s9gs3i9ox7C
         aHDZgWoo+VjZ5nc0tInJOZBsRhHrZmwaAjouGbED0Sgu3tS97elv6+mMUvqp1kD2qLoS
         ZJOs8h1LH4G36FRLOrFOfF9g1AIPZ7fGvXXcMgBKHYK0x2v3hfPjFX7giKBM2X81huVO
         YXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wiR40pi1nEhGNDCWfH4/lilBAZpKJHn53VzZLDBbcxY=;
        b=h3uecLW5TQdO2YxXX/jtS/Pm3h5xHUABVw0WPVgXgzBnCquYyDNRt081UEGSnRNqVq
         bq1oBLrPdq1lsFFk5RcyEInd5xwRU0pkjrBNQeYqKGTNjI7XKAm4a6gMMjRnamLXT3CN
         xemQhyfONHROfyjTncqm+zFDz+X8EMqa/GWvfcje6uD6TKsEcP03h5Grw5nX6HANO2vj
         GrL4jTEkBPQuu3pJlV5g2c4cGmcFvaLl32neCG7Zqi6ADDMy118xMQAnuUokALYx8Emw
         ngjDlNmg1Dec1UkQCaNYkG87LOmkEhEUn3nyKMBOYXDTzdLw0mvY1ZOmQ3SLD42HRN0Q
         RR/A==
X-Gm-Message-State: AOAM533dTJYZc01EbE0peIL8BW0Q168rd9Aia8FQgv/Wo/YU7zdY7HGt
        eJY6SHsE89BBSSOmn/hK+O+upEzHJ4m1DQ==
X-Google-Smtp-Source: ABdhPJwVD4H5/+tZrLrdqjF4Aw2PKSXZLz/v7s/Hni5VvFZM0zYxNbcpBIm076CjDMnbgIAYh1bakA==
X-Received: by 2002:a05:620a:2149:: with SMTP id m9mr1104064qkm.60.1611536698679;
        Sun, 24 Jan 2021 17:04:58 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d8ad:42c:f23b:d0ef])
        by smtp.gmail.com with ESMTPSA id c17sm11257932qkb.13.2021.01.24.17.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 17:04:58 -0800 (PST)
Date:   Sun, 24 Jan 2021 20:04:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Schilling <christian.schilling.de@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ls-refs protocol extension
Message-ID: <YA4ZOOccXK0YEOWu@nand.local>
References: <CAJsFKUCuvO7Y7-MJZ-GG9Jv+4-ei=-tvx4PF1PbeU61m+CV9RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJsFKUCuvO7Y7-MJZ-GG9Jv+4-ei=-tvx4PF1PbeU61m+CV9RA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 24, 2021 at 01:40:08PM +0100, Christian Schilling wrote:
> Hi list,
> I have been working on a custom git server where the sha values
> required to respond to a ls-refs command can occasionally be expensive
> to compute.

Almost certainly the expensive part of ls-refs is actually traversing
the references, not parsing the objects they point at and determining
their hash.

Incidentally, we had a discussion recently [1] that resulted in some
patches that make it so that ls-refs often only has to read through part
of the refs in your repository, not all of them.

> It would be a great improvement of user experience if it was possible
> to show progress to the user while this is happening.

It's possible that that might help, but honestly I'd be surprised if
there was a real use-case that needed it (especially after the patches
that I mentioned which should make it fast enough that you don't have to
care :-)).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20210119144251.27924-1-jacob@gitlab.com/
