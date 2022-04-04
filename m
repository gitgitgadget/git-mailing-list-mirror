Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C13C35276
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379997AbiDDVVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380401AbiDDUCU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 16:02:20 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB030576
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 13:00:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DC445C06F4;
        Mon,  4 Apr 2022 16:00:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Apr 2022 16:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=pAJjthR78EpXSUKDA4XlNAAPyfCDF2WLuyre8B
        DqDGU=; b=IQY2GiT3DkRclWozbfX1E4MCO5vAQHam8RktK6mmS6B2pZ3Mz8PqBJ
        GfuCYM7gvMQGMN3v76Wciiwf4iJRlercz0TqXHATRQCVSxtWBQBibs1CSrc75Wxq
        AR2WZuzC50exoDcjOdWvQsntWxiRA98wdaS96uGt14HyQ9qsuH1u39IRzMgFlGyG
        XneH5typT3/ckygzcyjCui6X2zex6BA949ZgRNJyNFAoky0kZt3k9X4Pl2ulaKaE
        g4lpYRU6SItyUtwfSE2a17M5lA+ccOkD0pdmE+uPFatdbePfClizO168UyA+/gtl
        w6NUydXZvDhDRMKIlQs/ZcDR9uiBvEcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pAJjthR78EpXSUKDA
        4XlNAAPyfCDF2WLuyre8BDqDGU=; b=RJfbjDSB+EhU3etn+MUwzYPdtDOjZTNgO
        leG+/1AEf/Z2hvnQ+7Xqefg2PKTqKdcfOOSYT3ae7C/F/A27834pIo1H+zPluXBJ
        qo03SZky4FHKWLg8JzkkyTEj6JAg8iIe2/khWln8p0kEHynF8/NA496Fb+tG9TSV
        y6YAJRzJWrFupMuomuT3CW5bNDN91Lpv3vg01dqraDC9JEsFyy4yroXvGDcdl73k
        gu1VGPQqpVv5CcJDIYqwktpFwZ4CVCQEXBbnWjB4Y0Teox39Vz8b91Of7TC771rQ
        /DRE5YKWHRBjGrozvxCUO9n11UjsMB9McJlOC7kAIYa6zVKS38T6A==
X-ME-Sender: <xms:U05LYp5ZruRmld0c50YcWPq-hfY6hexZcSi0ewqe3u8R28IB6vdnXA>
    <xme:U05LYm44Xuz68YgKmtbdFiO_XMbWuXaSD04D9iRq1wO1sxVvsxw5R-L1trMJup21L
    1LyroXF7z-3gnyzkA>
X-ME-Received: <xmr:U05LYgczmatf5Uqk7DjraDpwOqfHwOdjy4ngT79XDvQUgnIjlyyNmb5lQTO_HdFbOLN4265UJ0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepvdejieeflefhteeihffhtdfhfeekhffhuedttedvgfevgfevfeehfffgkeej
    feehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:U05LYiJwahWD1w1x5sxpk2yxx-wxHK36ISw6AFDp-wTveodJTIpTKA>
    <xmx:U05LYtIOrNbur3ncRvlWXkjFdm_YnPmJdzx6UD8npN4d1SWEgEoVyw>
    <xmx:U05LYryXEUOAboQuzXXPh0xc51pJVdP6COmmSQzMdoCkrG-uZfzAzg>
    <xmx:VE5LYl9i_fOK8bKwkXKBYIG16IsSdpGKXGcCZ0lOfil6ff97tiYbqw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Apr 2022 16:00:17 -0400 (EDT)
Date:   Mon, 4 Apr 2022 22:00:15 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: Re: [PATCH v9 3/4] vimdiff: add tool documentation
Message-ID: <YktOTyBq/O9Myev6@zacax395.localdomain>
References: <20220329224439.290948-1-greenfoo@u92.eu>
 <20220330191909.294610-1-greenfoo@u92.eu>
 <20220330191909.294610-4-greenfoo@u92.eu>
 <d01710e1-8a42-e4d1-5034-f6796372587e@gmail.com>
 <xmqq1qydu6r1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qydu6r1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > typo here: implementation (by bad!)
> >
> > Maybe Junio will correct it before merging to next ?
> 
> Thanks.
> 
> $ git range-diff @{1}...
> 1:  7efd9fdf62 ! 1:  7b5cf8be18 vimdiff: add tool documentation
>     @@ Commit message
>          take configuration options not explained anywhere else (as it is the
>          case with the 'vimdiff' tool and the new 'layout' option)
>      
>     -    Note that the function 'show_tool_names', used in the implmentation of
>     +    Note that the function 'show_tool_names', used in the implementation of
>          'git mergetool --tool-help', is also used in Documentation/Makefile to
>          generate the list of allowed values for the configuration variables
>          '{diff,merge}.{gui,}tool'. Adjust the rule so its output is an Asciidoc
> 2:  3e7aa9c425 = 2:  980145f747 mergetools: add description to all diff/merge tools

Thanks! No need to roll out a v10, then?
