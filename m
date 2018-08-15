Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26021F404
	for <e@80x24.org>; Wed, 15 Aug 2018 00:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeHODgw (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 23:36:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43648 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHODgw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 23:36:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so9994817pfi.10
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 17:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n2Mqxp6s6wFAk9R8p0eSbZem9+coXNBIWhFl5FDZs5o=;
        b=X5A5h8aFtB3vMKJHzPRC7WMV1IwHkP5uXX49F6yWgrkafBux14yLEyQ1LXRxylWIv0
         InZxQbE5dBpf4D7lfzSpimabRu6HiClFRWnTzgnRAixrJb1R6eqSkPep+HKiY+6rlr+1
         mobffFYyriQiDPsvT0LOawaOyvrPvuzYUDveVMsffyFyLBYvXV39Y+u+JU7y9j091ZlY
         yqnRI98kqjwHU3fKBrDSFmTcuSTwovTOoqcChpzEyg7VAprUo+dNkBFmhJUlXIQlUh2k
         BtkbYcAhBEGiIsIvEElzxuttr7XbUqNTl6u47FG/NvpizT8RG/AJr8e8ad4p4lqbcqqG
         rQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n2Mqxp6s6wFAk9R8p0eSbZem9+coXNBIWhFl5FDZs5o=;
        b=nJfae5YJ/1kMYb8inDd3rp9yf8fjH0HUwLn8NJ98GT5jugEffwZkp7nbEIpnD2RJpT
         lGQ5sn/E84UxuvnPEv9AvunDDn05C3/I83SNa5JAnrK56Ogb3l7GimHrtntuIX4gboyp
         kyneDl/i+3xh4B/YiCADZkW4i8ONoPJiBVs0X9/7QQWNYtQVDz+VmtsCPsUOLrMttyfa
         atSZzXD5US23/FmDAhhGxu9lnqJG7akKQfPc8LS+TEBAQ8+s3Ox6/X8ygSJKNtnK3MTN
         /Pl8ZK2dHxW+y2UJFNLgKNl1cGXJSTpnXDn4mtbkeygCnDTD6XD12M2ahBknkaZKZG3F
         pGaw==
X-Gm-Message-State: AOUpUlHVKCsLG4Fcc97rUspcySVivw/tLVTTII7iC5la1RVlQL+Aa2mu
        U1KSBIxplmHC0EU1dLrBywoDKwJ0
X-Google-Smtp-Source: AA+uWPzVRxBACv34OLKSByEI9yjuZkXsV3HqEI9h/NFibBcZGfTLrxAut4pJWKua6XPo7jw4kYjwGg==
X-Received: by 2002:a63:4857:: with SMTP id x23-v6mr23629290pgk.30.1534294027548;
        Tue, 14 Aug 2018 17:47:07 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p26-v6sm41765771pfi.183.2018.08.14.17.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 17:47:07 -0700 (PDT)
Date:   Tue, 14 Aug 2018 17:47:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, joakim.tjernlund@infinera.com,
        git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com
Subject: Re: [PATCH 1/2] store submodule in common dir
Message-ID: <20180815004705.GA5932@aiede.svl.corp.google.com>
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
 <20180814223820.123723-1-sbeller@google.com>
 <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com>
 <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Theoretically we should be able to make modules/kernel%2fv2.[24]
> additional "worktree"s of modules/kernel%2fv2.6, but given that
> these are all "bare" repositories without an attached working tree,
> I am not sure how that would supposed to work.  Thinking about
> having multiple worktrees on a single bare repository makes me head
> spin and ache X-<;-)

Agreed about spinning head.  This is why I suggested at [1] that
anyone intereseted in this start with description of their proposed
design, which would have three benefits:

- after implementation, it would document the intent behind whatever
  we choose to do, hopefully saving people debugging or improving this
  code some head spinning

- it would allow subject matter experts on-list to suggest refinements
  and simplifications

- it would avoid the interested contributor going too far down a blind
  alley in case their initial proposal has a fatal flaw

I also agree with the "theoretically we should be able to make it
work".  As described in [1], I think most of this is work we're going
to have to do eventually, as part of properly supporting multiple
worktrees for a superproject.  But I don't want to set wrong
expectations: this will be hard.

Thanks,
Jonathan

[1] https://public-inbox.org/git/20180814231049.GH142615@aiede.svl.corp.google.com/
