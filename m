Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F038E211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfANS4Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:56:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46555 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANS4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:56:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so41149wrt.13
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 10:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tTOp0Me7IG1sPYz1mAqqauzDcPjHX9xMYE7e2Hi1mp4=;
        b=giDov6mITZrSHuj9i9fw2Bv+nfVEmDFAWDrTq9koJSWxxHf2vgo6KkdMxIiZ9gUasU
         M8PwnTGP4spyJLSsLN36VCyXYnanzRdIGnATq/WU3RHuq3ivGAWU2vpz3TuMVTQyHjmj
         XZDYt+qZ8/Ts7BKd36zOgDsLvrBQY733LusHBClKrpJAOREH0M9NWcdITKmDQ/7FWXwc
         QkBJ/oaixHyxNpF1TNw+gre6K+qqmS3Ut+I12fmVpbeR/+hufcAR+xoBZwFppBtrxWwn
         JOS6fMKsr6+AFyX4K3wcNDiecdadKb+H1A/qjjD+KRElRSRr47w2MvtzO0dG5sUregCE
         cpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tTOp0Me7IG1sPYz1mAqqauzDcPjHX9xMYE7e2Hi1mp4=;
        b=cTfNKnVk0auoaei1o9Vx8iQnyzoNfNMdW/HpIE8MFWnlDW84uNGzahgZXyDD+igVGa
         5Z3/b3PNtEDxyatcEP3/8kJxq4ooF9P/XEEQf8QNW+BfTo7Yf7v/9KPMEV6foKTUWYsl
         C6w6GwlNSy8ZzfK93FWwFsjMtQCrtmmK/eH1Wnw7q7zs7uVcM1R+2lUvg50ItUDTu4e6
         his6P7EAUl1pN7gx6EbsGyZKSOKyA8aTUhYa4LYgdlVF781DNxGR19ezZC9XNQYDJJP5
         t73b3hAyEEa6b+BGrT5+4EAdfiTz+E1Uk/PoMNEmIWtRcv4gFM1qBVJzSw1oxQvGJSGd
         jTsQ==
X-Gm-Message-State: AJcUukduAMXy6Qauc3eZujgV5/rWjW8bqd2WHSm5vRxE4CZPKg1AWb2m
        deTXDcZsGHE9Prc3ccV+uLE=
X-Google-Smtp-Source: ALg8bN53KhhxQPfOMUUaM3jz2rFJ22r7edznuTVUe+OgwfsBoHhErTlsce7uqRC9wHDJ8I/4Sl17lA==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr24386919wri.210.1547492174489;
        Mon, 14 Jan 2019 10:56:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m15sm65168679wrr.95.2019.01.14.10.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:56:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, viniciusalexandre@gmail.com,
        Romain Merland <merlorom@yahoo.fr>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>, amazo@checkvideo.com,
        aoakley@roku.com
Subject: Re: [PATCH 0/2] git-p4: handle moved files when updating a P4 shelve
References: <20190113135815.11286-1-luke@diamand.org>
Date:   Mon, 14 Jan 2019 10:56:13 -0800
In-Reply-To: <20190113135815.11286-1-luke@diamand.org> (Luke Diamand's message
        of "Sun, 13 Jan 2019 13:58:13 +0000")
Message-ID: <xmqqva2rukz6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> I found this bug recently in git-p4 - updating a shelved changelist where files
> are being moved doesn't work. The destination of any moves needs to be
> added to the list of files passed to P4.

Thanks.

>
> Luke Diamand (2):
>   git-p4: add failing test for shelved CL update involving move
>   git-p4: handle update of moved files when updating a shelve
>
>  git-p4.py                |  1 +
>  t/t9807-git-p4-submit.sh | 53 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 51 insertions(+), 3 deletions(-)
