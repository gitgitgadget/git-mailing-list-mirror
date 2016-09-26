Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6CE1F935
	for <e@80x24.org>; Mon, 26 Sep 2016 06:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034473AbcIZGeD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 02:34:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54466 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761679AbcIZGeB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 02:34:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u8Q6Xp1a001506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Mon, 26 Sep 2016 08:33:52 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8Q6XqSF025950;
        Mon, 26 Sep 2016 08:33:52 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Changing the default for "core.abbrev"?
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Sep 2016 08:33:52 +0200
In-Reply-To: <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 25 Sep 2016 20:46:39 -0700")
Message-ID: <vpq37kntbjj.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 26 Sep 2016 08:33:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8Q6Xp1a001506
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1475476433.35948@knIsVmsvJGUxECzsE/vCQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am not opposed to bump the default to 12 or whatever, but I
> suspect any lengthening today may need to be accompanied by a tool
> support that finds the set of objects that are reachable from a
> commit whose names begin with non-unique abbreviations that appear
> in the commit log message.

Something much simpler would be to set core.abbrev at clone time,
depending on the size of the project just cloned. So, when cloning a
hello-world, we'd keep the 7 but when cloning a big project we'd get a
larger value.

This doesn't cover the case of someone growing his own project without
cloning, and isn't as clever as actually looking for colision, but it
would probably provide a sane default in 99% cases, and wouldn't be
worse than hardcoding 7 in the 1% remaining cases.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
