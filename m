Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C7120562
	for <e@80x24.org>; Mon, 30 Oct 2017 16:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbdJ3QYU (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:24:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:50981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932126AbdJ3QYT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:24:19 -0400
Received: from [192.168.178.43] ([92.76.242.15]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M85r3-1dDmwi2uGX-00vdZQ; Mon, 30
 Oct 2017 17:24:17 +0100
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell
 function in C
From:   Stephan Beyer <s-beyer@gmx.net>
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
 <49b9e9e6-8aeb-9a14-9309-f9274fe13e7d@gmx.net>
Message-ID: <ff95b58e-ed76-ebe3-fee9-7f73f1a0c868@gmx.net>
Date:   Mon, 30 Oct 2017 17:24:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <49b9e9e6-8aeb-9a14-9309-f9274fe13e7d@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WugrMt5aSfFuFHVqqnocLEvSsiuJSgRf8sxqyZXAl0PYvTXb6gh
 2BXobtFeI9We+S+Pdb5IT9whijIjRILgpZJX1yaTOOlPvJ2OZSq8uslxup1cBtxI6evxrrY
 aDZtgN3GUcKUoblRRJBxvNwwBabuuWujBvCXGZYiVA9yh/OjX4vTr2ef00Ta9DAny9bbyIc
 B8rvxi2AtZ2hsHQEKvyfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EiJOVWWGERQ=:RnHeve530N4G7O7etQLyHG
 V2V10sLSWKfK/vARCiM/oE0BliY5PgvTTliBPAdxQiLLgNKexnthRkLTWLNMGy/k0R5D3g/1m
 /QONRGdRqqHmx7MvRUVe19EA/ZlMf/2AKdMuBNadO3DKkaSZLVXsZvQPG5YY8Wmt3BY7uDPfa
 3xwu4vuFrVAle1HhKUBfWRJlUBdHH4FWRFEw2z+SVydsyXHimcHWavcfrVmFYh0Lo5NNyM475
 Ams6qi2vGZJQurtUDXW74oiZ+pb2pHfVSNJrWfwf0s9ytS8QRtRdWEtel2udZsf11Qwt3pXgK
 LM+VmF4CH7X3aRyhZz9cKclr41DBcBxQYTsqGpIP3+Y0OyNg8LATjkB6YWRYAMYaqSEYGRkls
 dwaE39mJbaSi00Id8LwdtWBT6SfnVDloTj515SYlRDJVO935fvX19RvLqBp7MQrx8RFQXlt49
 Alltfke/5Fi+V6V1/JI56HyEqq36GHjWiVg+1nX6S9P8R2gwcuuHxtdWFw0ExgRui5PhvarBj
 Kxfo0kPXAltTqQii9kGdzOhxZCzc5QeHAgRwfITF2pJsHQkKOBmVSqsBuB0U9zlAHFCPkzDhF
 OKqUy+KSQpLo6y9L9TvI0JqW9i+JzcBORjdLwEzsHgCksr4kqP9UGu8SJqgYeKTK8tFy5Jni3
 826bwlolEOlbFI+LUNFy3F9grRuAsqlaBONWEyP9JSor1+2tfv/yE4w+gIME6KmS2BY9tHLaP
 FSEtkwewEy4PEROihi62t4Ji7XmXVISTGlCzIfVY5Bg1ylhC8Mk+SsPBwGiEAcRTco+EYskog
 kWsnl6V7iywxCmh/JpQlj8HKFEEbzYIuNg+BiU4vyQ3Dg69KNs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/30/2017 02:38 PM, Stephan Beyer wrote:
> This last change is not necessary. You never use "res".

Whoops, ignore this!
I compared old and new diff and mixed something up, it seems.

Sorry,
Stephan
