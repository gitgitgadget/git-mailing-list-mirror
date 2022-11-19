Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAE9C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 03:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiKSDBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiKSDA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 22:00:59 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA33A4653
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 19:00:55 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id g7so3436679ile.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 19:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8O6nCEg3oeNc71oWSejO1fS+K00Yg8DlIvet459IWnU=;
        b=qxgeuDydY1ywDM8SkSu3ANLQS0NkKPm9T+PxYVqBa3y01ffWiumvGJi+Uf1qTq+Tgm
         NbLwx6uEo8Lcb43btW+etK2KAuBTs2mcffyKPtNRRfXuJr8lCNbPt20oeRIfN9a3j/h/
         uPw0hfSE66v6e33hrDO6Vcs83diwAnA4z+HQDhV94JfBFLra5lTRI4noDxAPNW/1ZQgl
         jp6thqJvGz3LKyH/lhteXlWxRDdPVhHlq2Kbj/4RRyUTgfF1pK0JmiFqCz+h00ir31Hy
         i3sLZlGEnD/7XRIO9XqWmcVTNnfrcPKaczc5kjGi9EBkUw8T7eiPG3A2gnxDA48SDDFl
         8jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O6nCEg3oeNc71oWSejO1fS+K00Yg8DlIvet459IWnU=;
        b=YKmb9i8XxvR+MtJFOx9LZ9DaMudxAZDKYWUvHwWbp3ogMs9X8fDA2Io41qJ5b7NrP7
         A855mxlAPI+b0rBkwaXRBpDggoaQZ8i8/f4DcRFdZi0UrYT61GpbCLcWN4VQD+jMNkXZ
         /ZjzYz2kv9TVj4fvc/C6vFOxWT7c0eC2TdXtk5CtvWXFwHYYdpTxwzzXlxT756lLabRJ
         XjdeJ5yiRVVatC56moLor0fEp0NnnK5IGhZRrmAdU7/9iPkAwKGTq/SWziF3G0M09qPc
         Pq7YRLmcilm37K+It7I3SnH2dphMv/3JZpxZViBQnRxjKum0wGPJKfG1WWuuuIVPtJcp
         3vVA==
X-Gm-Message-State: ANoB5pmOcwaiFmp3h2GuIpKgFlFvF/kVrfxDAkedK5i3G71T+zRr70K9
        0Qc+dybNIQhelN3sZym/wJNccA==
X-Google-Smtp-Source: AA0mqf4orRXC6P6T79kjf0kgWU4kTAwsPg4UmWkQYeIUWNJpS6bfkqrPiS6XlOPzYl+U33RsMDuVPA==
X-Received: by 2002:a92:a30b:0:b0:302:555a:f761 with SMTP id a11-20020a92a30b000000b00302555af761mr4147708ili.323.1668826854609;
        Fri, 18 Nov 2022 19:00:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d10-20020a02620a000000b003633b78ee12sm1779361jac.75.2022.11.18.19.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:00:54 -0800 (PST)
Date:   Fri, 18 Nov 2022 22:00:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file
 format
Message-ID: <Y3hG5VL24K2p9G+S@nand.local>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com>
 <0e156172-0670-2832-78cb-c7dfe2599192@github.com>
 <xmqqiljbkfg9.fsf@gitster.g>
 <CABPp-BGqXbO9SyF_V_fPEOcZ2uQEWzr0V+KrdcHmfWOq3upniQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGqXbO9SyF_V_fPEOcZ2uQEWzr0V+KrdcHmfWOq3upniQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 04:41:25PM -0800, Elijah Newren wrote:
> (I haven't looked much at reftable, so I can't opine on that question,
> but Stolee's approach did seem eminently easier to review.  I did have
> some questions about his proposal(s) because I didn't quite understand
> them, in part due to being unfamiliar with the area.)

For what it's worth, I'm in the same boat as you are.

That being said, I do find it somewhat sad that we have reftable bits in
Junio's tree that don't appear to be progressing all that much. So as
much as I would like to see us have fewer reference backends, I'd rather
see whatever the "next-gen" backend be have good support and momentum,
even if that means carrying more code.

Thanks,
Taylor
