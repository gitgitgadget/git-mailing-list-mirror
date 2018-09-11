Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F921F404
	for <e@80x24.org>; Tue, 11 Sep 2018 04:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeIKJDm (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 05:03:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44592 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeIKJDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 05:03:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so10699477plb.11
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XglnsviZ2BRInyLhcHs+NuyfP0QnOIpXgICSnIhJgbQ=;
        b=oFIVGXvg49R2MSBeEF+ia2idTMGXzfiBi7JU6huou0akAFPx0M1Ivt0ojgAstZFmRC
         r76RmvWubnMhYtAo/Zuk7woV3seMEtrpCssbK0bI21J7H3FN0O81YSO1jyZX9mi9TiKC
         1b2+PtIu2o+3wmsn3XsiQjnAPjQV9SJnOr6ilykqZ3AX3i2hvS1f083zD5NIb8t++nMT
         6081iO6xXUO1e9dPfOtoUXy1OiWKkBeCXXxlGrybsoL/sNriYa7Lw/R/YbhF4rx9M9rw
         7p82dVHJ7tevBtYoFEuPdVtrHao8pJPYDvlKxn1AI7nyCIvAmgfYp74QGvXFMq4TEIBK
         bwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XglnsviZ2BRInyLhcHs+NuyfP0QnOIpXgICSnIhJgbQ=;
        b=rDalb7v19fh+Y1hWuWAKu45x9qEQUXxHEstphzDraCv3nhfcBa+sFAEbrfUDTuwLMQ
         MbnPMm+lqpA9E1gANEfUGQ5EroFf524LuEJLTjt/8loWXn2vLec3yg17uXNVARgplVs9
         6gvj+WlX/D0LKUYqxZfxZGT9ra5Om6bIdF8NBaHCy+zvgx5pnuDa+df8V8UxfFrtVP4/
         V95IYtxhU5Kez2WeIlYfGToEJCN63NSRzxC1NzeoEIBz2NNiZbKBuKmOfACzJSt8wD+S
         rTZvFDnglVYOHTlN3X8Hn2e3JURSrXkbFhodA18oKVZY9aEUR3jkbGhK4CmzCp0guWau
         G3Eg==
X-Gm-Message-State: APzg51BTbd0Yz+QsBxuiiqThrc0oNDW66XdqzlCXlFO5hhYNbTSpOsij
        SWqji9h1U+kOd6V688+D6P0=
X-Google-Smtp-Source: ANB0VdbF30Xddaln+fciKW0gZ0LKnU6SnuMb0dzjlMvLFJIBsNBtP731GxK+nxTGpa7m2FrL8AIhpg==
X-Received: by 2002:a17:902:d694:: with SMTP id v20-v6mr24758409ply.328.1536638783351;
        Mon, 10 Sep 2018 21:06:23 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 74-v6sm25007898pfv.33.2018.09.10.21.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 21:06:22 -0700 (PDT)
Date:   Mon, 10 Sep 2018 21:06:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180911040621.GD20518@aiede.svl.corp.google.com>
References: <20180908001940.GB225427@aiede.svl.corp.google.com>
 <20180908054224.21856-1-max@max630.net>
 <20180910051748.GA55941@aiede.svl.corp.google.com>
 <20180910203628.GF20545@jessie.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910203628.GF20545@jessie.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov wrote:
> On Sun, Sep 09, 2018 at 10:17:48PM -0700, Jonathan Nieder wrote:

>> From: Max Kirillov <max@max630.net>
>> Subject: http-backend test: make empty CONTENT_LENGTH test more realistic
>
> Thank you, yes, this is what should have left

Oh, tying up this loose end: do you know why the test passes without
574c513e8d (http-backend: allow empty CONTENT_LENGTH, 2018-09-10)?
