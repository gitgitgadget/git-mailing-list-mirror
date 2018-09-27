Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039A11F453
	for <e@80x24.org>; Thu, 27 Sep 2018 00:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeI0G6a (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 02:58:30 -0400
Received: from mx.sdf.org ([205.166.94.20]:53960 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbeI0G6a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 02:58:30 -0400
Received: from sdf.org (IDENT:aedifex@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id w8R0gmVf007880
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO)
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 00:42:48 GMT
Received: (from aedifex@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id w8R0gmqT011231
        for git@vger.kernel.org; Thu, 27 Sep 2018 00:42:48 GMT
Date:   Thu, 27 Sep 2018 00:42:48 +0000
From:   Tacitus Aedifex <aedifex@sdf.org>
To:     git@vger.kernel.org
Subject: Re: Fixing constant preference prompts during tests
Message-ID: <20180927004248.GA4550@SDF.ORG>
Mail-Followup-To: git@vger.kernel.org
References: <20180926162638.GA28077@SDF.ORG>
 <xmqqh8icmb8l.fsf@gitster-ct.c.googlers.com>
 <20180926213703.GA22278@SDF.ORG>
 <xmqqa7o4j5fi.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa7o4j5fi.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 02:48:49PM -0700, Junio C Hamano wrote:
>We do not want your choice of gpg.program or what kind of
>trust you have personally recorded in your ~/.gnupg/ affect how gpg
>invoked inside our tests work.

This makes sense to me now. I get what you are saying. The gpg binary installed 
on my system is fairly new:

gpg --version
gpg (GnuPG) 2.2.8
libgcrypt 1.8.3
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: /home/user/.gnupg
Supported algorithms:
Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed

I'm not sure if that has anything to do with it. I'm going to have to 
investigate further to figure out what is being executed and with what 
parameters that leads to the prerefences prompt. While working with GPG on 
another project I noticed that GPG doesn't like to work with keyrings other 
than the default ones. I tried a bunch of different combinations of 
--no-default-keyrings, --homedir, --default-key, etc to try to get GPG to never 
touch ~/.gnupg and I couldn't figure it out. It would always re-create ~/.gnupg 
and default keyrings and even read gpg.conf when explicitly told not to. I 
suspect that is what is going on here.

//tæ
