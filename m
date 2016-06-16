Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B86A11FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 07:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbcFPHKS (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 03:10:18 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38096 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbcFPHKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 03:10:17 -0400
Received: by mail-wm0-f51.google.com with SMTP id m124so55009749wme.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 00:10:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KsHJAF81X1h5Xcq6QT9BTKBKi+LTgQOCEEV9G4tdeH4=;
        b=zqOzgq7+HDowxe8XEcX+D6x0E+NQ/6+ZFPVlvrLOtb10E5FouZtMebjBO7OpazcYzN
         lgzL2gz2OqjIxbA5ooVmh1XwdY1WASM9ohI3axHsnsQnpyiDtwTvt0DrBZccMmBr1O8J
         BR4IHEqKJjMgI4EsAnOFNdzrnYF2YGxIIT00AOZY+/hpky9pZK/VzvFfScTaEGopuLHN
         ZT1sSrhrnJc1KJq1nlfdsJCbfG70aMaK42rNjIw8YtrDoCKIUeLDorPnLBiO75tS0pNi
         GGUYX89s3YcET5LPL9Mf4yPSMGeX+UdIldhqqvCVZgGuZHzW+AsnWay7oRuraSZLDcvK
         wnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KsHJAF81X1h5Xcq6QT9BTKBKi+LTgQOCEEV9G4tdeH4=;
        b=HT0164YmqH29s9GJOszTFoHevx/8S3wqPLSnjuiofSB+W4NviMZ0nnpEHJE/y7m1nz
         t3EbdHYj+k5JuleCjmRwyhHmMapgX/4JF+hcSmSuAGwLBpkeqixe3Ehts9Ke/S0+dFsc
         naw/6okpRwwe9+vjGz8CLSJ15K3suMszxC1iKuem631oZGk/E3Mee0Nn2OajNHeKl6PZ
         8gb0bdNQdFn2cP71b+v0On2H49lm7pNDM90SOcl16Z+F6eOnggjbKy2h0E+i1qruFA0j
         WEKpXZgIqOwCzig2hVoqd36VYS7tFYqTN+YYphe3E0YFz5gusd1AJNNXVDzmL3tKp3OA
         j3kA==
X-Gm-Message-State: ALyK8tI/nKXN3AC8ibvITearcj2zlk8yn4+UavvVoJgFeNw7aa2+e8qQA6Gv16SXv2fBQA==
X-Received: by 10.194.114.228 with SMTP id jj4mr2401008wjb.121.1466061015118;
        Thu, 16 Jun 2016 00:10:15 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4FE9.dip0.t-ipconnect.de. [93.219.79.233])
        by smtp.gmail.com with ESMTPSA id o10sm42063879wjz.37.2016.06.16.00.10.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jun 2016 00:10:14 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v8 2/3] bisect: rewrite `check_term_format` shell function in C
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160524072124.2945-3-pranit.bauva@gmail.com>
Date:	Thu, 16 Jun 2016 09:10:12 +0200
Cc:	git@vger.kernel.org, christian.couder@gmail.com,
	chriscool@tuxfamily.org, sunshine@sunshineco.com,
	Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <B8F28BE0-B43A-489F-9BCC-B40712C450D3@gmail.com>
References: <20160524072124.2945-1-pranit.bauva@gmail.com> <20160524072124.2945-3-pranit.bauva@gmail.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 24 May 2016, at 09:21, Pranit Bauva <pranit.bauva@gmail.com> wrote:

> Reimplement the `check_term_format` shell function in C and add
> a `--check-term-format` subcommand to `git bisect--helper` to call it
> from git-bisect.sh
> 
> Using `--check-term-format` subcommand is a temporary measure to port
> shell function to C so as to use the existing test suite. As more
> functions are ported, this subcommand will be retired and will
> be called by some other method/subcommand. For eg. In conversion of
> write_terms() of git-bisect.sh, the subcommand will be removed and
> instead check_term_format() will be called in its C implementation while
> a new subcommand will be introduced for write_terms().
> 
> Helped-by: Johannes Schindelein <Johannes.Schindelein@gmx.de>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>

Hi Pranit,

please drop my Mentored-by until I contribute something
useful. I feel bad being mentioned in the same way as
Christian although he does all the work.

Thanks,
Lars

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---

