Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453391FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934588AbdAITVo (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:21:44 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:33220 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbdAITVm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:21:42 -0500
Received: by mail-io0-f170.google.com with SMTP id v96so87914720ioi.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 11:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dvcpDdx8GVojlYfBKclyufioQBSPb7rSN4LVDqzbjCg=;
        b=foKitqtbdm/MAsSyOeAw/XHv+UoWYhXyU/Cfe/6S6n59BCZwlNZXnGzd6PNYph4FGB
         mBl4Z0sylyPKkDHlFm+oxmgSANFJ+/JVpFiRI1Foim7enpWLQHCc9konAr0OWtUdRK53
         Yn9ZoznK5QK290F8stz1MKAz211p7U1IOCFNh19yRmG7iPjt0XBKRdZQ/eoh1IFF1Lat
         xXr9Ab0d1N6fRsDIUNXzgDu2m91pHefXjSa1MWk+gJJxCBMTRZhgRKYGyevYJXKCStS6
         gPRp6GlRQSZX/9TRltQ9+3nLXQSQL0djxk2pjbKbSLGeSsAg/LcTQSiVv6uEZgUW0TUz
         xadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dvcpDdx8GVojlYfBKclyufioQBSPb7rSN4LVDqzbjCg=;
        b=JKjtZVrfTgSNwMf/xwqkU+worxBZujLSvWclmxdxvj5PIe+DL91g3OjBIU79TfTBgP
         +AZBoLKcnE06jDu/q3TpIsEHMnKHPthblhxJh7m0seZFwi4ciJ/pGBh0lm0mNTLYXycm
         0KIhJJclm52mmHQq+tL93lZJY5y6XzGt963cKHY6PRcETXzPdeBjV8lGX3m+JiE9LHfR
         2R/Lm6gHwXbnBWsVYvWYmUGIVomTfNC9Mqc3dSC64eRtcue+pUdpXF8taTkwKpdh2woJ
         yURZpMTN+NmkGQIOEGbyCSFLlNoRasSaLdXN3cHxW8dDQNh4zLoDHhm5Clj0zGBOSqeW
         ++Lg==
X-Gm-Message-State: AIkVDXL3WshduMq9QDUF9wAD+zcHPieSHajPnLMRpzMW5BaK5wnds1E8/qcS7Q4vmG21KSnSlz2pMcNiIvP8OFW8
X-Received: by 10.107.3.160 with SMTP id e32mr8277939ioi.52.1483989702023;
 Mon, 09 Jan 2017 11:21:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Mon, 9 Jan 2017 11:21:41 -0800 (PST)
In-Reply-To: <xmqqy3ylyqhf.fsf@gitster.mtv.corp.google.com>
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
 <cover.1483373635.git.johannes.schindelin@gmx.de> <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de>
 <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com> <xmqqy3ylyqhf.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jan 2017 11:21:41 -0800
Message-ID: <CAGZ79ka0+=om_iWyALCZcK502oU9vCFsZG15ktsN6MxkwKTN-w@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Avoid Coverity warning about unfree()d git_exec_path()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2017 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> So with the above, are you saying "Dscho said 'hopefully', and I
> confirm that this change does squelch misdiagnosis by Coverity"?

I could not find the coverity issue any more.
(It really misses easy access to "recently fixed" problems)

> commit c9bb5d101ca657fa466afa8c4368c43ea7b7aca8
> Author: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date:   Mon Jan 2 17:22:33 2017 +0100
>
>     git_exec_path: avoid Coverity warning about unfree()d result
>
>     Technically, it is correct that git_exec_path() returns a possibly
>     malloc()ed string returned from system_path(), and it is sometimes
>     not allocated.  Cache the result in a static variable and make sure
>     that we call system_path() only once, which plugs a potential leak.
>
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Sounds good to me,

Thanks,
Stefan
