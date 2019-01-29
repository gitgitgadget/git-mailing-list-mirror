Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B911F453
	for <e@80x24.org>; Tue, 29 Jan 2019 00:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfA2ACU (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 19:02:20 -0500
Received: from avasout05.plus.net ([84.93.230.250]:43700 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfA2ACU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 19:02:20 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id oGr3gAu9wuQOBoGr4g7qnt; Tue, 29 Jan 2019 00:02:19 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=JtDfUvwC c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=xc-_RC1pKzzd67JoAU4A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: sparse job, was Re: [PATCH] test-xml-encode: fix sparse NULL
 pointer warnings
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <68a8c70e-dc42-1df3-3616-c096f63cb848@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1901281706440.41@tvgsbejvaqbjf.bet>
 <a6b689da-b002-0aa2-e9d6-755d004bc320@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1901282333350.41@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ef5a8623-e5e6-5cc8-5178-0afce7b5499e@ramsayjones.plus.com>
Date:   Tue, 29 Jan 2019 00:02:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1901282333350.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDNnPmevVdef5DxquOKhKB2K0poTGTl+BfNJ9GvH+UE1c//bna84j0K6myfphYHXRpD7mT6NZpqow7ieMXFt/wGwhfryaizQWc1gd4jtBT/sC2ikYf6g
 PYCZBsz/RpoMOhS5GsU1kU8ZCzq7FIfGXmlYP8ULSPDEJLVXMYCJwFcMzgkrtGiCEQIGO/NpH4zkUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/01/2019 22:34, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Mon, 28 Jan 2019, Ramsay Jones wrote:
> 
>> Hmm, I've never built an Ubuntu package before, so I don't know
>> exactly what would be required (spec file etc.) to create a PPA.
>> But I suspect you are not talking about doing that, right?
> 
> I would have gone for `checkinstall`... That still works, right?

Ah, I never think about using checkinstall - I haven't really used
it in anger. For some reason, I thought you needed to structure your
Makefile a certain way (using $DESTDIR or somesuch), but I seem to
be confusing it with something else. Apparently, no change to the
Makefile is required - it uses some kind of filesystem watcher to
note which files are copied into place by 'make install'. heh, go
figure! :-D

So, I think you only need to set the PREFIX when building (the
default installation PREFIX is $HOME), or create a local.mk file
to configure the build (I don't do that).  The 'sparse' build
does not make use of any 'auto-tools', so no configure script.

Ah, I think you will need to have pkg-config installed. I have
never built sparse from a tar-ball - I assume it works! ;-)

So (just typing into my email client - not tested):

  $ wget http://www.kernel.org/pub/software/devel/sparse/dist/sparse-0.6.0.tar.gz
  $ tar xvf sparse-0.6.0.tar.gz
  $ cd sparse-0.6.0
  $ make PREFIX=/usr/local
  $ sudo checkinstall make PREFIX=/usr/local install

... should do it. (famous last words).

ATB,
Ramsay Jones

