Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750392095E
	for <e@80x24.org>; Sun, 19 Mar 2017 20:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbdCSUuu (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:50:50 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45873 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752366AbdCSUut (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Mar 2017 16:50:49 -0400
X-AuditID: 12074412-4a3ff70000000b04-b1-58ceee78864d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 90.5E.02820.87EEEC85; Sun, 19 Mar 2017 16:47:54 -0400 (EDT)
Received: from [192.168.69.190] (p5B105D72.dip0.t-ipconnect.de [91.16.93.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2JKlmUJ018711
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 19 Mar 2017 16:47:50 -0400
Subject: Re: [PATCH v6 16/27] path.c: move some code out of
 strbuf_git_path_submodule()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-17-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <45b2b743-4eb0-3511-a48f-1a4725d67c36@alum.mit.edu>
Date:   Sun, 19 Mar 2017 21:47:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318020337.22767-17-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1K16dy7C4N0kI4uuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZXTveMhY0MtZceHCYfYGxonsXYwcHBICJhKtR1W7GLk4
        hAR2MElcbd/CCOGcY5L4eqiLqYuRk0NYIFJi84RbbCC2iECaxOLJ75khiiYySpx6sZQFxGEW
        uMEocWniR7AONgFdiUU9zWA2r4C9xMX7cxlBbBYBVYnXB3azgtiiAiEScxY+YISoEZQ4OfMJ
        C4jNKWAh0bnnEVgNs4C6xJ95l5ghbHmJ5q2zmScw8s9C0jILSdksJGULGJlXMcol5pTm6uYm
        ZuYUpybrFicn5uWlFuma6eVmluilppRuYoSEu9AOxvUn5Q4xCnAwKvHw3rh0LkKINbGsuDL3
        EKMkB5OSKO8/daAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4ND4FyvCmJlVWpRfkwKWkOFiVx
        3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvBVvgRoFi1LTUyvSMnNKENJMHJwgw3mAhv94AzK8
        uCAxtzgzHSJ/ilFRSpz3I0hCACSRUZoH1wtLR68YxYFeEeYNBlnBA0xlcN2vgAYzAQ1eduMM
        yOCSRISUVANjo5yI6SuTz2uqNuSsYgqQXihYPG93lsDuGf+Sj3z6ONNj/btqdwPbI98uK9qL
        H9V7IvitMXJ37Abn8PlB76/PObpXlrf8WOS5XKePPxy8L1yL6bT6UduodupmY7Rx483dQkum
        sm35dXbNVT2WYyy3N0pXqrnEs9Z+UzG/EXc/oMhpudVezvxFSizFGYmGWsxFxYkAija7PSID
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
> refs is learning to avoid path rewriting that is done by
> strbuf_git_path_submodule(). Factor out this code so it could be reused
> by refs*

Is the "*" on the previous line is a typo, or did you want to add a
footnote, or ...?

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  path.c      | 35 +++++++----------------------------
>  submodule.c | 36 ++++++++++++++++++++++++++++++++++++
>  submodule.h |  1 +
>  3 files changed, 44 insertions(+), 28 deletions(-)
> 
> [...]
> diff --git a/submodule.c b/submodule.c
> index 3200b7bb2b..3c445f274e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1596,3 +1596,39 @@ const char *get_superproject_working_tree(void)
>  
>  	return ret;
>  }
> +
> +/*
> + * Given a submodule path (as in the index), return the repository
> + * path of that submodule in 'buf'. Return -1 on error or when the
> + * submodule is not initialized.
> + */

Thanks for writing a docstring, but given that this is a public
function, I think it is preferred to put the docstring in the header file.

> [...]

Michael

