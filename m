Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6ACC63697
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9060246EE
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="laSQo+0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgKSAA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:00:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:55473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKSAA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 19:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605744003;
        bh=4upwBoRBvqzqO5Pxd/DwL6aZoJIkJFzvRAD6XihKl5g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=laSQo+0J6jHa3vB9+D4kmG6BaOcOy/v6SNirZjj3N6kX8YdqyByJMArz/qcD1W6Hh
         jRf880cdO71BeMFhVjmolkflIJgSkfMMUCfr5JcqJx0m6E3wu/YpH/rZ53Xrx2cV9A
         skzPh9KU7Sc2OIa5PeSthz3YGkyV0vdo8omFIuqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNNy-1kkVTV2nFS-00VSJC; Thu, 19
 Nov 2020 01:00:03 +0100
Date:   Thu, 19 Nov 2020 01:00:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/28] Use main as default branch name
In-Reply-To: <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2011190057370.56@tvgsbejvaqbjf.bet>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <87r1oraewl.fsf@x220.int.ebiederm.org> <xmqqv9e34mq5.fsf@gitster.c.googlers.com> <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YvhktWurYR4dldBHP7UG/sfiS7GNBJxS5YYQ7tNe6oi8g8iCAu+
 xvBuyp+0G7TNTQOMWgumbYUVbfUN0xwhARKD6iG30SHqOPi8LsmyOWtRsM1D9YQmRl3QrE6
 rv/k5yh6xwj1WTiAPXUbFGRPLJCRLv/gVVZ5NqQ+zyvebqq6d4vZGxOX3GWI3IjiTqi07sz
 bG14ZxER+ERrX5WnF3ImA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8WQfjN/7zbc=:BM2kBheh8ikseQwek3MG4E
 nqaY8zkY4+C5Krdo2wvH10CYlF94OpFE1px/7uk5kP1qx8U1b45UIgAnfGR4mxODqBD1DiPB5
 DgWlykj5r5GaXNgVn1gJ/79WQFZSTE4vZ/EWJOXGJOwoOFWFASadlfPNn1D5qX67fqK/wCJVo
 snHeufP3zmHz4StpgccRkO21yNVIAE4jKl83vet1fxnqc9hLMg78Qb9DyRZRKEscuqnmPFoLB
 Mrg0HPSvYJo3Wq2qLFawvXAHEZZHUQ4Jt6qYGSioQ3+985UfzcTpld6naQ3i9yn8WlM/8zyIs
 z7qS0npBsTymDbRzk6zZcPM3xdcAWsZ0H2kCmlCOEvN4XGq+NXXn2qrZEd2k2as6VvLFWTi9a
 oLxvgOIatLqbICqerzl0VL5jQyxBNO4tkp/AX64TL+RfggVprgS8hbkZePFFHwA2If3BrkI+i
 kY1ooiVQrVU6VuvRHberMWr1k7qd4cjsl+PK34Gx2Jncso26cOVOFNctytKFpuNP+czhyDoTj
 igglOg9u3bp9HS+SdRkn2wu9BcKNDZZ7iaiec+zP8rRSqq+m44CjFqVql4D1elXehaG4sLNJ+
 lXj//EDjKOs7N5sH3H7pNfCcOItSqNIEpMh0d8OPNm1JH1BtxvZZwVPml4U59cZp4WHJMHxGh
 +OTQX+zgERRAiaKHLT3POkQwIlNZnlOWlRpm01ljIU9aNCafplhHO8ihi3+2WncbuUs22pHXT
 TEJJ8FzhBvSO7Rq6AchGhRiP0wUDCah3QWfmLbd8ScKEP1cG7xQsSA2BB0KsLAyOhxatDIgKw
 3wn6dNd2TVK+OO5LA4uHcCMKwMiTi6fJsJ4Yy1O6d9xEKvgPK04EiazFVsuIykcQ9r0DfNd7d
 AErZhfWbXLNi2ZbkDXZbBC3ddNG1KLwN0OSu86n3Q=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Wed, 18 Nov 2020, Philip Oakley wrote:

> An alternative in the other direction is to go with the 'not currently
> on any branch' (detached at nowhere) but then require users to
> deliberately create their first branch with their chosen name. This
> moves the 'backward incompatibility' to a different place, which may be
> easier to manage.

It might be easier to manage for _us_, the Git developers. But every user
who initializes a repository and wants to push now needs to take the extra
step to give their unnamed branch ("detached HEAD" is _still_ confusing
new users!!!) a name.

That would be much more disruptive than choosing a "rather dull and
boring" name instead of a rather racially-charged one.

And we promised to try to minimize the disruption to Git users.

Ciao,
Dscho
