Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C141FF40
	for <e@80x24.org>; Wed, 22 Jun 2016 05:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbcFVFqn (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 01:46:43 -0400
Received: from mout.web.de ([217.72.192.78]:56469 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbcFVFqn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 01:46:43 -0400
Received: from [192.168.178.36] ([79.237.51.220]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LlF9O-1bpTVm46Mw-00b5Qq; Wed, 22 Jun 2016 07:46:33
 +0200
Subject: Re: [PATCH 2/2] archive-tar: write extended headers for far-future
 mtime
To:	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043758.GB18323@sigill.intra.peff.net> <57687417.4020009@web.de>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <576A2631.2000608@web.de>
Date:	Wed, 22 Jun 2016 07:46:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <57687417.4020009@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:LMbBbTKk0s5zPd2i9k+mHoJFPOOAkswWcESeaoLLthF6c7eD50V
 K6Rbe6LF+Ed57z8p4X0n/687MYoTSovcmI02cfsImWKOnOpdVgVnrXuWSop3lgXPqLu0szr
 wbaFb/9VDWgaTdkmhBZxy3MkAIvtguWSnNmeKFWYUfZpI1yrfxqoqOef3JSVzkAK36z0Tf0
 MPSalQa99158s3by079eQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WPolvWo9iA0=:2JPr3ScY0ugS3WTAyzj7J6
 U+oB53AgDSmMBtVsjAHzLmg84fKm9dy2t1gxuT2vL7Z3d6nMNO8/+Zvhc6q5A+VKspdOStDIE
 HjYbh2o2Rf05KdahD11p01CAQz6yroOdKCL3n/VADJ4b1vNz5jBJuB/5XXIdXocC/ya8IXwod
 7w5cyafr+iv4GesQgAJWSaKwFLQ6mgBnnvKShRYRVG/XnuUOx9DREgWuIjxE1MHnWi7bZb+eK
 oOScQPoEKFNW5Nd40/MK1GqlTvKlXkw7bU2rnynPsBcosin4IUy6e/LOSs5qWiN9R+l2w2U5i
 fcryFdL72CHWfopnKqh2JGN0H0SUxhuVIUV4wA3cpIvuZHsS6GJZUBCLWyngKpvRbZci1JhrE
 zNdwKbiYizkny3ubl5VPpquQg4MOiF7HnXtwWdpg1V9hzb6T6xL8W24IARnv8KG6oPILVrkEb
 y47yZbH4cLLZyfhfnoyeCjNEijuZmkUpu+iUwLZogQ1CVCAgcenpGPvGWg7M2gjOJFSZHFzsR
 eY0mi7LLMN2EXqUEcrDl49w4fewL6IkzZMDTdzozQMt2UjY8nh9ftfwaAJ3R0f9PzNRKesAij
 8o4lPg6HMCrKQcN7MCa21xqOP/3mjM/TH65v6JaLVfLvcAmoe1P6EB9n3Y5dWMm/33NZ+mxdv
 q7T6ZzHOqGI1MRRxQl0gCRf/qSdrh3y3vZ1ZSfe6GV6axul+QdjWpVJOdcj+MprflFFRjKcsn
 Fowr1FP3cXBmRvnjauqjJiLKwSbW+JkRjmzIUak56IUdNpodlXcr8FpjXEDawtrrYUQ1lP4gY
 lcj2toZ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 21.06.2016 um 00:54 schrieb René Scharfe:
> Am 16.06.2016 um 06:37 schrieb Jeff King:
>>    2. System tars that cannot handle pax headers.
>
> In t5000 there is a simple interpreter for path headers for systems
> whose tar doesn't handle them.  Adding one for mtime headers may be
> feasible.
>
> It's just a bit complicated to link a pax header file to the file it
> applies to when it doesn't also contain a path header.  But we know that
> the mtime of all entries in tar files created by git archive are is the
> same, so we could simply read one header and then adjust the mtime of
> all files accordingly.

This brings me to the idea of using a single global pax header for mtime 
instead of one per entry.  It reduces the size of the archive and allows 
for slightly easier testing -- it just fits better since we know that 
all our mtimes are the same.

René

