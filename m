Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544211F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeHMUbf (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:31:35 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40503 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeHMUbe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:31:34 -0400
Received: by mail-wr1-f44.google.com with SMTP id h15-v6so14997904wrs.7
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 10:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VRMG2qC0xfqjPbchCXmeI2jFp026CsUEdNET2VGUmVA=;
        b=mu5RK2UE/OgXV8DFU/YWH6VeSxrUIu3iQEhqojaLF3/YUC2jDrMOjWACMXVgT1EsjH
         BeENECQ5vzoyAcfh/kLHld53nol7lIfeBymiaztNIer4R5Wo6KkvNK1d2dHaXXWTKuUK
         hTbEDGAFhOqNgolW/TyXnvWXxxeJ7kfk+5Lj6X4VkIhKoxMT5tCQ3283BogVGiBonCZv
         58pJ4hTHsCSsFbViICF2j86N/IkIvgItp8oDkxIF+rQUk5aPIYdWKqOBXxpmoAkODsXR
         j/6gjyrX6MLmQkQXyRid/uOG/gHqVyGmoKKKkqjKHtgGxKtVT0JSQYik6hESTqOx10EN
         sbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VRMG2qC0xfqjPbchCXmeI2jFp026CsUEdNET2VGUmVA=;
        b=VwfsPS+8eGuQO9xLGFBcteO7kUDr50MAajvoy7pOgpsGU7nRPESO7wqrSQBLyX3pa+
         LqcX5YHlhwr/erANaAVVal5VDi9X2dh1xGFhj7NIByGJKd63GaoMQ5E4beDM3PXtzGCw
         6irybFOp1tjsmLjsdqPkax+6cV9E8uQGUoXirE/9xWUUbrhCkxztpSVSRvJuu8wz1za+
         3jkEkCZb7bJ2yW/7C8AWBil0jU+PqfvxtwtgETzrFL5O+V9fA+VdUWbIulCaOCXp4edg
         cle72HAocni6E6sl+FiaVNFUhaTUvKGqvsMOazkA7ut6u+OJnE25FX5bh74P6pALdUY1
         sOyw==
X-Gm-Message-State: AOUpUlFpZrnLTjf1dFStF15q4aYwHlOIJRGAQwi/Pft204lJrwjWc85u
        1yOoLEMAmKOpGhaItgCBbrI=
X-Google-Smtp-Source: AA+uWPwyzI+KzAGWDTlSkXUtIOmJJuQ76Z/dgs9854+Hkul6DGBLjANoFZGF1d9RySt19GL8BCxRCQ==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr10891899wrh.72.1534182499812;
        Mon, 13 Aug 2018 10:48:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p13-v6sm13341064wrj.20.2018.08.13.10.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:48:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 16/21] range-diff --dual-color: skip white-space warnings
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
        <c56c51c8bb470ec9a498e984854f5154acf86ef2.1534159977.git.gitgitgadget@gmail.com>
Date:   Mon, 13 Aug 2018 10:48:18 -0700
In-Reply-To: <c56c51c8bb470ec9a498e984854f5154acf86ef2.1534159977.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 13 Aug 2018
        04:33:24 -0700 (PDT)")
Message-ID: <xmqqzhxq5fa5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When displaying a diff of diffs, it is possible that there is an outer
> `+` before a context line. That happens when the context changed between
> old and new commit. When that context line starts with a tab (after the
> space that marks it as context line), our diff machinery spits out a
> white-space error (space before tab), but in this case, that is
> incorrect.

    Also it is possible that there is an outer `+`, ` `, or `-`
    before an added line (i.e. the second column is `+`), and that
    line introduces a leading whitespace error (e.g. the whole line
    begins with two plusses, SP and HT, meaning that the new
    iteration of the patch introduces a space-before-tab whitespace
    error), but feeding that to our normal diff machinery would of
    course not catch it as introducing a new whitespace error.

I think it is a good design decision to give up showing whitespace
errors correctly in this round, because the problem is not limited
to the first space on an outer context line.  The next paragraph
would want to lose the mention of the "Rather than".  We do want to
list the problems we know about for future reference, but that is
what we already did in the above paragraph, so all we need to say
after this point in the next paragraph would be "let's punt and
leave whitespace error highlighting for future enhancements" or
something like that.

With the dim/bold cues step applied, the resulting dual-color mode
shows the differences between the previous few rounds and this one
pretty nicely.  After seeing the huccup between v5 and v6, I am a
bit hesitant to merge this immediately to 'next' but hopefully we
can have it there in a few days (I definitely will merge the topic
to my previate edition that I use for my everyday work during this
integration cycle).

Thanks.
