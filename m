Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4EFC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 11:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCVLvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVLvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 07:51:09 -0400
Received: from weald2.air.saab.se (weald2.air.saab.se [136.163.212.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C82D4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 04:51:03 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald2.air.saab.se (8.14.7/8.14.7) with ESMTP id 32MBomVi009606
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 12:50:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 weald2.air.saab.se 32MBomVi009606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald2_2; t=1679485848;
        bh=LTGToGv8iwhhtg8wwnlxWsY/h21BzLzW617OjEVrv8c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mgg6Jq/oE5ChQ74MylVAFzwZtNFUnUbeRag+qwY4VCMDtHb24bKOULQyBVVKiGLKX
         bYp7PNTVS0jUjR9egCMWRgaEKmhnF0gxuOuD9KzwXbkPIHY4T0i/HTuOM3CLqTqjqN
         QjBeIT8bLQrPtDZ3MyFwR0gulwlJYUfR5yYO1aJHVCy+rdxD/jYsDsqF2VS6Oq9Ql5
         pzhhKdmsNv6bT3Fd/N9hnExBFL8UQWmWiAHbTZOR8ZDjy8H28DXWyeV8+2PjZ+ipcv
         FSaKjfRWKYkvhHkeQ9jArhW8lOHX305nEednG2gYRG6Q58UO/+JoaC3rK33VpBevRB
         lBISWQBtMynoQ==
Received: from corpappl17783.corp.saab.se (corpappl17783.corp.saab.se [10.12.196.90])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 32MBomML347536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 12:50:48 +0100
Received: from corpappl17778.corp.saab.se (10.12.196.85) by
 corpappl17783.corp.saab.se (10.12.196.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 22 Mar 2023 12:50:47 +0100
Received: from corpappl17778.corp.saab.se ([fe80::8df4:c4d8:a91e:cc18]) by
 corpappl17778.corp.saab.se ([fe80::8df4:c4d8:a91e:cc18%14]) with mapi id
 15.02.1118.026; Wed, 22 Mar 2023 12:50:47 +0100
From:   Lundkvist Per <per.lundkvist@saabgroup.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Soundness of signature verification excluding
 unsigned empty merges
Thread-Topic: [EXTERNAL] Re: Soundness of signature verification excluding
 unsigned empty merges
Thread-Index: AQHZW9YuL0XHoZNDkEewevJzAqRee68FcOjegAFADec=
Date:   Wed, 22 Mar 2023 11:50:47 +0000
Message-ID: <cf655e6bcf7248a393b8bfb89bc5833a@saabgroup.com>
References: <27a7d2956ed94d7ea8eb6d17f1414525@saabgroup.com>,<xmqqmt46jbrg.fsf@gitster.g>
In-Reply-To: <xmqqmt46jbrg.fsf@gitster.g>
Accept-Language: en-AU, sv-SE, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.197.18]
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-27518.007
x-tm-as-result: No-10--19.087800-8.000000
x-tmase-matchedrid: 13nEecSBt9GJVA+ukO+5MXpXbwx9aHgaKQNhMboqZlrGZbX3v50Wr/y+
        IfkvA3MsL2t0lTyrb2mOltXIJxb6e2Kpop2untnPjoyKzEmtrEfwUenwsKlntFjH3z6RfJRwIa7
        NUssol07/FMNtciEZrJBiPSJiPDCdU/cjYQukEoLfqVBdB7I8UbiUGLgNIUm7+qrYkjx5HFsplD
        /bYdJZ1edin0834i0ovtTJr/rCD9VXvJFU/uBRZYh/ebSxR/HnqJNAg+VJy+ts+HFD7B2Y6UWVx
        BAe6/8O01Q4rs5clVanqW3VSGf5d79ZdlL8eonabh2NZp6L5YT6APa9i04WGCq2rl3dzGQ17eux
        dOndYh+4TP2w4sTbEqX0orwAKv7RLizDq+S5cSNN7abY7WT/Xg==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--19.087800-8.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-27518.007
x-tm-snts-smtp: DA27D3A05D974486F7D316A2323927E29AB58697826EE67E59C3CD5BE27C17852002:B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Lundkvist Per <per.lundkvist@saabgroup.com> writes:
>
> > But it seems like if we allow unsigned empty merge commits, i.e. those =
that
> > themselves do not introduce any any other change than what its parents
> > introduce, and require all other commits to be properly validated, then=
 we can
> > safely validate the whole repository?
>=20
> Depends on what you are trying to protect against, I would think.
>=20
> Two tl;dr of it are
>=20
>  * a merge that does "not introduce any other change than what its
>    parents introduce" can still cause harm to the codebase.
>=20
>  * a merge that introduces other changes may very well be necessary
>    to merge two histories.
>=20
> Each commit signed by known/authorized people is simple.  But what
> does it mean for them to sign an individual commit in the first
> place?  "I wrote it" is too naive an answer ;-)
>=20
> A commit that is perfectly good in one context may cause the
> codebase to do a totally wrong thing in a different context, so your
> sign on the commit itself may assure others that you as the area
> expert vouches for the change in its original context, but will that
> signature be good enough to hold you responsible for the catastrophe
> it may cause by merging the history leading to the commit to a
> history that has forked from the original one long ago?

OK, got it. For certain type of commits there may be opportunities in time =
where
it is possible to reintroduce these old signed commits cleanly with an unsi=
gned
merge, and this is a type of attack this validation strategy would not prot=
ect
against.

Thanks!
