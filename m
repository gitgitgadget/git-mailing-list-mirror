Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13F91F404
	for <e@80x24.org>; Thu, 25 Jan 2018 18:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeAYSqz (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 13:46:55 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46872 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeAYSqy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 13:46:54 -0500
Received: by mail-pf0-f195.google.com with SMTP id y5so6411738pff.13
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CVOrvzhDhelaoSNEi/pi4FW7JC1RTof8O6IoaaUPOhI=;
        b=Cp4fTU3QO7F0BKRtqk3D0Ct+NnUNJ/OuVeBtGyX+N8wh67wiwqJFaN4NyRpsWAuabB
         HYJ8N77kh1NxNV7FdqgGCmuH5EHpuGR6dxTr4rbN4qP1fZuOyVTw2QyIdXvNMXcOcmJ3
         WAPhMrpQQHtEUAKUJBftU7Zm6JOLAuPIodxtg5j08XoFj0Po58JuzwYyjohD+mnSTPuG
         0PDEl5sy7H6QDPP/Gx2g7A5IQ3pkacgMKyZjlC1vFjr3Pd7U01+Sl3Bm1moJCWMctHDl
         3BPJsixehx38+4LJNjuEXkzZXebskhZayaBRjJyqJXVHxdFujXquHdsUbMbn61VoiT/J
         w2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CVOrvzhDhelaoSNEi/pi4FW7JC1RTof8O6IoaaUPOhI=;
        b=JtNgyCkezNPWY3+fOrvQdqbBZxML1svdIGOQMRe7QsSeAA3V9vlAQ35wvXEuFJMhSn
         tPFKhKEsSzoRItEVFlcK4cif+k1KBgP0DOQQcnNqsl4m/NfHC1phbOvmuTdq2CFVUGzR
         2s0SMlnxEeHbw/QHYjTSlf8804ieDl+AZD7Ro5cf8ThTPzwlgJt7YOtU/cvE60Di+6N+
         SMiLakfpnD2iuB4RlwgCaTiybEjzYg2NPMnqE0WMEMGXytWVW9bKlgb/2gBiAIpuhZ6Z
         pF6BMaNBVhngHDdBpoSxr4pKRc85KiGRoRi1XDrkWra/LKNE5bA8kzvm+vba+Lu7CNSG
         K6Gg==
X-Gm-Message-State: AKwxytcNxVqRLS/rPxelbKhJf6lXUb+0KDFjscausjDj1tTd3yo7le1Z
        DCy+Zvb7iU8TFRW5IuTpUhggyowX
X-Google-Smtp-Source: AH8x224rL4ZHCn62HA7Zi2mHILKd3yyITC2GU4O2aStYwRK58y5aG6ocqlJTxnmz5ntswpVvodUlXA==
X-Received: by 2002:a17:902:b783:: with SMTP id e3-v6mr12330483pls.160.1516906013714;
        Thu, 25 Jan 2018 10:46:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f924:a479:e3c:a7cc])
        by smtp.gmail.com with ESMTPSA id n80sm18983678pfj.79.2018.01.25.10.46.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 10:46:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/6] off-by-one errors in git-daemon
References: <20180125005447.GA26661@sigill.intra.peff.net>
Date:   Thu, 25 Jan 2018 10:46:51 -0800
In-Reply-To: <20180125005447.GA26661@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 24 Jan 2018 19:54:48 -0500")
Message-ID: <xmqqshatai90.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This series fixes two off-by-one errors in git-daemon noticed by Michael
> (who then nerd-sniped me into fixing them). It also improves
> git-daemon's verbose logging of extended attributes, and beefs up the
> tests a bit.
>
> Before anyone gets excited, no, these aren't security-interesting
> errors. The only effect you could have is for git-daemon to reject your
> request as nonsense. ;)

Thanks.  All looked sensible.
