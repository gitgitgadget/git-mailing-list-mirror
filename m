Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032E21F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971176AbeCSULF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 16:11:05 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:38431 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971169AbeCSULB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 16:11:01 -0400
Received: by mail-pf0-f173.google.com with SMTP id d26so7480126pfn.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 13:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDuEzgAVzO53R0rAWLTcIKr7FscTgUt4xhlUKD2Z1mo=;
        b=cBw0y6QKde1/2rbQ04PY8eBktSvZmXVox6tTQQbYVXFWfZlRaE5LPinZ+3JCi8U3mC
         b3nWjW8p35u5cCNM6o79MzvzWoubRa5Km0ACgy4bMt1DEDgcDL1niS/i0vWkrTWytXcl
         MyxuEAgGrd3vPpPEfqjaAJcM8RktAy/OsWegza4TrWRj8axbL70i/01JcLdvTL/tUfiN
         FAhMkbZD6rChVKuZPqxQt5vLuMZwzmZluIj8EL8h+O2F1PEjosjhrSwVBD779aCzhPz+
         kA6yXLpVWVyxT66jhb3kAmemQ12Ny6R/62vLhGQPaHnczyDhrbEG2Dj0CUe0Icsabb0r
         CDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDuEzgAVzO53R0rAWLTcIKr7FscTgUt4xhlUKD2Z1mo=;
        b=FfBZkABLt47DTSHuhBDd+01ifmhgDer+XNUFMTAavY3Yd2nlYiXUU3BXxu6gvKqxrB
         3L8B+P0PBCvY+9FSEsL00+qn19boVE4ASJJKUkg/+sndd7NvSUwyx4WM7cPht4oSio1a
         soA0SOqQHDf+qY8oJTPqMHMD/Mw5RcEiCCwyI01qS0bprXCWq9HDwS7cikf/Qj68jfN2
         GklyWcCjgZCQfkZSO5JTbkXkMLhfARhK0LjyK5ZcJTGmgBmKv1Un8FiQ/rQ7uHW3DzzM
         d1XWoLDXMuiw/RG3Dt9TkgpVNuh9rIQjJbBwM6yFIOL5Mkrj7mSEBKAJm+hYWIr7qSah
         dX6A==
X-Gm-Message-State: AElRT7FzB6lfXkolnxXLxTRGQx//YDs1sWFLliRphOUw5eXwLxqWcHNF
        7h3nVHGCgTZCUSVhOSZRhKtgpSpBiLc=
X-Google-Smtp-Source: AG47ELsQC1wKdJ4MEMtsfz8FWle6UeG+gy5nsavp25C/aeEOUwykuqYPsJuu08sWSmk6mK9Mms5Kdg==
X-Received: by 10.99.135.67 with SMTP id i64mr10055472pge.346.1521490259892;
        Mon, 19 Mar 2018 13:10:59 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id q15sm15954pff.65.2018.03.19.13.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 13:10:58 -0700 (PDT)
Date:   Mon, 19 Mar 2018 13:10:57 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 39/44] packfile: allow prepare_packed_git_one to handle
 arbitrary repositories
Message-Id: <20180319131057.7cf5c90d55b34542f691cee8@google.com>
In-Reply-To: <20180303113637.26518-40-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
        <20180303113637.26518-1-pclouds@gmail.com>
        <20180303113637.26518-40-pclouds@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat,  3 Mar 2018 18:36:32 +0700
Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> wrote:

> From: Stefan Beller <sbeller@google.com>
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Thanks - I've checked that none of the functions invoked in
prepare_packed_git_one() access the_repository. (add_packed_git() does
not, despite its name.)

The patches up to this one are fine.

[snip]

> -			for (p = the_repository->objects.packed_git; p;
> +			for (p = r->objects.packed_git; p;

Optional: this could be get_packed_git(r).
