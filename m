Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90DA220960
	for <e@80x24.org>; Thu, 13 Apr 2017 22:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdDMWcT (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 18:32:19 -0400
Received: from mout.web.de ([212.227.15.4]:64540 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdDMWcR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 18:32:17 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRUC0-1cW5FO1xAO-00SdZT; Fri, 14
 Apr 2017 00:32:06 +0200
Subject: Re: [PATCH] xgethostname: handle long hostnames
To:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
References: <20170413192335.20679-1-dturner@twosigma.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <aa10d2cb-c21a-fbfd-9fae-0d0153e4901b@web.de>
Date:   Fri, 14 Apr 2017 00:32:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <20170413192335.20679-1-dturner@twosigma.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:JRE6Lg4BBmB2T+E6TfQKafpw2HXswfWl5yi9XbU2Olj7MgHrNiU
 5nDoMWUvx1dutf5uTSA+3oeIclCENJO5uWNvs0TJht7pVWBX4bEYu5uuaTgzxZbquJNzaY+
 /LxxcowFs70rypnV4yL7pRxpjD1VEL64sFhga8U6FW3QSHW9fnx7nCHfhqBqE/2hgOMWsb5
 HTh5p6o3k6g0TvRisemOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0cesSoVgrvQ=:9fA0uA2oqf9fbBv06jGEE+
 i0L+dx46RlSWlgT1xycU2ympEESQ6p4b9nHpY9tS98jjhHPESLrXLnBLJGeM1ewT9Ic7vVnoj
 8Ij1Aze/RxD3o9Z0FEp4eqeYTj7jbWs9Lq+9V81trTEzUbhYHSfhiVWJNiQCJSA+fsfurmqfI
 5O1v/TUroyhWwtOSxZHs2iCR+okajoQts5fuDhnTz9os+xAp2B0eWshL1lzefLKXS5QGWRlhr
 oJ+mziz5ntW9o9CUUoukaSn9spUdxEYwEqolX8aD9fWU4D/XKPDbfE0hBZS8Ke3xKcfg29+3z
 bwezwKWP3DIsgo9vFZ71uZB4rnJuU5LABuGUeqFAyf1Pl9J8mEaK8ibNdkyac8UbCsVfC3Fyl
 mRCcklIpUMUBcLo5DPiHTY6TJIIyLzbYhOSlvhXJNpJ+qs3r5Yi6u1hgDHiS529RlIJBLPFYs
 oJB9ttwGwYF+inVRZWHail4l245j1YDI3O3DgPoQX/gbumVXCApgVkB6u45eovhSn+uUSbgwQ
 X2/0p31sRE3uM5Xa/DvKDtYvHUskjUPEWJt/qCjCJyzsP2Q74HoYgd3x7d3J0o6qJYc1VbPrA
 QeX/TeLYZvl7Q46XyPKDhrpGNw8VcPRy7jTAS1lMGrXS17bJIKepFRJTO1u5vPmw6MaZw8xwf
 Jkzv5Yh46TTnoVY+LKuwhdddkgsd4ElOxfbwqi6vKLTWDFgdomRGORDajK+MGZ6dJ9wRtcLcz
 MQOTWYxTxS6vhtFp6h0D8EJ6S08Ybs2MMM38tLpaDY3U7AvsN0IlauA8KEo8bNq55sgD1fRnD
 LcFnd04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.04.2017 um 21:23 schrieb David Turner:
> If the full hostname doesn't fit in the buffer supplied to
> gethostname, POSIX does not specify whether the buffer will be
> null-terminated, so to be safe, we should do it ourselves.  Introduce
> new function, xgethostname, which ensures that there is always a \0
> at the end of the buffer.
> 
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---

> diff --git a/wrapper.c b/wrapper.c
> index 0542fc7582..d837417709 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -655,3 +655,16 @@ void sleep_millisec(int millisec)
>   {
>   	poll(NULL, 0, millisec);
>   }
> +
> +int xgethostname(char *buf, size_t len)
> +{
> +	/*
> +	 * If the full hostname doesn't fit in buf, POSIX does not
> +	 * specify whether the buffer will be null-terminated, so to
> +	 * be safe, do it ourselves.
> +	 */
> +	int ret = gethostname(buf, len);
> +	if (!ret)
> +		buf[len - 1] = 0;
> +	return ret;
> +}

Silent truncation is not ideal, no matter if it's done by the wrapper or
the original function.  It would be better to use a properly sized
buffer.

POSIX requires hostnames to have a maximum length of HOST_NAME_MAX.  So
how about just adding an assert to make sure len is big enough?  Or
evaluate the condition at compile time with BUILD_ASSERT_OR_ZERO?

Downside: Not all platforms define HOST_NAME_MAX.  daemon.c uses 256 as
a fallback.  On Windows a buffer size of 256 is documented to suffice
in all cases [1].  The Linux manpage [2] mentions a hostname length
limit of 255 (plus NUL) as well, even though HOST_NAME_MAX is 64 there.

Another possibility: Die (or at least warn) if the buffer doesn't
contain a NUL byte after calling gethostname().  That only works for
platforms that don't NUL-terminate on truncation, though, so silent
truncation would still go unnoticed.

Anyway, the buffer in builtin/gc.c with its 128 bytes seems to be too
short; the others are at least 256 bytes long.  Replacing the magic
buffer size number with HOST_NAME_MAX + 1 might be a good idea (after
moving the fallback definition to git-compat-util.h).

René


[1] https://msdn.microsoft.com/en-us/library/windows/desktop/ms738527(v=vs.85).aspx
[2] http://man7.org/linux/man-pages/man2/gethostname.2.html
