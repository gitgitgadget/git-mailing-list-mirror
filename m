Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383C22018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbcF1SVG (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:21:06 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:42270 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060AbcF1SVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:21:05 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rfDdV0n2dz5tlM;
	Tue, 28 Jun 2016 20:21:01 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E01EB52D3;
	Tue, 28 Jun 2016 20:21:00 +0200 (CEST)
Subject: Re: [PATCH v1] git-p4: place temporary refs used for branch import
 under ref/git-p4-tmp
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <1467012398-7357-1-git-send-email-larsxschneider@gmail.com>
Cc:	mhagger@alum.mit.edu, luke@diamand.org, vitor.hda@gmail.com
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <5772C00C.6000403@kdbg.org>
Date:	Tue, 28 Jun 2016 20:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <1467012398-7357-1-git-send-email-larsxschneider@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 27.06.2016 um 09:26 schrieb larsxschneider@gmail.com:
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2274,7 +2274,7 @@ class P4Sync(Command, P4UserMap):
>           self.useClientSpec_from_options = False
>           self.clientSpecDirs = None
>           self.tempBranches = []
> -        self.tempBranchLocation = "git-p4-tmp"
> +        self.tempBranchLocation = "refs/git-p4-tmp"
>           self.largeFileSystem = None
>
>           if gitConfig('git-p4.largeFileSystem'):
> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
> index 0aafd03..8f28ed2 100755
> --- a/t/t9801-git-p4-branch.sh
> +++ b/t/t9801-git-p4-branch.sh
> @@ -300,7 +300,7 @@ test_expect_success 'git p4 clone complex branches' '
>   		test_path_is_file file2 &&
>   		test_path_is_file file3 &&
>   		! grep update file2 &&
> -		test_path_is_missing .git/git-p4-tmp
> +		test_path_is_missing .git/ref/git-p4-tmp

This should be .git/refs/git-p4-tmp, no? Otherwise, this does not test 
what it should test.

>   	)
>   '
>
> @@ -352,7 +352,7 @@ test_expect_success 'git p4 sync changes to two branches in the same changelist'
>   		test_path_is_file file2 &&
>   		test_path_is_file file3 &&
>   		! grep update file2 &&
> -		test_path_is_missing .git/git-p4-tmp
> +		test_path_is_missing .git/ref/git-p4-tmp

Same here.

>   	)
>   '

-- Hannes

