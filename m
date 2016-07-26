Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF04203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 15:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756852AbcGZPJ3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 11:09:29 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:60189 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754140AbcGZPJ2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 11:09:28 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jul 2016 11:09:27 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3675520E1;
	Tue, 26 Jul 2016 17:00:29 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nIiNpxWzyvct; Tue, 26 Jul 2016 17:00:29 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 25E2120DE;
	Tue, 26 Jul 2016 17:00:29 +0200 (CEST)
Date:	Tue, 26 Jul 2016 17:18:49 +0200 (CEST)
From:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, peff@peff.net, jnareb@gmail.com, tboegi@web.de
Message-ID: <323759193.1122705.1469546329160.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <20160722154900.19477-3-larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160722154900.19477-3-larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/3] convert: modernize tests
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: convert: modernize tests
Thread-Index: ZAJcjllk9D5mDlXy/xArdeYDYexSPw==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Lars,

Sorry, minor nit that I noticed a couple of days ago but didn't
comment on the moment and forgot until now.

Lars Schneider <larsxschneider@gmail.com> wrote:
> Use `test_config` to set the config, check that files are empty with
> `test_must_be_empty`, compare files with `test_cmp`, and remove spaces
> after ">".

Considering how close it is to your patch, you might also want to
remove spaces after '<'.

There is only one occurrence in this file and it's in a line you are
already modifying.

See below:

>  test_expect_success check '
>  
> -        cmp test.o test &&
> -        cmp test.o test.t &&
> +        test_cmp test.o test &&
> +        test_cmp test.o test.t &&
>  
>          # ident should be stripped in the repository
>          git diff --raw --exit-code :test :test.i &&
> @@ -47,10 +47,10 @@ test_expect_success check '
>          embedded=$(sed -ne "$script" test.i) &&
>          test "z$id" = "z$embedded" &&
>  
> -        git cat-file blob :test.t > test.r &&
> +        git cat-file blob :test.t >test.r &&
>  
> -        ./rot13.sh < test.o > test.t &&
> -        cmp test.r test.t
> +        ./rot13.sh < test.o >test.t &&

Here.

> +        test_cmp test.r test.t
>  '

Thanks,
Rémi
