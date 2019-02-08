Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDA91F453
	for <e@80x24.org>; Fri,  8 Feb 2019 20:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfBHUOt (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 15:14:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51024 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBHUOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 15:14:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id z5so5315583wmf.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 12:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ynJbu6Fm2rT29Iosuxteh1BkS3l6uvaDXmtpA1zI8V8=;
        b=Z0JRb+ObvRHwQupDb+yxFEpgV+WaDyVYj71wkVSqCsmZHzxO2DlQpe0b8FeSXPRV73
         uf7LkiQSt8UesIETbMerNQOQYd7ahGQ8aVaOzFFoSLPwVFzb4+M3s9aP9XBWl6UC3jdw
         qpoVty9HILVyu7edZq8snAEqJLIO4XQYbRsQkHXZWPtelWjN+vmo/orW/DODWEyNjbrJ
         vSDftNL5qQ4/IKJ6q8uH681fP2qmTEU0TyWHBw6Q1oduKQ80jkGVylcufayclbR6fV8j
         4gfoLtPjGpwWErkcROEH2x66n6UC52jXU1jc2grYrkJkLuw/jUX+jDX3wnjcexFMaF/z
         o9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ynJbu6Fm2rT29Iosuxteh1BkS3l6uvaDXmtpA1zI8V8=;
        b=a11W71CZHJz/PlCtxnsADajYj3/GoiQkcalqdGLDBAKSyM97zWY7jkiSFjdsAtqzqA
         yRTD9CPIvTRFXJ1d1geOIXt5D4W2iB5foSBoLJNAuj4H++kVB31D8j2sbUKj88koeuKC
         I8+AWUkNfhr/UPla0jWaU/BiOSg4Rz0suaVvQ44w8wpaFtv+jeHLe49tONrsnhkH5k7J
         IDar8QnukAYD9KZFJ6s7e6rOdZzpNpV9g9zuRsheGGw63Q+0iZeK1cD5ZM+63i2TubvI
         9Ccz4QeCvbPr8CayN98bz2Gq/zCEGRx3VuXxBxUZ/qbXZJFLqzi4Dji5Do+1Gauv9eFz
         4cbA==
X-Gm-Message-State: AHQUAub/CJC+sjNRTKdtjPn/VUlJvKpGflQws0uMo3uDt7Wn4xN1uiFv
        ts5g5fOgLWRAHU/LSWJqaL0=
X-Google-Smtp-Source: AHgI3IbeP01TEbVogqARDCFS4QJBGnBOHOvTbNhmdFtbvkQR07c90KOI8RafarHyYFGKLeHD132Zag==
X-Received: by 2002:adf:c711:: with SMTP id k17mr17442899wrg.197.1549656887514;
        Fri, 08 Feb 2019 12:14:47 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id h133sm6605573wmd.8.2019.02.08.12.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 12:14:46 -0800 (PST)
Date:   Fri, 8 Feb 2019 21:14:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <ldiamand@roku.com>
Subject: Re: [PATCHv2] git-p4: ticket expiry test: use a fake p4 to avoid use
 of 'sleep'
Message-ID: <20190208201445.GB10587@szeder.dev>
References: <20190208190231.8134-1-luke@diamand.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208190231.8134-1-luke@diamand.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 07:02:31PM +0000, Luke Diamand wrote:
> +# create a fake version of "p4" which returns a TicketExpiration based
> +# on $EXPIRY, for testing login expiration
> +create_fake_p4() {
> +	(
> +		cd "$git" && mkdir expire-p4 &&
> +		cat >>expire-p4/p4 <<-EOF &&
> +		#!/usr/bin/python

I think this should be $PYTHON_PATH.

> +		import marshal, os, subprocess, sys
> +		if "login" in sys.argv:
> +		    marshal.dump({"foo" : "bar", "code" : "stat", "TicketExpiration" : os.environ["EXPIRY"]}, sys.stdout)
> +		else:
> +		    subprocess.check_call([os.environ["P4"]] + sys.argv[1:])
> +		EOF
> +		chmod 0755 expire-p4/p4
> +	)
> +}
>  
>  test_expect_success 'git operation with expired ticket' '
> -	P4TICKETS="$cli/tickets" &&
> -	P4USER=short_expiry_user &&
> -	echo "password" | p4 login &&
> +	create_fake_p4 &&
> +	echo "newpassword" | p4 login &&
>  	(
>  		cd "$git" &&
> -		git p4 sync &&
> -		sleep 5 &&
> -		test_must_fail git p4 sync 2>errmsg &&
> -		grep "failure accessing depot" errmsg
> +		P4=$(command -v p4) && export P4 &&
> +		EXPIRY=3600 PATH=$PWD/expire-p4:$PATH git p4 sync &&
> +		EXPIRY=1 PATH=$PWD/expire-p4:$PATH test_must_fail git p4 sync -v 2>errmsg &&
> +		grep "failure accessing depot.*expires in 1 second" errmsg
>  	)
>  '
>  
> -- 
> 2.20.1.612.g17ebf93fb6.dirty
> 
