Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFE62047F
	for <e@80x24.org>; Tue, 19 Sep 2017 12:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbdISMoa (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 08:44:30 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43719 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751503AbdISMo2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 08:44:28 -0400
X-AuditID: 1207440d-86bff70000000f42-1c-59c1112b67c0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 26.54.03906.B2111C95; Tue, 19 Sep 2017 08:44:27 -0400 (EDT)
Received: from [192.168.69.190] (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8JCiO59019935
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 08:44:25 -0400
Subject: Re: [PATCH v2 13/21] packed_ref_cache: keep the `packed-refs` file
 mmapped if possible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <b32234e07a1bd1e60442a13d97d7c4e51edf3336.1505799700.git.mhagger@alum.mit.edu>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <354c8088-ae24-479d-3b4e-fe8e189223b2@alum.mit.edu>
Date:   Tue, 19 Sep 2017 14:44:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <b32234e07a1bd1e60442a13d97d7c4e51edf3336.1505799700.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqKsteDDS4P8HK4u1z+4wWTxff4Ld
        outKN5NFQ+8VZov+5V1sFt1T3jJa/GjpYbbYvLmdxYHDY+esu+weHz7GeSzYVOrxrHcPo8fF
        S8oenzfJBbBFcdmkpOZklqUW6dslcGUsWXSUseAff8XfheoNjHd5uhg5OCQETCSunyvvYuTi
        EBLYwSSx/ds3ZgjnApPEtpNr2boYOTmEBRIlFix/wApiiwioSUxsO8QCUsQs8IJJ4u2Pg+wQ
        HR2MEi8OrGYEqWIT0JVY1NPMBGLzCthLHJ7+EyzOIqAq8X5mKzOILSoQIdH39jI7RI2gxMmZ
        T1hAbE6BaImzl/+D1TMLqEv8mXeJGcIWl7j1ZD4ThC0vsf3tHOYJjAKzkLTPQtIyC0nLLCQt
        CxhZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKExAfvDsb/62QOMQpwMCrx
        8Apc2x8pxJpYVlyZe4hRkoNJSZR3Gu/BSCG+pPyUyozE4oz4otKc1OJDjBIczEoivLc/HYgU
        4k1JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CyWpwcAj0rll9gVGKJS8/L1VJgjdH
        AGiBYFFqempFWmZOCUIpEwcnyCIeoEU2IDW8xQWJucWZ6RD5U4yKUuK8YiAJAZBERmkeXC8s
        rb1iFAd6S5g3GqSKB5gS4bpfAQ1mAhqcvQHkg+KSRISUVAOjVOaXRjOnOr1aX/dQu+I2Ma3t
        zD8EJEJO9K28F2324Kljy/KSkGT+BS/eCAo9/hLZ2RUgunzerBOZEyZEHXwxSZeL81KtF2u+
        SNLmmAybheHh3/ecvhh+bv5H9q+KniJSV/0fyniffHC3RbpdI+AU24YpZ4t2WMb++5t40m36
        5t3PRWbK5XYqsRRnJBpqMRcVJwIAunemhkYDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/19/2017 08:22 AM, Michael Haggerty wrote:
> Keep a copy of the `packed-refs` file contents in memory for as long
> as a `packed_ref_cache` object is in use:
> 
> * If the system allows it, keep the `packed-refs` file mmapped.
> 
> * If not (either because the system doesn't support `mmap()` at all,
>   or because a file that is currently mmapped cannot be replaced via
>   `rename()`), then make a copy of the file's contents in
>   heap-allocated space, and keep that around instead.
> 
> We base the choice of behavior on a new build-time switch,
> `MMAP_PREVENTS_DELETE`. By default, this switch is set for Windows
> variants.
> 
> This whole change is still pointless, because we only read the
> `packed-refs` file contents immediately after instantiating the
> `packed_ref_cache`. But that will soon change.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Makefile              |  10 +++
>  config.mak.uname      |   3 +
>  refs/packed-backend.c | 184 ++++++++++++++++++++++++++++++++++++++------------
>  3 files changed, 155 insertions(+), 42 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f2bb7f2f63..7a49f99c4f 100644
> [...]
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 0fe41a7203..4981516f1e 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> [...]
> @@ -304,6 +371,61 @@ struct ref_iterator *mmapped_ref_iterator_begin(
>  	return ref_iterator;
>  }
>  
> +/*
> + * Depending on `mmap_strategy`, either mmap or read the contents of
> + * the `packed-refs` file into the `packed_refs` instance. Return 1 if
> + * the file existed and was read, or 0 if the file was absent. Die on
> + * errors.
> + */
> +static int load_contents(struct packed_ref_cache *packed_refs)
> +{
> +	int fd;
> +	struct stat st;
> +	size_t size, bytes_read;

Coverity helpfully pointed out that `bytes_read` has to be signed:
`ssize_t`. I'll fix that in the next round after waiting for other comments.

> [...]

Michael
