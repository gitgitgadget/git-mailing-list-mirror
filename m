Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7694C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DA66103B
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhIQGkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:40:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:48649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233942AbhIQGkC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 02:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631860715;
        bh=ozSDIT1bcSPZpOL5eJ3dfBxY9rWKTAbvCM6uS5sqtuA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=WgLwkEOe7nSN8j7VBdjG0ip5iedbjTUVxtznAwfBbpUG/hNSzaRkiIl884XEMAQ8e
         EFDFSpwE7YKl8MdwzQYK4y8hSAXqZtFeC1D7JxBJlwY3FDb9W+7/R3vQEp0pGC8dMv
         nuNxGHZ1tdP6ZeXN1krZEw1xYxEYO3mwsVnGQ+8o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYXm-1nAs7R1tmw-00m0A0; Fri, 17
 Sep 2021 08:38:35 +0200
Message-ID: <d90b59b8b0d049d4afd72faf04ff680ae5f91b85.camel@gmx.de>
Subject: Re: data loss when doing ls-remote and piped to command
From:   Mike Galbraith <efault@gmx.de>
To:     Rolf Eike Beer <eb@emlix.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tobias Ulmer <tu@emlix.com>, Junio C Hamano <gitster@pobox.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Sep 2021 08:38:34 +0200
In-Reply-To: <b14d79e49e3abe3fdf00cf18bb8c992b4575c5cc.camel@gmx.de>
References: <6786526.72e2EbofS7@devpool47> <2279155.Qy0YqsFniq@devpool47>
         <85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com>
         <2677927.DK6gFqPMyL@devpool47>
         <b14d79e49e3abe3fdf00cf18bb8c992b4575c5cc.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m598A5p80pKmO2XRFM7R/VDbG7Bzmb+OBcpx3rU9CqwfnaqS7Sb
 PZR5KusUPrjiBh1hgXyszT8xGg+4o+XmdEft8caxmPloSzytmnzWEu07uBfSqjn2V1vtHdT
 k5km98zDsfC6brfVnbGIDzrh8T0GWutmL3YZreOrAih2731dtu3YjXRNItRryyP6ath0UrN
 PCwW7ZyxItUxCZmxUL3wQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vthMrA8ZOrk=:Pz1OE8oXPTRKo2vOY0O06E
 cPG1NIXBT7aWV52v9Qg4v51dqUwwrt1PQMMP2X2WMKZH2tX02IZsNTFLQ9FD52Vnpj6TQkbtL
 iTUr1s/J/2MFayYdBZamLer5Bpt1v/38tOXIUMNwTtvFXVaLoBnTpsbMZIyFSAhxWqbVgXfRa
 5i11AAhuOIt+jVAuMMwQPOO5h8T24syB/k2v9H5YSN3xzu3YmSqWv1+0EldsdMg8+eDqr9EcB
 03oFXgq/FSHF8Y24Ef2JJtxo0rjWX3naHowmTUnEvzLrppdgTJKZIE5qSBKBZlqj/4tB/vuUQ
 XM87j/AQ3sZG/9p8oSb6oN8Q2Me4tR7VG+LygpdIxy1yKl9SZf7F4xX/2kIb3jKFpazrwqISL
 SEk2pnnvGanX65aLQ27ae/EX4waVLbzdb+y4HL7/81VHq+ZO/UhXJyqmjjy8f7Tv4aOhf5CnK
 3QPcK+ylP9kRqPmsSp/PtQIfW3/YPn9Mmw7n/MCHN5ShBrmNIrJzmujpaHczRj9traNWtBB7r
 t6PiLZ4clZ2RzsXh3/wp4Iy9UHJRbgab/fGzEJ9EecMmlXP87DRSumHETnyDY/yib46aylOJW
 uPbYbPG1lJl8D8fWeOMqPN6dPQk+kd4mbumxhET5xO/v18iJH83Z8iB3niZJXrbylt3G3jYof
 nBuatMbR1KkifrPFbxQvk3I4EanqqpXLO+3HO2lSZak+0E6ISndcUCvdHjyqyI6DdoW28vHiO
 gzq+BgBxsgO6F7IlAY64MQAXo698CECuVg3f5OQUPChaUKjeisTbWVFoCGH5WWNOppdWAFjsg
 rwTdVdYsUL9sjRJG6CyhH+fomPstrqPWBoSZOa1avNNcPWHThRwaBFTI/j4JIPCF+tjtYYUdB
 yfBhMlxdT8f0DpiM2eKpU4jjH+tQ8Y0Gvh30inmRiFtQ+UeuXaK7hgglUO5Kcja98T2O/gexZ
 KB+M4JMv8q537CQQFHw56VFe8UJvZmbGDRRu42VSwpZO//Hq0oUs83Esgd7ocNDlesT0Mue6I
 3Nfc1LmXJ3XW8HxFzeQGvnFXz3/EiSAnBWcrkD9lBjLeYNf7ElQc0VSTG15moU7Z75PJ5ECpK
 W0BiajevlJx22w=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2021-09-16 at 17:49 +0200, Mike Galbraith wrote:
> Both kernels failed to reproduce...

Nor did the TW kernel (now 5.14.2-1-default) reproduce, neither in my
Leap-15.3 box, nor in a TW KVM set up to play server.  'course that
doesn't mean there's no kernel bug lurking, means with certainty only
that if there is one, the posted reproducer ain't all that wonderful.

	-Mike
