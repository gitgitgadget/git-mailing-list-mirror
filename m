Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23DC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 20:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiAZUTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiAZUTr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 15:19:47 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02D8C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:19:46 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i14so672725ila.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3Fr3U1ZS4nGXTRYpm5q1So02qg2he3QRoAOnD0t8oCo=;
        b=tr4oD+t/Pi29BRMg0GMLiVG91gxJHznu2zvNwknUjysEqPuemKLTKCm7EoeVzCoNWx
         oqf3GGerOO2qAuKAlF0wgZ/dWlWqasDY1SKqxSMxwNZuRW7I3gl1ay0Nb2tiaTXUFjrD
         /xEjyHzvTKioVBkNW4c+yw5WWhwmh+0Ped8o8cONMTzJ37bdya/3oQdyNOo/n2XBp8rK
         k8RMRhuXIR72P2ou8r6A0vz4xmm23C0sDZqAMqZjx0BzpplXmCmhdOH6GdYG/g374s6g
         uk4gko0IvyZHQTle0eABeJO25JdWkk7Svt9bUOY4mfCRmg7huJvjRjhXut0sZhFShZnV
         yDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3Fr3U1ZS4nGXTRYpm5q1So02qg2he3QRoAOnD0t8oCo=;
        b=o98sliSP8eCt4ZW/t7D7pnJpWrZD/7fTegXkGyqL5BVyDiQyiVjkxA3Z8U90n79Hdc
         Obv9fuOW/ZAD2dqTb0W2gmoCZ+RMY5ZMkpNkN/LTebR12Wxtac14j/tFH5W/DglWXP3h
         SWpiTuW2XOr3wIq0uFI5//CchCB9Olht4pnqS9iPQwAtyiN12LHw6pCUwUh605nAmEyT
         CR8oSGaecr7jtL0zPV2itjs3y+31zaj1I+gqazrfKGeCIrCGtJv36xQ5Fq7x1QL4IyY4
         tDP4EFm/mTZp8GitR5M4Qt6l/slKanSy+9DESs00oCxoIjc+o+xWWGMJ69UwALc7zE8E
         +qfg==
X-Gm-Message-State: AOAM5329TXkJzYjzC2zIsDnN5NMJhhrqnPkM6LMxfoNWr4BqAD7U3i+f
        5EGr66Smn7ysbEEorM/XlmwFyw==
X-Google-Smtp-Source: ABdhPJxGuOlQCg/0t5nl8papexvwo3ymCcvK9lzVHV9ZSTHmikl/Aaw7dtUZiLRMPG0Jphv5UqYYYA==
X-Received: by 2002:a92:9412:: with SMTP id c18mr559637ili.224.1643228386389;
        Wed, 26 Jan 2022 12:19:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9sm11657224ilu.43.2022.01.26.12.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:19:46 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:19:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 5/9] t5326: extract `test_rev_exists`
Message-ID: <YfGs4WG+S9f4/eqW@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
 <b9c4ff863647c3719725b3ab290e055493b7d6af.1643150456.git.me@ttaylorr.com>
 <220126.86tudqeduk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220126.86tudqeduk.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 04:04:37PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, Jan 25 2022, Taylor Blau wrote:
>
> I left a comment on 3/9, but re $subject: It really suggests we're just
> refactoring some code to a function ("extract"...), but really we're
> using the new trace2 event added earlier here to test things in a new
> way.

I can see what you're saying. I'd rather not squash the two patches
together (because it makes sense to me as-is, and I'd much rather get
this bug fixed than split hairs on the patch structure), but if you feel
strongly I would do it.

Thanks,
Taylor
