Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7E81FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbcHPIwz (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 04:52:55 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36900 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbcHPIwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 04:52:53 -0400
Received: by mail-wm0-f42.google.com with SMTP id i5so152149249wmg.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 01:52:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2dw+DhHCn4iJaBKK4bkf81yqeZy3rjNFTUyHk6aTDL8=;
        b=cT3VtU+lxsaS4jwj2+IUdz1qMr1ANyEW0WCR1nJ3K8faoBk2R1TlwqhbGxG+BHoh15
         3X22wjWAcu/p2S44AwPq6WNRyf1K5QdYCWc3n4w1qKvKogatfertelHgUfFEUAVpYT9P
         WECDxeF/upaCB6F1f2sspDxYK/398rylM2CwKGg4kIwig4PaPybil9xuur7+NEXduYEz
         vRY1M6h5t4gYdLHJcVf5TiRzDzUsriNrX5X18op8WbaoUjJL9GQmhUQvSQ9to8EmulqK
         Yp4LLfQ/WrDhYzx4S/a2W5k3u7vAllMvBCMMQ7S4d3SJMHRBH8iyAppMOwSkZ+NNh0yx
         jKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2dw+DhHCn4iJaBKK4bkf81yqeZy3rjNFTUyHk6aTDL8=;
        b=KCUK7f9kaSGxvK5FVskYhLqOVqcz68AGjgqHid2aQxBVt1fERNL4x6DSjT1zJVGaLs
         y049L9q6dPtb2XZZ8NnRhegqRBVwaHIFe5WVj8mdWzgMV0I1R4LBi42LljnKp/NE2Mig
         7jojYuevHuCFr1o8HG3nrIP3MEQNV+za/nNQb4Aq7JyjCiljb+J1u+BZvO0TVGOLJrhA
         6tvm4tXG0UgO9I0YZOSYdoSYPDp98wl7H2uPzEDYW7c/E9wK07iFDJ7UM76A53p5hXS/
         vGlHi9aMIQF+JVSDcRHBwqYYMNKnucRpq+VAr6SOmoUbVVhU28b+3vt/ZQwV0M2DygHU
         MxAQ==
X-Gm-Message-State: AEkoousyacBSM9/CamQawXAFcW24RIeOMA1FUBoL6/Ax22D1LEqd+XBJTSJMEyw+r3g1KqAyNClW1ddrmBEKuA==
X-Received: by 10.194.62.70 with SMTP id w6mr41956806wjr.130.1471337572187;
 Tue, 16 Aug 2016 01:52:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.199.75 with HTTP; Tue, 16 Aug 2016 01:52:31 -0700 (PDT)
In-Reply-To: <146860882262.30566.9308142555262174975.stgit@zbitter>
References: <146860882262.30566.9308142555262174975.stgit@zbitter>
From:	Catalin Marinas <catalin.marinas@gmail.com>
Date:	Tue, 16 Aug 2016 09:52:31 +0100
Message-ID: <CAHkRjk6U0a+UsBBKTiQTCqxY61aZaJB6jqR4fEpcaGoVFcn1VA@mail.gmail.com>
Subject: Re: [StGit PATCH] contrib/vim: Fix filetype detection in VIM >=7.4
To:	Zane Bitter <zbitter@redhat.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 15 July 2016 at 19:58, Zane Bitter <zbitter@redhat.com> wrote:
> The command "setfiletype" will not override an existing filetype. This was
> never a problem for me previously, but since upgrading from VIM 7.3 to 7.4
> the filetype for StGit's files is explicitly set to "text", preventing the
> stgit ftdetect plugin overriding it. Use "setlocal filetype=" instead to
> ensure that we override any previously detected filetype.

Applied. Thanks.

Catalin
