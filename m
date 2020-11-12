Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA3C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 09:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E86522202
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGasSepR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgKLJu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 04:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgKLJu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 04:50:57 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D8FC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 01:50:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id za3so6800655ejb.5
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 01:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AsOYZKeadQGSjwTrhka3ivzO4nAgB7AeM+0fHDHtA3o=;
        b=JGasSepR30PiTFOu1w43f/3LX0ICDQ96XO4NWiNQ0XJmHcqHiF1tsOobXMIB3cJxgd
         Qac56BRTbWzV/mwfIY7pzBAtp2taCtr4BXTMMntTrowfweK67ix8I2lajogKxe3BCyo4
         EnSfTc2KSWiBwH51WqIOYUP8+oPdFqMVSxu/YYYTt7SGW8I0YgFDvq/2HVRaMR7Wl6J0
         BBaVcbKLeX+jz2S2j9xRZC3j/9rNA12EknLLWfzHePsABbojE+NjUV8g5ugfrwAqAyBd
         p8szHgtRmPh8d3vLrP2RiOf+Wzx3EL1xyDgbkO6hJzyFAv7En/h2+XN1csZufxGb7w3C
         dXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsOYZKeadQGSjwTrhka3ivzO4nAgB7AeM+0fHDHtA3o=;
        b=IA3EurlmwASWEU66tXkRi/4s6kiQ471NVFZd9GWPzGXkvZSrxgtNbY6RSoJA9MXMQ9
         WvLcblL6rFzrzKGdr88toQ/zA1fWdVhNSsJbApuz/z8XOHyVBkrXJzeGHIOhU/uq+rDx
         tCp3KD8pHxFDkY793+DGCkLy3BKMBw26S4FQD1okTfqaI3B9hrpxC6sY078IGks/uPv2
         QAsaCTiHJIJQ5128UpBt8ipDt3tiif1S/WMM2BPS8x1sPiNpH3NibsA7UqO2RSQbvqey
         DP0SqVJ6mE8FaGGZ1/cRKCVNnmYqk2+P+/ivmaCI8VM/HoRKz05qqCwN8fBOZCGW9Yn8
         gtVQ==
X-Gm-Message-State: AOAM532b8BEV0bFJDIJkcOtDdT5UaAS7LCV4YHf/LsJWTSJFnLqe/ZGM
        hiWVD9IganbHsYqyl7nKm63zwlQtj6D0IJ/wupCNEXXWuJ21xA==
X-Google-Smtp-Source: ABdhPJwJKBw3RMf28RnRJWHRGVATNFqz/uXcBSZcgS15mlLlo4dfBVSNKweaCkCJPCCwlu8qj368oQzJ8O6u8rUmpB8=
X-Received: by 2002:a17:906:2b06:: with SMTP id a6mr30742744ejg.283.1605174655878;
 Thu, 12 Nov 2020 01:50:55 -0800 (PST)
MIME-Version: 1.0
References: <dcf76ed6-103c-bfc5-2226-37702df62056@mail.ru>
In-Reply-To: <dcf76ed6-103c-bfc5-2226-37702df62056@mail.ru>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 Nov 2020 10:50:44 +0100
Message-ID: <CAP8UFD1ANmskDJ0D3D=OJm_FUaNc2-59tLLeAwwNFCKMX2RcZQ@mail.gmail.com>
Subject: Re: how to measure your code
To:     Semyon Kirnosenko <kirnosenko@mail.ru>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Nov 11, 2020 at 5:26 PM Semyon Kirnosenko <kirnosenko@mail.ru> wrote:
>
> Hello!
>
> I'd like to introduce a new statistics generator for git. Call it
> Repositorch. It allows to get some basic and advanced statistics
> including LOCs, Burndown, Code ownership, Defect density, etc.
>
> Some links:
>
> github - https://github.com/kirnosenko/Repositorch
> dockerhub - https://hub.docker.com/r/kirnosenko/repositorch
> how to use guide - https://www.youtube.com/watch?v=Rd5R0BbFdGA
>
> Still in alpha but ready for some fun mining :)

Thanks! We publish a monthly newsletter called Git Rev News
(https://git.github.io/rev_news/archive/) and you are welcome to
submit a pull request to add a small text about your tool to the "Git
tools and sites" section of the (currently empty) draft of the next
edition:

https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-69.md

Best,
Christian.
