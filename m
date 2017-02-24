Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A17201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdBXVyt (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:54:49 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36771 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBXVys (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:54:48 -0500
Received: by mail-pg0-f66.google.com with SMTP id z128so4449428pgb.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 13:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ByWdIppmPMlFajHCUkjcaII/IVwLZJXf5ZZIl96tGxE=;
        b=R3/4snNoyl9lXucS9xamOus5/yhFsyuKlNHy2MaM39URrsjOVMLrhvzIbpGCrHuNUV
         iLmTgo5LUNJeueToU5JVYdqAcOKq5lYN4y9v/+20vVYpkUVEKIYpHYMl5q6ARFZeiRMG
         n5PPo8HXlnS9qZLpfJ7vhllPOh4c8i6lCAlif3NN5eHo1zaHwZ6+ShOeBCaPK5ut83Ry
         SGUmHwkOlXZyqICq+8tdH4qred1a2gRT81ZJ8Qz4Bvyl0CPea8sMqk9fxe0FGUrmKTCA
         6FBVIcQ0tjq9/kJguFfrZBHZnlS75Qlb/HNywa0vpbmySiXweVzr3aKEWFmd29GWK0Zh
         BfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ByWdIppmPMlFajHCUkjcaII/IVwLZJXf5ZZIl96tGxE=;
        b=hHye/I1gdMp8E25Mo9UVsXqquPz3Epr9UklaaLoLMCB0eDZTn//LgmormtJM53SAQb
         WJWDDHGZ+3GEpEJAICwEgRrjvOeVuSkD5WDXvTY51h/N3MtmNwOXoAx3FaomUcLC69FU
         WBRXCt7vLuaB3S95xNWztxM1sHIrD65bPiXz49zURfBth5c/y6hfAguTk7l2Rr62Ub61
         GRYIXBtj20MV4FLbFv/k05SRuxNKKiUY8WdkUlFYLHomD/A5VNtuQR3Mx/dphO749lyw
         qLl1SL+o9anim4KW0MWvlsMjlIdQ9QRm/I98VF1cl0Lti1ptgAPIVui8cw4Fw3SLhzax
         aOog==
X-Gm-Message-State: AMke39lkLVZXGq2d2V6BviDpxrTHW0L91CnjpphYRdmmbJ0HSNQWGdL7b7bHxT2sy/5yOA==
X-Received: by 10.99.110.198 with SMTP id j189mr6223451pgc.120.1487973287921;
        Fri, 24 Feb 2017 13:54:47 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id o1sm16831295pgf.63.2017.02.24.13.54.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 13:54:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
        <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
        <alpine.DEB.2.20.1702101647340.3496@virtualbox>
        <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
        <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org>
Date:   Fri, 24 Feb 2017 13:54:46 -0800
In-Reply-To: <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org> (Johannes Sixt's
        message of "Mon, 13 Feb 2017 18:46:35 +0100")
Message-ID: <xmqqmvdbz23d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> It can be argued that in normal interactive use, it is hard to notice
> that another DLL is loaded. Don't forget, though, that on Windows it
> is not only the pure time to resolve the entry points, but also that
> typically virus scanners inspect every executable file that is loaded,
> which adds another share of time.
>
> I'll use the patch for daily work for a while to see whether it hurts.

Please ping this thread again when you have something to add.  For
now, I'll demote this patch from 'next' to 'pu' when we rewind and
rebuild 'next' post 2.12 release.

Thanks.
