Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6481FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 21:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932492AbdBGV5A (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 16:57:00 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33385 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932479AbdBGV46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 16:56:58 -0500
Received: by mail-lf0-f67.google.com with SMTP id x1so7774820lff.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 13:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=AzCJoLqQA39srZrb/kS/FV6PHfD39KBOW5rz2mpU+Vo=;
        b=h++4oIYsvqiHu+ZQRPI4jZOIBnyQOm8PVl1dMJntMnYw/IAKiwRvJah+q1UeSnT/Q7
         NcT5V2d4MkaHKXbvFz0JKK4R5zJgT48mDvoUeZQZ4VqEWDO0KDECSzvZzBIMtrj487o0
         SqxxbXVkVTkZJIHi81GtQq+MXMQmbTdEu4haXUAbm9L24wteyEF6xkzpPFu+rj8pbIfr
         pTQWPgSY9ynIvl/zLqsJqCN7WuKcBoItoJtSLkCI7haHmzn3l5xB9pHgLlP6p7/s93am
         Rtpt6nol9ETufP8OImQ4I7ZNAoZ4YjZD+GWe5MWvcQ2wXO3PzUXznSw3K8eZlvOtfkcn
         Nz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AzCJoLqQA39srZrb/kS/FV6PHfD39KBOW5rz2mpU+Vo=;
        b=CIieFdSPO4d/BIcPLxbPtRM7P06twwaiH1PofMhzH2dfjLYBwV0O9kFJKOVP8mvWmM
         0r4RBzfr5fu4gqt1OggXASr28+2mnCsModPcQLSM72tixvnxOJyMZ/+GUE4WX2ny3PkX
         ejLKpxOCUo70Xs2cH5G9P4FSWdfFhcmA2j/KkmL+mNokcgL2oXLvm3oBfvAVke/Z3ChR
         Wid/QlsIKxRJlrA+pP2fR7z7jxmlsiQQThnPafshCYpwlMpzszFiyxgTdEjZ7wI9P7rj
         kkXs9aBI9LXpzVmuQOC5i6vJl2gjdxXSTbiPxws+GVVSfz2/i3TahwxbpF0JSN60Pl3A
         adMA==
X-Gm-Message-State: AIkVDXL7MGvQFGCr++ylnf025NgfQP8DbxHcO5NTLEZdlU7xfnhK4B5QZwChC3/YLwtU2g==
X-Received: by 10.25.234.216 with SMTP id y85mr5818033lfi.35.1486504612238;
        Tue, 07 Feb 2017 13:56:52 -0800 (PST)
Received: from [192.168.1.26] (ddj179.neoplus.adsl.tpnet.pl. [83.23.87.179])
        by smtp.googlemail.com with ESMTPSA id m27sm1740337ljb.8.2017.02.07.13.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 13:56:51 -0800 (PST)
Subject: Re: [RFC] Add support for downloading blobs on demand
To:     Ben Peart <peartben@gmail.com>,
        'Christian Couder' <christian.couder@gmail.com>
References: <20170113155253.1644-1-benpeart@microsoft.com>
 <20170117184258.sd7h2hkv27w52gzt@sigill.intra.peff.net>
 <002601d2710b$c3715890$4a5409b0$@gmail.com>
 <CAP8UFD3R6nzDPApNvK6rcXR2qdAE6G4J3xbvEam3xsobO7viiA@mail.gmail.com>
 <002701d2816e$f4682fa0$dd388ee0$@gmail.com>
Cc:     'Jeff King' <peff@peff.net>, 'git' <git@vger.kernel.org>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        Ben Peart <benpeart@microsoft.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <04cdd7ae-3349-470f-39c6-7f8723fdcae8@gmail.com>
Date:   Tue, 7 Feb 2017 22:56:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <002701d2816e$f4682fa0$dd388ee0$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to point to two (or rather one and a half) solutions that I got
aware of when watching streaming of "Git Merge 2017"[0].  There should
be here people who were there; and hopefully video of those presentations
and slides / notes would be soon available.

[0]: http://git-merge.com/

First tool that I'd like to point to is Git Virtual File System, or
GVFS in short (which unfortunately shares abbreviation with GNOME Virtual
File System).

The presentation was "Scaling Git at Microsoft" by Saeed Noursalehi, 
Microsoft.  You can read about this solution in ArsTechnica article[1],
and on Microsoft blog[2].  The code (or early version of thereof) is
also available[3] - I wonder why on GitHub and not Codeplex...

[1]: https://arstechnica.com/information-technology/2017/02/microsoft-hosts-the-windows-source-in-a-monstrous-300gb-git-repository/
[2]: https://blogs.msdn.microsoft.com/visualstudioalm/2017/02/03/announcing-gvfs-git-virtual-file-system/
[3]: https://github.com/Microsoft/GVFS


The second presentation that might be of some interest is "Scaling
Mercurial at Facebook: Insights from the Other Side" by Durham Goode,
Facebook.  The code is supposedly available as open-source; though
I don't know how useful their 'blob storage' solution would be of use
for your problem.


HTH
-- 
Jakub Narębski

