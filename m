Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC14C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC7E61077
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECVGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 17:06:06 -0400
Received: from silly.haxx.se ([159.253.31.95]:56276 "EHLO silly.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhECVGF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 17:06:05 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 May 2021 17:06:05 EDT
Received: by silly.haxx.se (Postfix, from userid 1001)
        id 428755E554; Mon,  3 May 2021 22:56:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id 3EB507D66D;
        Mon,  3 May 2021 22:56:54 +0200 (CEST)
Date:   Mon, 3 May 2021 22:56:54 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@silly
To:     Jeff King <peff@peff.net>
cc:     Daniel Carpenter <dc@ammonit.com>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: http.sslVersion only specifies minimum TLS version, later versions
 are allowed
In-Reply-To: <YJBhH0eLKRSpPFy3@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.2105032250540.30150@fvyyl>
References: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com> <87pmy7x6le.fsf@evledraar.gmail.com> <YJAEVMeY9v/j6PeS@coredump.intra.peff.net> <ed63aa37ef0547bd97a5d965fb5e123f@ammonit.com> <YJBhH0eLKRSpPFy3@coredump.intra.peff.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 May 2021, Jeff King wrote:

> I think it would also make sense to improve the documentation for 
> http.sslVersion to make it clear that this is a minimum (the current wording 
> is quite misleading).

While improving the http.sslVersion, maybe also consider dropping the special 
mention of NSS and OpenSSL in there? Maybe just like this:

         The SSL version to use when negotiating an SSL connection, if you
         want to force the default.  The available and default version
-       depend on whether libcurl was built against NSS or OpenSSL and the
-       particular configuration of the crypto library in use. Internally
+       depend on which TLS library libcurl was built to use. Internally
         this sets the 'CURLOPT_SSL_VERSION' option; see the libcurl
         documentation for more details on the format of this option and
         for the ssl version supported. Currently the possible values of

Maybe also consider dropping 'sslv2' and 'sslv3' from the docs now since 
virtually no TLS library supports them since several years now (as they're 
considered insecure and bad) and therefor asking curl to use those will more 
often than not rather cause an error.

-- 

  / daniel.haxx.se
