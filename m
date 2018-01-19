Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093A71F404
	for <e@80x24.org>; Fri, 19 Jan 2018 23:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756249AbeASXCv (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 18:02:51 -0500
Received: from elephants.elehost.com ([216.66.27.132]:43259 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbeASXCu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 18:02:50 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0JN2mJm000164
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 18:02:48 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <20180119230010.8544-1-randall.s.becker@rogers.com>
In-Reply-To: <20180119230010.8544-1-randall.s.becker@rogers.com>
Subject: RE: [PATCH v3 0/6] Force pipes to flush immediately on NonStop platform
Date:   Fri, 19 Jan 2018 18:02:42 -0500
Message-ID: <001501d39179$9f8fd430$deaf7c90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIJINik9QEcQ1QfzaWv+yYhk2xTJaMQsSyA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: randall.s.becker@rogers.com [mailto:randall.s.becker@rogers.com]
> Sent: January 19, 2018 6:00 PM
> To: git@vger.kernel.org
> Cc: Randall S. Becker <rsbecker@nexbridge.com>
> Subject: [PATCH v3 0/6] Force pipes to flush immediately on NonStop
> platform
> 
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> * wrapper.c: called setbuf(stream,NULL) to force pipe flushes not
>   enabled by default on the NonStop platform. This applies only
>   to the NonStop platform guarded by #ifdef __TANDEM.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  wrapper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/wrapper.c b/wrapper.c
> index d20356a77..671cbb4b4 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -403,6 +403,9 @@ FILE *xfdopen(int fd, const char *mode)
>  	FILE *stream = fdopen(fd, mode);
>  	if (stream == NULL)
>  		die_errno("Out of memory? fdopen failed");
> +#ifdef __TANDEM
> +	setbuf(stream,NULL);
> +#endif
>  	return stream;
>  }
> 
> --
> 2.16.0.31.gf1a482c

This is a replacement for the v2 patch based on Stefan's suggestions.
Cheers,
Randall

