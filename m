Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02D32018A
	for <e@80x24.org>; Tue, 28 Jun 2016 15:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbcF1PRa (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 11:17:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33780 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbcF1PR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 11:17:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5SFHG0m014387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 17:17:16 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5SFHIsC024380;
	Tue, 28 Jun 2016 17:17:18 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	"Andy Falanga \(afalanga\)" <afalanga@micron.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's happening to the index
References: <57728A17.3010207@micron.com>
Date:	Tue, 28 Jun 2016 17:17:18 +0200
In-Reply-To: <57728A17.3010207@micron.com> (Andy Falanga's message of "Tue, 28
	Jun 2016 14:30:47 +0000")
Message-ID: <vpq60stuyv5.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 28 Jun 2016 17:17:16 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5SFHG0m014387
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467731838.88785@NKtlSFmZfzeWXXzkrnWf0g
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Andy Falanga (afalanga)" <afalanga@micron.com> writes:

> After the line calling increlnum is executed, I often have issues with 
> make unable to spawn the next command because it can't read the current 
> directory info.

This may happen if you delete the current directory, even if your
re-create it afterwards. For example:

/tmp/test$ rm -fr /tmp/test && mkdir /tmp/test
/tmp/test$ touch foo
touch: cannot touch ‘foo’: No such file or directory
/tmp/test$ cd /tmp/test
/tmp/test$ touch foo   
/tmp/test$ 

This is unrelated from Git, but maybe you asked Git to delete a
directory (by switching to a branch which doesn't contain a directory
for example).

> If I do: cd .. && cd -; all is well.

This is a typical symptom of the issue above.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
