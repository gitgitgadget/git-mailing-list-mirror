Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1F71F404
	for <e@80x24.org>; Thu,  8 Feb 2018 17:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBHRWH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 12:22:07 -0500
Received: from mout.web.de ([212.227.15.14]:38135 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751988AbeBHRWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 12:22:06 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLyCC-1ec9r43pUa-007mHa; Thu, 08
 Feb 2018 18:21:55 +0100
Date:   Thu, 8 Feb 2018 18:21:53 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, prohaska@zib.de, gitster@pobox.com,
        sunshine@sunshineco.com, novalis@novalis.org
Subject: Re: [PATCH v1] name-hash: properly fold directory names in
 adjust_dirname_case()
Message-ID: <20180208172153.GA30760@tor.lan>
References: <20180208004156.36224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208004156.36224-1-benpeart@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:rrsU7eisOXDz5sZ/nGl9fv/b0lkwxEdfScobnV71CVCjnBjMpWg
 yqMjWUPhv3CmoCG990KOCv4P5ckcF/LS50W+VjGErNRxWaB82Fz60tcpfLGxbOMBnrGLzIC
 WHTBXrNe+3QZwSinu8UWzYPP5QWWeiBZGwfb51RxM5FZfLpN/b0+SShelTaKsF9DFj2tBTG
 i3Zqj0FPJLxdD2KBJvQEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qurj6xwZU5M=:s5H7yWzJ29bkK5oZK0kUA5
 ouIu4dRCf1cwn7FgT81oieixJ16UKinhmh89XLYMTq1tpx+s3XnGwA99cRgSB71TdK+hkS4Hr
 bEztnIV2UOhcL8C6UfmFc4+0nYmWQN/xhP5Y8mnOWXKHMXbWxJ3SJEtcwJiEDFrvaxSnGNZDp
 w6w2H45osPtkg9RYJZ8o0es0Xsnwmnj0d8Qt1oFIcD6wC+gmGPd5UVf+P3WCLA9y3CFzyFJNY
 Gsojwks6hnLbdHWbVtl8cfyvw17f5qcQE4uOkZ4GienMC+93INsGd9KmG2NXYpYbr+raMA0Lu
 RNpjtposen/GGBgLBQEkLsvPHqFhSrn/L2+XT2nrvs2i0s4FAiiM7CLu810c0p0HGIld9u3DX
 2Q8XhCbrCiCPFg9z6ixLNFyTLshM5NHfFuzMI0IaxMpfw6wxG43AIKtEA2Qk8YsyN2dT96YtD
 ICnPp6R5SeC3Qi4F2+78ZdDlz641PYcHAsSmqDRS65y2UkXouna/nVvQZGOR4YDAg5UrMBwJz
 QiYWkkdd8DtABV1F+aMae7Sq1tC2khoC8LOVC9kPKVtAdhKgmlo0ee+wFa7k7ItanWstyUJxE
 Xp6cvSIXgDrK0BEHdpCOLeNcD2q7i8VxH0jBmVU3Z6hXUJLKl5eHR7X6nKQXpHJx8sLrJBo4U
 /R0VyFye3v8R+vkOcFXbzlsjN8xO7kQA/rla5BjU/ak065Ne1Y++essbzXz9j+8eC1SWPNMFb
 1ybrpPv5t+KX9bo25YgFQ9zd+VpCpZzyM2oax30FZ5HV/yjqQQQWwp8NxrHZ/glxBfHl7OBTs
 ymllK6AavGYyZ+JsSSre6ZTHxBO1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 07:41:56PM -0500, Ben Peart wrote:
[]

> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index b29d749bb7..219c96594c 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -80,7 +80,17 @@ test_expect_success 'merge (case change)' '
>  	git merge topic
>  '
>  
> -
> +test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
> +	git reset --hard initial &&
> +	mkdir -p dir1 &&
> +	mkdir -p dir1/dir2 &&
> +	touch dir1/dir2/a &&
> +	touch dir1/dir2/b &&
> +	git add dir1/dir2/a &&
> +	git add dir1/DIR2/b &&
> +	camel=$(git ls-files | grep dir2) &&
> +	test $(echo "$camel" | wc -l) = 2
> +'
>  

There is nothing wrong with with "wc -l", but:
a more new-style would probably use test_line_count() here.

My personal favorite would be to spell out what we expect and run a diff.
When it fails, we can see what fails, and the function would look
like this:


test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
	git reset --hard initial &&
	mkdir -p dir1 &&
	mkdir -p dir1/dir2 &&
	touch dir1/dir2/a &&
	touch dir1/dir2/b &&
	git add dir1/dir2/a &&
	git add dir1/DIR2/b &&
	git ls-files | grep dir2 | sort >actual &&
	cat >expected <<-\EOF &&
	dir1/dir2/a
	dir1/dir2/b
	EOF
	test_cmp expected actual
'



