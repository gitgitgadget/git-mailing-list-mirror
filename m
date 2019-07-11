Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919161F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfGKRdB (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:33:01 -0400
Received: from mail-gateway-shared14.cyon.net ([194.126.200.67]:33420 "EHLO
        mail-gateway-shared14.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728268AbfGKRdB (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jul 2019 13:33:01 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared14.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1hlcwA-0004Ly-Rk
        for git@vger.kernel.org; Thu, 11 Jul 2019 19:32:58 +0200
Received: from [10.20.10.233] (port=62502 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <dev+git@drbeat.li>)
        id 1hlcw9-0003K8-LT; Thu, 11 Jul 2019 19:32:53 +0200
Subject: Re: [PATCH v2 3/3] tests: add test for git log --no-use-mailmap
To:     Ariadne Conill <ariadne@dereferenced.org>, git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <20190711172626.16480-1-ariadne@dereferenced.org>
 <20190711172626.16480-4-ariadne@dereferenced.org>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <f2cd0072-95de-3e60-d860-a5dd2c58c41a@drbeat.li>
Date:   Thu, 11 Jul 2019 19:32:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711172626.16480-4-ariadne@dereferenced.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.07.19 19:26, Ariadne Conill wrote:
> In order to prove that the --no-use-mailmap option works as expected,
> we add a test for it which runs with -Dlog.mailmap=true to ensure that

s/-D/-c /

This ain't Java :-)

> the option successfully negates the configured default.
> 
> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
> ---
>  t/t4203-mailmap.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 43b1522ea2..23a8947bce 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -465,6 +465,14 @@ test_expect_success 'Only grep replaced author with --use-mailmap' '
>  	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
>  	test_must_be_empty actual
>  '
> +cat >expect <<\EOF
> +Author: santa <me@company.xx>
> +EOF
> +
> +test_expect_success 'Grep author with --no-use-mailmap + log.mailmap=True' '
> +	git -c log.mailmap=True log --no-use-mailmap --author santa | grep Author >actual &&
> +	test_cmp expect actual
> +'
>  
>  # git blame
>  cat >expect <<\EOF
> 


Cheers,
Beat
