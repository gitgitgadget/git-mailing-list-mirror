Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E92C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiKHVt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKHVtz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:49:55 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88BB13D27
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:49:54 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id b2so12553454iof.12
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=moqZYileMV1wDh0gyS5lkS6pp9IhkjyfIqVFWwb7bNs=;
        b=58PKq+9PNHooaiFqXHVS35c9cFbhAzbN76DPr5EJlOIEliKs8eit6JUHkzvskEMfqf
         vlJVZ0mJ6wB9jUTtb5scfQSNYi8XfFS0PZM7G15FQ0ofSTc61vYZBNoaOVqLYhwNDh+3
         L23pdIUa1RvY7h17N+2jT9TDHjhRT4bxva1/NihZG6b2/6asCisZv4g5Js+vL+RMWcy1
         GUIh4Ur9ukGUlCHOCvj25EHGfyF9L6p2Qk6Nlf1DQbqD20PnBPcpLLMyEE0vpdpSHg54
         5h6uFxiuRBSNxcXYRLT//CECpxTNE4d1xxvgP+8xbWi2RzDjMAz4nxhY8/YH3Q0E4ub7
         vWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moqZYileMV1wDh0gyS5lkS6pp9IhkjyfIqVFWwb7bNs=;
        b=o7ePWmBkvXbJmKE3bnoHSFQBmZV9x9SKqcIuL2xQXrcRvH3INDicMxuT8c+SIVXjyX
         G4T4iCAYeqdVydTVYUVLnXJeb/S9jBi18PKbzRRnRwFfZQAFJ01KQbb+xRIxs4Wd4Vcs
         Utfv+Z6hTa1R29NUMNqCmtoONHKgkUXxeiPWqN2sUoOB9osfofnJhDTEofN1iYPqwKrD
         p6TNCseFk8A/yBJZ6aQQmUz/DPC4hKS4jdAGNhGdVvvla+NcskRXC4TZAfM4wzt4olDO
         4KDNyiZcD/7OWOMsmfjsG+VGYu7F7vwGq9319xn97aF9KOfwnLYVYzB508aApXXO5PaR
         9MLg==
X-Gm-Message-State: ANoB5pleh90acVsm3IRg1TjGxN1CJLa7pk13q1rdMd0pnu9QGa6+VKnN
        QTRanHmN9c5A55IwbQeHk/wr+YAhG/xE+nlG
X-Google-Smtp-Source: AA0mqf4VQN2yMRUAsc2eVCc23wMn1/kbXBYkiNrTF1f9L1XXwB4nmobLCOXkLQ+ccMc85eJA/CjPng==
X-Received: by 2002:a5d:9681:0:b0:6db:6aaf:153a with SMTP id m1-20020a5d9681000000b006db6aaf153amr600776ion.45.1667944194171;
        Tue, 08 Nov 2022 13:49:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b63-20020a0295c5000000b0037108a00c73sm3967164jai.139.2022.11.08.13.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:49:53 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:49:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #01; Thu, 3)
Message-ID: <Y2rPAGp96IwrLS1T@nand.local>
References: <Y2RldUHTwNzmez73@nand.local>
 <e1c10d50-779d-2a22-b0c6-83bc0769ea37@iee.email>
 <Y2Wtn0wKhbQrScGU@nand.local>
 <88b30b5f-2712-4c84-331c-2ea7338053ad@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88b30b5f-2712-4c84-331c-2ea7338053ad@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 12:19:22PM +0000, Philip Oakley wrote:
> On 05/11/2022 00:26, Taylor Blau wrote:
> > On Sat, Nov 05, 2022 at 12:21:23AM +0000, Philip Oakley wrote:
> >> On 04/11/2022 01:05, Taylor Blau wrote:
> >>> --------------------------------------------------
> >>> [Cooking]
> >>> * po/pretty-hard-trunc (2022-11-02) 1 commit
> >>>  - pretty-formats: add hard truncation, without ellipsis, options
> >>>
> >>>  Add a new pretty format which truncates without ellipsis.
> >>>
> >>>  Missing test coverage.
> >> Is that out of date? V3 did include tests in t4205 and t6006.
> >>
> >>>  source: <20221102120853.2013-1-philipoakley@iee.email>
> >> This source is the V3.
> > Yes, thanks for catching. Indeed, the version that I have at:
> >
> >     git@github.com:ttaylorr/git.git
> >
> > on po/pretty-hard-trunc has the new tests. I think we are still waiting
> > for review on that topic, though...
> >
> > Thanks,
> > Taylor
> An extra review would be useful.
>
> I wasn't certain about the use of `qz_to_tab_space` in the here-doc
> formulation of t6006-rev-list-format where some of the new tests now
> included trailing spaces (but others didn't).

Let's wait for a little more review before we start merging this one
down. I'll try and take a look if others don't beat me to it shortly.

Thanks,
Taylor
