Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEBBC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E0322B4B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406050AbhALSrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 13:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390417AbhALSrz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 13:47:55 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DA5C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 10:47:14 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id l7so1380739qvt.4
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I19beq25H0+ln+DtiJxsVnYVuQi1Z1NL2RsScXV3wpY=;
        b=DSQlBQDKDSfBRIrpIm3ydD/WQSxRRsW0XlWFGDFFQuHChfu0cmdxnlpj6uWdXcRMWz
         MooEpqUaR/ubiBhg9zXfU6YL8XIynVxN7p4LzIKi/vDe88WFMZ3t6A/j1CfPXK8vueVt
         wkfuQrPfGvZoes3Q8wZ2nnO5TmU6J4vzx4Bjb9U79HUNMjZhcsk+UTSAeVcLsg5imKoc
         QAzx0M1Wwswr2M3kXTAPOMaHFzyDl7MI+lbWrpQuhqX94t5ElCExI4q/uuAh5BoSnYDL
         Zf9ElIuNwpPaq34yu7+6Ss5I+NJvePZ0BeTd/8LuOQsdJFM0mKdP+nyp3qI/ifm/VDmD
         o3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I19beq25H0+ln+DtiJxsVnYVuQi1Z1NL2RsScXV3wpY=;
        b=kTmfmTeejp/qxC2wXR6ktu3FqtfcroDTh8722vwJJ9BMY/nTxzLmqMB8gszzK9oX2Y
         M8HpTRl8rRa89U8bKDTv1loo7dzl/MdQKBp732+RSijBnlUqLWjhvuvGaV4QL7ORLHAl
         imhTXWfh5owVjFtZkdfwM/BNQbexPEXIgDDPw8DsRrjdTaFomjzQcJZZ/zOudKYv5yfT
         KukYtwrQWGn3j5FW93kpVOXfpxk96bBKSdf/5RBYhvpcsB0yl1k8paqfbCbyOmmKW3Hw
         LLIkmkSdr0te132Eh+vxytNk5Z2op+cSHIsf9Jw7dTL3eHznqEUcWu7t/SYXKxexMQgC
         ghSg==
X-Gm-Message-State: AOAM5333wEiYk5f6BRuPJUW7HWcpSO9ENKCmVBah+wUMXuxI3z42XkrX
        SngD31wkXeTBsYHEG3jrRqZcF95YP7BtkQ==
X-Google-Smtp-Source: ABdhPJxRmatdICRMO73EpkVxjo0PLBzK3AJZ4eOyNA9kpq8RzxWFbXLWqttgzaBDrZkLnXCd3NoUkg==
X-Received: by 2002:a0c:f812:: with SMTP id r18mr804923qvn.39.1610477233822;
        Tue, 12 Jan 2021 10:47:13 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id s186sm1764926qka.98.2021.01.12.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 10:47:13 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:47:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     yoh@onerussian.com
Cc:     git@vger.kernel.org
Subject: Re: suspected race between packing and fetch (single case study)
Message-ID: <X/3urtfn6L551gzJ@nand.local>
References: <fe9babc8-a3ee-6be4-e4f8-9690cb7c79bd@fz-juelich.de>
 <e7301aaf-b341-ec0b-9e2d-ab7f60ac58da@fz-juelich.de>
 <X/ipCPFyW3gAWrHo@nand.local>
 <xmqq35z9g3pw.fsf@gitster.c.googlers.com>
 <X/ymFuUPn2POWA/p@nand.local>
 <X/3gbjQs7+wHoJpb@lena.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/3gbjQs7+wHoJpb@lena.dartmouth.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 12:46:22PM -0500, yoh@onerussian.com wrote:
>
> On Mon, 11 Jan 2021, Taylor Blau wrote:
> > ++
> > +*NOTE*: this operation can race with concurrent modification to the
> > +source repository, similar to running `cp -r src dst` while modifying
> > +`src`.
>
> Couldn't `gc` be triggered by git in seemingly read-only operations,
> thus possibly ruining the analogy with `cp` while doing `rm` (explicit
> intent to modify)?
>
> Moreover, situation is also a bit different since a sane user script
> would not place `rm` into background to keep operating on original
> source right before doing `cp` -- and that is what is happening here:

If you're suggesting that something is missing from the above patch, I'm
not sure I quite understand what you would like added.

All of these (background gc, explicit rm-ing) fall under the category of
"concurrent modification": they are changing the source directory in
some way while a read operation is taking place.

> `git` operation is presumably complete (but leaves `gc` running in the
> background) and script advances to the next step only to run into a race
> condition with that preceding `git` command which apparently triggered
> `gc`.  Should then any script which operates on local `git` repositories
> not to forget to add   -c gc.autodetach=0  for every git
> invocation which might be potentially effected?

If your workflow is that you are frequently cloning via the local
transport and there is no other synchronization going on between
whatever work is happening in the source repository, then yes. (But note
of course that you can set gc.autodetach=0 via the source repository's
.git/config rather than typing it each time).

Thanks,
Taylor
