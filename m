Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABE51F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 23:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeKMJHk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 04:07:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38005 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeKMJHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 04:07:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so4730491pgq.5
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 15:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ft4V7X3grICrshm6qOph2+KjQcYJxDTrGxOGPaUWzI=;
        b=X3y5JEOa8A6YDT/0zvA1OtMSo4QT4l1mT8h9vd2OFUTO9rlA6ynu7bmiqv19h1D9Wk
         MVLNyq7KXEjxGrWCZ5MPrpuCTLyuPsFGRwurkCcktBDknsyhzdDt+TyrQQqAdxmYdy7l
         EH814zG7GGPSp39zsSOf3fEhv6eRUvR5304PwJTG2Ex0/Ij+41XbU24VMxTCMXRhOSk4
         7Th2AeXwpf63sFsLAMw8wmStPhJ5PKVEzrt7YDoPAhc2SBIGkrnDgJmAwahqmN33/44j
         04tquAhBAHp60X0USVcjgqeMELWosbq4kx6S7ybwLt+s5AvPVgna53OR/o1QxDfBAMa7
         fWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5ft4V7X3grICrshm6qOph2+KjQcYJxDTrGxOGPaUWzI=;
        b=uAVeAs1VLczoyLjsaYln0ixjc3NXnM/IQO6McMOCNx4C0m9HRt5sMC1P1Z9Cp0sZ3x
         gcEovNS/ofs6Brb6Zglz1xWX/lp5ElfQgcmKAxulEIDOzMQeBZWparRXw1b2fe0UVisp
         sA0elub98gA/jbMDXSq2iR0E8jwLGFvpA5ejoUsGdIJ2MySTdF8qZGdW+0jFoQV21G0S
         L5BTNU4DYspJI2ItGjuEBF9koxdDq51M390sc3Oqo1Eohn+0rw2a8265EUuEfwCK8YrC
         uwjc1PZS3I58wI9AESUO3gA4CChyyUrNMpU8NgAuH1QZmn3ivds/1MgmRWBhdjBixdib
         6Whw==
X-Gm-Message-State: AGRZ1gIfHqm6+jlKdvd3DdDRtyTvuPW6R8yaSvmP/jWz5GUTwk0a0fkh
        aGZ4YJ8pbs+CDH9Ai6JbQhoXRyEIAOq7mQ==
X-Google-Smtp-Source: AJdET5e4u+ocCtAilq//A/Lj8Sy7gMBnRCVnrZLdy0DTvJEXvL9tx3ORo8wfsy1SaSdIgnUvZNHmhg==
X-Received: by 2002:a62:6a88:: with SMTP id f130-v6mr2715984pfc.98.1542064340735;
        Mon, 12 Nov 2018 15:12:20 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id g65sm2980987pfa.63.2018.11.12.15.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 15:12:19 -0800 (PST)
Date:   Mon, 12 Nov 2018 15:12:14 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] apply --recount: allow "no-op hunks"
Message-ID: <20181112231214.GB126896@google.com>
Mail-Followup-To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.74.git.gitgitgadget@gmail.com>
 <dffe2e1144e4a3533f67784abd36671b078105d3.1542056085.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dffe2e1144e4a3533f67784abd36671b078105d3.1542056085.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.12 12:54, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When editing patches e.g. in `git add -e`, it is quite common that a
> hunk ends up having no -/+ lines, i.e. it is now supposed to do nothing.
> 
> This use case was broken by ad6e8ed37bc1 (apply: reject a hunk that does
> not do anything, 2015-06-01) with the good intention of catching a very
> real, different issue in hand-edited patches.
> 
> So let's use the `--recount` option as the tell-tale whether the user
> would actually be okay with no-op hunks.
> 
> Add a test case to make sure that this use case does not regress again.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
