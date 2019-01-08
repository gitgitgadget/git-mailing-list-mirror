Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B46A1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 23:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfAHXTt (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 18:19:49 -0500
Received: from mail-oi1-f202.google.com ([209.85.167.202]:43904 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbfAHXTt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 18:19:49 -0500
Received: by mail-oi1-f202.google.com with SMTP id p131so2506114oig.10
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 15:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bqFHz1+x8EKDMQFW9Zc16Jl+t5J2GST5ne5PJdvsWZg=;
        b=O5sGXObeSxDwSEx78KWeHwTPzo709JXfZyAQ5/fA2GYdtsefle7IiWlRl2VJJdhOe6
         GuDgWE13izhDzICd1rPKLrFsCEA76X5c76CNGEkcGCvGFDNJRSMmCScHVfHrSQt/ANfD
         9UXhJy0YAfTUsfh7jhevBzOY0mBWB24UTs0VLs3It40F+SgMSwTjg7l7dzPIHN0ZcWS4
         duBrkUUEdz2eef5mkkR72b5wj/7WpgJmuiY3m4jp8StAtYYj9kN/wYWEiuxKrmPNv7T9
         e/p0itsjryUEr+t/O5O8UCz7QR9H/h5GFdwPD1YDvRXktPmt7bXpcUqB4J3kzh1br985
         1xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bqFHz1+x8EKDMQFW9Zc16Jl+t5J2GST5ne5PJdvsWZg=;
        b=trLuNJqZIVAanzrWkI2o2pb4Q9zdcUVU1vO4L2i6xACEXP7XcmJq9FB19vvu62UaFS
         YnpPiY9GTxWIs2P1siOBPeAgCgYQ3JzjNXNc5HncUVLLmspo0939Ij0vpNDm06sVZbox
         qUO9mwXY9oDJ5BYg23/AbaNEK3IG2baE250hImoL52QXAKepzwvEeTfHVRRu3J4Tx3F8
         BwS9yXJIZwCYFPnh8I74ZKk6JUaj+a+b6FPIj8n3yhjihgqLvmlmoj9SNIev0yZVceWl
         zuhBF22Tzxrp+gi2IRjVM/seQa8p1K53tUImNmoJpMdHoCOWWrxKEpIMuHhWuL73k2Z6
         13Cw==
X-Gm-Message-State: AJcUukf+PCasbWkIc1VuYSMbJifzQuNN1TYNWb2M/XVW5wdwADSOOY2T
        0YGZQBKJHLjGizHZQKq0Ys+ADH7g9nddlIDVEDi1
X-Google-Smtp-Source: ALg8bN4iKCw857TeLX5pUsH/hapNi9S2Xn+5UVAK3gTCXmvfdDXlD/AtEPYwIGd9rCsJPI9YDnmZqc9JEhTNDi8kZw2x
X-Received: by 2002:a9d:6256:: with SMTP id i22mr2530968otk.27.1546989588514;
 Tue, 08 Jan 2019 15:19:48 -0800 (PST)
Date:   Tue,  8 Jan 2019 15:19:45 -0800
In-Reply-To: <54fba0d3-4b8e-1faf-4b2d-e67c1f5fbf02@comcast.net>
Message-Id: <20190108231945.36970-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <54fba0d3-4b8e-1faf-4b2d-e67c1f5fbf02@comcast.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 1/2] list-objects-filter: teach tree:# how to handle >0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@comcast.net
Cc:     jonathantanmy@google.com, matvore@google.com, git@vger.kernel.org,
        sbeller@google.com, git@jeffhostetler.com, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Any reason for moving "case LOFS_BLOB" (and "case LOFS_BEGIN_TREE"
> > below) after LOFS_END_TREE?
> 
> I put LOFS_BLOB and after LOFS_END_TREE since that is the order in all 
> the other filter logic functions. I put LOFS_BEGIN_TREE at the end 
> (which is different from the other filter logic functions) because it's 
> usually better to put simpler things before longer or more complex 
> things. LOFS_BEGIN_TREE is much more complex and if it were not the last 
> switch section, it would tend to hide the sections that come after it.
> 
> FWIW, I consider this the coding corollary of the end-weight problem in 
> linguistics - see https://www.thoughtco.com/end-weight-grammar-1690594 - 
> this is not my original idea, but something from the book Perl Best 
> Practices, although that book only mentioned it in the context of 
> ordering clauses in single statements rather than ordering entire blocks.

OK - my thinking was that we should minimize the diff, but this
reasoning makes sense to me.

> > Here, filter_trees_update_omits() is
> > only ever used to remove a blob from the omits set, since once this blob
> > is encountered with include_it == true, it is marked as LOFR_MARK_SEEN
> > and will not be traversed again.
> It is possible that include_it can be false and then in a later 
> invocation it can be true. In that case, the blob will be added to the 
> set and then removed from it.

Ah...yes, you're right.

> For your reference, here is an interdiff for this particular patch after 
> applying your comments:

The interdiff looks good, thanks. All my issues are resolved.
